package kr.kh.fitness.controller;

import java.sql.Timestamp;
import java.text.NumberFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.dto.PaymentRequestDTO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.service.PaymentService;

// 회원권 결제 컨트롤러
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	PaymentService paymentService;

	// 회원권 조회
	@GetMapping("/paymentList")
	public String paymentList(Model model) {
	    List<PaymentTypeVO> paymentList = paymentService.getMembershipList();
	    // 가격 포맷팅
 		for (PaymentTypeVO pt : paymentList) {
 			pt.setFormattedPrice(NumberFormat.getInstance(Locale.KOREA).format(pt.getPt_price()));
 		}
	    model.addAttribute("paymentList", paymentList);
	    return "/payment/paymentList";
	}

	// 회원권 결제 get
	@GetMapping("/paymentInsert")
	public String paymentInsert(Model model) {
		List<PaymentTypeVO> paymentList = paymentService.getMembershipList();
		model.addAttribute("paymentList", paymentList);
		return "/payment/paymentInsert";
	}

	// 회원권 결제 post 메서드 (JSON)
	@PostMapping("/paymentInsert")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> paymentInsertPost(@RequestBody PaymentRequestDTO request, HttpSession session) {
		PaymentTypeVO payment = request.getPaymentType();
	    PaymentCategoryVO category = request.getPaymentCategory();
	    
		Map<String, Object> response = new HashMap<>();
		try {
	        MemberVO user = (MemberVO) session.getAttribute("user");
	        String userId = user.getMe_id(); // 사용자 ID를 가져옴
	        System.out.println("유저 정보 : " + user);
	        
			// payment, category 확인
			System.out.println("결제 정보 : " + payment);
		    System.out.println("결제 유형 : " + category);
		    
		    // 기존 결제 정보를 조회
		    PaymentVO existingPayment = paymentService.getLastPaymentByUserId(userId, payment.getPt_num());
		    System.out.println("넘버 : " + payment.getPt_num());
		    
		    if (existingPayment != null) {
		        // 기존 결제가 있는 경우
		        LocalDateTime now = LocalDateTime.now();
		        
		        // pa_end를 long 타입으로 가져오기
		        long pcPaidAtTimestamp = existingPayment.getPa_end().getTime(); // Date에서 long으로 변환
		        LocalDateTime paidAtDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(pcPaidAtTimestamp), ZoneId.systemDefault());
		        
		        // 기존 결제의 만료일을 계산
		        LocalDateTime expirationDateTime = paidAtDateTime.plusDays(payment.getPt_date());
		        System.out.println("만료일 계산 : " + expirationDateTime);

		        // LocalDateTime을 Timestamp로 변환
		        Timestamp expirationTimestamp = Timestamp.valueOf(expirationDateTime);

		        // 결제 업데이트를 위한 필드 설정
		        existingPayment.setPa_end(expirationTimestamp);
		        System.out.println("실제 들어간 만료일 계산값 : " + existingPayment.getPa_end());

		        // 결제 업데이트 서비스 호출
		        paymentService.updatePayment(existingPayment);
		        // 결제 업데이트 서비스 호출
		        boolean updateResult = paymentService.updatePayment(existingPayment);
		        if (updateResult) {
		            response.put("success", true);
		            response.put("message", "결제가 완료되었습니다. 만료일이 연장되었습니다.");
		            response.put("url", "/payment/paymentList");
		        } else {
		            response.put("success", false);
		            response.put("message", "결제 업데이트에 실패했습니다.");
		        }
		    } else {
                // 새로운 결제인 경우
	        	
				// 현재 날짜와 시간 가져오기
			    LocalDateTime now = LocalDateTime.now();
			    
			    // 기간을 숫자로 변환
			    int period = payment.getPt_date(); // 예: 30, 60, 90일
			    LocalDateTime expirationDateTime = now.plusDays(period); // 기간을 더함

			    // 날짜 및 시간 포맷팅
			    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			    String formattedDateTime = expirationDateTime.format(formatter);
			    System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
			    
			    // 결제 처리
			    boolean res = paymentService.insertPayment(payment, category, formattedDateTime, user);
			    
			    // 결제가 완료되면 결제 완료 창이 뜨고, 결제에 실패하면 실패 창이 뜸.
				// 결제가 성공적으로 끝나면 membershipList로 감, 실패하면 그대로 유지
                if (res) {
                    response.put("success", true);
                    response.put("message", "결제가 완료되었습니다.");
                    response.put("url", "/payment/paymentList");
                } else {
                    response.put("success", false);
                    response.put("message", "결제가 실패하였습니다.");
                    response.put("url", "/payment/paymentInsert");
                }
	        }
		}catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생하였습니다: " + e.getMessage());
		}
		return ResponseEntity.ok(response); // JSON 형식으로 응답
	}
}