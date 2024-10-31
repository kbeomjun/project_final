package kr.kh.fitness.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;
import kr.kh.fitness.service.SingleSignOnService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class UserController {

	// private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private String kakaoApiKey;
	
	@Autowired
	private String kakaoRedirectUri;
	
	@Autowired
	private String naverClientId;
	@Autowired
	private String naverClientSecret;
	@Autowired
	private String naverCallbackUrl;

	@Autowired
	private SingleSignOnService singleSignOnService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

//	@Autowired
//	private MemberDAO memberDao;

	@Autowired
	private MemberService memberService;

	@GetMapping("/login")
	public String loginPage(Model model, HttpSession session, HttpServletRequest request) {
		
		session.removeAttribute("pw_check");
		
		String prevUrl = request.getHeader("Referer");
		if (prevUrl != null && !prevUrl.contains("/login")) {
			request.getSession().setAttribute("prevUrl", prevUrl);
		}
		
	    String redirectURI;
		try {
			redirectURI = URLEncoder.encode(naverCallbackUrl, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			model.addAttribute("msg", "로그인에 실패했습니다. \\n(네이버 접근이 일시적으로 제한됩니다.)");
			model.addAttribute("url", "/login");	
			return "/main/message";
		}
		
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    
	    String naverApiUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    naverApiUrl += "&client_id=" + naverClientId;
	    naverApiUrl += "&redirect_uri=" + redirectURI;
	    naverApiUrl += "&state=" + state;
	    
	    model.addAttribute("naverApiUrl", naverApiUrl);
	    model.addAttribute("state", state);
	    model.addAttribute("clientId", naverClientId);
	    model.addAttribute("redirectURI", redirectURI);
	    
		model.addAttribute("kakaoApiKey", kakaoApiKey);
		model.addAttribute("kakaoRedirectUri", kakaoRedirectUri);
		
		return "/member/login";
	}

	@PostMapping("/login")
	public String login(MemberVO member, @RequestParam(value = "autologin", required = false) String autologin,
			Model model, HttpSession session, HttpServletResponse response) {
		 log.info("로그인 시도: " + member.getMe_id()); // 로그인 시도 로그
		 
		 //네이버 하고 정보변경 페이지에 연동
	        try {
	            // 로그인 서비스 호출
	            MemberVO user = memberService.login(member);
	            if (user == null) {
	                // 로그인 실패 원인에 대한 상세 로그 추가
	                MemberVO dbUser = memberService.getMemberID(member.getMe_id());
	                if (dbUser == null) {
	                    log.warn("로그인 실패: 존재하지 않는 사용자 ID - " + member.getMe_id());
	                } else {
	                    log.warn("로그인 실패: 비밀번호 불일치 - 사용자 ID: " + member.getMe_id());
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

	            log.info("로그인 성공: 사용자 ID - " + user.getMe_id());

	            // 자동 로그인 플래그 설정
	            boolean isAutoLogin = "true".equals(autologin);
	            user.setAutoLogin(isAutoLogin);

	            // 세션에 사용자 정보 저장
	            session.setAttribute("user", user);
	            log.info("세션에 사용자 정보 저장: " + user);

	            // 자동 로그인 선택 시 쿠키 설정
	            if (isAutoLogin) {
	            	memberService.setAutoLoginCookie(user, response);
	            }

	            model.addAttribute("msg", "로그인을 성공했습니다");
	            
	            String prevUrl = (String)session.getAttribute("prevUrl");
	    		
	    		if (prevUrl != null) {
	    			model.addAttribute("url", prevUrl);
	    			session.removeAttribute("prevUrl");
	    		}
	    		else {
	    			model.addAttribute("url", "/");
	    		}
	            log.info("로그인 성공: " + user.getMe_id() + " (자동 로그인: " + isAutoLogin + ")");
	        } catch (Exception e) {
	            log.error("로그인 처리 중 오류 발생", e);
	            model.addAttribute("msg", "로그인 처리 중 오류가 발생했습니다");
	            model.addAttribute("url", "/login");
	        }
	        return "/main/message";
	}

	@GetMapping("/logout")
	public String logout(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		// 세션에서 사용자 정보 가져오기 (로그인된 사용자가 있는지 확인)
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user != null) {
            log.info("로그아웃 시도: 사용자 ID - " + user.getMe_id());
            // DB에서 me_cookie와 me_limit 값을 null로 업데이트
            memberService.clearLoginCookie(user.getMe_id());
            log.info("DB에서 자동 로그인 정보 삭제 완료: 사용자 ID - " + user.getMe_id());
            // 세션에서 사용자 정보 제거 (로그아웃 처리)
            session.removeAttribute("user");
            log.info("세션에서 사용자 정보 제거 완료");

			session.removeAttribute("token");
			session.removeAttribute("socialType");
			log.info("세션에서 소셜 토큰 정보 제거 완료");

        }

        // 로그아웃 시 쿠키 삭제
        Cookie cookie = new Cookie("me_cookie", null);
        cookie.setMaxAge(0); // 즉시 삭제
        cookie.setPath("/");
        response.addCookie(cookie);
        log.info("자동 로그인 쿠키 삭제 완료");

        model.addAttribute("msg", "로그아웃 했습니다");
        
        String prevUrl = request.getHeader("Referer");
		if (prevUrl != null) {
			model.addAttribute("url", prevUrl);
			session.removeAttribute("prevUrl");
		}
		else {
			model.addAttribute("url", "/");
		}
        return "/main/message";
	}

	@GetMapping("/terms")
	public String termsPage() {
		log.info("약관 페이지로 이동");
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
			log.error("회원 정보가 null입니다.");
			model.addAttribute("msg", "회원 정보가 null입니다.");
			model.addAttribute("url", "/signup");
			return "/main/message";
		}

		try {
			// 이메일을 합쳐서 member 객체에 설정
			String fullEmail = emailId + "@" + emailDomain;
			member.setMe_email(fullEmail);

			// 전화번호 로그
			log.info("전화번호 (me_phone): " + member.getMe_phone()); // 추가된 로그
			
			// 회원가입 시도
			//boolean res = memberDao.insertMember(member);
			boolean res = memberService.signup(member);
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
		log.info("회원 가입 정보: " + member); // 추가된 로그

		return "/main/message";
	}

    // 아이디 중복 체크
    @ResponseBody
    @GetMapping("/check/id")
    public boolean checkId(@RequestParam("id") String id) {
        log.info("아이디 중복 체크 시도: " + id);
        boolean res = memberService.checkId(id);
        log.info("아이디 중복 체크 결과: " + id + " - " + (res ? "사용 가능" : "사용 불가"));
        return res;
    }
    
    // 아이디 찾기 페이지로 이동
    @GetMapping("/find/id")
    public String findID() {
        log.info("아이디 찾기 페이지로 이동");
        return "/member/findId";
    }
    
    // 아이디 찾기 처리
    @ResponseBody
    @PostMapping("/find/id")
    public Map<String, Object> findIdPost(@RequestParam String name, @RequestParam String email) {
        log.info("아이디 찾기 시도: 이름 - " + name + ", 이메일 - " + email);
        
        Map<String, Object> response = new HashMap<>();
        String userId = memberService.findId(name, email);
        
        if (userId != null) {
            response.put("success", true);
            response.put("username", userId);
            log.info("아이디 찾기 결과: " + userId);
        } else {
            response.put("success", false);
            log.info("아이디 찾기 결과: 찾기 실패");
        }
        
        return response; // JSON 형식의 응답 반환
    }
    
    // 비밀번호 찾기 페이지로 이동
    @GetMapping("/find/pw")
    public String findPw() {
        log.info("비밀번호 찾기 페이지로 이동");
        return "/member/findPw";
    }
    
    // 비밀번호 찾기 처리
    @ResponseBody
    @PostMapping("/find/pw")
    public boolean findPwPost(@RequestParam String id) {
        log.info("비밀번호 찾기 시도: 사용자 ID - " + id);
        boolean res = memberService.findPw(id);
        log.info("비밀번호 찾기 결과: 사용자 ID - " + id + " - " + (res ? "성공" : "실패"));
        return res;
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
		boolean res = memberService.joinSocialMember(social_type, socialUser);
		
		if(res) {
			model.addAttribute("msg","간편 가입이 완료되었습니다. \\n 로그인을 다시 해주세요.");
		}
		else {
			model.addAttribute("msg","간편 가입이 실패하였습니다.");
		}
		model.addAttribute("url","/login");
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
	
	
	
	@PostMapping("/sso/match/login")
	public String socialMatchLoginPost(
			Model model, 
			@ModelAttribute MemberVO socialUser, 
			@RequestParam("social_type") String social_type) {
		log.info("/sso/match/login - POST");
		 // token을 통해서 소셜 로그인 정보를 가져온다.
		
		MemberVO user = memberService.login(socialUser);
		if(user == null) {
			model.addAttribute("msg","계정 연동에 실패하였습니다.\\n 아이디/패스워드가 일치하지 않습니다.");
		}
		else if(user.getMe_authority().equals("REMOVED")) {
			
			model.addAttribute("msg", "탈퇴한 회원입니다.");
		} 
		else {	
			boolean res= memberService.updateUserSocialAccount(social_type, socialUser);
			
			if(res) {
				model.addAttribute("msg","기존 계정과 연동이 완료되었습니다. \\n 로그인을 다시 해주세요.");
				model.addAttribute("url","/login");
				return "/main/message";
			}
			else {
				model.addAttribute("msg","계정 연동에 실패하였습니다. \\n 연동 과정에서 오류가 발생했습니다 \\n 관리자 문의");
			}
		}
		model.addAttribute("url","/login");
		return "/main/message";
	}

	@GetMapping("/oauth/kakao")
	public String kakaoLogin(Model model, HttpSession session, HttpServletResponse response, @RequestParam("code") String code) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			if(user.getMe_kakaoUserId() == null) {
				return userSocialConnection(model, session, "KAKAO", code, user, null);
			}
			session.setAttribute("socialType", "KAKAO");
			model.addAttribute("member", user);
			return "/mypage/info";
		}
	    return handleSocialLogin(model, session, response, "KAKAO", code, null);
	}

	@GetMapping("/oauth/naver")
	public String naverCallback(Model model, 
		    HttpSession session, 
		    HttpServletResponse response, 
		    HttpServletRequest request,
		    @RequestParam(value = "code", required = false) String code,
		    @RequestParam(value = "error", required = false) String error,
		    @RequestParam(value = "error_description", required = false) String errorDescription,
		    @RequestParam(value = "state", required = false) String state
		) {
		
	    if(code != null){
		    	MemberVO user = (MemberVO)session.getAttribute("user");
		    
			if(user != null) {
				if(user.getMe_naverUserId() == null) {
					return userSocialConnection(model, session, "NAVER", code, user, state);
				}
				session.setAttribute("socialType", "NAVER");
				model.addAttribute("member", user);
				return "/mypage/info";
			}
		    return handleSocialLogin(model, session, response, "NAVER", code, state);
	    }
	    // 네이버 로그인 '동의하기'에서 '취소'를 눌렀을 경우 -> 로그인 페이지로 이동
	    else if (errorDescription != null && errorDescription.equals("Canceled By User")) {
	    	
	    	if((boolean)session.getAttribute("pw_check")) {
	    		session.removeAttribute("pw_check");
	    		model.addAttribute("url", "/mypage/pwcheck");
	    	}
	    	else{
	    		model.addAttribute("url", "/login");
	    	}
	    }
	    else {
	    	model.addAttribute("msg", "네이버 연결에 실패했습니다. \\n(관리자에게 문의하세요)");
	    	model.addAttribute("url", "/login");
	    }
	    return "/main/message";
	}
	
	private String userSocialConnection(Model model, HttpSession session, String socialType, String code, MemberVO user, String state) {
	    String token;
	    MemberVO loginUser;
	    String socialId;
		
		if ("KAKAO".equals(socialType)) {
	        token = singleSignOnService.getReturnAccessTokenKakao(code);
	        loginUser = singleSignOnService.getUserInfoFromKakaoToken(token);
	        socialId = getUserIdBySocialType(loginUser, socialType);
	    } else {
	        token = singleSignOnService.getAccessTokenFromNaver(code, state, naverClientId, naverClientSecret);
	        loginUser = singleSignOnService.getUserInfoFromNaverToken(token);
	        socialId = getUserIdBySocialType(loginUser, socialType);
	    }
		
	    if (token == null || loginUser == null) {
	        model.addAttribute("msg", "연결에 실패했습니다. \\n(" + socialType + " 계정 정보를 가져올 수 없습니다.)");
	        model.addAttribute("url", "/mypage/pwCheck");
	        return "/main/message";
	    }
	    
	    
    	if(memberService.updateSocialConnection(user.getMe_id(), socialId, socialType)) {
    		MemberVO updateUser = memberService.getMember(user.getMe_id());
    		session.setAttribute("user", updateUser);
    		session.setAttribute("socialType", socialType);
    		return "redirect:/mypage/info";
    	} else {
    		return "/mypage/pwCheck";
    	}
	}

	private String handleSocialLogin(Model model, HttpSession session, HttpServletResponse response, String socialType, String code, String state) {
	    log.info("/oauth/" + socialType.toLowerCase());

	    String token;
	    MemberVO loginUser;
	    
	    // 토큰 및 사용자 정보 가져오기
	    if ("KAKAO".equals(socialType)) {
	        token = singleSignOnService.getReturnAccessTokenKakao(code);
	        loginUser = singleSignOnService.getUserInfoFromKakaoToken(token);
	    } else {
	        token = singleSignOnService.getAccessTokenFromNaver(code, state, naverClientId, naverClientSecret);
	        loginUser = singleSignOnService.getUserInfoFromNaverToken(token);
	    }

	    if (token == null || loginUser == null) {
	        model.addAttribute("msg", "로그인에 실패했습니다. \\n(" + socialType + " 계정 정보를 가져올 수 없습니다.)");
	        model.addAttribute("url", "/login");
	        return "/main/message";
	    }

	    // 이메일로 사용자 정보 가져오기
	    MemberVO user = singleSignOnService.getMemberInfoFromSocial(socialType, loginUser);
	    String loginUserId = getUserIdBySocialType(loginUser, socialType);
	    String userId = getUserIdBySocialType(user, socialType);

	    if (user != null) {
	        if ("REMOVED".equals(user.getMe_authority())) {
	            model.addAttribute("msg", "이미 탈퇴한 계정입니다.");
	            model.addAttribute("url", "/login");
	            return "/main/message";
	        }

	        // 소셜 ID 일치 여부 확인
	        if (userId != null && userId.equals(loginUserId)) {
	        	Integer autoLogin = (Integer) session.getAttribute("socialAutoLogin");
	        	if (autoLogin != null && autoLogin == 1) {
	        		
	            	memberService.setAutoLoginCookie(user, response);
	        		session.removeAttribute("socialAutoLogin");
	        	}
	        	session.setAttribute("access_token", token);
	            session.setAttribute("user", user);
	            session.setAttribute("socialType", socialType);
	            model.addAttribute("msg", user.getMe_id() + "님 환영합니다 \\n(" + socialType + " 계정으로 로그인 했습니다.)");
	            
	            String prevUrl = (String)session.getAttribute("prevUrl");
	    		if (prevUrl != null) {
	    			model.addAttribute("url", prevUrl);
	    			session.removeAttribute("prevUrl");
	    		}
	    		else {
	    			model.addAttribute("url", "/");
	    		}
	        } else if (userId != null && !userId.trim().isEmpty() && !loginUserId.equals(userId)) {
	            model.addAttribute("msg", "등록된 " + socialType + " 계정과 일치하지 않습니다 \\n(기존 계정으로 로그인 해주세요.)");
	            model.addAttribute("url", "/login");
	        } else {
	            return redirectToMatch(model, socialType, loginUser, user.getMe_id());
	        }
	    } else {
	        return redirectToJoin(model, socialType, loginUser);
	    }

	    return "/main/message";
	}

	private String redirectToMatch(Model model, String socialType, MemberVO loginUser, String meId) {
	    try {
	        String encodedGender = (loginUser.getMe_gender() != null) ? URLEncoder.encode(loginUser.getMe_gender(), "UTF-8") : null;
	        String encodedName = (loginUser.getMe_name() != null) ? URLEncoder.encode(loginUser.getMe_name(), "UTF-8") : null;
	        String userId = getUserIdBySocialType(loginUser, socialType);
	        
	        return "redirect:/sso/matchRedirect?socialType=" + socialType + "&id=" + userId
	                + "&gender=" + encodedGender + "&phone=" + loginUser.getMe_phone() + "&name=" + encodedName + "&me_id=" + meId;
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	        model.addAttribute("msg", "인코딩 오류가 발생했습니다. \\n(관리자 문의!!)");
	        model.addAttribute("url", "/login");
	        return "/main/message";
	    }
	}

	private String getUserIdBySocialType(MemberVO user, String socialType) {
	    if (user == null) {
	        return null;
	    }
	    if ("KAKAO".equals(socialType)) {
	        return user.getMe_kakaoUserId();
	    } else if ("NAVER".equals(socialType)) {
	        return user.getMe_naverUserId();
	    }
	    return null;
	}
	
	private String redirectToJoin(Model model, String socialType, MemberVO loginUser) {
		 try {
		        String encodedGender = (loginUser.getMe_gender() != null) ? URLEncoder.encode(loginUser.getMe_gender(), "UTF-8") : null;
		        String encodedName = (loginUser.getMe_name() != null) ? URLEncoder.encode(loginUser.getMe_name(), "UTF-8") : null;
		        String userId = getUserIdBySocialType(loginUser, socialType);

		        return "redirect:/sso/joinRedirect?socialType=" + socialType + "&email=" + loginUser.getMe_email()
		                + "&id=" + userId + "&gender=" + encodedGender + "&phone=" + loginUser.getMe_phone() 
		                + "&name=" + encodedName;
		    } catch (UnsupportedEncodingException e) {
		        e.printStackTrace();
		        model.addAttribute("msg", "인코딩 오류가 발생했습니다. \\n(관리자 문의!!)");
		        model.addAttribute("url", "/login");
		        return "/main/message";
		    }
	}
	
	@PostMapping("/oauth/autoLogin")
    @ResponseBody
    public boolean oauthAutoLogin(HttpSession session, @RequestParam("autoLogin") Integer autoLogin) {
		
		session.removeAttribute("socialAutoLogin");
		session.setAttribute("socialAutoLogin", autoLogin);
		return autoLogin==1?true:false;
		
    }
    
}
