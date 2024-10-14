package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;

public interface PaymentService {

	List<PaymentTypeVO> getMembershipList();

	boolean insertPayment(PaymentVO payment, PaymentTypeVO paymentType, PaymentCategoryVO category, String formattedDateTime, MemberVO user);

	PaymentVO getLastPaymentByUserId(String userId, int pt_num);

	boolean updatePayment(PaymentVO existingPayment);

	PaymentVO getPayment(String me_id);

}
