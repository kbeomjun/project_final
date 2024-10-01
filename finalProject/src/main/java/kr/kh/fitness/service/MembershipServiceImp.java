package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.MembershipDAO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

@Service
public class MembershipServiceImp implements MembershipService{

	@Autowired
	private MembershipDAO membershipDao;

	@Override
	public List<PaymentTypeVO> getMembershipList() {
		return membershipDao.selectMembershipList();
	}

}
