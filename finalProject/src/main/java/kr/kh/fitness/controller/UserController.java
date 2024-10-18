package kr.kh.fitness.controller;

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

    @GetMapping("/login")
    public String loginPage() {
        return "/member/login";
    }    

    @PostMapping("/login")
    public String login(MemberVO member, @RequestParam(value = "autologin", required = false) String autologin, 
                        Model model, HttpSession session, HttpServletResponse response) {
        logger.info("로그인 시도: " + member.getMe_id()); // 로그인 시도 로그

        try {
            MemberVO user = memberService.login(member, response);
            if (user != null) {
                // 자동 로그인 플래그 설정: 체크박스가 선택되었으면 "true"로 전송됨
                boolean isAutoLogin = "true".equals(autologin);
                user.setAutoLogin(isAutoLogin);

                session.setAttribute("user", user);
                model.addAttribute("msg", "로그인을 성공했습니다");
                model.addAttribute("url", "/");
                logger.info("로그인 성공: " + user.getMe_id() + " (자동 로그인: " + isAutoLogin + ")");
            } else {
                model.addAttribute("msg", "없는 아이디거나 잘못 입력하셨습니다");
                model.addAttribute("url", "/login");
                logger.warn("로그인 실패: 없는 아이디 또는 비밀번호 불일치");
            }
            model.addAttribute("user", user);
        } catch (Exception e) {
            logger.error("로그인 처리 중 오류 발생", e);
            model.addAttribute("msg", "로그인 처리 중 오류가 발생했습니다");
            model.addAttribute("url", "/login");
        }
        return "/main/message";
    }


    @GetMapping("/logout")
    public String logout(Model model, HttpSession session, HttpServletResponse response) {
        // 세션에서 사용자 정보 가져오기 (로그인된 사용자가 있는지 확인)
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        if (user != null) {
            // DB에서 me_cookie와 me_limit 값을 null로 업데이트
            memberService.clearLoginCookie(user.getMe_id());
            // 세션에서 사용자 정보 제거 (로그아웃 처리)
            session.removeAttribute("user");
        }
    
        session.removeAttribute("user");
        //로그아웃 시 쿠키 삭제
        Cookie cookie = new Cookie("me_cookie", null);
        cookie.setMaxAge(0); // 즉시 삭제
        cookie.setPath("/");
        response.addCookie(cookie);
        
        model.addAttribute("msg", "로그아웃 했습니다");
        model.addAttribute("url", "/");
        return "/main/message";
    }

    @GetMapping("/terms")
    public String termsPage() {
        return "/member/terms";
    }

    // 회원가입 페이지
    @GetMapping("/signup")
    public String signupPage() {
        return "/member/signup";
    }

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
            // 이메일을 합쳐서 member 객체에 설정
            //String fullEmail = emailId + "@" + emailDomain;
            //member.setMe_email(fullEmail);
            logger.info("합쳐진 이메일: " + member.getMe_email());  // 추가된 로그

            // 전화번호 로그
            logger.info("전화번호 (me_phone): " + member.getMe_phone());

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
    
    @ResponseBody
	@GetMapping("/check/id")
	public boolean checkId(@RequestParam("id")String id) {
		boolean res = memberService.checkId(id);
		return res;
	}
    
    @GetMapping("/find/id")
	public String findID() {
		return "/member/findId";
	}
    
    @ResponseBody
    @PostMapping("/find/id")
    public String findIdPost(@RequestParam String name, @RequestParam String email) {
        String userId = memberService.findId(name, email);
        return userId != null ? userId : "fail";
    }
    
    //비밀번호 찾기
    @GetMapping("/find/pw")
	public String findPw() {
		return "/member/findPw";
	}
    
	@ResponseBody
	@PostMapping("/find/pw")
	public boolean findPwPost(@RequestParam String id) {
		boolean res = memberService.findPw(id);
		return res;
	}
}
