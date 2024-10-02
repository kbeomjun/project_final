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
    public String login(MemberVO member, Model model, HttpSession session, HttpServletResponse response) {
        logger.info("로그인 시도: " + member.getMe_id()); // 로그인 시도 로그

        try {
            MemberVO user = memberService.login(member, response);
            if (user != null) {
                session.setAttribute("user", user);

                Cookie cookie = new Cookie("me_cookie", user.getMe_id());
                cookie.setMaxAge(48 * 60 * 60); // 48시간
                cookie.setPath("/"); // 모든 경로에서 유효
                response.addCookie(cookie);
                
                model.addAttribute("msg", "로그인을 성공했습니다");
                model.addAttribute("url", "/");
                logger.info("로그인 성공: " + user.getMe_id()); // 로그인 성공 로그
            } else {
                model.addAttribute("msg", "없는 아이디거나 잘못 입력하셨습니다");
                model.addAttribute("url", "/login");
                logger.warn("로그인 실패: 없는 아이디 또는 비밀번호 불일치"); // 로그인 실패 로그
            }
            model.addAttribute("user", user);
        } catch (Exception e) {
            logger.error("로그인 처리 중 오류 발생", e); // 예외 발생 시 로그 기록
            model.addAttribute("msg", "로그인 처리 중 오류가 발생했습니다");
            model.addAttribute("url", "/login");
        }
        return "/main/message";
    }

    @GetMapping("/logout")
    public String logout(Model model, HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("user");
        session.removeAttribute("user");
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
    public String signupPost(Model model, MemberVO member, 
                             @RequestParam("me_emailId") String emailId, 
                             @RequestParam("me_emailDomain") String emailDomain) {
        if (member == null) {
            logger.error("회원 정보가 null입니다.");
            model.addAttribute("msg", "회원 정보가 null입니다.");
            model.addAttribute("url", "/signup");
            return "/main/message";
        }

        try {
            // 이메일을 합쳐서 member 객체에 설정
            String fullEmail = emailId + "@" + emailDomain;
            member.setMe_email(fullEmail);

            // 전화번호 로그
            logger.info("전화번호 (me_phone): " + member.getMe_phone());  // 추가된 로그

            // 비밀번호 암호화
            String encPw = passwordEncoder.encode(member.getMe_pw());
            member.setMe_pw(encPw);
            
            // 회원가입 시도
            boolean res = memberDao.insertMember(member);
            if (res) {
                model.addAttribute("msg", "회원 가입을 했습니다.");
                model.addAttribute("url", "/");
            } else {
                model.addAttribute("msg", "회원 가입을 하지 못했습니다.");
                model.addAttribute("url", "/signup");
            }
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("msg", "회원 가입에 실패했습니다. (중복된 아이디 또는 이메일일 수 있습니다.)");
            model.addAttribute("url", "/signup");
        } catch (Exception e) {
            model.addAttribute("msg", "회원 가입 중 문제가 발생했습니다.");
            model.addAttribute("url", "/signup");
        }

        // 전체 회원 정보 로그
        logger.info("회원 가입 정보: " + member); // 추가된 로그

        return "/main/message";
    }
    @ResponseBody
	@GetMapping("/check/id")
	public boolean checkId(@RequestParam("id")String id) {
		boolean res = memberService.checkId(id);
		return res;
	}
}