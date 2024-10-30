package kr.kh.fitness.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.model.dto.BranchProgramDTO;
import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.dto.ProgramInsertFormDTO;
import kr.kh.fitness.model.dto.ResultMessage;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface AdminService {

	List<BranchProgramDTO> getBranchProgramList(String branchName);

	BranchProgramDTO getBranchProgram(int bp_num);

	List<SportsProgramVO> getProgramList();

	List<EmployeeVO> getEmployeeListByBranch(String br_name);

	String insertBranchProgram(BranchProgramVO branchProgram);

	String updateBranchProgram(BranchProgramVO branchProgram);

	String deleteBranchProgram(int bp_num);

	List<BranchProgramScheduleVO> getBranchScheduleList(String view, String br_name);

	BranchProgramVO getBranchProgramInSchedule(int bs_num);
	
	List<MemberVO> getScheduleMemberList(int bs_num);
	
	List<MemberVO> getMemberListInUser();

	List<MemberVO> getMemberList();
	
	String insertSchedule(BranchProgramScheduleVO schedule, String me_id);
	
	BranchProgramScheduleVO getSchedule(int bs_num);

	List<BranchOrderVO> getBranchOrderList(String br_name);
	
	String updateSchedule(BranchProgramScheduleVO schedule);

	void deleteSchedule(int bs_num);

	List<BranchStockDTO> getEquipmentListInHQ();

	String insertOrder(BranchOrderVO order);

	BranchOrderVO getBranchOrder(int bo_num);
	
	boolean deleteOrder(int bo_num);
	
	String insertEmployee(EmployeeVO employee, MultipartFile file);

	EmployeeVO getEmployee(int em_num);

	String updateEmployee(EmployeeVO employee, MultipartFile file, String isDel);
	
	String deleteEmployee(EmployeeVO employee);
	
	MemberVO getMember(String me_id);
	
	void updateMemberNoShow(String me_id, int me_noshow);

	BranchVO getBranch(String br_name);

	List<BranchFileVO> getBranchFileList(BranchVO branch);

	MemberVO getAdmin(BranchVO branch);

	String updateBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin, String[] numList);
	
	List<BranchStockDTO> getEquipmentListInBranch(String view);

	List<BranchEquipmentStockVO> getEquipmentChangeInBranch(String br_name);

	ResultMessage insertBranchProgramSchedule(ProgramInsertFormDTO pif);

	ResultMessage insertBranchProgramScheduleList(ProgramInsertFormDTO pif);

	List<MemberInquiryVO> getMemberInquiryList(String br_name, String mi_state);

	MemberInquiryVO getMemberInquiry(MemberInquiryVO mi);

	String updateMemberInquiry(MemberInquiryVO miVo);

}
