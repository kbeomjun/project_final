package kr.kh.fitness.service;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.HQDAO;
import kr.kh.fitness.model.dto.BranchStockDTO;
import kr.kh.fitness.model.vo.BranchEquipmentStockVO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchOrderVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.SportsEquipmentVO;
import kr.kh.fitness.model.vo.SportsProgramVO;
import kr.kh.fitness.utils.UploadFileUtils;

@Service
public class HQServiceImp implements HQService {
	@Autowired
	HQDAO hqDao;
	@Resource
	String uploadPath;
	
	@Override
	public List<BranchVO> getBranchList() {return hqDao.selectBranchList();}

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
			if(file.getSize() != 0) {uploadBranchFile(file, branch.getBr_name());}
		}
		
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_postcode(branch.getBr_postcode());
		admin.setMe_address(branch.getBr_address());
		admin.setMe_detailAddress(branch.getBr_detailAddress());
		admin.setMe_extraAddress(branch.getBr_extraAddress());
		if(!hqDao.insertAdmin(admin)) {msg = "관리자를 등록하지 못했습니다.";}
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
	public BranchVO getBranch(BranchVO branch) {return hqDao.selectBranch(branch);}
	
	@Override
	public MemberVO getAdmin(BranchVO branch) {return hqDao.selectAdmin(branch);}

	@Override
	public List<BranchFileVO> getBranchFileList(BranchVO branch) {return hqDao.selectBranchFileList(branch);}

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
			if(file.getSize() != 0) {uploadBranchFile(file, branch.getBr_name());}
		}
		
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_address(branch.getBr_address());
		if(!hqDao.updatetAdmin(admin, br_ori_name)) {msg = "관리자를 수정하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<EmployeeVO> getEmployeeList() {return hqDao.selectEmployeeList();}
	
	@Override
	public List<SportsProgramVO> getProgramList() {return hqDao.selectProgramList();}

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
		
		String em_fi_name = uploadEmployeeFile(file, employee.getEm_num() + "");
		employee.setEm_fi_name(em_fi_name);
		
		if(!hqDao.insertEmployee(employee)) {msg = "직원을 등록하지 못했습니다.";}
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

	@Override
	public EmployeeVO getEmployee(EmployeeVO employee) {return hqDao.selectEmployee(employee);}

	@Override
	public String updateEmployee(EmployeeVO employee, MultipartFile file, String isDel) {
		String msg = "";
		if(employee == null) {msg = "직원 정보가 없습니다.";}
		if(file == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		String em_fi_name = hqDao.selectEmployeeFileName(employee);
		employee.setEm_fi_name(em_fi_name);
		if(isDel != null) {
			UploadFileUtils.delteFile(uploadPath, employee.getEm_fi_name());
			em_fi_name = uploadEmployeeFile(file, employee.getEm_num() + "");
			employee.setEm_fi_name(em_fi_name);
		}
		
		if(!hqDao.updateEmployee(employee)) {msg = "직원을 수정하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<SportsEquipmentVO> getSportsEquipmentList() {return hqDao.selectSportsEquipmentList();}

	@Override
	public String insertSportsEquipment(SportsEquipmentVO se, MultipartFile file) {
		String msg = "";
		if(se == null) {msg = "기구 정보가 없습니다.";}
		if(file == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		String se_fi_name = uploadSportsEquipmentFile(file, se.getSe_name());
		se.setSe_fi_name(se_fi_name);
		
		if(!hqDao.insertSportsEquipment(se)) {msg = "기구를 등록하지 못했습니다.";}
		return msg;
	}
	private String uploadSportsEquipmentFile(MultipartFile file, String se_fi_ori_name) {
		if(file == null) {return null;}
		try {
			String se_fi_name = UploadFileUtils.uploadFile(uploadPath, "기구", se_fi_ori_name, file.getBytes());
			return se_fi_name;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public SportsEquipmentVO getSportsEquipment(SportsEquipmentVO se) {return hqDao.selectSportsEquipment(se);}

	@Override
	public String updateSportsEquipment(SportsEquipmentVO se, MultipartFile file, String se_ori_name, String isDel) {
		String msg = "";
		if(se == null) {msg = "기구 정보가 없습니다.";}
		if(file == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		String se_fi_name = hqDao.selectSportsEquipmentFileName(se_ori_name);
		se.setSe_fi_name(se_fi_name);
		if(isDel != null) {
			UploadFileUtils.delteFile(uploadPath, se.getSe_fi_name());
			se_fi_name = uploadSportsEquipmentFile(file, se.getSe_name());
			se.setSe_fi_name(se_fi_name);
		}
		
		if(!hqDao.updateSportsEquipment(se, se_ori_name)) {msg = "기구를 수정하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<BranchEquipmentStockVO> getBranchEquipmentStockList() {return hqDao.selectBranchEquipmentStockList(null, null);}

	@Override
	public List<BranchStockDTO> getBranchStockList() {return hqDao.selectBranchStockList();}

	@Override
	public String insertBranchEquipmentStock(BranchEquipmentStockVO be) {
		String msg = "";
		if(be == null) {msg = "재고 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.insertBranchEquipmentStock(be)) {msg = "재고를 등록하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<BranchOrderVO> getBranchOrderList() {return hqDao.selectBranchOrderList();}

	@Override
	public String acceptOrder(int bo_num) {
		String msg = "";
		BranchOrderVO bo = hqDao.selectBranchOrder(bo_num);
		if(bo == null) {msg = "발주 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		BranchStockDTO st = hqDao.selectBranchStock(bo);
		if(st.getBe_se_total() < bo.getBo_amount()) {msg = "재고가 부족합니다.";}
		if(!msg.equals("")) {return msg;}
		
		List<BranchEquipmentStockVO> beStockList = hqDao.selectBranchEquipmentStockList(bo, "입고");
		List<BranchEquipmentStockVO> beReleaseList = hqDao.selectBranchEquipmentStockList(bo, "출고");
		int index = 0;
		for(int i = 0; i < beStockList.size(); i++) {
			if(index == beReleaseList.size()) {break;}
			
			int amount1 = beStockList.get(i).getBe_amount();
			while(amount1 > 0) {
				if(amount1 > -beReleaseList.get(index).getBe_amount()) {
					beStockList.get(i).setBe_amount(amount1 + beReleaseList.get(index).getBe_amount());
					beReleaseList.get(index).setBe_amount(0);
					amount1 = beStockList.get(i).getBe_amount();
					index++;
				}else if(beStockList.get(i).getBe_amount() == -beReleaseList.get(index).getBe_amount()) {
					beStockList.get(i).setBe_amount(0);
					beReleaseList.get(index).setBe_amount(0);
					amount1 = 0;
					index++;
				}else {
					beStockList.get(i).setBe_amount(0);
					beReleaseList.get(index).setBe_amount(beReleaseList.get(index).getBe_amount() + amount1);
					amount1 = 0;
					break;
				}
				if(index == beReleaseList.size()) {break;}
			}
		}
		
		int amount2 = bo.getBo_amount();
		for(int i = 0; i < beStockList.size(); i++) {
			if(beStockList.get(i).getBe_amount() == 0 ) {continue;}
			
			if(amount2 == 0) {break;}
			
			if(amount2 >= beStockList.get(i).getBe_amount()) {
				hqDao.insertBranchEquipmentStock(
						new BranchEquipmentStockVO(beStockList.get(i).getBe_amount(), beStockList.get(i).getBe_birth(), 
													"입고", bo.getBo_br_name(), bo.getBo_se_name()));
				hqDao.insertBranchEquipmentStock(
						new BranchEquipmentStockVO(-beStockList.get(i).getBe_amount(), beStockList.get(i).getBe_birth(), 
													"출고", "본사", bo.getBo_se_name()));
				amount2 -= beStockList.get(i).getBe_amount();
			}else {
				hqDao.insertBranchEquipmentStock(
						new BranchEquipmentStockVO(amount2, beStockList.get(i).getBe_birth(), 
													"입고", bo.getBo_br_name(), bo.getBo_se_name()));
				hqDao.insertBranchEquipmentStock(
						new BranchEquipmentStockVO(-amount2, beStockList.get(i).getBe_birth(), 
													"출고", "본사", bo.getBo_se_name()));
				amount2 = 0;
			}
		}
		
		bo.setBo_state("승인");
		hqDao.updateBranchOrderState(bo);
		return msg;
	}

	@Override
	public String denyOrder(int bo_num) {
		String msg = "";
		BranchOrderVO bo = hqDao.selectBranchOrder(bo_num);
		if(bo == null) {msg = "발주 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		bo.setBo_state("거부");
		hqDao.updateBranchOrderState(bo);
		return msg;
	}

	@Override
	public List<PaymentTypeVO> getPaymentTypeList() {
		List<PaymentTypeVO> ptList = hqDao.selectPaymentTypeList();
		for(int i = 0; i < ptList.size(); i++) {
			DecimalFormat df = new DecimalFormat("###,###");
			String formattedPrice = df.format(ptList.get(i).getPt_price());
			ptList.get(i).setFormattedPrice(formattedPrice);
		}
		return ptList;
	}

	@Override
	public String insertPaymentType(PaymentTypeVO pt) {
		String msg = "";
		if(pt == null) {msg = "회원권 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.insertPaymentType(pt)) {msg = "회원권을 등록하지 못했습니다.";}
		return msg;
	}

	@Override
	public PaymentTypeVO getPaymentType(PaymentTypeVO pt) {return hqDao.selectPaymentType(pt);}

	@Override
	public String updatePaymentType(PaymentTypeVO pt) {
		String msg = "";
		if(pt == null) {msg = "회원권 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.updatePaymentType(pt)) {msg = "회원권을 수정하지 못했습니다.";}
		return msg;
	}
}