package kr.kh.fitness.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.TestDAO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.utils.UploadFileUtils;
import lombok.extern.log4j.Log4j;

/* 테스트 컨트롤러로 프로젝트 정상 작동 확인 후 삭제 할 페이지입니다.*/

@Log4j
@Controller
public class TestController {
	
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@Resource
	String uploadPath;
	
	@PostMapping("/test/saveFile")
	public String saveFileTest(MultipartFile file) throws Exception {
		log.info("/test/saveFile 테스트 파일 업로드");
	    String fileName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(),file.getBytes());
	    return "/main/home";
	}

	@Autowired
	private TestDAO testDao;
	
	@GetMapping("/")
	public String home(Locale locale, Model model) {
		
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/main/home";
	}
	
	@GetMapping("/login")
	public String login(Model model, MemberVO member, HttpSession session) {
		
		MemberVO user = testDao.login("br_admin");
		
		if(user != null) {
			System.out.println(user);
			model.addAttribute("msg", "로그인을 성공했습니다.");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", "로그인을 실패했습니다.");
			model.addAttribute("url", "/");
		}
		session.setAttribute("user", user);
		return "/main/message";
	}
	
	
//	@GetMapping("/")
//	public String home(Locale locale, Model model) {
//		log.info("/ : 테스트 메인 페이지");
//		
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		//System.out.println("등록된 장비 갯수 : " + testDao.getEquipCount());
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "/main/home";
//	}

}
