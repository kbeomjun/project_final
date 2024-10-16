package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.PaymentDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentHistoryVO;
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
	public boolean insertPayment(PaymentVO payment, PaymentTypeVO paymentType, PaymentHistoryVO history, String formattedDateTime, MemberVO user) {
		if(payment.getPa_start() == null) {
			return false;
		}
		
		if(paymentType.getPt_num() == 0
			|| paymentType.getPt_price() == 0
			|| paymentType.getPt_date() <= 0) {
			return false;
		}
		
		if(history.getPh_imp_uid() == null
			|| history.getPh_merchant_uid() == null
			|| history.getPh_amount() == 0
			|| history.getPh_status() == null
			|| history.getPh_me_id() == null) {
			return false;
		}
		
		if(user.getMe_id() == null) {
			return false;
		}
		
	    // 1. PaymentCategoryVO 삽입
	    boolean categoryInserted = insertPaymentHistory(paymentType, history, user);
	    
	    if (!categoryInserted) {
	        return false; // 카테고리 삽입 실패
	    }
		
		return paymentDao.insertPayment(payment, paymentType, history, formattedDateTime, user);
	}
	
	// user id와 pt_num을 주고 기존 결제 정보를 조회
	@Override
	public PaymentVO getLastPaymentByUserId(String userId, int pt_num) {
		if(userId == null) {
			return null;
		}
		return paymentDao.getLastPaymentByUserId(userId, pt_num);
	}

	@Override
	public PaymentVO getPayment(String me_id) {
		if(me_id == null) {
			return null;
		}
		return paymentDao.selectPayment(me_id);
	}

	@Override
	public boolean insertPaymentHistory(PaymentTypeVO paymentType, PaymentHistoryVO history, MemberVO user) {
	    return paymentDao.insertPaymentHistory(paymentType, history, user);
	}

	@Override
	public String getFirstPaymentStartDate(String me_id) {
		return paymentDao.selectFirstPaymentStartDate(me_id);
	}

	@Override
	public String getLastPaymentEndDate(String me_id) {
		return paymentDao.selectLastPaymentEndDate(me_id);
	}

	@Override
	public List<PaymentTypeVO> getPTMembershipList() {
		return paymentDao.selectPTMembershipList();
	}

	@Override
	public PaymentVO getPaymentMembership(String me_id) {
		if(me_id == null) {
			return null;
		}
		return paymentDao.selectPaymentMembership(me_id);
	}

	@Override
	public PaymentVO getPaymentPT(String me_id) {
		if(me_id == null) {
			return null;
		}
		return paymentDao.selectPaymentPT(me_id);
	}

}
