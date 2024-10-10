package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.PaymentDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

@Service
public class PaymentServiceImp implements PaymentService{
	
	@Autowired
	private PaymentDAO paymentDao;

	public List<PaymentTypeVO> getMembershipList() {
		return paymentDao.selectMembershipList();
	}

	@Override
	public boolean insertPayment(PaymentTypeVO payment, PaymentCategoryVO category, String formattedDateTime, MemberVO user) {
		if(payment.getPt_num() == 0
			|| payment.getPt_price() == 0
			|| payment.getPt_date() <= 0) {
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
	    boolean categoryInserted = paymentDao.insertPaymentCategory(payment, category, user);
	    
	    if (!categoryInserted) {
	        return false; // 카테고리 삽입 실패
	    }
		
		return paymentDao.insertPayment(payment, category, formattedDateTime, user);
	}

}
