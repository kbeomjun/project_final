package kr.kh.fitness.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;
import kr.kh.fitness.service.AdminService;
import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/program/list")
	public String programMagagement(Model model, HttpSession session, String br_name) {
		
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			br_name = user.getMe_name();
			
			List<BranchProgramVO> programList = adminService.getBranchProgramList(br_name);
			model.addAttribute("programList", programList);
			model.addAttribute("br_name", br_name);
			return "/admin/programList";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/home";
		}
	}
	
	@GetMapping("/program/insert")
	public String programInsert(Model model, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<SportsProgramVO> programList = adminService.getProgramList();
		List<EmployeeVO> employeeList = adminService.getEmployeeList(user.getMe_name());
		
		model.addAttribute("programList", programList);
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("branchName", user.getMe_name());
		
		return "/admin/programInsert";
	}
	
	@PostMapping("/program/insert")
	public String programInsertPost(Model model, BranchProgramVO branchProgram) {
		
		if(adminService.insertBranchProgram(branchProgram)) {
			model.addAttribute("msg", "등록에 성공했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		} else {
			model.addAttribute("msg", "등록에 실패했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		}
		return "/main/message";
	}
	
	@GetMapping("/program/update")
	public String programUpdate(Model model, BranchProgramVO branchProgram, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("branchProgram", branchProgram);
		model.addAttribute("branchName", user.getMe_name());
		
		return "/admin/programUpdate";
	}
	
	@PostMapping("/program/update")
	public String programUpdatePost(Model model, BranchProgramVO branchProgram) {
		
		if(adminService.updateBranchProgram(branchProgram)) {
			model.addAttribute("msg", "수정에 성공했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		} else {
			model.addAttribute("msg", "수정에 실패했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		}
		return "/main/message";
	}
	
	@GetMapping("/program/delete")
	public String programDelete(Model model, BranchProgramVO branchProgram) {
		System.out.println(branchProgram);
		
		if(adminService.deleteBranchProgram(branchProgram)) {
			model.addAttribute("msg", "삭제에 성공했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		}
		return "/main/message";
	}
	
	@GetMapping("/schedule/list")
	public String programSchedule(Model model, HttpSession session, String br_name) {
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			br_name = user.getMe_name();
			
			List<BranchProgramVO> scheduleList = adminService.getBranchScheduleList(br_name);
			model.addAttribute("scheduleList", scheduleList);
			model.addAttribute("br_name", br_name);
			return "/admin/scheduleList";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/home";
		}
	}
	
	@GetMapping("/schedule/detail")
	public String scheduleDetail(Model model, BranchProgramVO branchProgram) {
		
		
		List<MemberVO> memberList = adminService.getScheduleMemberList(branchProgram.getBp_num());
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("branchProgram", branchProgram);
		
		return "/admin/scheduleDetail";
	}
}
