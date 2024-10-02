package kr.kh.fitness.service;

import java.time.LocalDate;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.HQDAO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.utils.UploadFileUtils;

@Service
public class HQServiceImp implements HQService {
	@Autowired
	HQDAO hqDao;
	@Resource
	String uploadPath;
	
	@Override
	public List<BranchVO> getBranchList() {
		return hqDao.selectBranchList();
	}

	@Override
	public String insertBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin) {
		String msg = "";
		if(branch == null) {msg = "지점 정보가 없습니다.";}
		if(fileList == null) {msg = "사진 정보가 없습니다.";}
		if(admin == null) {msg = "관리자 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.insertBranch(branch)) {msg = "지점을 등록하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}

		for(MultipartFile file : fileList) {
			uploadBranchFile(file, branch.getBr_name());
		}
		
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_postcode(branch.getBr_postcode());
		admin.setMe_address(branch.getBr_address());
		admin.setMe_detailAddress(branch.getBr_detailAddress());
		admin.setMe_extraAddress(branch.getBr_extraAddress());
		if(!hqDao.insertAdmin(admin)) {
			msg = "관리자를 등록하지 못했습니다.";
		}
		return msg;
	}
	private void uploadBranchFile(MultipartFile file, String br_name) {
		if(file == null) {return;}
		try {
			String bf_name = UploadFileUtils.uploadFile(uploadPath, "지점", br_name, file.getBytes());
			BranchFileVO branchFile = new BranchFileVO(bf_name, br_name);
			hqDao.insertBranchFile(branchFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public BranchVO getBranch(BranchVO branch) {
		return hqDao.selectBranch(branch);
	}
	
	@Override
	public MemberVO getAdmin(BranchVO branch) {
		return hqDao.selectAdmin(branch);
	}

	@Override
	public List<BranchFileVO> getBranchFileList(BranchVO branch) {
		return hqDao.selectBranchFileList(branch);
	}

	@Override
	public String updateBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin, String br_ori_name, String[] numList) {
		String msg = "";
		if(branch == null) {msg = "지점 정보가 없습니다.";}
		if(fileList == null) {msg = "사진 정보가 없습니다.";}
		if(admin == null) {msg = "관리자 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.updateBranch(branch, br_ori_name)) {msg = "지점을 수정하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(numList != null) {
			for(int i = 0; i < numList.length; i++) {
				int bf_num = Integer.parseInt(numList[i]);
				BranchFileVO branchFile = hqDao.selectBranchFile(bf_num);
				if(hqDao.deleteBranchFile(branchFile)) {
					UploadFileUtils.delteFile(uploadPath, branchFile.getBf_name());
				}
			}
		}
		for(MultipartFile file : fileList) {
			uploadBranchFile(file, branch.getBr_name());
		}
		
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_address(branch.getBr_address());
		if(!hqDao.updatetAdmin(admin, br_ori_name)) {msg = "관리자를 수정하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<EmployeeVO> getEmployeeList() {
		return hqDao.selectEmployeeList();
	}

	@Override
	public String insertEmployee(EmployeeVO employee, MultipartFile file) {
		String msg = "";
		if(employee == null) {msg = "직원 정보가 없습니다.";}
		if(file == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int em_num = createEmployeeNum(year);
		employee.setEm_num(em_num);
		
		String em_fi_name = uploadEmployeeFile(file, employee.getEm_num() + "_" + employee.getEm_name());
		employee.setEm_fi_name(em_fi_name);
		
		if(!hqDao.insertEmployee(employee)) {msg = "직원을 등록하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		return msg;
	}
	private int createEmployeeNum(int year) {
		int min = 1, max = 9999;
		List<EmployeeVO> emList = hqDao.selectEmployeeList();
		int em_num = 0;
		while(true){
			boolean flag = true;
			int random = (int)(Math.random() * (max - min + 1) + min);
			String randomNum = String.valueOf(random);
			if(randomNum.length() < 4) {
				while(randomNum.length() < 4) {
					randomNum = "0" + randomNum;
				}
			}
			em_num = Integer.parseInt(year+randomNum);
			for(int i = 0; i < emList.size(); i++) {
				if(em_num == emList.get(i).getEm_num()) {
					flag = false;
					break;
				}
			}
			if(flag) {break;}
		}
		return em_num; 
	}
	private String uploadEmployeeFile(MultipartFile file, String em_fi_ori_name) {
		if(file == null) {return null;}
		try {
			String em_fi_name = UploadFileUtils.uploadFile(uploadPath, "직원", em_fi_ori_name, file.getBytes());
			return em_fi_name;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}