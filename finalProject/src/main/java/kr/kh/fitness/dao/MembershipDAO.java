package kr.kh.fitness.dao;

import java.util.List;

import kr.kh.fitness.model.vo.PaymentTypeVO;

public interface MembershipDAO {

	List<PaymentTypeVO> selectMembershipList();

}
