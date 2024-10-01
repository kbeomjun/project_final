package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;

public interface HQDAO {
	
	List<BranchVO> selectBranchList();

	boolean insertBranch(@Param("br") BranchVO branch);

	void insertBranchFile(@Param("bf") BranchFileVO branchFile);

	boolean insertAdmin(@Param("me") MemberVO admin);

	BranchVO selectBranch(@Param("br") BranchVO branch);

	MemberVO selectAdmin(@Param("br") BranchVO branch);

	List<BranchFileVO> selectBranchFileList(@Param("br") BranchVO branch);

	boolean updateBranch(@Param("br") BranchVO branch, @Param("br_ori_name") String br_ori_name);

	BranchFileVO selectBranchFile(@Param("bf_num") int bf_num);

	boolean deleteBranchFile(@Param("bf") BranchFileVO branchFile);

	boolean updatetAdmin(@Param("me") MemberVO admin, @Param("br_ori_name") String br_ori_name);

	List<EmployeeVO> selectEmployeeList();
}
