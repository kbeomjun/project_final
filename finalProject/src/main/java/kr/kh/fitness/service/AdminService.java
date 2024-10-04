package kr.kh.fitness.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsEquipmentVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface AdminService {

	List<BranchProgramVO> getBranchProgramList(String branchName);

	BranchProgramVO getBranchProgram(int bp_num);

	List<SportsProgramVO> getProgramList();

	List<EmployeeVO> getEmployeeListByBranch(String em_br_name);

	String insertBranchProgram(BranchProgramVO branchProgram);

	String updateBranchProgram(BranchProgramVO branchProgram);

	boolean deleteBranchProgram(int bp_num);

	List<BranchProgramScheduleVO> getBranchScheduleList(String br_name);

	List<MemberVO> getScheduleMemberList(int bs_num);
	
	List<MemberVO> getMemberList();
	
	String insertSchedule(BranchProgramScheduleVO schedule, String me_id);
	
	BranchProgramScheduleVO getSchedule(int bs_num);

	List<BranchOrderVO> getBranchOrderList(String br_name);

	String updateSchedule(BranchProgramScheduleVO schedule);

	List<BranchEquipmentStockVO> getEquipmentListInHQ();

	boolean insertOrder(BranchOrderVO order);

	boolean deleteOrder(int bo_num);

	List<BranchEquipmentStockVO> getEquipmentListInBranch(String br_name, String view);

	String insertEmployee(EmployeeVO employee, MultipartFile file);

	EmployeeVO getEmployee(int em_num);

	String updateEmployee(EmployeeVO employee, MultipartFile file, String isDel);


}
