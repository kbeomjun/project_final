package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsEquipmentVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

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

	List<SportsProgramVO> selectProgramList();

	boolean insertEmployee(@Param("em") EmployeeVO employee);

	EmployeeVO selectEmployee(@Param("em") EmployeeVO employee);

	String selectEmployeeFileName(@Param("em") EmployeeVO employee);

	boolean updateEmployee(@Param("em") EmployeeVO employee);

	List<SportsEquipmentVO> selectSportsEquipmentList();

	boolean insertSportsEquipment(@Param("se") SportsEquipmentVO se);

	SportsEquipmentVO selectSportsEquipment(@Param("se") SportsEquipmentVO se);

	String selectSportsEquipmentFileName(@Param("se_ori_name") String se_ori_name);

	boolean updateSportsEquipment(@Param("se") SportsEquipmentVO se, @Param("se_ori_name") String se_ori_name);

	List<BranchEquipmentStockVO> selectBranchEquipmentStockList();

	List<BranchStockDTO> selectBranchStockList();
}