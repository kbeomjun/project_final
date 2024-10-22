package kr.kh.fitness.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.dao.MemberDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.KakaoService;
import kr.kh.fitness.service.MemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class UserController {

	private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private String kakaoApiKey;
	
	@Autowired
	private String kakaoRedirectUri;

	@Autowired
	KakaoService kakaoService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	private MemberDAO memberDao;

	@Autowired
	private MemberService memberService;

	@GetMapping("/login")
	public String loginPage(Model model) {
		model.addAttribute("kakaoApiKey", kakaoApiKey);
		model.addAttribute("redirectUri", kakaoRedirectUri);
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
		session.removeAttribute("user");
		// 로그아웃 시 쿠키 삭제
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
	public String signupPost(Model model, MemberVO member, @RequestParam("me_emailId") String emailId,
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
			logger.info("전화번호 (me_phone): " + member.getMe_phone()); // 추가된 로그

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
	public boolean checkId(@RequestParam("id") String id) {

		boolean res = memberService.checkId(id);
		return res;
	}
	
	@GetMapping("/oauth/kakao")
    public String kakaoLogin(Model model, HttpSession session, @RequestParam("code") String code) {// Data를 리턴해주는 컨트롤러 함수, 쿼리스트링에 있는 code값을 받을 수 있음
		// POST 방식으로 key=value 데이터를 요청 (카카오톡으로)
		/*
		 * Retrofit2 OkHttp HttpsURLConnection RestTemplate
		 */
		log.info("/oauth/kakao");
		//System.out.println("code:: " + code);
		
		// 카카오에서 준 code를 통해서 accessToken을 받아 온다.
        String kakaoToken = kakaoService.getReturnAccessToken(code);
        //System.out.println("kakaoToken:: " + kakaoToken);
		
        // accessToken을 통해서 소셜 로그인 정보를 가져온다.
        MemberVO loginUser = kakaoService.getUserInfo(kakaoToken);
        
        if(loginUser == null) {
        	model.addAttribute("msg", "로그인에 실패했습니다. \\n(카카오 계정 정보를 가져올 수 없습니다.)");
			model.addAttribute("url", "/login");	
			return "/main/message";
        }
        
        // email로 user 정보를 가져온다.
        MemberVO user = kakaoService.getMemberInfoFromEmail(loginUser);
        
        if(user != null) {
        	// 로그인 성공, session에 추가.
        	if(user.getMe_kakaoUserId() != null && loginUser.getMe_kakaoUserId().equals(user.getMe_kakaoUserId())) {
        		session.setAttribute("user", user);
        		session.setAttribute("socialType", "KAKAO");
        		model.addAttribute("msg", user.getMe_id()+"님 환영합니다 \\n(카카오 계정으로 로그인 했습니다.)");
				model.addAttribute("url", "/");
        	}// user 정보와 이메일이 일치하나 kakaoId가 일치하지 않는 경우.
        	else if(user.getMe_kakaoUserId() != null && user.getMe_kakaoUserId().trim().length() != 0 && !loginUser.getMe_kakaoUserId().equals(user.getMe_kakaoUserId()) ) {
        		model.addAttribute("msg", "등록된 카카오톡 계정과 일치하지 않습니다 \\n(기존 계정으로 로그인 해주세요.)");
				model.addAttribute("url", "/login");
        	} // email 정보는 있으나, kakaoId가 등록되지 않는 경우.
        	else if(user.getMe_kakaoUserId() == null || user.getMe_kakaoUserId().trim().length() ==0) {
        		try {
                    String encodedGender = URLEncoder.encode(loginUser.getMe_gender(), "UTF-8");
                    String encodedName = URLEncoder.encode(loginUser.getMe_name(), "UTF-8");

                    return "redirect:/sso/matchRedirect?socialType=KAKAO&id=" + loginUser.getMe_kakaoUserId()
                            + "&gender=" + encodedGender + "&phone=" + loginUser.getMe_phone() + "&name=" + encodedName + "&me_id=" + user.getMe_id();
                    
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                    model.addAttribute("msg", "인코딩 오류가 발생했습니다. \\n(관리자 문의!!)");
                    model.addAttribute("url", "/login");
                    return "/main/message";
                }
    		}
        }
        else{
            try {
                // 한글 값들을 URL 인코딩하여 전달
                String encodedGender = URLEncoder.encode(loginUser.getMe_gender(), "UTF-8");
                String encodedName = URLEncoder.encode(loginUser.getMe_name(), "UTF-8");

                return "redirect:/sso/joinRedirect?socialType=KAKAO&email=" + loginUser.getMe_email() + "&id=" + loginUser.getMe_kakaoUserId()
                        + "&gender=" + encodedGender + "&phone=" + loginUser.getMe_phone() + "&name=" + encodedName;
                
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
                model.addAttribute("msg", "인코딩 오류가 발생했습니다. \\n(관리자 문의!!)");
                model.addAttribute("url", "/login");
                return "/main/message";
            }
        }
        return "/main/message";
     
	}
	
	@GetMapping("/sso/joinRedirect")
	public String socialJoinRedirect(
            @RequestParam(value = "socialType") String socialType,
            @RequestParam(value = "email") String email,
            @RequestParam(value = "id") String id,
            @RequestParam(value = "gender") String gender,
            @RequestParam(value = "phone") String phone,
            @RequestParam(value = "name") String name,
            Model model) {
        log.info("/sso/join/redirect");
        
        // 받은 파라미터를 모델에 추가하여 뷰에서 사용할 수 있도록 설정
        model.addAttribute("socialType", socialType);
        model.addAttribute("email", email);
        model.addAttribute("id", id);
        model.addAttribute("gender", gender);
        model.addAttribute("phone", phone);
        model.addAttribute("name", name);

	    return "/sso/joinRedirect";
	}
	
	@PostMapping("/sso/joinRedirect")
	public String socialJoinRedirectPost(
	        @RequestParam("socialType") String socialType,
	        @ModelAttribute MemberVO socialUser,
	        Model model) {
		
		log.info("/sso/joinRedirect - post");
		
	    // 받은 파라미터를 모델에 추가하여 뷰에서 사용할 수 있도록 설정
	    model.addAttribute("socialType", socialType);
	    model.addAttribute("socialUser", socialUser);

	    // 뷰 페이지 리턴 (예: join.jsp)
	    return "/sso/join";
	    
	}

	@PostMapping("/sso/join")
	public String socialJoinPost(
			Model model, 
			@ModelAttribute MemberVO socialUser, 
			@RequestParam("social_type") String social_type) {
		log.info("/sso/join - POST");
		 // token을 통해서 소셜 로그인 정보를 가져온다.
		System.out.println(socialUser);
		System.out.println("email : " + socialUser.getMe_email());
		
		boolean res = memberService.joinSocialMember(social_type, socialUser);
		
		if(res) {
			model.addAttribute("msg","간편 가입이 완료되었습니다. \\n 로그인을 다시 해주세요.");
		}
		else {
			model.addAttribute("msg","간편 가입이 실패하였습니다.");
		}
		model.addAttribute("url","/");
	    return "/main/message";
	}
	
	@GetMapping("/sso/matchRedirect")
	public String socialMatchRedirect(
            @RequestParam(value = "socialType") String socialType, 
            @RequestParam(value = "id") String id,
            @RequestParam(value = "gender") String gender,
            @RequestParam(value = "phone") String phone,
            @RequestParam(value = "name") String name,
            @RequestParam(value = "me_id") String me_id,
            Model model) {
        log.info("/sso/match/redirect");
        
        // 받은 파라미터를 모델에 추가하여 뷰에서 사용할 수 있도록 설정
        model.addAttribute("socialType", socialType);
        model.addAttribute("id", id);
        model.addAttribute("gender", gender);
        model.addAttribute("phone", phone);
        model.addAttribute("name", name);
        model.addAttribute("me_id", me_id);

	    return "/sso/matchRedirect";
	}
	
	@PostMapping("/sso/matchRedirect")
	public String socialMatchRedirectPost(
	        @RequestParam("socialType") String socialType,
	        @ModelAttribute MemberVO user,
	        Model model) {
		
		log.info("/sso/matchRedirect - post");
		
	    // 받은 파라미터를 모델에 추가하여 뷰에서 사용할 수 있도록 설정
	    model.addAttribute("socialType", socialType);
	    model.addAttribute("user", user);

	    return "/sso/match";
	    
	}
	
	@PostMapping("/sso/match")
	public String socialMatchPost(
			Model model, 
			@ModelAttribute MemberVO socialUser, 
			@RequestParam("social_type") String social_type) {
		log.info("/sso/match - POST");
		 // token을 통해서 소셜 로그인 정보를 가져온다.
		System.out.println(socialUser);
		
		boolean res= memberService.updateUserSocialAccount(social_type, socialUser);
		
		if(res) {
			model.addAttribute("msg","기존 계정과 연동이 완료되었습니다. \\n 로그인을 다시 해주세요.");
		}
		else {
			model.addAttribute("msg","계정 연동에 실패하였습니다.");
		}
		model.addAttribute("url","/");
	    return "/main/message";
	}
}
