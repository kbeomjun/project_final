package kr.kh.fitness.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id") String me_id);

	boolean insertMember(@Param("m") MemberVO member);

	MemberVO selectMemberByCookie(@Param("me_cookie") String id);

	void updateMemberCookie(@Param("user") MemberVO user);

	MemberVO selectMemberFromEmail( @Param("email")String me_email);

	int updateSocialUser(@Param("social")String social_type, @Param("user")MemberVO socialUser);

	void deleteUser(@Param("user")MemberVO socialUser);
}
