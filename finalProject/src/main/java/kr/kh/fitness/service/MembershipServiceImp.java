package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.MembershipDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

@Service
public class MembershipServiceImp implements MembershipService{

	@Autowired
	private MembershipDAO membershipDao;

	@Override
	public List<PaymentTypeVO> getMembershipList() {
		return membershipDao.selectMembershipList();
	}

	@Override
	public boolean insertPaymentType(PaymentTypeVO payment, String formattedDateTime, MemberVO user) {
		if(payment.getPt_num() == 0
			|| payment.getPt_price() == 0
			|| payment.getPt_date() <= 0) {
			return false;
		}
		
		if(user.getMe_id() == null) {
			return false;
		}
		
		return membershipDao.insertPaymentType(payment, formattedDateTime, user);
	}

}
