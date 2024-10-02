package kr.kh.fitness.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;

@Controller
public class UserController {
	
	@Autowired
	private MemberService memberService;
	
	
	@GetMapping("/login")
	public String loginPage() {
		return "/member/login";
	}	
	
	@PostMapping("/login")
	public String login
			(MemberVO member, Model model, HttpSession session, HttpServletResponse response) {
		MemberVO user = memberService.login(member, response);
		if(user != null) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "로그인을 성공했습니다");
			model.addAttribute("url", "/");
		}else {
			model.addAttribute("msg", "없는 아이디거나 잘못 입력하셨습니다");
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
	
	  @GetMapping("/terms")
	    public String termsPage() {
	        return "/member/terms";
	    }
	    
	    // 회원가입 페이지
	    @GetMapping("/signup")
	    public String signupPage() {
	        return "/member/signup";
	    }
	    /*
	    // 회원가입 처리
	    @PostMapping("/signup")
	    public String signup(Model model, @ModelAttribute MemberVO member) {
	        // 모든 회원 정보를 가져와 리스트에 저장
	        List<MemberVO> existingMembers = memberService.findAllMembers(); // 모든 회원 정보를 가져오는 메소드 필요

	        // 중복 체크
	        for (MemberVO existingMember : existingMembers) {
	            if (existingMember.getMe_id().equals(member.getMe_id())) {
	                model.addAttribute("url", "/signup");
	                model.addAttribute("msg", "중복된 아이디입니다."); // 중복 아이디 에러 메시지
	                return "/main/message"; // 메시지 페이지로 이동
	            }
	        }

	        // 회원가입 시 필수 입력값이 모두 존재하는지 확인
	        if (memberService.signup(member)) {
	            model.addAttribute("url", "/");
	            model.addAttribute("msg", "회원가입을 했습니다.");
	        } else {
	            model.addAttribute("url", "/signup");
	            model.addAttribute("msg", "회원가입을 하지 못했습니다.");
	        }
	        
	        return "/main/message";
	    }
	    */

}


