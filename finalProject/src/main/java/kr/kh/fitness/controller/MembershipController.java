package kr.kh.fitness.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.service.MembershipService;

// 회원권 컨트롤러
@Controller
@RequestMapping("/membership")
public class MembershipController {
	
	@Autowired
	MembershipService membershipService;
	
	@GetMapping("/membershipList")
	public String membershipList(Model model) {
		
		List<PaymentTypeVO> paymentList = membershipService.getMembershipList();
		
//		System.out.println("회원권 조회 화면에 들어옴");
//		System.out.println(paymentList);
		
		model.addAttribute("paymentList", paymentList);
		
		return "/membership/membershipList";
	}

	@GetMapping("/membershipInsert")
	public String membershipInsertGet() {
		System.out.println("회원권 결제 화면에 들어옴");
		
		return "/membership/membershipInsert";
	}
	
	@PostMapping("/membershipInsert")
	public String membershipInsertPost(Model model) {
		
		return "/membership/membershipList";
	}
}
