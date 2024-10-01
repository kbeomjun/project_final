package kr.kh.fitness.dao;

import kr.kh.fitness.model.vo.MemberVO;

public interface TestDAO {
	
	int getEquipCount(); // Test용

	MemberVO login(String me_id);

}
