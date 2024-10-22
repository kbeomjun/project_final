package kr.kh.fitness.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
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
	            
	            if(user.getMe_authority().equals("REMOVED")) {
					model.addAttribute("msg", "탈퇴한 회원입니다.");
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

	@GetMapping("/terms")
	public String termsPage() {
		logger.info("약관 페이지로 이동");
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
        			// 한글 값들을 URL 인코딩하여 전달
            		String encodedGender = (loginUser.getMe_gender()!=null)?URLEncoder.encode(loginUser.getMe_gender(), "UTF-8"):null;
                    String encodedName = (loginUser.getMe_name()!=null)?URLEncoder.encode(loginUser.getMe_name(), "UTF-8"):null;

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
        		String encodedGender = (loginUser.getMe_gender()!=null)?URLEncoder.encode(loginUser.getMe_gender(), "UTF-8"):null;
                String encodedName = (loginUser.getMe_name()!=null)?URLEncoder.encode(loginUser.getMe_name(), "UTF-8"):null;

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
    public Map<String, Object> findIdPost(@RequestParam String name, @RequestParam String email) {
        logger.info("아이디 찾기 시도: 이름 - " + name + ", 이메일 - " + email);
        
        Map<String, Object> response = new HashMap<>();
        String userId = memberService.findId(name, email);
        
        if (userId != null) {
            response.put("success", true);
            response.put("username", userId);
            logger.info("아이디 찾기 결과: " + userId);
        } else {
            response.put("success", false);
            logger.info("아이디 찾기 결과: 찾기 실패");
        }
        
        return response; // JSON 형식의 응답 반환
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
