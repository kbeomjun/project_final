package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;

public interface PaymentDAO {

	List<PaymentTypeVO> selectMembershipList();

	boolean insertPayment(@Param("pt")PaymentTypeVO payment, @Param("end")String formattedDateTime, @Param("me")MemberVO user);

}
