package kr.kh.fitness.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kh.fitness.model.dto.BranchProgramDTO;
import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.dto.ProgramInsertFormDTO;
import kr.kh.fitness.model.dto.ResultMessage;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.SportsProgramVO;
import kr.kh.fitness.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	//지점 프로그램 목록(프로그램명+트레이너명+총인원수)
	@GetMapping("/program/list")
	public String programMagagement(Model model, HttpSession session, String br_name) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		br_name = user.getMe_name();
		
		List<BranchProgramDTO> branchProgramList = adminService.getBranchProgramList(br_name);
		List<SportsProgramVO> programList = adminService.getProgramList();
		List<EmployeeVO> employeeList = adminService.getEmployeeListByBranch(user.getMe_name());
		
		model.addAttribute("branchProgramList", branchProgramList);
		model.addAttribute("programList", programList);
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("br_name", br_name);
		
		return "/admin/program/list";
	}
	
	//지점 프로그램 등록 post
	@PostMapping("/program/insert")
	public String programInsertPost(Model model, BranchProgramVO branchProgram) {
		
		String msg = adminService.insertBranchProgram(branchProgram);
		
		model.addAttribute("url", "/admin/program/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}

	//지점 프로그램 수정 get
	@ResponseBody
	@GetMapping("/program/update")
	public Map<String, Object> programUpdate(@RequestParam int bp_num, PaymentTypeVO ptVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		BranchProgramDTO branchProgram = adminService.getBranchProgram(bp_num);
		map.put("branchProgram", branchProgram);
		return map;
	}	
	
	//지점 프로그램 수정 post
	@PostMapping("/program/update")
	public String programUpdatePost(Model model, BranchProgramVO branchProgram) {
		String msg = adminService.updateBranchProgram(branchProgram);

		model.addAttribute("url", "/admin/program/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 프로그램 삭제
	@GetMapping("/program/delete/{bp_num}")
	public String programDelete(Model model, @PathVariable("bp_num")int bp_num, HttpSession session, RedirectAttributes redirectAttributes) {
		
		BranchProgramDTO branchProgram = adminService.getBranchProgram(bp_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(!user.getMe_name().equals(branchProgram.getBp_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 프로그램은 삭제할 수 없습니다.");
	        return "redirect:/admin/program/list";
		}
		String msg = adminService.deleteBranchProgram(bp_num); 
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/admin/program/list");
		return "/main/message";
	}
	
	//지점 프로그램 일정 목록(프로그램명+트레이너명+[예약인원/총인원]+프로그램날짜+프로그램시간)
	@GetMapping("/schedule/list")
	public String programSchedule(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<BranchProgramScheduleVO> presentList = adminService.getBranchScheduleList("present", br_name);
		List<BranchProgramScheduleVO> pastList = adminService.getBranchScheduleList("past", br_name);
		
		model.addAttribute("presentList", presentList);
		model.addAttribute("pastList", pastList);
		model.addAttribute("br_name", br_name);
		return "/admin/schedule/list";
	}
	
	//지점 프로그램 일정 상세 -> 예약한 회원 목록(이름+전화번호+생년월일+성별+노쇼경고횟수)
	@GetMapping("/schedule/member/{bs_num}")
	public String scheduleMember(Model model, @PathVariable("bs_num")int bs_num, HttpSession session, RedirectAttributes redirectAttributes) {
		
		BranchProgramVO branchProgram = adminService.getBranchProgramInSchedule(bs_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(!user.getMe_name().equals(branchProgram.getBp_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 예약회원 목록은 조회할 수 없습니다.");
	        return "redirect:/admin/schedule/list";
		}
		
		List<MemberVO> memberList = adminService.getScheduleMemberList(bs_num);
		
		model.addAttribute("memberList", memberList);
		
		return "/admin/schedule/member";
	}
	
	//지점 프로그램 일정 추가 get
	@GetMapping("/schedule/regist")
	public String scheduleInsert(Model model, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		List<BranchProgramDTO> programList = adminService.getBranchProgramList(user.getMe_name());
		List<MemberVO> memberList = adminService.getMemberListInUser();
		model.addAttribute("programList", programList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("branchName", user.getMe_name());
		
		return "/admin/schedule/regist";
	}
//	
//	//지점 프로그램 일정 추가 post
//	@PostMapping("/schedule/insert")
//	public String scheduleInsertPost(Model model, String date, String startTime, String endTime, BranchProgramScheduleVO schedule, String me_id) {
//		
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 날짜 형식 지정
//        Date bs_start;
//        Date bs_end;
//        if(me_id == null) {
//        	me_id = "";
//        }
//        
//        
//		try {
//			bs_start = formatter.parse(date + " " + startTime);
//			bs_end = formatter.parse(date + " " + endTime);
//			schedule.setBs_start(bs_start);
//			schedule.setBs_end(bs_end);
//			System.out.println(schedule);
//
//			String msg = adminService.insertSchedule(schedule, me_id);
//			if(msg == "") {
//				model.addAttribute("url", "/admin/schedule/list");
//			} else {
//				model.addAttribute("url", "/admin/schedule/insert/"+schedule.getBp_br_name());
//			}
//			model.addAttribute("msg", msg);
//			return "/main/message";
//			
//		} catch (ParseException e) {
//			e.printStackTrace();
//			//return "/main/home";
//			return "/main/main";
//		}
// 
//	}
	
	//지점 프로그램 일정 추가 post
	@PostMapping("/schedule/regist")
	public String scheduleInsertPost(Model model, HttpServletRequest request, @ModelAttribute ProgramInsertFormDTO pif) {
		
		// System.out.println(pif);
		
		ResultMessage rm = new ResultMessage();
		
		if(pif.getSp_type().equals("단일")) {
			rm = adminService.insertBranchProgramSchedule(pif);
		}else {
			rm = adminService.insertBranchProgramScheduleList(pif);
		}
		if(rm.isResult()) {
			model.addAttribute("msg", "등록 성공\\n" + rm.getMessage());
		}
		else {
			model.addAttribute("msg", "등록 실패\\n" + rm.getMessage());
		}
		
		String prevUrl = request.getHeader("Referer");
		if (prevUrl != null) {
			model.addAttribute("url", prevUrl);
		}
		else {
			model.addAttribute("url", "/admin/schedule/list");
		}
		return "/main/message";
 
	}
	
	//지점 프로그램 일정 수정 get
	@GetMapping("/schedule/update/{bs_num}")
	public String scheduleUpdate(Model model, @PathVariable("bs_num")int bs_num, HttpSession session, RedirectAttributes redirectAttributes) {
		
		BranchProgramVO branchProgram = adminService.getBranchProgramInSchedule(bs_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(!user.getMe_name().equals(branchProgram.getBp_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 일정은 조회할 수 없습니다.");
	        return "redirect:/admin/schedule/list";
		}
		
		BranchProgramScheduleVO schedule = adminService.getSchedule(bs_num);
		
		model.addAttribute("schedule", schedule);
		
		return "/admin/schedule/update";
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
	
	//지점 프로그램 일정 삭제
	@GetMapping("/schedule/delete/{bs_num}")
	public String scheduleDelete(Model model, @PathVariable("bs_num")int bs_num, HttpSession session, RedirectAttributes redirectAttributes) {
		BranchProgramVO branchProgram = adminService.getBranchProgramInSchedule(bs_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(!user.getMe_name().equals(branchProgram.getBp_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 일정은 삭제할 수 없습니다.");
	        return "redirect:/admin/schedule/list";
		}
		
		adminService.deleteSchedule(bs_num);
		
		return "redirect:/admin/schedule/list";
	}
	
	//지점 발주 신청목록
	@GetMapping("/order/list")
	public String orderList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<BranchOrderVO> orderList = adminService.getBranchOrderList(br_name);
		List<BranchStockDTO> equipmentList = adminService.getEquipmentListInHQ();
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("br_name", br_name);
		
		return "/admin/order/list";
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
	@GetMapping("/order/delete/{bo_num}")
	public String orderDelete(Model model, @PathVariable("bo_num")int bo_num, HttpSession session, RedirectAttributes redirectAttributes) {
		
		BranchOrderVO order = adminService.getBranchOrder(bo_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(!user.getMe_name().equals(order.getBo_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 발주내역은 삭제할 수 없습니다.");
	        return "redirect:/admin/order/list";
		}
		
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
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<EmployeeVO> employeeList = adminService.getEmployeeListByBranch(br_name);
		
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("br_name", br_name);
		return "/admin/employee/list";
	}
	
	//지점 직원 등록 get
	@GetMapping("/employee/insert")
	public String employeeInsert(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<SportsProgramVO> programList = adminService.getProgramList();
		EmployeeVO em = adminService.getEmployee(20000001);
		model.addAttribute("em_br_name", user.getMe_name());
		model.addAttribute("programList", programList);
		model.addAttribute("em", em);
		return "/admin/employee/insert";
	}
	
	//지점 직원 등록 post
	@PostMapping("/employee/insert")
	public String employeeInsertPost(Model model, EmployeeVO employee, MultipartFile file) {
		String msg = adminService.insertEmployee(employee, file);
		if(msg.equals("")) {
			model.addAttribute("url", "/admin/employee/list");
		}else {
			model.addAttribute("url", "/admin/employee/insert");
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 직원 상세조회
	@GetMapping("/employee/detail/{em_num}")
	public String employeeDetail(Model model, @PathVariable("em_num") int em_num, HttpSession session, RedirectAttributes redirectAttributes) {
		EmployeeVO employee = adminService.getEmployee(em_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(!user.getMe_name().equals(employee.getEm_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 직원은 조회할 수 없습니다.");
	        return "redirect:/admin/employee/list";
		}
		
		List<SportsProgramVO> programList = adminService.getProgramList();
		model.addAttribute("em", employee);
		model.addAttribute("programList", programList);		
		return "/admin/employee/detail";
	}
	
	//지점 직원 상세수정
	@PostMapping("/employee/update")
	public String employeeUpdatePost(Model model, EmployeeVO employee, MultipartFile file, String isDel) {
		
		String msg = adminService.updateEmployee(employee, file, isDel);
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/admin/employee/list");
		return "/main/message";
	}	
	
	//지점 직원 삭제
	@GetMapping("/employee/delete/{em_num}")
	public String employeeDelete(Model model, @PathVariable("em_num") int em_num, HttpSession session, RedirectAttributes redirectAttributes) {
		EmployeeVO employee = adminService.getEmployee(em_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(!user.getMe_name().equals(employee.getEm_br_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점의 직원은 삭제할 수 없습니다.");
	        return "redirect:/admin/employee/list";
		}
		
		String msg = adminService.deleteEmployee(employee);
		if(msg.equals("")) {
			model.addAttribute("url", "/admin/employee/list");
		}else {
			model.addAttribute("url", "/admin/employee/detail/" + em_num);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//전체 회원목록
	@GetMapping("/member/list")
	public String memberList(Model model) {
		
		List<MemberVO> memberList = adminService.getMemberList();
		
		model.addAttribute("memberList", memberList);
		return "/admin/member/list";
	}
	
	//회원 상세보기
	@GetMapping("/member/detail/{me_id}")
	public String memberDetail(Model model, @PathVariable("me_id")String me_id, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberVO member = adminService.getMember(me_id);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(member.getMe_name().equals(user.getMe_name())) {
			return branchDetail(model, session);
		}
		if(member.getMe_authority().equals("BRADMIN") && !member.getMe_name().equals(user.getMe_name())) {
	        redirectAttributes.addFlashAttribute("msg", "다른 지점은 조회할 수 없습니다.");
	        return "redirect:/admin/member/list";
		}
		if(member.getMe_authority().equals("HQADMIN")) {
	        redirectAttributes.addFlashAttribute("msg", "본사는 조회할 수 없습니다.");
	        return "redirect:/admin/member/list";			
		}
		
		model.addAttribute("me", member);
		return "/admin/member/detail";		
	}
	
	//회원 노쇼횟수 수정
	@ResponseBody
	@PostMapping("/member/update")
	public Map<String, Object> memberUpdate(
					@RequestParam("noshow") int noshowCount,
					@RequestParam("me_id") String memberId){
			
		adminService.updateMemberNoShow(memberId, noshowCount);
		MemberVO member = adminService.getMember(memberId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("me", member);
		return map;
	}
	
	//회원 노쇼횟수 초기화
	@ResponseBody
	@PostMapping("/member/reset")
	public Map<String, Object> memberReset(@RequestParam("me_id") String memberId) {
	    // 노쇼 횟수를 0으로, 노쇼 제한시간을 null로 업데이트
	    adminService.updateMemberNoShow(memberId, 0);
	    
	    // 업데이트된 회원 정보 반환
	    MemberVO member = adminService.getMember(memberId);
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("me", member);
	    return map;
	}
	
	//지점 상세보기 조회
	@GetMapping("/branch/detail")
	public String branchDetail(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		BranchVO branch = adminService.getBranch(br_name);
		List<BranchFileVO> bfList = adminService.getBranchFileList(branch);
		MemberVO admin = adminService.getAdmin(branch);
		
		model.addAttribute("br", branch);
		model.addAttribute("bfList", bfList);
		model.addAttribute("me", admin);
		
		return "/admin/branch/detail";
	}
	
	//지점 상세보기 수정
	@PostMapping("/branch/update")
	public String branchUpdate(Model model, BranchVO branch, MultipartFile[] fileList, MemberVO admin, String[] numList) {
		String msg = adminService.updateBranch(branch, fileList, admin, numList);

		model.addAttribute("url", "/admin/branch/detail");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//지점 운동기구 재고 조회
	@GetMapping("/equipment/list")
	public String equipmentList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<BranchEquipmentStockVO> equipmentChange = adminService.getEquipmentChangeInBranch(br_name);
		List<BranchStockDTO> equipmentList = adminService.getEquipmentListInBranch(br_name);
		
		model.addAttribute("equipmentChange", equipmentChange);
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("br_name", br_name);
		return "/admin/equipment/list";
	}
	
	//지점 문의내역 목록 조회
	@GetMapping("/inquiry/list")
	public String inquiryList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String br_name = user.getMe_name();
		
		List<MemberInquiryVO> miWaitList = adminService.getMemberInquiryList(br_name, "wait");
		List<MemberInquiryVO> miDoneList = adminService.getMemberInquiryList(br_name, "done");
		
		model.addAttribute("miWaitList", miWaitList);
		model.addAttribute("miDoneList", miDoneList);
		model.addAttribute("br_name", br_name);
		return "/admin/inquiry/list";
	}
	
	//지점 문의내역 상세
	@ResponseBody
	@GetMapping("/inquiry/detail")
	public Map<String, Object> inquiryDetail(@RequestParam int mi_num, MemberInquiryVO miVo) {
		MemberInquiryVO mi = adminService.getMemberInquiry(miVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mi", mi);
		return map;
	}
	
	//지점 문의내역 답변(수정)
	@PostMapping("/inquiry/update")
	public String inquiryUpdatePost(Model model, MemberInquiryVO miVo) {
	    String msg = adminService.updateMemberInquiry(miVo);
	    model.addAttribute("url", "/admin/inquiry/list");
	    model.addAttribute("msg", msg);
		return "/main/message";
	}
	
}
