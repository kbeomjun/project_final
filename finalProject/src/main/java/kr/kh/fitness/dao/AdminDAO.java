package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.dto.BranchStockDTO;
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

public interface AdminDAO {

	List<BranchProgramVO> selectBranchProgramList(String br_name);

	List<SportsProgramVO> selectProgramList();

	List<EmployeeVO> selectEmployeeListByBranch(String em_br_name);

	BranchProgramVO selectBranchProgram(BranchProgramVO branchProgram);

	BranchProgramVO selectBranchProgramByNum(int bp_num);

	boolean insertBranchProgram(BranchProgramVO branchProgram);

	int selectScheduleWithCurrent(BranchProgramVO branchProgram);
	
	boolean updateBranchProgram(BranchProgramVO branchProgram);

	boolean deleteBranchProgram(int bp_num);

	List<BranchProgramScheduleVO> selectBranchScheduleList(@Param("view")String view, @Param("cri")BranchCriteria cri);

	List<MemberVO> selectScheduleMemberList(int bs_num);
	
	BranchProgramScheduleVO selectSchedule(BranchProgramScheduleVO schedule);

	boolean insertSchedule(BranchProgramScheduleVO schedule);
	
	void insertReservationByPTManager(@Param("me_id")String me_id, @Param("bs_num")int bs_num);
	
	void updateScheduleByPTReservation(int bs_num);
	
	List<MemberVO> selectMemberList();

	BranchProgramScheduleVO selectScheduleByNum(int bs_num);

	boolean updateSchedule(BranchProgramScheduleVO schedule);

	void deleteSchedule(int bs_num);
	
	List<BranchOrderVO> selectBranchOrderList(String br_name);

	List<BranchStockDTO> selectEquipmentListInHQ();

	boolean insertOrder(BranchOrderVO order);

	boolean deleteOrder(int bo_num);

	List<EmployeeVO> selectEmployeeList();

	boolean insertEmployee(EmployeeVO employee);

	EmployeeVO selectEmployee(int em_num);

	String selectEmployeeFileName(EmployeeVO employee);

	boolean updateEmployee(EmployeeVO employee);
	
	MemberVO selectMember(String me_id);
	
	void updateMemberNoShow(@Param("me_id")String me_id, @Param("me_noshow")int me_noshow, @Param("me_cancel")String me_cancel);

	BranchVO selectBranch(String br_name);

	List<BranchFileVO> selectBranchFileList(BranchVO branch);

	MemberVO selectAdmin(BranchVO branch);

	boolean updateBranch(BranchVO branch);

	BranchFileVO selectBranchFile(int bf_num);

	boolean deleteBranchFile(BranchFileVO branchFile);

	boolean updateAdmin(MemberVO admin);

	void insertBranchFile(BranchFileVO branchFile);
	
	List<BranchStockDTO> selectEquipmentListInBranch(@Param("br_name")String br_name, @Param("view")String view);

	List<BranchEquipmentStockVO> selectEquipmentChangeInBranch(String br_name);

	int selectScheduleTotalCount(@Param("view")String view, @Param("cri")BranchCriteria cri);

}
