package kr.kh.fitness.service;

import kr.kh.fitness.model.dto.ResultMessage;
import kr.kh.fitness.model.vo.MemberVO;

public interface SingleSignOnService {

	String getReturnAccessTokenKakao(String code);

	MemberVO getUserInfoFromKakaoToken(String kakaoToken);

	// ResultMessage loginSocialUser(MemberVO user);

	boolean isValidSocialName(String social_type);

	MemberVO getMemberInfoFromEmail(MemberVO loginUser);

	String getAccessTokenFromNaver(String code, String state, String naverClientId, String naverClientSecret);

	MemberVO getUserInfoFromNaverToken(String token);
	
}