package kr.kh.fitness.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

import kr.kh.fitness.dao.MemberDAO;
import kr.kh.fitness.model.dto.ResultMessage;
import kr.kh.fitness.model.vo.MemberVO;

@Service
public class KaKaoServiceImp implements KakaoService {
	
	private final List<String> social_list = new ArrayList<>(List.of("KAKAO", "NAVER"));

	@Autowired
	private String kakaoRestKey;

	@Autowired
	private String kakaoRedirectUri;
	
	@Autowired
	private MemberDAO memberDao;
	
	private final String KAKAO_INITIAL = "KAKAO_";
	private final String KAKAO_PW = "KAKAO_SOCIAL_LOGIN";

	public String getReturnAccessToken(String code) {
		String access_token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// HttpURLConnection 설정 값 셋팅
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// buffer 스트림 객체 값 셋팅 후 요청
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + kakaoRestKey); // 앱 KEY VALUE
			sb.append("&redirect_uri=" + kakaoRedirectUri); // 앱 CALLBACK 경로
			sb.append("&code=").append(code);
			bw.write(sb.toString());
			bw.flush();

			// RETURN 값 result 변수에 저장
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder result = new StringBuilder(); // StringBuilder 사용
			String br_line;

			while ((br_line = br.readLine()) != null) {
				result.append(br_line); // StringBuilder로 결과 조합
			}

			// Gson을 사용하여 JSON 문자열을 JsonObject로 변환
			Gson gson = new Gson();
			JsonObject element = gson.fromJson(result.toString(), JsonObject.class);

			// 토큰 값 저장
			access_token = element.get("access_token").getAsString();

			// refresh_token이 필요할 경우 아래 코드도 추가
			// String refresh_token = element.get("refresh_token").getAsString();

			br.close();
			bw.close();
		} catch (IOException | JsonSyntaxException e) {
			e.printStackTrace();
		}

		return access_token;
	}

	public MemberVO getUserInfo(String access_token) {
		MemberVO user = new MemberVO();

		String reqURL = "https://kapi.kakao.com/v2/user/me";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_token);

			int responseCode = conn.getResponseCode();
			//System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			StringBuilder result = new StringBuilder(); // StringBuilder로 변경
			String br_line;

			while ((br_line = br.readLine()) != null) {
				result.append(br_line); // StringBuilder 사용
			}
			
			//System.out.println("response: " + result.toString());

			// Gson을 사용하여 JSON 문자열을 JsonObject로 변환
			Gson gson = new Gson();
			JsonObject element = gson.fromJson(result.toString(), JsonObject.class);

			// 데이터 추출
			String id = element.get("id").getAsString();
			//JsonObject properties = element.getAsJsonObject("properties");
			JsonObject kakao_account = element.getAsJsonObject("kakao_account");

			// String nickname = properties.get("nickname").getAsString();
			String email = kakao_account.get("email").getAsString();
			String name = kakao_account.get("name").getAsString();
			
			user.setMe_kakaoUserId(id);
			user.setMe_email(email);
			user.setMe_name(name);
			user.setMe_pw(KAKAO_PW);
			
			if(kakao_account.get("gender") !=null) {
				
				if(kakao_account.get("gender").getAsString().equals("male")) {
					user.setMe_gender("남자");
				}else {
					user.setMe_gender("여자");
				}
			}
			if(kakao_account.get("phone_number") != null) {
				String phoneNumber = kakao_account.get("phone_number").getAsString();
				user.setMe_phone(formatPhoneNumber(phoneNumber));
			}
			
			return user;
			
		} catch (IOException | JsonSyntaxException e) {
			e.printStackTrace(); // 예외 처리
			return null;
		}
		
		
	}

	/*
	 * 카카오에서 전화번호를 다음과 같이 전송해준다. "+82 10-1234-5678" 
	 * "+82 10-1234-5678" 포맷을 "01012345678"로 변경
	 */
	public static String formatPhoneNumber(String phoneNumber) {
		if(phoneNumber == null) {
			return null;
		}
		// 국제 전화 코드 "+82 " 제거
		String formattedNumber = phoneNumber.replace("+82 ", "");
		// 공백 및 "-" 문자 제거
		formattedNumber = formattedNumber.replaceAll("[\\s\\-]", "");
		// 첫 번째 숫자를 "0"으로 변경
		if (!formattedNumber.startsWith("0")) {
			formattedNumber = "0" + formattedNumber;
		}
		return formattedNumber;
	}

	@Override
	public ResultMessage loginSocialUser(MemberVO user) {
		
		ResultMessage rm = new ResultMessage();
		// result "success", "fail", "join"
		MemberVO tmpUser = memberDao.selectMember(user.getMe_email());
		
		return null;
	}

	@Override
	public MemberVO getMemberInfoFromEmail(MemberVO loginUser) {
		
		return memberDao.selectMemberFromEmail(loginUser.getMe_email());
	}
	
	public boolean isValidSocialName(String social_type) {

		if(social_type == null || social_type.trim().length() == 0) {
			return false;
		}
		
		for(String social : social_list ) {
			if(social.equals(social_type)) {
				return true;
			}
		}
		
		return false;
	}
}
