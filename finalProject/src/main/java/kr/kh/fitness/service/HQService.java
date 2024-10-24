package kr.kh.fitness.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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

public interface HQService {
	List<BranchVO> getBranchList();

	String insertBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin);

	BranchVO getBranch(BranchVO branchVo);

	MemberVO getAdmin(BranchVO branch);

	List<BranchFileVO> getBranchFileList(BranchVO branch);

	String updateBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin, String br_ori_name, String[] numList);

	List<EmployeeVO> getEmployeeList();

	List<SportsProgramVO> getSportsProgramList();

	String insertEmployee(EmployeeVO employee, MultipartFile file);

	EmployeeVO getEmployee(EmployeeVO employee);

	String updateEmployee(EmployeeVO employee, MultipartFile file, String isDel);
	
	String deleteEmployee(EmployeeVO employee);

	List<SportsEquipmentVO> getSportsEquipmentList(String search);

	String insertSportsEquipment(SportsEquipmentVO se, MultipartFile file);

	SportsEquipmentVO getSportsEquipment(SportsEquipmentVO se);

	String updateSportsEquipment(SportsEquipmentVO se, MultipartFile file, String se_ori_name, String isDel);

	List<BranchEquipmentStockVO> getBranchEquipmentStockList();

	List<BranchStockDTO> getBranchStockList(String search);

	String insertBranchEquipmentStock(BranchEquipmentStockVO be);

	List<BranchOrderVO> getBranchOrderList(String str);

	String acceptOrder(int bo_num);

	String denyOrder(int bo_num);

	List<PaymentTypeVO> getPaymentTypeList();

	String insertPaymentType(PaymentTypeVO pt);

	PaymentTypeVO getPaymentType(PaymentTypeVO pt);

	String updatePaymentType(PaymentTypeVO pt);

	String insertSportsProgram(SportsProgramVO sp, MultipartFile[] fileList);

	SportsProgramVO getSportsProgram(SportsProgramVO sp);

	List<ProgramFileVO> getProgramFileList(SportsProgramVO sp);

	String updateSportsProgram(SportsProgramVO sp, MultipartFile[] fileList, String sp_ori_name, String[] numList);

	List<MemberVO> getMemberList();

	MemberVO getMember(MemberVO me);
	
	String deleteMember(MemberVO me);

	List<MemberInquiryVO> getMemberInquiryList(String mi_state);

	MemberInquiryVO getMemberInquiry(MemberInquiryVO mi);

	String updateMemberInquiry(MemberInquiryVO mi);

	List<InquiryTypeVO> getInquiryTypeList();

	String insertFAQ(MemberInquiryVO mi);

	String updateFAQ(MemberInquiryVO mi);

	List<PaymentVO> getPaymentList();

	String insertRefund(RefundVO re);
}