package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ProgramFileVO;
import kr.kh.fitness.model.vo.RefundVO;
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

	boolean updateAdmin(@Param("me") MemberVO admin, @Param("br_ori_name") String br_ori_name);

	List<EmployeeVO> selectEmployeeList();

	List<SportsProgramVO> selectSportsProgramList();

	boolean insertEmployee(@Param("em") EmployeeVO employee);

	EmployeeVO selectEmployee(@Param("em") EmployeeVO employee);

	String selectEmployeeFileName(@Param("em") EmployeeVO employee);

	boolean updateEmployee(@Param("em") EmployeeVO employee);
	
	boolean deleteEmployee(@Param("em") EmployeeVO employee);

	List<SportsEquipmentVO> selectSportsEquipmentList();

	boolean insertSportsEquipment(@Param("se") SportsEquipmentVO se);

	SportsEquipmentVO selectSportsEquipment(@Param("se") SportsEquipmentVO se);

	String selectSportsEquipmentFileName(@Param("se_ori_name") String se_ori_name);

	boolean updateSportsEquipment(@Param("se") SportsEquipmentVO se, @Param("se_ori_name") String se_ori_name);

	List<BranchEquipmentStockVO> selectBranchEquipmentStockList(@Param("bo") BranchOrderVO bo, @Param("be_type") String be_type);

	List<BranchStockDTO> selectBranchStockList();

	boolean insertBranchEquipmentStock(@Param("be") BranchEquipmentStockVO be);

	List<BranchOrderVO> selectBranchOrderList(@Param("str") String str);

	BranchOrderVO selectBranchOrder(@Param("bo_num") int bo_num);

	BranchStockDTO selectBranchStock(@Param("bo") BranchOrderVO bo);

	void updateBranchOrderState(@Param("bo") BranchOrderVO bo);

	List<PaymentTypeVO> selectPaymentTypeList();

	boolean insertPaymentType(@Param("pt") PaymentTypeVO pt);

	PaymentTypeVO selectPaymentType(@Param("pt") PaymentTypeVO pt);

	boolean updatePaymentType(@Param("pt") PaymentTypeVO pt);

	boolean insertSportsProgram(@Param("sp") SportsProgramVO sp);

	void insertProgramFile(@Param("pf") ProgramFileVO programFile);

	SportsProgramVO selectSportsProgram(@Param("sp") SportsProgramVO sp);

	List<ProgramFileVO> selectProgramFileList(@Param("sp") SportsProgramVO sp);

	boolean updateSportsProgram(@Param("sp") SportsProgramVO sp, @Param("sp_ori_name") String sp_ori_name);

	ProgramFileVO selectProgramFile(@Param("pf_num") int pf_num);

	boolean deleteProgramFile(@Param("pf") ProgramFileVO programFile);

	List<MemberVO> selectMemberList();

	MemberVO selectMember(@Param("me") MemberVO me);

	List<MemberInquiryVO> selectMemberInquiryList(@Param("str") String str);

	MemberInquiryVO selectMemberInquiry(@Param("mi") MemberInquiryVO mi);

	boolean updateMemberInquiry(@Param("mi") MemberInquiryVO mi);

	MemberVO selectMemberByEmail(@Param("me_email") String me_email);

	List<InquiryTypeVO> selectInquiryTypeList();

	boolean insertMemberInquiry(@Param("mi") MemberInquiryVO mi);

	List<PaymentVO> selectPaymentList();

	PaymentVO selectPayment(@Param("pa_num") int pa_num);

	boolean updatePayment(@Param("pa") PaymentVO pa);

	boolean insertRefund(@Param("re") RefundVO re);
}