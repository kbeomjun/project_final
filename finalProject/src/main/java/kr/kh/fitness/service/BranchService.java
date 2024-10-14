package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;

public interface BranchService {

	List<BranchVO> getBranchList();

	List<EmployeeVO> getEmployeeList(String br_name);

	List<BranchFileVO> getBranchImageList(String br_name);

	boolean isExistBranch(String br_name);


}
