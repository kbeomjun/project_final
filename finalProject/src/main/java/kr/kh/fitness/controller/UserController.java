package kr.kh.fitness.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.dao.MemberDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;

@Controller
public class UserController {
    
    private final Logger logger = Logger.getLogger(this.getClass());
    
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    private MemberDAO memberDao;
    
    @Autowired
    private MemberService memberService;

    // 로그인 페이지로 이동
    @GetMapping("/login")
    public String loginPage() {
        logger.info("로그인 페이지로 이동");
        return "/member/login";
    }    

    // 로그인 처리
    @PostMapping("/login")
    public String login(MemberVO member, @RequestParam(value = "autologin", required = false) String autologin, 
            Model model, HttpSession session, HttpServletResponse response) {
		logger.info("로그인 시도: " + member.getMe_id()); // 로그인 시도 로그
		
		try {
		MemberVO user = memberService.login(member, response);
		if(user != null && user.getMe_authority().equals("REMOVED")) {
		    model.addAttribute("msg", "탈퇴한 회원입니다.");
		    model.addAttribute("url", "/login");			
		} else if (user != null) {
		    // 자동 로그인 플래그 설정: 체크박스가 선택되었으면 "true"로 전송됨
		    boolean isAutoLogin = "true".equals(autologin);
		    user.setAutoLogin(isAutoLogin);
		
		    // 세션에 사용자 정보 저장
		    session.setAttribute("user", user);
		    
		    // 자동 로그인 선택 시 쿠키 설정
		    if (isAutoLogin) {
		        // 고유한 토큰 생성 (UUID 사용)
		        String autoLoginToken = UUID.randomUUID().toString();
		
		        // 사용자 정보에 토큰 설정하고 DB 업데이트
		        user.setMe_cookie(autoLoginToken);
		        memberService.updateMemberCookie(user);
		
		        // 쿠키 생성 및 설정 (7일 동안 유지)
		        Cookie cookie = new Cookie("me_cookie", autoLoginToken);
		        cookie.setMaxAge(7 * 24 * 60 * 60); // 7일 동안 유지
		        cookie.setPath("/");
		        response.addCookie(cookie);
		    }
		
		    model.addAttribute("msg", "로그인을 성공했습니다");
		    model.addAttribute("url", "/");
		    logger.info("로그인 성공: " + user.getMe_id() + " (자동 로그인: " + isAutoLogin + ")");
		} else {
		    model.addAttribute("msg", "없는 아이디거나 잘못 입력하셨습니다");
		    model.addAttribute("url", "/login");
		    logger.warn("로그인 실패: 없는 아이디 또는 비밀번호 불일치");
			}
		} catch (Exception e) {
			logger.error("로그인 처리 중 오류 발생", e);
			model.addAttribute("msg", "로그인 처리 중 오류가 발생했습니다");
			model.addAttribute("url", "/login");
			}
		return "/main/message";
	}

        try {
            // 로그인 서비스 호출
            MemberVO user = memberService.login(member, response);
            if (user == null) {
                // 로그인 실패 원인에 대한 상세 로그 추가
                MemberVO dbUser = memberService.getMemberID(member.getMe_id());
                if (dbUser == null) {
                    logger.warn("로그인 실패: 존재하지 않는 사용자 ID - " + member.getMe_id());
                } else {
                    logger.warn("로그인 실패: 비밀번호 불일치 - 사용자 ID: " + member.getMe_id());
                }

                model.addAttribute("msg", "없는 아이디거나 잘못 입력하셨습니다");
                model.addAttribute("url", "/login");
                return "/main/message";
            }

            logger.info("로그인 성공: 사용자 ID - " + user.getMe_id());

            // 자동 로그인 플래그 설정
            boolean isAutoLogin = "true".equals(autologin);
            user.setAutoLogin(isAutoLogin);

            // 세션에 사용자 정보 저장
            session.setAttribute("user", user);
            logger.info("세션에 사용자 정보 저장: " + user);

            // 자동 로그인 선택 시 쿠키 설정
            if (isAutoLogin) {
                // 고유한 토큰 생성 (UUID 사용)
                String autoLoginToken = UUID.randomUUID().toString();
                logger.info("생성된 자동 로그인 토큰: " + autoLoginToken);

                // 자동 로그인 유효 시간 설정 (현재 시간에서 7일 뒤로 설정)
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.DAY_OF_MONTH, 7);
                Date limitDate = calendar.getTime();
                user.setMe_limit(limitDate);
                logger.info("자동 로그인 유효 시간 설정: " + limitDate);

                // 사용자 정보에 토큰 설정하고 DB 업데이트
                user.setMe_cookie(autoLoginToken);
                try {
                    memberService.updateMemberCookie(user);
                    logger.info("DB에 자동 로그인 토큰과 유효 시간 업데이트 완료: 사용자 ID: " + user.getMe_id());
                } catch (Exception e) {
                    logger.error("DB 업데이트 중 오류 발생: ", e);
                }

                // 쿠키 생성 및 설정 (7일 동안 유지)
                Cookie cookie = new Cookie("me_cookie", autoLoginToken);
                cookie.setMaxAge(7 * 24 * 60 * 60); // 7일 동안 유지
                cookie.setPath("/");
                response.addCookie(cookie);
                logger.info("자동 로그인 쿠키 설정 완료: 쿠키 이름 - me_cookie, 쿠키 값 - " + autoLoginToken);
            }

            model.addAttribute("msg", "로그인을 성공했습니다");
            model.addAttribute("url", "/");
            logger.info("로그인 성공: " + user.getMe_id() + " (자동 로그인: " + isAutoLogin + ")");
        } catch (Exception e) {
            logger.error("로그인 처리 중 오류 발생", e);
            model.addAttribute("msg", "로그인 처리 중 오류가 발생했습니다");
            model.addAttribute("url", "/login");
        }
        return "/main/message";
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(Model model, HttpSession session, HttpServletResponse response) {
        // 세션에서 사용자 정보 가져오기 (로그인된 사용자가 있는지 확인)
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        if (user != null) {
            logger.info("로그아웃 시도: 사용자 ID - " + user.getMe_id());
            // DB에서 me_cookie와 me_limit 값을 null로 업데이트
            memberService.clearLoginCookie(user.getMe_id());
            logger.info("DB에서 자동 로그인 정보 삭제 완료: 사용자 ID - " + user.getMe_id());
            // 세션에서 사용자 정보 제거 (로그아웃 처리)
            session.removeAttribute("user");
            logger.info("세션에서 사용자 정보 제거 완료");
        }
    
        // 로그아웃 시 쿠키 삭제
        Cookie cookie = new Cookie("me_cookie", null);
        cookie.setMaxAge(0); // 즉시 삭제
        cookie.setPath("/");
        response.addCookie(cookie);
        logger.info("자동 로그인 쿠키 삭제 완료");
        
        model.addAttribute("msg", "로그아웃 했습니다");
        model.addAttribute("url", "/");
        return "/main/message";
    }

    // 약관 페이지로 이동
    @GetMapping("/terms")
    public String termsPage() {
        logger.info("약관 페이지로 이동");
        return "/member/terms";
    }

    // 회원가입 페이지로 이동
    @GetMapping("/signup")
    public String signupPage() {
        logger.info("회원가입 페이지로 이동");
        return "/member/signup";
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String signupPost(Model model, MemberVO member) {
        // 회원 정보가 null인 경우 로그 및 메시지 처리
        if (member == null) {
            logger.error("회원 정보가 null입니다.");
            model.addAttribute("msg", "회원 정보가 null입니다.");
            model.addAttribute("url", "/signup");
            return "/main/message";
        }

        try {
            // 비밀번호 암호화 및 로그
            String encPw = passwordEncoder.encode(member.getMe_pw());
            logger.info("암호화된 비밀번호: " + encPw);  // 추가된 로그
            member.setMe_pw(encPw);
            
            // 회원가입 시도
            boolean res = memberDao.insertMember(member);
            if (res) {
                model.addAttribute("msg", "회원 가입을 했습니다.");
                model.addAttribute("url", "/");
                logger.info("회원 가입 성공: " + member.getMe_id());
            } else {
                model.addAttribute("msg", "회원 가입을 하지 못했습니다.");
                model.addAttribute("url", "/signup");
                logger.warn("회원 가입 실패: " + member.getMe_id());
            }
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("msg", "회원 가입에 실패했습니다. (중복된 아이디 또는 이메일일 수 있습니다.)");
            model.addAttribute("url", "/signup");
            logger.error("DataIntegrityViolationException 발생: 중복된 아이디 또는 이메일", e);  // 추가된 로그
        } catch (Exception e) {
            model.addAttribute("msg", "회원 가입 중 문제가 발생했습니다.");
            model.addAttribute("url", "/signup");
            logger.error("회원 가입 중 예기치 않은 오류 발생", e);  // 추가된 로그
        }

        // 전체 회원 정보 로그 (디버깅용)
        logger.info("회원 가입 정보: " + member);  // 추가된 로그

        return "/main/message";
    }
    
    // 아이디 중복 체크
    @ResponseBody
    @GetMapping("/check/id")
    public boolean checkId(@RequestParam("id") String id) {
        logger.info("아이디 중복 체크 시도: " + id);
        boolean res = memberService.checkId(id);
        logger.info("아이디 중복 체크 결과: " + id + " - " + (res ? "사용 가능" : "사용 불가"));
        return res;
    }
    
    // 아이디 찾기 페이지로 이동
    @GetMapping("/find/id")
    public String findID() {
        logger.info("아이디 찾기 페이지로 이동");
        return "/member/findId";
    }
    
    // 아이디 찾기 처리
    @ResponseBody
    @PostMapping("/find/id")
    public String findIdPost(@RequestParam String name, @RequestParam String email) {
        logger.info("아이디 찾기 시도: 이름 - " + name + ", 이메일 - " + email);
        String userId = memberService.findId(name, email);
        logger.info("아이디 찾기 결과: " + (userId != null ? userId : "찾기 실패"));
        return userId != null ? userId : "fail";
    }
    
    // 비밀번호 찾기 페이지로 이동
    @GetMapping("/find/pw")
    public String findPw() {
        logger.info("비밀번호 찾기 페이지로 이동");
        return "/member/findPw";
    }
    
    // 비밀번호 찾기 처리
    @ResponseBody
    @PostMapping("/find/pw")
    public boolean findPwPost(@RequestParam String id) {
        logger.info("비밀번호 찾기 시도: 사용자 ID - " + id);
        boolean res = memberService.findPw(id);
        logger.info("비밀번호 찾기 결과: 사용자 ID - " + id + " - " + (res ? "성공" : "실패"));
        return res;
    }
}
