package kr.kh.fitness.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id") String me_id);

	boolean insertMember(@Param("m") MemberVO member);

	MemberVO selectMemberByCookie(@Param("me_cookie") String id);

	void updateMemberCookie(@Param("user") MemberVO user);

	MemberVO selectMemberFromSocial(@Param("social")String socialType, @Param("user")MemberVO loginUser);

	int updateSocialUser(@Param("social")String social_type, @Param("user")MemberVO socialUser);

	void deleteUser(@Param("user")MemberVO socialUser);
	
	boolean updateMember(@Param("user") MemberVO user);

	void updateMemberCookieDelete(@Param("me_id") String me_id);

	MemberVO selectMemberByNameAndEmail(@Param("me_name") String name, @Param("me_email") String email);

	MemberVO findMemberByIdEmailPhone(@Param("me_id")String id, @Param("me_email") String email, @Param("me_phone") String phone);
}
