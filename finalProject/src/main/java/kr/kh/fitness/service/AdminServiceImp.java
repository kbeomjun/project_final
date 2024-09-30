package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.AdminDAO;
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
	public List<BranchProgramVO> getBranchScheduleList(String br_name) {
		if(br_name == null) {
			return null;
		}
		return adminDao.selectBranchScheduleList(br_name);
	}

	@Override
	public List<MemberVO> getScheduleMemberList(int bp_num) {
		return adminDao.selectScheduleMemberList(bp_num);
	}

}
