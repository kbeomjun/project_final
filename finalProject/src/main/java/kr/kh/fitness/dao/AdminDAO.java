package kr.kh.fitness.dao;

import java.util.List;

import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface AdminDAO {

	List<BranchProgramVO> selectBranchProgramList(String br_name);

	List<SportsProgramVO> selectProgramList();

	List<EmployeeVO> selectEmployeeList(String em_br_name);

	BranchProgramVO selectBranchProgram(BranchProgramVO branchProgram);

	boolean insertBranchProgram(BranchProgramVO branchProgram);

	BranchProgramScheduleVO selectSchedule(BranchProgramVO branchProgram);
	
	boolean updateBranchProgram(BranchProgramVO branchProgram);

	boolean deleteBranchProgram(BranchProgramVO branchProgram);

	List<BranchProgramVO> selectBranchScheduleList(String br_name);

	List<MemberVO> selectScheduleMemberList(int bp_num);

	List<BranchOrderVO> selectBranchOrderList(String br_name);

}
