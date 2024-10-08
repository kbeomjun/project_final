package kr.kh.fitness.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
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

	List<SportsProgramVO> getProgramList();

	String insertEmployee(EmployeeVO employee, MultipartFile file);

	EmployeeVO getEmployee(EmployeeVO employee);

	String updateEmployee(EmployeeVO employee, MultipartFile file, String isDel);

	List<SportsEquipmentVO> getSportsEquipmentList();

	String insertSportsEquipment(SportsEquipmentVO se, MultipartFile file);

	SportsEquipmentVO getSportsEquipment(SportsEquipmentVO se);

	String updateSportsEquipment(SportsEquipmentVO se, MultipartFile file, String se_ori_name, String isDel);

	List<BranchEquipmentStockVO> getBranchEquipmentStockList();

	List<BranchStockDTO> getBranchStockList();

	String insertBranchEquipmentStock(BranchEquipmentStockVO be);

	List<BranchOrderVO> getBranchOrderList();

	String acceptOrder(int bo_num);
}