package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.MemberVO;

public interface HQDAO {
	List<BranchVO> selectBranchList();

	boolean insertBranch(@Param("br")BranchVO branch);

	void insertBranchFile(@Param("bf")BranchFileVO branchFile);

	boolean insertAdmin(@Param("me")MemberVO admin);

	BranchVO selectBranch(@Param("br")BranchVO branch);

	MemberVO selectAdmin(@Param("br")BranchVO branch);

	List<BranchFileVO> selectBranchFileList(@Param("br")BranchVO branch);
}