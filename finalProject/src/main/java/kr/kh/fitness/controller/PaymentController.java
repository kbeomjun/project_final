package kr.kh.fitness.controller;

import java.text.NumberFormat;
import java.time.LocalDateTime;
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
import kr.kh.fitness.service.PaymentService;

//회원권 컨트롤러
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	PaymentService paymentService;

	// 회원권 조회
	@GetMapping("/paymentList")
	public String membershipList(Model model) {
	    List<PaymentTypeVO> paymentList = paymentService.getMembershipList();
	    // 가격 포맷팅
 		for (PaymentTypeVO pt : paymentList) {
 			pt.setFormattedPrice(NumberFormat.getInstance(Locale.KOREA).format(pt.getPt_price()));
 		}
	    model.addAttribute("paymentList", paymentList);
	    return "/payment/paymentList";
	}

	// 회원권 결제
	@GetMapping("/paymentInsert")
	public String membershipInsertGet(Model model) {
		List<PaymentTypeVO> paymentList = paymentService.getMembershipList();
		model.addAttribute("paymentList", paymentList);
		return "/payment/paymentInsert";
	}

	// 결제 처리 메서드 (JSON)
	@PostMapping("/paymentInsert")
	@ResponseBody
	public ResponseEntity<?> processPayment(@RequestBody PaymentRequestDTO request, HttpSession session) {
		PaymentTypeVO payment = request.getPaymentType();
	    PaymentCategoryVO category = request.getPaymentCategory();
	    
		Map<String, Object> response = new HashMap<>();
		try {
			// payment, category 확인
			System.out.println("결제 정보 : " + payment);
		    System.out.println("결제 유형 : " + category);
			
			// 현재 날짜와 시간 가져오기
		    LocalDateTime now = LocalDateTime.now();
		    
		    // 기간을 숫자로 변환
		    int period = payment.getPt_date(); // 예: 30, 60, 90일
		    LocalDateTime expirationDateTime = now.plusDays(period); // 기간을 더함
		    
		    // 날짜 및 시간 포맷팅
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		    String formattedDateTime = expirationDateTime.format(formatter);
		    System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
		    
		    // 유저 값 가져오기
		    MemberVO user = (MemberVO) session.getAttribute("user");
		    System.out.println("유저 정보 : " + user);
		    
	        String paymentStatus = category.getPc_status(); // PaymentCategoryVO에서 pc_status 가져오기

		    System.out.println(paymentStatus);
		    
		    if ("paid".equals(paymentStatus)) {
		    	System.out.println(payment);
				boolean res = paymentService.insertPayment(payment, category, formattedDateTime, user);
				
				// 결제가 완료되면 결제 완료 창이 뜨고, 결제에 실패하면 실패 창이 뜸.
				// 결제가 성공적으로 끝나면 membershipList로 감, 실패하면 그대로 유지
				if(res) {
				    response.put("success", true);
				    response.put("message", "결제가 완료되었습니다.");
				    response.put("url", "/payment/paymentInsert");
				}
				else {
				    response.put("success", false);
				    response.put("message", "결제가 실패하였습니다.");
				    response.put("url", "/payment/paymentInsert");
				}
			}else {
				response.put("success", false);
		        response.put("message", "결제가 실패하였습니다. 상태: " + paymentStatus);
		        response.put("url", "/payment/paymentInsert");
			}
		}catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생하였습니다: " + e.getMessage());
		}
	    return ResponseEntity.ok(response); // JSON 형식으로 응답
	}
}