package kr.kh.fitness.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.AdminDAO;
import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.dto.ProgramInsertFormDTO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;
import kr.kh.fitness.pagination.BranchCriteria;
import kr.kh.fitness.pagination.PageMaker;
import kr.kh.fitness.utils.UploadFileUtils;

@Service
public class AdminServiceImp implements AdminService{
	
	@Autowired
	private AdminDAO adminDao;
	@Resource
	String uploadPath;
	
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
	public List<BranchOrderVO> getBranchOrderList(String br_name) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectBranchOrderList(br_name);
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
	public List<BranchStockDTO> getEquipmentListInBranch(String br_name, String view) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectEquipmentListInBranch(br_name, view);
	}

	@Override
	public List<BranchEquipmentStockVO> getEquipmentChangeInBranch(String br_name) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectEquipmentChangeInBranch(br_name);
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
	public boolean insertBranchProgramSchedule(ProgramInsertFormDTO pif) {
		
		// 지점에 등록된 프로그램이 없다면
		if(adminDao.selectBranchProgramByNum(pif.getBs_bp_num()) == null) {
			return false;
		}
		
		// 시간이 중복 등록되었거나 등록되지 않았다면
		if(pif.getHours().size() != 1) {
			return false;
		}
		
		int hour = pif.getHours().get(0);
		
		BranchProgramScheduleVO bps = newBranchProgramSchedule(pif.getSelectDate(), hour, pif.getBs_bp_num(), 1);
		
		if(bps == null) return false;
		return adminDao.insertBranchProgramSchedule(bps);
        
	}

	private BranchProgramScheduleVO newBranchProgramSchedule(Date selectDate, int hour, int bp_num, int current) {
		
		Calendar calendar = Calendar.getInstance();
        calendar.setTime(selectDate);

        // 스케줄 시간만큼 증가시키기
        calendar.add(Calendar.HOUR, hour);
        Date startDate = calendar.getTime();
        calendar.add(Calendar.HOUR, 1);
        Date endDate = calendar.getTime();
        
        System.out.println("기존 날짜: " + startDate);
        System.out.println("마감 시간: " + endDate);
        
        //해당 프로그램이 현재 등록하려는 시간으로 이미 스케쥴이 등록되어 있는 지 확인
        if(adminDao.selectBranchSchedule(bp_num, startDate) != null) {
        	System.out.println("이미 스케쥴이 등록된 시간");
        	return null;
        }
        
        BranchProgramScheduleVO bps = new BranchProgramScheduleVO(startDate, endDate, current, bp_num);
        
        return bps;
	}

	@Override
	public boolean insertBranchProgramScheduleList(ProgramInsertFormDTO pif) {
		
		// 지점에 등록된 프로그램이 없다면
		if (adminDao.selectBranchProgramByNum(pif.getBs_bp_num()) == null) {
			return false;
		}
		
		// 시작 시간 혹은 마감 시간이 null이라면
		if(pif.getStartDate() == null || pif.getEndDate() == null) {
			return false;
		}
		
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(pif.getStartDate());
        
        List<BranchProgramScheduleVO> bps_list = new ArrayList<BranchProgramScheduleVO>();

        for(int week : pif.getWeeks()) {
        	
        	// 요일 숫자 값 출력 (일요일: 1, 월요일: 2, ..., 토요일: 7)
            int dayOfWeek = startCalendar.get(Calendar.DAY_OF_WEEK);
            System.out.println("오늘의 요일 숫자 값: " + dayOfWeek);
            System.out.println("입력받은 요일 값: " + week);
            
            int start = week - dayOfWeek;
            if(start < 0) start += 7;
            
            Calendar weekcalendar = Calendar.getInstance();
            weekcalendar.setTime(pif.getStartDate());
            
            weekcalendar.add(Calendar.DATE, start);
            Date weekDate = weekcalendar.getTime();

            System.out.println("현재 날짜: " + pif.getStartDate());
            System.out.println(start+"일 후 날짜: " + weekDate);
            
            // weekDate가 마감날짜보다 앞이라면 계속 일정 추가
            while(pif.getEndDate().compareTo(weekDate) >= 0) {
            	
            	for(int hour : pif.getHours()) {
            		
            		BranchProgramScheduleVO bps = newBranchProgramSchedule(weekDate, hour, pif.getBs_bp_num(), 0);
            		if(bps == null) {
            			System.out.println("bps 생성하는 과정에서 에러 발생!");
            			return false;
            		}else {
            			bps_list.add(bps);
            		}
            	}
            	
            	// 다음주 같은 요일
            	weekcalendar.add(Calendar.DATE, 7); 
                weekDate = weekcalendar.getTime();
            }
            
        }
		
		return adminDao.insertBranchProgramScheduleList(bps_list);
	}

}
