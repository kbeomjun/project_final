package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.MembershipPaymentDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

@Service
public class MembershipPaymentServiceImp implements MembershipPaymentService{

	@Autowired
	private MembershipPaymentDAO membershipPaymentDao;

	@Override
	public List<PaymentTypeVO> getMembershipList() {
		return membershipPaymentDao.selectMembershipList();
	}

	@Override
	public boolean insertPaymentType(PaymentTypeVO payment, String formattedDateTime, MemberVO user) {
		if(payment.getPt_num() == 0
			|| payment.getPt_price() == 0
			|| payment.getPt_date() <= 0
			|| payment.getPt_me_id() == null) {
			return false;
		}
		
		if(user.getMe_id() == null) {
			return false;
		}
		
		return membershipPaymentDao.insertPaymentType(payment, formattedDateTime, user);
	}

}
