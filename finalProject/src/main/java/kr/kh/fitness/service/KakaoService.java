package kr.kh.fitness.service;

import java.util.Map;

import kr.kh.fitness.model.dto.ResultMessage;
import kr.kh.fitness.model.vo.MemberVO;

public interface KakaoService {

	String getReturnAccessToken(String code);

	MemberVO getUserInfo(String kakaoToken);

	ResultMessage loginSocialUser(MemberVO user);

	boolean isValidSocialName(String social_type);

	MemberVO getMemberInfoFromEmail(MemberVO loginUser);
	
}