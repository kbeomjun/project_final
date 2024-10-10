package kr.kh.fitness.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id") String me_id);

	boolean insertMember(@Param("m") MemberVO member);

	MemberVO selectMemberByCookie(@Param("me_cookie") String id);
}
