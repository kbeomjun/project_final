package kr.kh.fitness.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.PaymentDAO;
import kr.kh.fitness.model.dto.PaymentDetailsDTO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentHistoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;

@Service
public class PaymentServiceImp implements PaymentService{
	
	@Autowired
	private PaymentDAO paymentDao;

	// 회원권 조회할때 오직 조회용인 리스트
	@Override
	public List<PaymentTypeVO> membershipList() {
	    return paymentDao.membershipList();
	}

	// 회원권 리스트
	public List<PaymentTypeVO> getMembershipList() {
	    return paymentDao.selectMembershipList();
	}
	// 회원권 리스트
	public List<PaymentTypeVO> getMembershipPTList() {
	    return paymentDao.selectMembershipPTList();
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

	// 사용자의 회원권 정보 조회
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

	// 결제 정보를 포맷팅하여 반환하는 메서드
	@Override
	public PaymentDetailsDTO getPaymentDetails(String me_id) {
	    // 기존 결제 정보를 가져옴
	    List<PaymentVO> membershipPayments = getPayments(me_id, "이용권");
	    List<PaymentVO> ptPayments = getPayments(me_id, "PT");
	    
	    System.out.println("이용권 : " + membershipPayments);
	    System.out.println("PT : " + ptPayments);
		
	    // 회원권 결제와 PT 결제의 정보를 처리하여 필요한 데이터 생성
		String firstStartDateStr = null;
		String lastEndDateStr = null;
		LocalDate newStartDate = null; // newStartDate 추가
		boolean isRePayment = false; // 재결제 여부
		
		// 회원권 결제에서 최초 시작일과 마지막 결제의 만료일 가져오기
		if (!membershipPayments.isEmpty()) {
			PaymentVO firstMembershipPayment = membershipPayments.get(0);
		    firstStartDateStr = new SimpleDateFormat("yyyy-MM-dd").format(firstMembershipPayment.getPa_start());

		    // 마지막 결제 정보 가져오기
		    PaymentVO lastMembershipPayment = membershipPayments.get(membershipPayments.size() - 1);
		    lastEndDateStr = new SimpleDateFormat("yyyy-MM-dd").format(lastMembershipPayment.getPa_end());

		    // 재결제의 새로운 시작일을 만료일 기준으로 설정
		    LocalDate lastEndDate = LocalDate.parse(lastEndDateStr);
		    newStartDate = lastEndDate.plusDays(1); // 만료일에 +1일 추가

		    // 재결제 여부 설정
		    isRePayment = true; // 재결제임을 나타냄

		    // 디버깅 출력
		    System.out.println("서비스의 첫 번째 결제 시작일 : " + firstStartDateStr);
		    System.out.println("서비스의 마지막 결제의 만료일 : " + lastEndDateStr);
		}
	    
	    System.out.println("서비스의 재결제 시작일 : " + newStartDate); // 디버깅 정보
	    
	    // PT 결제 확인
	    boolean hasPTPayments = !ptPayments.isEmpty();
	    boolean isRePaymentForPT = false; // PT 결제에 대한 재결제 여부
	    
	    // PT 결제 정보 처리
	    String ptFirstStartDateStr = null;
	    String ptLastEndDateStr = null;
	    System.out.println("PT 재결제임? : " + hasPTPayments);

	    if (hasPTPayments) {
	        PaymentVO firstPTPayment = ptPayments.get(0); // 첫 번째 PT 결제
	        ptFirstStartDateStr = new SimpleDateFormat("yyyy-MM-dd").format(firstPTPayment.getPa_start());
	        
	        PaymentVO lastPTPayment = ptPayments.get(ptPayments.size() - 1); // 마지막 PT 결제
	        ptLastEndDateStr = new SimpleDateFormat("yyyy-MM-dd").format(lastPTPayment.getPa_end());

	        // PT 결제의 마지막 만료일이 null인 경우
	        if (ptLastEndDateStr == null) {
	            System.out.println("PT 결제 내역이 없습니다. 첫 결제로 처리합니다.");
	        } else {
	            // 재결제 여부 설정
	            isRePaymentForPT = true; // PT 결제가 있으므로 재결제임을 나타냄
	        }
	    } else {
	        System.out.println("PT 결제가 없습니다. 첫 결제로 처리합니다.");
	    }

	    // PaymentDetailsDTO 반환
	    return new PaymentDetailsDTO(firstStartDateStr, lastEndDateStr, isRePayment, newStartDate, ptFirstStartDateStr, ptLastEndDateStr, isRePaymentForPT);
	}

	public List<PaymentVO> getPayments(String me_id, String pt_type) {
	    // 결제 유형을 확인하기 위해 한번만 조회
		List<PaymentVO> payments = paymentDao.selectPaymentsByType(me_id, pt_type);
	    
	    return payments;
	}

}
