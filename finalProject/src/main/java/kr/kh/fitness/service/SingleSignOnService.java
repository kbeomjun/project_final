package kr.kh.fitness.service;

import javax.servlet.http.HttpSession;

import kr.kh.fitness.model.dto.ResultMessage;
import kr.kh.fitness.model.vo.MemberVO;

public interface SingleSignOnService {

	String getReturnAccessTokenKakao(String code);

	MemberVO getUserInfoFromKakaoToken(String kakaoToken);

	// ResultMessage loginSocialUser(MemberVO user);

	boolean isValidSocialName(String social_type);

	String getAccessTokenFromNaver(String code, String state, String naverClientId, String naverClientSecret);

	MemberVO getUserInfoFromNaverToken(String token);

	MemberVO getMemberInfoFromSocial(String socialType, MemberVO loginUser);

	boolean removeToken(String token, String social_type);
	
}