package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

public interface PaymentService {

	List<PaymentTypeVO> getMembershipList();

	boolean insertPayment(PaymentTypeVO payment, PaymentCategoryVO category, String formattedDateTime, MemberVO user);

}
