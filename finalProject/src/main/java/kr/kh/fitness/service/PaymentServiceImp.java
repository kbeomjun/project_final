package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.PaymentDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;

@Service
public class PaymentServiceImp implements PaymentService{
	
	@Autowired
	private PaymentDAO paymentDao;
	
	// 결제 리스트
	public List<PaymentTypeVO> getMembershipList() {
		return paymentDao.selectMembershipList();
	}

	// 결제 추가
	@Override
	public boolean insertPayment(PaymentVO payment, PaymentTypeVO paymentType, PaymentCategoryVO category, String formattedDateTime, MemberVO user) {
		if(payment.getPa_start() == null) {
			return false;
		}
		
		if(paymentType.getPt_num() == 0
			|| paymentType.getPt_price() == 0
			|| paymentType.getPt_date() <= 0) {
			return false;
		}
		
		if(category.getPc_imp_uid() == null
			|| category.getPc_merchant_uid() == null
			|| category.getPc_amount() == 0
			|| category.getPc_status() == null
			|| category.getPc_me_id() == null) {
			return false;
		}
		
		if(user.getMe_id() == null) {
			return false;
		}
		
	    // 1. PaymentCategoryVO 삽입
	    boolean categoryInserted = insertPaymentCategory(paymentType, category, user);
	    
	    if (!categoryInserted) {
	        return false; // 카테고리 삽입 실패
	    }
		
		return paymentDao.insertPayment(payment, paymentType, category, formattedDateTime, user);
	}
	

	// user id와 pt_num을 주고 기존 결제 정보를 조회
	@Override
	public PaymentVO getLastPaymentByUserId(String userId, int pt_num) {
		if(userId == null) {
			return null;
		}
		return paymentDao.getLastPaymentByUserId(userId, pt_num);
	}
	
	// 결제 업데이트
	@Override
	public boolean updatePayment(PaymentVO existingPayment) {
		return paymentDao.updatePayment(existingPayment);
	}

	@Override
	public PaymentVO getPayment(String me_id) {
		if(me_id == null) {
			return null;
		}
		return paymentDao.selectPayment(me_id);
	}

	@Override
	public boolean insertPaymentCategory(PaymentTypeVO paymentType, PaymentCategoryVO category, MemberVO user) {
	    return paymentDao.insertPaymentCategory(paymentType, category, user);
	}

}
