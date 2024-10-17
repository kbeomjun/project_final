package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentHistoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;

public interface PaymentDAO {

	List<PaymentTypeVO> membershipList();
	
	List<PaymentTypeVO> selectMembershipList();
	
	List<PaymentTypeVO> selectMembershipPTList();

	boolean insertPayment(@Param("pa")PaymentVO payment, @Param("pt")PaymentTypeVO paymentType, @Param("pc")PaymentHistoryVO category, @Param("end")String formattedDateTime, @Param("me")MemberVO user);

	boolean insertPaymentHistory(@Param("pt")PaymentTypeVO payment, @Param("ph")PaymentHistoryVO history, @Param("me")MemberVO user);

	PaymentVO getLastPaymentByUserId(@Param("me_id")String userId, @Param("pt_num")int pt_num);

	PaymentVO selectPayment(@Param("me_id")String me_id);

	String selectFirstPaymentStartDate(@Param("me_id")String me_id);

	String selectLastPaymentEndDate(@Param("me_id")String me_id);

	List<PaymentTypeVO> selectPTMembershipList();

	PaymentVO selectPaymentMembership(@Param("me_id")String me_id);
	
	PaymentVO selectPaymentPT(@Param("me_id")String me_id);

	List<PaymentVO> selectPayments(@Param("me_id")String me_id);
	
	List<PaymentVO> selectPaymentsByType(@Param("me_id")String me_id, @Param("pt_type")String pt_type);

}
