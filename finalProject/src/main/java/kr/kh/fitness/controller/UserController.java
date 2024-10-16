package kr.kh.fitness.controller;

import java.util.Map;

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
    public String kakaoLogin(Model model, @RequestParam("code") String code) {// Data를 리턴해주는 컨트롤러 함수, 쿼리스트링에 있는 code값을 받을 수 있음
		// POST 방식으로 key=value 데이터를 요청 (카카오톡으로)
		/*
		 * Retrofit2 OkHttp HttpsURLConnection RestTemplate (우린 이걸로 할거다)
		 */
		System.out.println("code:: " + code);
		
		// 접속토큰 get
        String kakaoToken = kakaoService.getReturnAccessToken(code);
        System.out.println("kakaoToken:: " + kakaoToken);
		
        // 접속자 정보 get
        Map<String, Object> result = kakaoService.getUserInfo(kakaoToken);
        log.info("result:: " + result);
        String snsId = (String) result.get("id");
        String userName = (String) result.get("nickname");
        String email = (String) result.get("email");
        String userpw = snsId;
        
		return "";
	}
}

/*
RestTemplate rt = new RestTemplate();

		// HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // 내가 지금 전송할 body data 가
																						// key=velue 형임을 명시

		// HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "b9d1d15c7c76c5b18e989b19383acaf0");
		params.add("redirect_uri", "http://localhost:8001/auth/kakao/callback");
		params.add("code", code);

		// HttpHeader 와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = 
				new HttpEntity<>(params, headers); // header 와 body 값을 가지고 있는 entity 값이 된다.

		// Http 요청하기 - Post 방식으로 - 그리고 Response 변수의 응답 받음.
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token", 
				HttpMethod.POST,
				kakaoTokenRequest, 
				String.class // String 타입으로 응답 데이터를 받겠다.
		);

		// Gson, Json, Simple, ObjectMapper라이브러리를 사용하여 자바객체로 만들 수 있다.
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("카카오 액세스 토큰 : " + oauthToken.getAccess_token());

		RestTemplate rt2 = new RestTemplate();

		// HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // 내가 지금 전송할 body data 가
																							// key=velue 형임을 명시

		// HttpHeader 와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);

		// Http 요청하기 - Post 방식으로 - 그리고 Response 변수의 응답 받음.
		ResponseEntity<String> response2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoProfileRequest, String.class // String 타입으로 응답 데이터를 받겠다.
		);
		
		System.out.println("유저정보 : " + response2.getBody());
		 
*/
