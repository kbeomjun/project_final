package kr.kh.fitness.service;

import javax.servlet.http.HttpServletResponse;

import kr.kh.fitness.model.vo.MemberVO;

public interface MemberService {

	MemberVO login(MemberVO member);

	boolean signup(MemberVO member);

	boolean checkId(String id);

	MemberVO getMemberID(String sid);

	void updateMemberCookie(MemberVO user);

	boolean joinSocialMember(String social_type, MemberVO socialUser);

	boolean updateUserSocialAccount(String social_type, MemberVO socialUser);

	boolean idCheck(String sns, String id);

	boolean signupSns(String sns, String id, String email);

	MemberVO loginSns(String sns, String id);

	boolean findPw(String id);

	String findId(String name, String email);

	void clearLoginCookie(String me_id);

	void setAutoLoginCookie(MemberVO user, HttpServletResponse response);

}
