package kr.kh.fitness.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.dto.BranchProgramDTO;
import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.ProgramReservationVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface AdminDAO {

	List<BranchProgramDTO> selectBranchProgramList(String br_name);

	List<SportsProgramVO> selectProgramList();

	List<EmployeeVO> selectEmployeeListByBranch(String em_br_name);

	BranchProgramVO selectBranchProgram(BranchProgramVO branchProgram);

	BranchProgramDTO selectBranchProgramByNum(int bp_num);

	boolean insertBranchProgram(BranchProgramVO branchProgram);

	int selectScheduleWithCurrent(BranchProgramVO branchProgram);
	
	boolean updateBranchProgram(BranchProgramVO branchProgram);

	int selectProgramReservationCount(int bp_num);
	
	boolean deleteBranchProgram(int bp_num);

	List<BranchProgramScheduleVO> selectBranchScheduleList(@Param("view")String view, @Param("br_name")String br_name);

	BranchProgramVO selectBranchProgramInSchedule(int bs_num);
	
	List<MemberVO> selectScheduleMemberList(int bs_num);
	
	BranchProgramScheduleVO selectSchedule(BranchProgramScheduleVO schedule);

	boolean insertSchedule(BranchProgramScheduleVO schedule);
	
	void insertReservationByPTManager(@Param("me_id")String me_id, @Param("bs_num")int bs_num);
	
	void updateScheduleByPTReservation(int bs_num);
	
	List<MemberVO> selectMemberListInUser();

	List<MemberVO> selectMemberList();
	
	BranchProgramScheduleVO selectScheduleByNum(int bs_num);

	boolean updateSchedule(BranchProgramScheduleVO schedule);

	void deleteSchedule(int bs_num);
	
	List<BranchOrderVO> selectBranchOrderList(String br_name);
	
	List<BranchStockDTO> selectEquipmentListInHQ();

	boolean insertOrder(BranchOrderVO order);

	BranchOrderVO selectBranchOrder(int bo_num);
	
	boolean deleteOrder(int bo_num);
	
	List<EmployeeVO> selectEmployeeList();

	boolean insertEmployee(EmployeeVO employee);

	EmployeeVO selectEmployee(int em_num);

	String selectEmployeeFileName(EmployeeVO employee);

	boolean updateEmployee(EmployeeVO employee);
	
	boolean deleteEmployee(EmployeeVO employee);
	
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
	
	List<BranchStockDTO> selectEquipmentListInBranch(@Param("view")String view, @Param("br_name")String br_name);

	List<BranchEquipmentStockVO> selectEquipmentChangeInBranch(String br_name);

	BranchProgramScheduleVO selectBranchSchedule(@Param("bp_num")int bs_bp_num, @Param("start")Date startDate);

	boolean insertBranchProgramSchedule(@Param("bps")BranchProgramScheduleVO bps);

	boolean insertBranchProgramScheduleList(@Param("bps_list")List<BranchProgramScheduleVO> bps_list);

	List<MemberInquiryVO> selectMemberInquiryList(@Param("br_name")String br_name, @Param("mi_state")String mi_state);

	MemberInquiryVO selectMemberInquiry(MemberInquiryVO mi);

	boolean updateMemberInquiry(MemberInquiryVO mi);

	MemberVO selectMemberByEmail(String me_email);

	ProgramReservationVO selectProgramReservation(@Param("me_id")String me_id, @Param("date")Date date);

	void insertProgramReservation(@Param("me_id")String me_id, @Param("date")Date date, @Param("bs_num")int bs_num);

}
