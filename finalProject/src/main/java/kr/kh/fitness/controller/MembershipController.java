package kr.kh.fitness.controller;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.service.MembershipService;

// 회원권 컨트롤러
@Controller
@RequestMapping("/membership")
public class MembershipController {
	
	@Autowired
	MembershipService membershipService;
	
	// 회원권 조회
	@GetMapping("/membershipList")
	public String membershipList(Model model) {
		
		List<PaymentTypeVO> paymentList = membershipService.getMembershipList();
		
//		System.out.println("회원권 조회 화면에 들어옴");
//		System.out.println(paymentList);
		// 가격 포맷팅
        for (PaymentTypeVO pt : paymentList) {
            pt.setFormattedPrice(NumberFormat.getInstance(Locale.KOREA).format(pt.getPt_price()));
        }
		
		model.addAttribute("paymentList", paymentList);
		
		return "/membership/membershipList";
	}

	
	// 회원권 결제
	@GetMapping("/membershipInsert")
	public String membershipInsertGet(Model model) {
		List<PaymentTypeVO> paymentList = membershipService.getMembershipList();
		
		model.addAttribute("paymentList", paymentList);
		
		return "/membership/membershipInsert";
	}
	
	@PostMapping("/membershipInsert")
	public String membershipInsertPost(Model model, PaymentTypeVO payment, HttpSession session) {
		
		// payment 확인
		System.out.println(payment);
		
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
	    
		boolean res = membershipService.insertPaymentType(payment, formattedDateTime, user);

		// 결제가 완료되면 결제 완료 창이 뜨고, 결제에 실패하면 실패 창이 뜸.
		// 결제가 성공적으로 끝나면 membershipList로 감, 실패하면 그대로 유지
		if(res) {
			model.addAttribute("msg", "결제가 완료되었습니다.");
			model.addAttribute("url", "/membership/membershipList");
		}
		else {
			model.addAttribute("msg", "결제에 실패하였습니다.");
			model.addAttribute("url", "/membership/membershipInsert");
		}
		
		return "/main/message";
	}
}
