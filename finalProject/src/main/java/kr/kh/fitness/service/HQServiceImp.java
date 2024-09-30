package kr.kh.fitness.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.HQDAO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
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
		try {
			if(hqDao.insertBranch(branch)) {
				msg = "";
			}else {
				msg = "지점을 등록하지 못했습니다.";
			}
		}catch (Exception e) {
			e.printStackTrace();
			msg = "지점을 등록하지 못했습니다.";
		}
		if(!msg.equals("")) {
			return msg;
		}

		for(MultipartFile file : fileList) {
			uploadFile(file, branch.getBr_name());
		}
		
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_address(branch.getBr_address());
		if(hqDao.insertAdmin(admin)) {
			msg = ""; 
		}else {
			msg = "관리자를 등록하지 못했습니다.";
		}
		
		return msg;
	}
	private void uploadFile(MultipartFile file, String br_name) {
		if(file == null || file.getOriginalFilename().length() == 0) {
			return;
		}
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
}