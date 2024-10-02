package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.AdminDAO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

@Service
public class AdminServiceImp implements AdminService{
	
	@Autowired
	private AdminDAO adminDao;
	
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
	public List<EmployeeVO> getEmployeeList(String em_br_name) {
		if(em_br_name == null) {
			return null;
		}
		return adminDao.selectEmployeeList(em_br_name);
	}

	@Override
	public boolean insertBranchProgram(BranchProgramVO branchProgram) {
		
		if(branchProgram == null) {
			return false;
		}
		
		BranchProgramVO checkProgram = adminDao.selectBranchProgram(branchProgram);
		if(checkProgram != null) {
			return false;
		}
		
		return adminDao.insertBranchProgram(branchProgram);
	}

	@Override
	public boolean updateBranchProgram(BranchProgramVO branchProgram) {
		if(branchProgram == null) {
			return false;
		}
		
		BranchProgramScheduleVO checkSchedule = adminDao.selectScheduleWithCurrent(branchProgram);
		
		if(checkSchedule != null) {
			return false;
		}
		
		if(adminDao.updateBranchProgram(branchProgram)) {
			return true;
		}
		
		return false;
	}

	@Override
	public boolean deleteBranchProgram(BranchProgramVO branchProgram) {
		if(branchProgram == null) {
			return false;
		}
		
		if(adminDao.deleteBranchProgram(branchProgram)) {
			return true;
		}
		
		return false;
	}

	@Override
	public List<BranchProgramScheduleVO> getBranchScheduleList(String br_name) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectBranchScheduleList(br_name);
	}

	@Override
	public List<MemberVO> getScheduleMemberList(int bs_num) {
		return adminDao.selectScheduleMemberList(bs_num);
	}

	@Override
	public List<EmployeeVO> getMemberList() {
		return adminDao.selectMemberList();
	}

	@Override
	public boolean insertSchedule(BranchProgramScheduleVO schedule, String me_id) {
		
		BranchProgramScheduleVO checkSchedule = adminDao.selectSchedule(schedule);
		if(checkSchedule != null) {
			return false;
		}
		if(!adminDao.insertSchedule(schedule)) {
			return false;
		}
		
		System.out.println(me_id);
		if(me_id.length() != 0) {
			adminDao.insertReservationByPTManager(me_id, schedule.getBs_num());
			adminDao.updateScheduleByPTReservation(schedule.getBs_num());
		}
		
		return true;
	}
	
	@Override
	public BranchProgramScheduleVO getSchedule(int bp_num) {
		return adminDao.selectScheduleByNum(bp_num);
	}

	@Override
	public List<BranchOrderVO> getBranchOrderList(String br_name) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectBranchOrderList(br_name);
	}

	@Override
	public boolean updateSchedule(BranchProgramScheduleVO schedule) {
		BranchProgramScheduleVO checkSchedule = adminDao.selectSchedule(schedule);
		if(checkSchedule != null) {
			return false;
		}
		return adminDao.updateSchedule(schedule);
	}
	
}
