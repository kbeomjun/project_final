package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.vo.PaymentTypeVO;

public interface MembershipService {

	List<PaymentTypeVO> getMembershipList();

}
