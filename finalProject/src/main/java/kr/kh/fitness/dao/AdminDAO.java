package kr.kh.fitness.dao;

import java.util.List;

import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface AdminDAO {

	List<BranchProgramVO> selectBranchProgramList(String branchName);

	List<SportsProgramVO> selectProgramList();

	List<EmployeeVO> selectEmployeeList(String em_br_name);

	BranchProgramVO selectBranchProgram(BranchProgramVO branchProgram);

	boolean insertBranchProgram(BranchProgramVO branchProgram);

}
