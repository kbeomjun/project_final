package kr.kh.fitness.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class KakaoService {
	
	
	@Autowired
	private String kakaoRestKey;
	
	@Autowired
	private String kakaoRedirectUri;
	
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
	        sb.append("&client_id="+kakaoRestKey);  // 앱 KEY VALUE
	        sb.append("&redirect_uri="+kakaoRedirectUri); // 앱 CALLBACK 경로
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
아이디 입력하고 이메일 등록해서 회원가입
     public Map<String, Object> getUserInfo(String access_token) {
	    Map<String, Object> resultMap = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";

	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");

	        // 요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + access_token);

	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);

	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

	        StringBuilder result = new StringBuilder(); // StringBuilder로 변경
	        String br_line;

	        while ((br_line = br.readLine()) != null) {
	            result.append(br_line); // StringBuilder 사용
	        }
	        System.out.println("response: " + result.toString());

	        // Gson을 사용하여 JSON 문자열을 JsonObject로 변환
	        Gson gson = new Gson();
	        JsonObject element = gson.fromJson(result.toString(), JsonObject.class);

	        // 데이터 추출
	        String id = element.get("id").getAsString();
	        JsonObject properties = element.getAsJsonObject("properties");
	        JsonObject kakao_account = element.getAsJsonObject("kakao_account");

	        //String nickname = properties.get("nickname").getAsString();
	        String email = kakao_account.get("email").getAsString();

	        System.out.println("id: " + id);
	        //System.out.println("nickname: " + nickname);
	        System.out.println("email: " + email);

	        //resultMap.put("nickname", nickname);
	        resultMap.put("id", id);
	        resultMap.put("email", email);

	    } catch (IOException | JsonSyntaxException e) {
	        e.printStackTrace(); // 예외 처리
	    }
	    return resultMap;
	}
}