package kr.kh.fitness.service;

import javax.servlet.http.HttpServletResponse;

import kr.kh.fitness.model.vo.MemberVO;

public interface MemberService {

	MemberVO login(MemberVO member, HttpServletResponse response);

	boolean signup(MemberVO member);

	boolean checkId(String id);

	MemberVO getMemberID(String sid);

	void updateMemberCookie(MemberVO user);

	boolean joinSocialMember(String social_type, MemberVO socialUser);

	boolean updateUserSocialAccount(String social_type, MemberVO socialUser);

}
