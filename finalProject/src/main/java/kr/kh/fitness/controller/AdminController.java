package kr.kh.fitness.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.fitness.dao.TestDAO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
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
	@Autowired
	private TestDAO testDao;
	
	//지점관리자 메뉴 목록
	@GetMapping("/menu/list")
	public String menuList() {
		return "/admin/menuList";
	}
	
	@GetMapping("/login")
	private String login(Model model, HttpSession session) {
		MemberVO user = testDao.login("br_admin2");

		session.setAttribute("user", user);
		return "/admin/menuList";
	}

	//지점 프로그램 목록(프로그램명+트레이너명+총인원수)
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
			return "/main/main";
		}
	}
	
	//지점 프로그램 등록 get
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
	
	//지점 프로그램 등록 post
	@PostMapping("/program/insert")
	public String programInsertPost(Model model, BranchProgramVO branchProgram) {
		
		if(adminService.insertBranchProgram(branchProgram)) {
			model.addAttribute("msg", "등록에 성공했습니다.");
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		} else {
			model.addAttribute("msg", "등록에 실패했습니다.");
			model.addAttribute("url", "/admin/program/insert");
		}
		
		return "/main/message";
	}
	
	//지점 프로그램 수정 get
	@GetMapping("/program/update")
	public String programUpdate(Model model, BranchProgramVO branchProgram, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("branchProgram", branchProgram);
		model.addAttribute("branchName", user.getMe_name());
		
		return "/admin/programUpdate";
	}
	
	//지점 프로그램 수정 post
	@PostMapping("/program/update")
	public String programUpdatePost(Model model, BranchProgramVO branchProgram) {
		
		if(adminService.updateBranchProgram(branchProgram)) {
			model.addAttribute("msg", "수정에 성공했습니다.");
		} else {
			model.addAttribute("msg", "수정에 실패했습니다.");
		}
		model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		return "/main/message";
	}
	
	//지점 프로그램 삭제
	@GetMapping("/program/delete")
	public String programDelete(Model model, int bp_num) {
		
		if(adminService.deleteBranchProgram(bp_num)) {
			model.addAttribute("msg", "삭제에 성공했습니다.");
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다.");
		}
		model.addAttribute("url", "/admin/program/list");
		return "/main/message";
	}
	
	//지점 프로그램 일정 목록(프로그램명+트레이너명+[예약인원/총인원]+프로그램날짜+프로그램시간)
	@GetMapping("/schedule/list")
	public String programSchedule(Model model, HttpSession session) {
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			String br_name = user.getMe_name();
			
			List<BranchProgramScheduleVO> scheduleList = adminService.getBranchScheduleList(br_name);
			model.addAttribute("scheduleList", scheduleList);
			model.addAttribute("br_name", br_name);
			return "/admin/scheduleList";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/main";		
		}
	}
	
	//지점 프로그램 일정 상세 -> 예약한 회원 목록(이름+전화번호+생년월일+성별+노쇼경고횟수)
	@GetMapping("/schedule/detail")
	public String scheduleDetail(Model model, int bs_num) {
		
		List<MemberVO> memberList = adminService.getScheduleMemberList(bs_num);
		
		model.addAttribute("memberList", memberList);
		
		return "/admin/scheduleDetail";
	}
	
	//지점 프로그램 일정 추가 get
	@GetMapping("/schedule/insert")
	public String scheduleInsert(Model model, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		List<BranchProgramVO> programList = adminService.getBranchProgramList(user.getMe_name());
		List<EmployeeVO> memberList = adminService.getMemberList();
		
		model.addAttribute("programList", programList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("branchName", user.getMe_name());
		
		return "/admin/scheduleInsert";
	}
	
	//지점 프로그램 일정 추가 post
	@PostMapping("/schedule/insert")
	public String scheduleInsertPost(Model model, String date, String startTime, String endTime, BranchProgramScheduleVO schedule, String me_id) {
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm"); // 날짜 형식 지정
        Date bs_start;
        Date bs_end;
        
        if(me_id == null) {
        	me_id = "";
        }
        
		try {
			bs_start = formatter.parse(date + " " + startTime);
			bs_end = formatter.parse(date + " " + endTime);
			schedule.setBs_start(bs_start);
			schedule.setBs_end(bs_end);

			if(adminService.insertSchedule(schedule, me_id)) {
				model.addAttribute("msg", "등록에 성공했습니다.");
			} else {
				model.addAttribute("msg", "등록에 실패했습니다.");
			}
			model.addAttribute("url", "/admin/schedule/list");
			model.addAttribute("br_name", schedule.getBp_br_name());
			return "/main/message";
			
		} catch (ParseException e) {
			e.printStackTrace();
			return "/main/main";
		}
	}
	
	//지점 프로그램 일정 수정 get
	@GetMapping("/schedule/update")
	public String scheduleUpdate(Model model, int bp_num) {
		
		BranchProgramScheduleVO schedule = adminService.getSchedule(bp_num);
		
		model.addAttribute("schedule", schedule);
		
		return "/admin/scheduleUpdate";
	}
	
	//지점 프로그램 일정 수정 post
	@PostMapping("/schedule/update")
	public String scheduleUpdatePost(Model model, String br_name, String date, String startTime, String endTime, BranchProgramScheduleVO schedule) {
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm"); // 날짜 형식 지정
        Date bs_start;
        Date bs_end;
        
		try {
			bs_start = formatter.parse(date + " " + startTime);
			bs_end = formatter.parse(date + " " + endTime);
			schedule.setBs_start(bs_start);
			schedule.setBs_end(bs_end);
			if(adminService.updateSchedule(schedule)) {
				model.addAttribute("msg", "수정에 성공했습니다.");
			} else {
				model.addAttribute("msg", "수정에 실패했습니다.");
			}
			model.addAttribute("url", "/admin/schedule/list");
			model.addAttribute("br_name", br_name);
			return "/main/message";
			
		} catch (ParseException e) {
			e.printStackTrace();
			return "/main/main";
		}
	}
	
	//지점 발주 신청목록
	@GetMapping("/order/list")
	public String orderList(Model model, HttpSession session) {
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			String br_name = user.getMe_name();
			
			List<BranchOrderVO> orderList = adminService.getBranchOrderList(br_name);
			model.addAttribute("orderList", orderList);
			model.addAttribute("br_name", br_name);
			return "/admin/orderList";
			
		} catch (Exception e) {
			e.printStackTrace();
			//return "/main/home";
			return "/main/main";
		}		
	}
	
	//지점 발주 등록 get
	@GetMapping("/order/insert")
	public String orderInsert(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<BranchEquipmentStockVO> equipmentList = adminService.getEquipmentList();
		
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("br_name", br_name);
		
		return "/admin/orderInsert";
	}
	
	//지점 발주 등록 post
	@PostMapping("/order/insert")
	public String orderInsertPost(Model model, BranchOrderVO order, String bo_other) {
		
		if(bo_other != null) {
			order.setBo_se_name(bo_other);
		}
		
		if(adminService.insertOrder(order)) {
			model.addAttribute("msg", "등록에 성공했습니다.");
		} else {
			model.addAttribute("msg", "등록에 실패했습니다.");
		}
		model.addAttribute("url", "/admin/order/list");
		
		return "/main/message";
	}
	
	//지점 발중 신청취소
	@GetMapping("/order/delete")
	public String orderDelete(Model model, int bo_num) {
		
		if(adminService.deleteOrder(bo_num)) {
			model.addAttribute("msg", "취소에 성공했습니다.");
		} else {
			model.addAttribute("msg", "취소에 실패했습니다.");
		}
		model.addAttribute("url", "/admin/order/list");
		return "/main/message";
	}
}
