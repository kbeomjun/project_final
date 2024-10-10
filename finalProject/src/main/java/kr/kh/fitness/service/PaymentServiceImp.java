package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.PaymentDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

@Service
public class PaymentServiceImp implements PaymentService{
	
	@Autowired
	private PaymentDAO paymentDao;

	public List<PaymentTypeVO> getMembershipList() {
		return paymentDao.selectMembershipList();
	}

	@Override
	public boolean insertPayment(PaymentTypeVO payment, String formattedDateTime, MemberVO user) {
		if(payment.getPt_num() == 0
			|| payment.getPt_price() == 0
			|| payment.getPt_date() <= 0
			|| payment.getPt_me_id() == null) {
			return false;
		}
		
		if(user.getMe_id() == null) {
			return false;
		}
		
		return paymentDao.insertPayment(payment, formattedDateTime, user);
	}

}
