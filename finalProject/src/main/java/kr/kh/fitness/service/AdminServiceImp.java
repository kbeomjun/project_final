package kr.kh.fitness.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.AdminDAO;
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
import kr.kh.fitness.model.vo.SportsProgramVO;
import kr.kh.fitness.pagination.BranchCriteria;
import kr.kh.fitness.pagination.Criteria;
import kr.kh.fitness.pagination.PageMaker;
import kr.kh.fitness.utils.UploadFileUtils;

@Service
public class AdminServiceImp implements AdminService{
	
	@Autowired
	private AdminDAO adminDao;
	@Resource
	String uploadPath;
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public List<BranchProgramVO> getBranchProgramList(String br_name) {
		
		if(br_name == null) {
			return null;
		}
		return adminDao.selectBranchProgramList(br_name);
	}

	@Override
	public List<SportsProgramVO> getProgramList() {
		return adminDao.selectProgramList();
	}

	@Override
	public List<EmployeeVO> getEmployeeListByBranch(String em_br_name) {
		if(em_br_name == null) {
			return null;
		}
		return adminDao.selectEmployeeListByBranch(em_br_name);
	}

	@Override
	public String insertBranchProgram(BranchProgramVO branchProgram) {
		if(branchProgram == null) {
			return "프로그램 정보가 없습니다.";
		}
		
		BranchProgramVO checkProgram = adminDao.selectBranchProgram(branchProgram);
		if(checkProgram != null) {
			return "이미 존재하는 프로그램입니다.";
		}
		if(!adminDao.insertBranchProgram(branchProgram)) {
			return "프로그램 등록에 실패했습니다.";
		}
		return "";
	}

	@Override
	public BranchProgramVO getBranchProgram(int bp_num) {
		return adminDao.selectBranchProgramByNum(bp_num);
	}
	
	@Override
	public String updateBranchProgram(BranchProgramVO branchProgram) {
		if(branchProgram == null) {
			return "프로그램 정보가 없습니다.";
		}
		
		int checkSchedule = adminDao.selectScheduleWithCurrent(branchProgram);
		
		if(checkSchedule > 0) {
			return "현재 예약된 인원보다 작을 수 없습니다.";
		}
		
		if(!adminDao.updateBranchProgram(branchProgram)) {
			return "프로그램 수정에 실패했습니다.";
		}
		
		return "";
	}

	@Override
	public boolean deleteBranchProgram(int bp_num) {
		return adminDao.deleteBranchProgram(bp_num);
	}

	@Override
	public List<BranchProgramScheduleVO> getBranchScheduleList(String view, BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		if(cri.getBr_name() == null) {
			return null;
		}
		return adminDao.selectBranchScheduleList(view, cri);
	}

	@Override
	public List<MemberVO> getScheduleMemberList(int bs_num) {
		return adminDao.selectScheduleMemberList(bs_num);
	}

	@Override
	public List<MemberVO> getMemberList() {
		return adminDao.selectMemberList();
	}
	
	@Override
	public List<MemberVO> getMemberListWithPagination(Criteria cri) {
		if(cri == null) {
			return null;
		}
		return adminDao.selectMemberListWithPagination(cri);
	}

	@Override
	public PageMaker getPageMakerInMember(Criteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = adminDao.selectMemberTotalCount(cri);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public String insertSchedule(BranchProgramScheduleVO schedule, String me_id) {
		
		BranchProgramScheduleVO checkSchedule = adminDao.selectSchedule(schedule);
		if(checkSchedule != null) {
			return "다른 일정과 시간이 겹칠 수 없습니다.";
		}
		if(!adminDao.insertSchedule(schedule)) {
			return "스케줄을 등록하지 못했습니다.";
		}
		
		if(me_id.length() != 0) {
			adminDao.insertReservationByPTManager(me_id, schedule.getBs_num());
			adminDao.updateScheduleByPTReservation(schedule.getBs_num());
		}
		
		return "";
	}
	
	@Override
	public BranchProgramScheduleVO getSchedule(int bs_num) {
		return adminDao.selectScheduleByNum(bs_num);
	}

	@Override
	public List<BranchOrderVO> getBranchOrderList(BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		if(cri.getBr_name() == null) {
			return null;
		}
		return adminDao.selectBranchOrderList(cri);
	}

	@Override
	public PageMaker getPageMakerInOrder(BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = adminDao.selectOrderTotalCount(cri);
		return new PageMaker(3, cri, totalCount);
	}


	@Override
	public String updateSchedule(BranchProgramScheduleVO schedule) {
		BranchProgramScheduleVO checkSchedule = adminDao.selectSchedule(schedule);
		if(checkSchedule != null) {
			return "다른 일정과 시간이 겹칠 수 없습니다.";
		}
		if(!adminDao.updateSchedule(schedule)) {
			return "스케줄 수정에 실패했습니다.";
		}
		return "";
	}

	@Override
	public void deleteSchedule(int bs_num) {
		adminDao.deleteSchedule(bs_num);
	}
	
	@Override
	public List<BranchStockDTO> getEquipmentListInHQ() {
		return adminDao.selectEquipmentListInHQ();
	}

	@Override
	public String insertOrder(BranchOrderVO order) {
		if(order == null) {
			return "발주 정보가 없습니다.";
		}
		if(order.getBo_se_name() == null || order.getBo_se_name().trim().length() == 0) {
			return "운동기구 이름이 존재하지 않습니다.";
		}
		if(!adminDao.insertOrder(order)) {
			return "발주 등록에 실패했습니다.";
		}
		return "";
	}

	@Override
	public boolean deleteOrder(int bo_num) {
		return adminDao.deleteOrder(bo_num);
	}

	@Override
	public List<EmployeeVO> getEmployeeListByBranchWithPagination(BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		if(cri.getBr_name() == null) {
			return null;
		}
		return adminDao.selectEmployeeListByBranchWithPagination(cri);
	}

	@Override
	public PageMaker getPageMakerInEmployee(BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = adminDao.selectEmployeeByBranchTotalCount(cri);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public String insertEmployee(EmployeeVO employee, MultipartFile file) {
		String msg = "";
		if(employee == null) {msg = "직원 정보가 없습니다.";}
		if(file == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int em_num = createEmployeeNum(year);
		employee.setEm_num(em_num);
		
		String em_fi_name = uploadEmployeeFile(file, employee.getEm_num() + "");
		employee.setEm_fi_name(em_fi_name);
		
		if(!adminDao.insertEmployee(employee)) {msg = "직원을 등록하지 못했습니다.";}
		return msg;
	}

	private int createEmployeeNum(int year) {
		int min = 1, max = 9999;
		List<EmployeeVO> emList = adminDao.selectEmployeeList();
		int em_num = 0;
		while(true){
			boolean flag = true;
			int random = (int)(Math.random() * (max - min + 1) + min);
			String randomNum = String.valueOf(random);
			if(randomNum.length() < 4) {
				while(randomNum.length() < 4) {
					randomNum = "0" + randomNum;
				}
			}
			em_num = Integer.parseInt(year+randomNum);
			for(int i = 0; i < emList.size(); i++) {
				if(em_num == emList.get(i).getEm_num()) {
					flag = false;
					break;
				}
			}
			if(flag) {break;}
		}
		return em_num;
	}
	
	private String uploadEmployeeFile(MultipartFile file, String em_fi_ori_name) {
		if(file == null) {return null;}
		try {
			String em_fi_name = UploadFileUtils.uploadFile(uploadPath, "직원", em_fi_ori_name, file.getBytes());
			return em_fi_name;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public EmployeeVO getEmployee(int em_num) {
		return adminDao.selectEmployee(em_num);
	}

	@Override
	public String updateEmployee(EmployeeVO employee, MultipartFile file, String isDel) {
		String msg = "";
		if(employee == null) {msg = "직원 정보가 없습니다.";}
		if(file == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		String em_fi_name = adminDao.selectEmployeeFileName(employee);
		employee.setEm_fi_name(em_fi_name);
		if(isDel != null) {
			UploadFileUtils.delteFile(uploadPath, employee.getEm_fi_name());
			em_fi_name = uploadEmployeeFile(file, employee.getEm_num() + "");
			employee.setEm_fi_name(em_fi_name);
		}
		
		if(!adminDao.updateEmployee(employee)) {msg = "직원을 수정하지 못했습니다.";}
		return msg;
	}
	
	@Override
	public MemberVO getMember(String me_id) {
		return adminDao.selectMember(me_id);
	}
	
	@Override
	public void updateMemberNoShow(String me_id, int me_noshow) {
	    // me_cancel 초기화
	    String me_cancel = null;
	    
	    // me_noshow가 5 이상이면 현재 시간 + 1개월을 me_cancel에 설정
	    if (me_noshow >= 5) {
	        LocalDateTime now = LocalDateTime.now();
	        LocalDateTime oneMonthLater = now.plusMonths(1);
	        me_cancel = oneMonthLater.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	    }
	    
	    adminDao.updateMemberNoShow(me_id, me_noshow, me_cancel);
	}

	@Override
	public BranchVO getBranch(String br_name) {
		return adminDao.selectBranch(br_name);
	}

	@Override
	public List<BranchFileVO> getBranchFileList(BranchVO branch) {
		return adminDao.selectBranchFileList(branch);
	}

	@Override
	public MemberVO getAdmin(BranchVO branch) {
		return adminDao.selectAdmin(branch);
	}
	
	@Override
	public String updateBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin, String[] numList) {
		String msg = "";
		if(branch == null) {
			msg = "지점 정보가 없습니다.";
		}
		if(fileList == null) {
			msg = "사진 정보가 없습니다.";
		}
		if(admin == null) {
			msg = "관리자 정보가 없습니다.";
		}
		
		if(!adminDao.updateBranch(branch)) {
			msg = "지점 정보를 수정하지 못했습니다.";
		}
		if(!msg.equals("")) {
			return msg;
		}
		
		if(numList != null) {
			for(int i = 0; i < numList.length; i++) {
				int bf_num = Integer.parseInt(numList[i]);
				BranchFileVO branchFile = adminDao.selectBranchFile(bf_num);
				if(adminDao.deleteBranchFile(branchFile)) {
					UploadFileUtils.delteFile(uploadPath, branchFile.getBf_name());
				}
			}
		}
		for(MultipartFile file : fileList) {
			uploadFile(file, branch.getBr_name());
		}
		
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		if(!adminDao.updateAdmin(admin)) {
			msg = "관리자 정보를 수정하지 못했습니다.";
		}
		return msg;
	}

	private void uploadFile(MultipartFile file, String br_name) {
		if(file == null || file.getOriginalFilename().length() == 0) {
			return;
		}
		try {
			String bf_name = UploadFileUtils.uploadFile(uploadPath, "지점", br_name, file.getBytes());
			BranchFileVO branchFile = new BranchFileVO(bf_name, br_name);
			adminDao.insertBranchFile(branchFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<BranchStockDTO> getEquipmentListInBranch(String view, BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		if(cri.getBr_name() == null) {
			return null;
		}
		return adminDao.selectEquipmentListInBranch(view, cri);
	}
	
	@Override
	public PageMaker getPageMakerInEquipmentList(String view, BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = adminDao.selectEquipmentListTotalCount(view, cri);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public List<BranchEquipmentStockVO> getEquipmentChangeInBranch(BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		if(cri.getBr_name() == null) {
			return null;
		}
		return adminDao.selectEquipmentChangeInBranch(cri);
	}
	
	@Override
	public PageMaker getPageMakerInEquipmentChange(BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = adminDao.selectEquipmentChangeTotalCount(cri);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public PageMaker getPageMaker(String view, BranchCriteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = adminDao.selectScheduleTotalCount(view, cri);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public ResultMessage insertBranchProgramSchedule(ProgramInsertFormDTO pif) {
		
		// 지점에 등록된 프로그램이 없다면
		if(adminDao.selectBranchProgramByNum(pif.getBs_bp_num()) == null) {
			return new ResultMessage(false, "프로그램을 불러오는데 실패하였습니다.");
		}
		
		// 시간이 중복 등록되었거나 등록되지 않았다면
		if(pif.getHours().size() != 1) {
			return new ResultMessage(false, "시간을 선택하지 않았거나 중복하였습니다.");
		}
		
		int hour = pif.getHours().get(0);
		
		// bps 객체 생성
		BranchProgramScheduleVO bps = newBranchProgramSchedule(pif.getSelectDate(), hour, pif.getBs_bp_num(), 1);
		
		if(bps == null) {
			return new ResultMessage(false, "스케쥴을 생성하는데 실패하였습니다. \\\\n(같은 시간에 이미 등록된 스케쥴이 있을 수 있습니다.)");
		}
		
		boolean res = adminDao.insertBranchProgramSchedule(bps);
		if(res) {
			return new ResultMessage(true,"스케쥴이 정상적으로 등록되었습니다.");
		}
		return new ResultMessage(false,"DB에 등록하는데 실패하였습니다.(관리자 문의!)");
	}

	private BranchProgramScheduleVO newBranchProgramSchedule(Date selectDate, int hour, int bp_num, int current) {
		
		Calendar calendar = Calendar.getInstance();
        calendar.setTime(selectDate);

        // 스케줄 시간 시간
        calendar.add(Calendar.HOUR, hour);
        Date startDate = calendar.getTime();
        // 스케줄 마감 시간
        calendar.add(Calendar.HOUR, 1);
        Date endDate = calendar.getTime();
        
        //해당 프로그램이 현재 등록하려는 시간으로 이미 스케쥴이 등록되어 있는 지 확인
        if(adminDao.selectBranchSchedule(bp_num, startDate) != null) {
        	System.err.println("이미 스케쥴이 등록된 시간");
        	return null;
        }
        
        BranchProgramScheduleVO bps = new BranchProgramScheduleVO(startDate, endDate, current, bp_num);
        
        return bps;
	}

	@Override
	public ResultMessage insertBranchProgramScheduleList(ProgramInsertFormDTO pif) {
		// 지점에 등록된 프로그램이 없다면
		if (adminDao.selectBranchProgramByNum(pif.getBs_bp_num()) == null) {
			return new ResultMessage(false,"프로그램을 불러오는데 실패하였습니다.");
		}
		// 시작 시간 혹은 마감 시간이 null이라면
		if(pif.getStartDate() == null || pif.getEndDate() == null) {
			return new ResultMessage(false,"시작 날짜와 마감 날짜가 정상적으로 입력되지 않았습니다.");
		}
		
		List<BranchProgramScheduleVO> bps_list = new ArrayList<BranchProgramScheduleVO>();
		
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(pif.getStartDate());
        int dayOfWeek = startCalendar.get(Calendar.DAY_OF_WEEK);

        // 요일 숫자 값 (일요일: 1, 월요일: 2, ..., 토요일: 7)
        for(int week : pif.getWeeks()) {
        	
			/*
			 * 시작 날짜가 수요일(4), 선택한 요일이 목요일(5)이라면
			 * 5-4 = 1일 시작 날짜에서 1일을 더해준 값이 해당 요일의 시작 날짜
			 * 시작 날짜가 수요일(4), 선택한 요일이 일요일(1)이라면
			 * 1-4 = -3, 시작 날짜 3일 전은 등록이 불가하므로 +7일 해준 날짜가 시작 날짜 
			 */
        	
            int start = week - dayOfWeek;
            if(start < 0) start += 7;
            
            Calendar weekcalendar = Calendar.getInstance();
            weekcalendar.setTime(pif.getStartDate());
            
            weekcalendar.add(Calendar.DATE, start);
            Date weekDate = weekcalendar.getTime();

            // weekDate가 마감날짜보다 앞이라면 계속 일정 추가
            while(pif.getEndDate().compareTo(weekDate) >= 0) {
            	
            	for(int hour : pif.getHours()) {
            		
            		BranchProgramScheduleVO bps = newBranchProgramSchedule(weekDate, hour, pif.getBs_bp_num(), 0);
            		if(bps == null) {
            			return new ResultMessage(false,"스케쥴을 생성하는데 실패하였습니다. \\n(같은 시간에 이미 등록된 스케쥴이 있을 수 있습니다.)");
            		}else {
            			bps_list.add(bps);
            		}
            	}
            	
            	// 다음 주 같은 요일 = 요일의 시작 날짜에서 7일을 더해준 값
            	weekcalendar.add(Calendar.DATE, 7); 
                weekDate = weekcalendar.getTime();
            }
            
        }
		
		if(bps_list.size() == 0) {
			return new ResultMessage(false,"선택한 날짜 사이에 요청한 요일이 존재하지 않습니다.");
		}
		
		boolean res = adminDao.insertBranchProgramScheduleList(bps_list);
		if(res) {
			return new ResultMessage(true,"입력한 스케쥴이 모두 등록되었습니다.");
		}
		
		return new ResultMessage(false,"DB에 등록하는데 실패하였습니다.(관리자 문의!)");
	}

	public List<MemberInquiryVO> getMemberInquiryList(String br_name, String mi_state) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectMemberInquiryList(br_name, mi_state);
	}

	@Override
	public MemberInquiryVO getMemberInquiry(MemberInquiryVO mi) {
		if(mi == null) {
			return null;
		}
		return adminDao.selectMemberInquiry(mi);
	}

	@Override
	public String updateMemberInquiry(MemberInquiryVO mi) {
		String msg = "";
		if(mi == null) {msg = "문의 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		mi.setMi_state("답변완료");
		if(!adminDao.updateMemberInquiry(mi)) {msg = "문의 답변을 등록하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		
		MemberVO me = adminDao.selectMemberByEmail(mi.getMi_email());
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy.MM.dd");
		String date = dtFormat.format(mi.getMi_date());
		boolean isSend = false;
		if(me == null) {
			isSend = mailSend(mi.getMi_email(), "KH피트니스 1:1문의 답변완료 안내",
								date + " 문의하신 내역에 답변이 완료되었습니다.<br/><br/>답변:<br/><br/>" + mi.getMi_answer());
		}else {
			isSend = mailSend(me.getMe_email(), "KH피트니스 1:1문의 답변완료 안내",
								date + " 문의하신 내역에 답변이 완료되었습니다.<br/><br/>답변은 KH피트니스 홈페이지에서 확인하실 수 있습니다.");
		}
		if(!isSend) {msg = "메일을 전송하지 못했습니다.";}
		return msg;
	}
	public boolean mailSend(String to, String title, String content) {
	    String setfrom = "stajun@naver.com";
	    try{
	    	MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom(setfrom);// 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(to);// 받는사람 이메일
	        messageHelper.setSubject(title);// 메일제목은 생략이 가능하다
	        messageHelper.setText(content, true);// 메일 내용

	        mailSender.send(message);
	        return true;
	    } catch(Exception e){
	        e.printStackTrace();
	        return false;
	    }
	}

}
