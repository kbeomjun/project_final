package kr.kh.fitness.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String home(Locale locale, Model model) {
		System.out.println("메인");
		return "/main/main";
	}

}
