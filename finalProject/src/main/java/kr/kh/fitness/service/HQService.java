package kr.kh.fitness.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;

public interface HQService {
	List<BranchVO> getBranchList();

	String insertBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin);

	BranchVO getBranch(BranchVO branchVo);

	MemberVO getAdmin(BranchVO branch);

	List<BranchFileVO> getBranchFileList(BranchVO branch);

	String updateBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin, String br_ori_name, String[] numList);

	List<EmployeeVO> getEmployeeList();
}