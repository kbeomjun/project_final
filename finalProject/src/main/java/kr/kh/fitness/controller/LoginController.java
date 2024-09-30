package kr.kh.fitness.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;

@Controller
public class LoginController {

	@GetMapping("/login")
	public String login() {
		return "/member/login";
	}
	@Autowired
	private MemberService memberService;
	
	@PostMapping("/login")
	public String login(MemberVO member, Model model, HttpSession session) {
		MemberVO user = memberService.login(member);
		if(user != null) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "로그인을 성공했습니다");
			model.addAttribute("url", "/");
		}else {
			model.addAttribute("msg", "로그인에 실패했습니다");
			model.addAttribute("url", "/login");
		}
		model.addAttribute("user", user);
		return "/main/message";
	}
	@GetMapping("/logout")
	public String logout(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		session.removeAttribute("user");
		model.addAttribute("msg", "로그아웃 했습니다");
		model.addAttribute("url", "/");
		return "/main/message";
		}
}

