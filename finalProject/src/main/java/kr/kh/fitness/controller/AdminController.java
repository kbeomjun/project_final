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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.TestDAO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
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
		List<EmployeeVO> employeeList = adminService.getEmployeeListByBranch(user.getMe_name());
		
		model.addAttribute("programList", programList);
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("branchName", user.getMe_name());
		
		return "/admin/programInsert";
	}
	
	//지점 프로그램 등록 post
	@PostMapping("/program/insert")
	public String programInsertPost(Model model, BranchProgramVO branchProgram) {
		
		String msg = adminService.insertBranchProgram(branchProgram);
		
		if(msg == "") {
			model.addAttribute("url", "/admin/program/list?br_name=" + branchProgram.getBp_br_name());
		} else {
			model.addAttribute("url", "/admin/program/insert");
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 프로그램 수정 get
	@GetMapping("/program/update/{bp_num}")
	public String programUpdate(Model model, @PathVariable("bp_num")int bp_num) {
		BranchProgramVO branchProgram = adminService.getBranchProgram(bp_num);
		
		model.addAttribute("branchProgram", branchProgram);
		
		return "/admin/programUpdate";
	}
	
	//지점 프로그램 수정 post
	@PostMapping("/program/update")
	public String programUpdatePost(Model model, BranchProgramVO branchProgram) {
		String msg = adminService.updateBranchProgram(branchProgram);
		if(msg == "") {
			model.addAttribute("url", "/admin/program/list");
		} else {
			model.addAttribute("url", "/admin/program/update/" + branchProgram.getBp_num());
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 프로그램 삭제
	@GetMapping("/program/delete/{bp_num}")
	public String programDelete(Model model, @PathVariable("bp_num")int bp_num) {
		
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
	@GetMapping("/schedule/insert/{br_name}")
	public String scheduleInsert(Model model, @PathVariable("br_name")String br_name) {
		
		List<BranchProgramVO> programList = adminService.getBranchProgramList(br_name);
		List<MemberVO> memberList = adminService.getMemberList();
		
		model.addAttribute("programList", programList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("branchName", br_name);
		
		return "/admin/scheduleInsert";
	}
	
	//지점 프로그램 일정 추가 post
	@PostMapping("/schedule/insert")
	public String scheduleInsertPost(Model model, String date, String startTime, String endTime, BranchProgramScheduleVO schedule, String me_id) {
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 날짜 형식 지정
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

			String msg = adminService.insertSchedule(schedule, me_id);
			if(msg == "") {
				model.addAttribute("url", "/admin/schedule/list");
			} else {
				model.addAttribute("url", "/admin/schedule/insert/"+schedule.getBp_br_name());
			}
			model.addAttribute("msg", msg);
			return "/main/message";
			
		} catch (ParseException e) {
			e.printStackTrace();
			return "/main/main";
		}
	}
	
	//지점 프로그램 일정 수정 get
	@GetMapping("/schedule/update/{bs_num}")
	public String scheduleUpdate(Model model, @PathVariable("bs_num")int bs_num) {
		
		BranchProgramScheduleVO schedule = adminService.getSchedule(bs_num);
		
		model.addAttribute("schedule", schedule);
		
		return "/admin/scheduleUpdate";
	}
	
	//지점 프로그램 일정 수정 post
	@PostMapping("/schedule/update")
	public String scheduleUpdatePost(Model model, String br_name, String date, String startTime, String endTime, BranchProgramScheduleVO schedule) {
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 날짜 형식 지정
        Date bs_start;
        Date bs_end;
        
		try {
			bs_start = formatter.parse(date + " " + startTime);
			bs_end = formatter.parse(date + " " + endTime);
			schedule.setBs_start(bs_start);
			schedule.setBs_end(bs_end);
			String msg = adminService.updateSchedule(schedule);
			if(msg == "") {
				model.addAttribute("url", "/admin/schedule/list");
			} else {
				model.addAttribute("url", "/admin/schedule/update/"+schedule.getBs_num());
			}
			model.addAttribute("msg", msg);
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
			return "/main/main";
		}		
	}
	
	//지점 발주 등록 get
	@GetMapping("/order/insert")
	public String orderInsert(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<BranchEquipmentStockVO> equipmentList = adminService.getEquipmentListInHQ();
		
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("br_name", br_name);
		
		return "/admin/orderInsert";
	}
	
	//지점 발주 등록 post
	@PostMapping("/order/insert")
	public String orderInsertPost(Model model, BranchOrderVO order, String bo_other) {
		
		//기타 선택 시 입력받은 운동기구 이름이 있을 경우 기구이름설정
		if(bo_other != null) {
			order.setBo_se_name(bo_other);
		}
		
		String msg = adminService.insertOrder(order);
		
		if(msg == "") {
			model.addAttribute("url", "/admin/order/list");
		} else {
			model.addAttribute("url", "/admin/order/insert");
		}
		model.addAttribute("msg", msg);
		
		return "/main/message";
	}
	
	//지점 발주 신청취소
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
	
	//직원 목록 조회
	@GetMapping("/employee/list")
	public String employeeList(Model model, HttpSession session) {
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			String br_name = user.getMe_name();
			List<EmployeeVO> employeeList = adminService.getEmployeeListByBranch(br_name);
			model.addAttribute("employeeList", employeeList);
			model.addAttribute("br_name", br_name);
			return "/admin/employeeList";
		}catch (Exception e) {
			e.printStackTrace();
			return "/main/main";
		}
	}
	
	//지점 직원 등록 get
	@GetMapping("/employee/insert/{em_br_name}")
	public String employeeInsert(Model model, @PathVariable("em_br_name")String em_br_name) {
		List<SportsProgramVO> programList = adminService.getProgramList();
		
		model.addAttribute("em_br_name", em_br_name);
		model.addAttribute("programList", programList);
		return "/admin/employeeInsert";
	}
	
	//지점 직원 등록 post
	@PostMapping("/employee/insert")
	public String employeeInsertPost(Model model, EmployeeVO employee, MultipartFile file) {
		String msg = adminService.insertEmployee(employee, file);
		if(msg.equals("")) {
			model.addAttribute("url", "/admin/employee/list");
		}else {
			model.addAttribute("url", "/admin/employee/insert/"+employee.getEm_br_name());
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 직원 상세조회
	@GetMapping("/employee/detail/{em_num}")
	public String employeeDetail(Model model, @PathVariable("em_num") int em_num) {
		EmployeeVO employee = adminService.getEmployee(em_num);
		List<SportsProgramVO> programList = adminService.getProgramList();
		model.addAttribute("em", employee);
		model.addAttribute("programList", programList);		
		return "/admin/employeeDetail";
	}
	
	//지점 직원 상세수정
	@PostMapping("/employee/update/{em_num}")
	public String employeeUpdatePost(Model model, @PathVariable("em_num") int em_num, EmployeeVO employee, MultipartFile file, String isDel) {
		String msg = adminService.updateEmployee(employee, file, isDel);
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/admin/employee/list");
		return "/main/message";
	}	
	
	//지점 상세보기 조회
	@GetMapping("/branch/detail")
	public String branchDetail(Model model, HttpSession session) {
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			String br_name = user.getMe_name();
			BranchVO branch = adminService.getBranch(br_name);
			List<BranchFileVO> bfList = adminService.getBranchFileList(branch);
			MemberVO admin = adminService.getAdmin(branch);
			
			model.addAttribute("br", branch);
			model.addAttribute("bfList", bfList);
			model.addAttribute("me", admin);
			
			return "/admin/branchDetail";
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/main";
		}		
	}
	
	//지점 상세보기 수정
	@PostMapping("/branch/update")
	public String branchUpdate(Model model, BranchVO branch, MultipartFile[] fileList, MemberVO admin, String[] numList) {
		String msg = adminService.updateBranch(branch, fileList, admin, numList);
		if(msg.equals("")) {
			model.addAttribute("url", "/admin/branch/detail");
		}else {
			model.addAttribute("url", "/admin/branch/detail");
		}
			model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 운동기구 재고 조회
	@GetMapping("/equipment/list")
	public String equipmentList(Model model, HttpSession session, @RequestParam(value = "view", defaultValue = "all")String view) {
		try {
			MemberVO user = (MemberVO)session.getAttribute("user");
			String br_name = user.getMe_name();
			
			List<BranchEquipmentStockVO> equipmentList = adminService.getEquipmentListInBranch(br_name, view);
			model.addAttribute("equipmentList", equipmentList);
			model.addAttribute("br_name", br_name);
			model.addAttribute("view", view);
			return "/admin/equipmentList";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/main";
		}			
	}
}
