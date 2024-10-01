package kr.kh.fitness.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

// 회원권 컨트롤러
@Controller
@RequestMapping("/membership")
public class MembershipController {
	

	@GetMapping("/membershipList")
	public String membershipList() {
		System.out.println("회원권 조회 화면에 들어옴");
		return "/membership/membershipList";
	}
}
