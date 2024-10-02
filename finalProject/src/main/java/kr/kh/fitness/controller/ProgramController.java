package kr.kh.fitness.controller;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.dto.CalendarDTO;
import kr.kh.fitness.model.dto.ProgramReservationMessage;
import kr.kh.fitness.model.dto.ProgramScheduleDTO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;
import kr.kh.fitness.service.ProgramService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/program")
public class ProgramController {

	@Autowired
	private ProgramService programService;

//	@GetMapping("/main")
//	public String programMain(Model model) throws Exception {
//		log.info("/program/main");
//
//		LocalDate today = LocalDate.now();
//		model.addAttribute("year", today.getYear());
//		model.addAttribute("month", today.getMonthValue());
//		model.addAttribute("day", today.getDayOfMonth());
//
//		return "/program/main";
//	}

	@GetMapping("/info")
	public String programInfo(Model model) throws Exception {
		log.info("/program/info");

		List<SportsProgramVO> list = programService.getProgramList();

		model.addAttribute("list", list);

		return "/program/info";
	}

	@GetMapping("/schedule")
	public String programScheduleCurrentMonth(Model model) {
		log.info("/program/schedule : no Arg");
		
		// 기본 값 설정
		LocalDate today = LocalDate.now();

		int year = today.getYear();
		int month = today.getMonthValue() - 1;
		int day = today.getDayOfMonth();

		return programSchedule(model, year, month, day, "null", "null");
	}

	@GetMapping("/schedule/{year}/{month}/{day}/{br_name}/{pr_name}")
	public String programSchedule(Model model, @PathVariable("year") Integer inputYear,
			@PathVariable("month") Integer inputMonth, @PathVariable("day") Integer inputDay,
			@PathVariable("br_name") String br_name, @PathVariable("pr_name") String pr_name) {
		
		log.info("/program/schedule : Arg");
		
		int year = inputYear;
		int month = inputMonth; // 0: 1월, 11: 12월
		int day = inputDay;

		// 이전달, 다음달 선택해서 접근한 경우 month 값이 아래와 같이 나올 수 있어서 조정
		if (month == -1) {
			month = 11;
			year--;
		}
		if (month == 12) {
			month = 0;
			year++;
		}

		// 출력하고자 달의 1일 객체 + 1일 요일 + 마지막 날짜
		Calendar firstDate = Calendar.getInstance();
		firstDate.set(Calendar.YEAR, year);
		firstDate.set(Calendar.MONTH, month);
		firstDate.set(Calendar.DATE, 1);
		int firstDay = firstDate.get(Calendar.DAY_OF_WEEK);
		int lastDate = firstDate.getActualMaximum(Calendar.DATE);

		// 출력 알고리즘(td의 개수 구하기) 4주~6주 까지 가능.
		int startBlankCnt = firstDay - 1;
		int endBlankCnt = 0;
		if ((startBlankCnt + lastDate) % 7 != 0) {
			endBlankCnt = 7 - (startBlankCnt + lastDate) % 7;
		}
		int tdCnt = startBlankCnt + lastDate + endBlankCnt;

		// 달력 DTO 설정
		CalendarDTO cal = new CalendarDTO();
		cal.setYear(year);
		cal.setMonth(month);
		cal.setDay(day);
		cal.setFirstDay(firstDay);
		cal.setLastDate(lastDate);
		cal.setStartBlankCnt(startBlankCnt);
		cal.setEndBlankCnt(endBlankCnt);
		cal.setTdCnt(tdCnt);

		LocalDate today = LocalDate.now();
		today = LocalDate.of(year, month + 1, day);

		String searchDate = String.format("%04d-%02d-%02d", year, month + 1, day);
		String searchMonth = String.format("%04d-%02d", year, month + 1);
		
		// 지점 리스트
		List<BranchVO> branch_list = programService.getBranchList();
		
		// 프로그램 리스트 
		List<SportsProgramVO> program_list = programService.getProgramList();
		
		// 
		List<ProgramScheduleDTO> ps_list = programService.getProgramSchedule(searchMonth, br_name, pr_name);
		
		model.addAttribute("cal", cal);
		model.addAttribute("selected", today);
		model.addAttribute("searchDate", searchDate);
		
		model.addAttribute("branch_list", branch_list);
		model.addAttribute("program_list", program_list);
		
		model.addAttribute("br_name", br_name);
		model.addAttribute("pr_name", pr_name);

		model.addAttribute("ps_list", ps_list);
		
		return "/program/schedule";
	}
	
	@GetMapping("/reservation/{bs_num}")
	public String programReservation(Model model, HttpSession session, HttpServletRequest request, @PathVariable("bs_num") Integer bs_num) {
		
		log.info("/program/reservation");

		MemberVO user = (MemberVO) session.getAttribute("user");
		
		ProgramReservationMessage rm = programService.addProgramReservation(user, bs_num);
		
		if(rm.isResult()) {
			model.addAttribute("msg", "예약이 확정되었습니다.");
		}
		else {
			model.addAttribute("msg", "예약에 실패하였습니다.\\n(" + rm.getMessage() + ")");
		}
	
		String prevUrl = request.getHeader("Referer");
		if (prevUrl != null) {
			model.addAttribute("url", prevUrl);
		}
		else {
			model.addAttribute("url", "/program/schedule");
		}
		
		return "/main/message";
	}
	
	
	// 이미 예약한 프로그램인 지 중복 체크
	@ResponseBody
	@GetMapping("/checkReservation")
	public Map<String, Object> programCheckReservation(HttpSession session, @RequestParam("bs_num") int bs_num){
		log.info("/program/CheckReservation");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		boolean isDuplicated = programService.checkReservation(user, bs_num);
		
		map.put("checkReservation", isDuplicated);
		return map;
	}
	
}
