package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.dto.PaymentDetailsDTO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentHistoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;

public interface PaymentService {

	List<PaymentTypeVO> membershipList();
	
	List<PaymentTypeVO> getMembershipList();

	List<PaymentTypeVO> getMembershipPTList();

	boolean insertPayment(PaymentVO payment, PaymentTypeVO paymentType, PaymentHistoryVO history, String formattedDateTime, MemberVO user);

	PaymentVO getLastPaymentByUserId(String userId, int pt_num);

	PaymentVO getPayment(String me_id);

	boolean insertPaymentHistory(PaymentTypeVO paymentType, PaymentHistoryVO history, MemberVO user);

	String getFirstPaymentStartDate(String me_id);

	String getLastPaymentEndDate(String me_id);

	List<PaymentTypeVO> getPTMembershipList();

	PaymentDetailsDTO getPaymentDetails(String me_id);

}
