package kr.kh.fitness.service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.fitness.dao.HQDAO;
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
import kr.kh.fitness.utils.UploadFileUtils;

@Service
public class HQServiceImp implements HQService {
	@Autowired
	HQDAO hqDao;
	@Resource
	String uploadPath;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public List<BranchVO> getBranchList() {return hqDao.selectBranchList();}

	@Override
	public String insertBranch(BranchVO branch, MultipartFile[] fileList, MemberVO admin) {
		String msg = "";
		if(branch == null) {msg = "지점 정보가 없습니다.";}
		if(fileList == null) {msg = "사진 정보가 없습니다.";}
		if(admin == null) {msg = "관리자 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		
		try {
			if(!hqDao.insertBranch(branch)) {msg = "지점을 등록하지 못했습니다.";}
		}catch (Exception e){
			e.printStackTrace();
			msg = "지점명 중복으로 등록하지 못했습니다.";
		}
		if(!msg.equals("")) {return msg;}
		for(MultipartFile file : fileList) {
			if(file.getSize() != 0) {uploadBranchFile(file, branch.getBr_name());}
		}
		
		String encPw = passwordEncoder.encode(admin.getMe_pw());
		admin.setMe_pw(encPw);
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_postcode(branch.getBr_postcode());
		admin.setMe_address(branch.getBr_address());
		admin.setMe_detailAddress(branch.getBr_detailAddress());
		admin.setMe_extraAddress(branch.getBr_extraAddress());
		try {
			if(!hqDao.insertAdmin(admin)) {msg = "관리자를 등록하지 못했습니다.";}
		}catch (Exception e){
			e.printStackTrace();
			msg = "관리자 아이디 중복으로 등록하지 못했습니다.";
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
		
		String encPw = passwordEncoder.encode(admin.getMe_pw());
		admin.setMe_pw(encPw);
		admin.setMe_name(branch.getBr_name());
		admin.setMe_phone(branch.getBr_phone());
		admin.setMe_address(branch.getBr_address());
		if(!hqDao.updateAdmin(admin, br_ori_name)) {msg = "관리자를 수정하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<EmployeeVO> getEmployeeList() {return hqDao.selectEmployeeList();}
	
	@Override
	public List<SportsProgramVO> getSportsProgramList() {return hqDao.selectSportsProgramList();}

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
	public String deleteEmployee(EmployeeVO employee) {
		String msg = "";
		if(employee == null) {msg = "직원 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		EmployeeVO employeeVo = hqDao.selectEmployee(employee);
		if(employeeVo == null) {msg = "직원 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.deleteEmployee(employeeVo)) {msg = "직원을 삭제하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		
		UploadFileUtils.delteFile(uploadPath, employeeVo.getEm_fi_name());
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
		try {
			if(!hqDao.insertSportsEquipment(se)) {msg = "기구를 등록하지 못했습니다.";}
		}catch (Exception e){
			e.printStackTrace();
			msg = "기구명 중복으로 등록하지 못했습니다.";
		}
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
	public List<BranchEquipmentStockVO> getBranchEquipmentStockList() {
		List<BranchEquipmentStockVO> beList = hqDao.selectBranchEquipmentStockList(null, null);
		SimpleDateFormat dtFormat1 = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
		SimpleDateFormat dtFormat2 = new SimpleDateFormat("yyyy.MM.dd");
		for(int i = 0; i < beList.size(); i++) {
			String be_recordStr = dtFormat1.format(beList.get(i).getBe_record());
			String be_birthStr = dtFormat2.format(beList.get(i).getBe_birth());
			
			beList.get(i).setBe_recordStr(be_recordStr);
			beList.get(i).setBe_birthStr(be_birthStr);
		}
		return beList;
	}

	@Override
	public List<BranchStockDTO> getBranchStockList() {return hqDao.selectBranchStockList();}

	@Override
	public String insertBranchEquipmentStock(BranchEquipmentStockVO be) {
		String msg = "";
		if(be == null) {msg = "재고 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		be.setBe_birth(new Date());
		be.setBe_type("입고");
		be.setBe_br_name("본점");
		if(!hqDao.insertBranchEquipmentStock(be)) {msg = "재고를 등록하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<BranchOrderVO> getBranchOrderList(String str) {return hqDao.selectBranchOrderList(str);}

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
													"출고", "본점", bo.getBo_se_name()));
				amount2 -= beStockList.get(i).getBe_amount();
			}else {
				hqDao.insertBranchEquipmentStock(
						new BranchEquipmentStockVO(amount2, beStockList.get(i).getBe_birth(), 
													"입고", bo.getBo_br_name(), bo.getBo_se_name()));
				hqDao.insertBranchEquipmentStock(
						new BranchEquipmentStockVO(-amount2, beStockList.get(i).getBe_birth(), 
													"출고", "본점", bo.getBo_se_name()));
				amount2 = 0;
			}
		}
		
		bo.setBo_state("입고완료");
		hqDao.updateBranchOrderState(bo);
		return msg;
	}

	@Override
	public String denyOrder(int bo_num) {
		String msg = "";
		BranchOrderVO bo = hqDao.selectBranchOrder(bo_num);
		if(bo == null) {msg = "발주 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		bo.setBo_state("승인거절");
		hqDao.updateBranchOrderState(bo);
		return msg;
	}

	@Override
	public List<PaymentTypeVO> getPaymentTypeList() {
		List<PaymentTypeVO> ptList = hqDao.selectPaymentTypeList();
		DecimalFormat dfFormat = new DecimalFormat("###,###");
		for(int i = 0; i < ptList.size(); i++) {
			String formattedPrice = dfFormat.format(ptList.get(i).getPt_price());
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

	@Override
	public String insertSportsProgram(SportsProgramVO sp, MultipartFile[] fileList) {
		String msg = "";
		if(sp == null) {msg = "프로그램 정보가 없습니다.";}
		if(fileList == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		
		try {
			if(!hqDao.insertSportsProgram(sp)) {msg = "프로그램을 등록하지 못했습니다.";}
		}catch (Exception e){
			e.printStackTrace();
			msg = "프로그램명 중복으로 등록하지 못했습니다.";
		}
		if(!msg.equals("")) {return msg;}
		for(MultipartFile file : fileList) {
			if(file.getSize() != 0) {uploadSportsProgramFile(file, sp.getSp_name());}
		}
		
		return msg;
	}
	private void uploadSportsProgramFile(MultipartFile file, String sp_name) {
		if(file == null) {return;}
		try {
			String pf_name = UploadFileUtils.uploadFile(uploadPath, "프로그램", sp_name, file.getBytes());
			ProgramFileVO programFile = new ProgramFileVO(pf_name, sp_name);
			hqDao.insertProgramFile(programFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public SportsProgramVO getSportsProgram(SportsProgramVO sp) {return hqDao.selectSportsProgram(sp);}

	@Override
	public List<ProgramFileVO> getProgramFileList(SportsProgramVO sp) {return hqDao.selectProgramFileList(sp);}

	@Override
	public String updateSportsProgram(SportsProgramVO sp, MultipartFile[] fileList, String sp_ori_name, String[] numList) {
		String msg = "";
		if(sp == null) {msg = "프로그램 정보가 없습니다.";}
		if(fileList == null) {msg = "사진 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		if(!hqDao.updateSportsProgram(sp, sp_ori_name)) {msg = "프로그램을 수정하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		if(numList != null) {
			for(int i = 0; i < numList.length; i++) {
				int pf_num = Integer.parseInt(numList[i]);
				ProgramFileVO programFile = hqDao.selectProgramFile(pf_num);
				if(hqDao.deleteProgramFile(programFile)) {
					UploadFileUtils.delteFile(uploadPath, programFile.getPf_name());
				}
			}
		}
		for(MultipartFile file : fileList) {
			if(file.getSize() != 0) {uploadSportsProgramFile(file, sp.getSp_name());}
		}
		
		return msg;
	}

	@Override
	public List<MemberVO> getMemberList() {return hqDao.selectMemberList();}

	@Override
	public MemberVO getMember(MemberVO me) {return hqDao.selectMember(me);}

	@Override
	public List<MemberInquiryVO> getMemberInquiryList(String str) {return hqDao.selectMemberInquiryList(str);}

	@Override
	public MemberInquiryVO getMemberInquiry(MemberInquiryVO mi) {return hqDao.selectMemberInquiry(mi);}

	@Override
	public String updateMemberInquiry(MemberInquiryVO mi) {
		String msg = "";
		if(mi == null) {msg = "문의 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		mi.setMi_state("답변완료");
		if(!hqDao.updateMemberInquiry(mi)) {msg = "문의 답변을 등록하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		
		MemberVO me = hqDao.selectMemberByEmail(mi.getMi_email());
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy.MM.dd");
		String date = dtFormat.format(mi.getMi_date());
		boolean isSend = false;
		if(me == null) {
			isSend = mailSend(mi.getMi_email(), "KH피트니스 1:1문의 답변완료 안내",
								date + " 문의하신 내역에 답변이 완료되었습니다.<br/><br/>답변:<br/><br/>" + mi.getMi_answer());
		}else {
			isSend = mailSend(me.getMe_email(), "KH피트니스 1:1문의 답변완료 안내",
								date + " 문의하신 내역에 답변이 완료되었습니다.<br/><br/>답변은 KH피트니스 홈페이지에서 확인하실 수 있습니다.");
		}
		if(!isSend) {msg = "메일을 전송하지 못했습니다.";}
		return msg;
	}
	public boolean mailSend(String to, String title, String content) {
	    String setfrom = "stajun@naver.com";
	    try{
	    	MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom(setfrom);// 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(to);// 받는사람 이메일
	        messageHelper.setSubject(title);// 메일제목은 생략이 가능하다
	        messageHelper.setText(content, true);// 메일 내용

	        mailSender.send(message);
	        return true;
	    } catch(Exception e){
	        e.printStackTrace();
	        return false;
	    }
	}
	
	@Override
	public List<InquiryTypeVO> getInquiryTypeList() {return hqDao.selectInquiryTypeList();}

	@Override
	public String insertFAQ(MemberInquiryVO mi) {
		String msg = "";
		if(mi == null) {msg = "FAQ 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		mi.setMi_state("FAQ");
		mi.setMi_email("hq_admin@naver.com");
		mi.setMi_br_name("본점");
		if(!hqDao.insertMemberInquiry(mi)) {msg = "FAQ를 등록하지 못했습니다.";}
		return msg;
	}

	@Override
	public String updateFAQ(MemberInquiryVO mi) {
		String msg = "";
		if(mi == null) {msg = "FAQ 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		mi.setMi_state("FAQ");
		mi.setMi_email("hq_admin@naver.com");
		mi.setMi_br_name("본점");
		if(!hqDao.updateMemberInquiry(mi)) {msg = "FAQ를 수정하지 못했습니다.";}
		return msg;
	}

	@Override
	public List<PaymentVO> getPaymentList() {
		List<PaymentVO> paList = hqDao.selectPaymentList();
		
		SimpleDateFormat dtFormat1 = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
		SimpleDateFormat dtFormat2 = new SimpleDateFormat("yyyy.MM.dd");
		DecimalFormat dfFormat = new DecimalFormat("###,###");
		for(int i = 0; i < paList.size(); i++) {
			String pa_dateStr = dtFormat1.format(paList.get(i).getPa_date());
		    String pa_startStr = dtFormat2.format(paList.get(i).getPa_start());
		    String pa_endStr = dtFormat2.format(paList.get(i).getPa_end());
		    String pa_formattedPrice = dfFormat.format(paList.get(i).getPa_price());
		    
		    paList.get(i).setPa_dateStr(pa_dateStr);
		    paList.get(i).setPa_startStr(pa_startStr);
		    paList.get(i).setPa_endStr(pa_endStr);
		    paList.get(i).setPa_formattedPrice(pa_formattedPrice);
		}
		return paList;
	}

	@Override
	public String insertRefund(RefundVO re) {
		String msg = "";
		if(re == null) {msg = "환불 정보가 없습니다.";}
		if(!msg.equals("")) {return msg;}
		
		PaymentVO pa = hqDao.selectPayment(re.getRe_pa_num());
		pa.setPa_state("환불완료");
		if(!hqDao.updatePayment(pa)) {msg = "결제 정보를 수정하지 못했습니다.";}
		if(!msg.equals("")) {return msg;}
		
		double re_percentDouble = (re.getRe_price() / pa.getPa_price() * 100);
		re.setRe_percent((int)Math.round(re_percentDouble));
		if(!hqDao.insertRefund(re)) {msg = "환불을 등록하지 못했습니다.";}
		return msg;
	}
}