package kr.kh.fitness.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
import kr.kh.fitness.service.HQService;

@Controller
@RequestMapping("/hq")
public class HQController {
	@Autowired
	HQService hqService;
	
	@GetMapping("/branch/list")
	public String branchList(Model model) {
		List<BranchVO> brList = hqService.getBranchList();
		model.addAttribute("brList", brList);
	    return "/hq/branch/list";
	}
	@GetMapping("/branch/insert")
	public String branchInsert() {
	    return "/hq/branch/insert";
	}
	@PostMapping("/branch/insert")
	public String branchInsertPost(Model model, BranchVO branch, MultipartFile[] fileList, MemberVO admin) {
		String msg = hqService.insertBranch(branch, fileList, admin);
		if(msg.equals("")) {
			model.addAttribute("url", "/hq/branch/list");
		}else {
			model.addAttribute("url", "/hq/branch/insert");
		}
		model.addAttribute("msg", msg);
	    return "/main/message";
	}
	@GetMapping("/branch/detail/{br_name}")
	public String branchDetail(Model model, @PathVariable("br_name") String br_name, BranchVO branchVo) {
		BranchVO branch = hqService.getBranch(branchVo);
		List<BranchFileVO> bfList = hqService.getBranchFileList(branch);
		MemberVO admin = hqService.getAdmin(branch);
		model.addAttribute("br", branch);
		model.addAttribute("bfList", bfList);
		model.addAttribute("me", admin);
		return "/hq/branch/detail";
	}
	@PostMapping("/branch/update/{br_ori_name}")
	public String branchUpdatePost(Model model, @PathVariable("br_ori_name") String br_ori_name, 
								BranchVO branch, MultipartFile[] fileList, MemberVO admin, String[] numList) {
		String msg = hqService.updateBranch(branch, fileList, admin, br_ori_name, numList);
		if(msg.equals("")) {
			model.addAttribute("url", "/hq/branch/detail/" + branch.getBr_name());
		}else {
			model.addAttribute("url", "/hq/branch/detail/" + br_ori_name);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/employee/list")
	public String employeeList(Model model) {
		List<EmployeeVO> emList = hqService.getEmployeeList();
		model.addAttribute("emList", emList);
	    return "/hq/employee/list";
	}
	@GetMapping("/employee/insert")
	public String employeeInsert(Model model) {
		List<BranchVO> brList = hqService.getBranchList();
		List<SportsProgramVO> programList = hqService.getSportsProgramList();
		model.addAttribute("brList", brList);
		model.addAttribute("programList", programList);
	    return "/hq/employee/insert";
	}
	@PostMapping("/employee/insert")
	public String employeeInsertPost(Model model, EmployeeVO employee, MultipartFile file) {
		String msg = hqService.insertEmployee(employee, file);
		if(msg.equals("")) {
			model.addAttribute("url", "/hq/employee/list");
		}else {
			model.addAttribute("url", "/hq/employee/insert");
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	@GetMapping("/employee/detail/{em_num}")
	public String employeeDetail(Model model, @PathVariable("em_num") int em_num, EmployeeVO employeeVo) {
		EmployeeVO employee = hqService.getEmployee(employeeVo);
		List<BranchVO> brList = hqService.getBranchList();
		List<SportsProgramVO> programList = hqService.getSportsProgramList();
		model.addAttribute("em", employee);
		model.addAttribute("brList", brList);
		model.addAttribute("programList", programList);
	    return "/hq/employee/detail";
	}
	@PostMapping("/employee/update/{em_num}")
	public String employeeUpdatePost(Model model, @PathVariable("em_num") int em_num, 
										EmployeeVO employee, MultipartFile file, String isDel) {
		String msg = hqService.updateEmployee(employee, file, isDel);
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/hq/employee/detail/" + em_num);
		return "/main/message";
	}
	@GetMapping("/employee/delete/{em_num}")
	public String employeeDelete(Model model, @PathVariable("em_num") int em_num, EmployeeVO employee) {
		String msg = hqService.deleteEmployee(employee);
		if(msg.equals("")) {
			model.addAttribute("url", "/hq/employee/list");
		}else {
			model.addAttribute("url", "/hq/employee/detail/" + em_num);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/equipment/list")
	public String equipmentList() {
	    return "/hq/equipment/list";
	}
	@ResponseBody
	@PostMapping("/equipment/list")
	public Map<String, Object> equipmentListPost(@RequestParam String search) {
		List<SportsEquipmentVO> seList = hqService.getSportsEquipmentList(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seList", seList);
		return map;
	}
	@PostMapping("/equipment/insert")
	public String equipmentInsertPost(Model model, SportsEquipmentVO se, MultipartFile file) {
		String msg = hqService.insertSportsEquipment(se, file);
		model.addAttribute("url", "/hq/equipment/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	@ResponseBody
	@GetMapping("/equipment/update")
	public Map<String, Object> equipmentUpdate(@RequestParam String se_name, SportsEquipmentVO seVo) {
		SportsEquipmentVO se = hqService.getSportsEquipment(seVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("se", se);
		return map;
	}
	@PostMapping("/equipment/update")
	public String equipmentUpdatePost(Model model, String se_ori_name, 
										SportsEquipmentVO se, MultipartFile file2, String isDel) {
		String msg = hqService.updateSportsEquipment(se, file2, se_ori_name, isDel);
		model.addAttribute("url", "/hq/equipment/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/stock/list")
	public String stockList(Model model) {
		List<SportsEquipmentVO> seList = hqService.getSportsEquipmentList("");
		model.addAttribute("seList", seList);
	    return "/hq/stock/list";
	}
	@ResponseBody
	@PostMapping("/stock/list1")
	public Map<String, Object> stockListPost1() {
		List<BranchEquipmentStockVO> beList = hqService.getBranchEquipmentStockList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", beList);
	    return map;
	}
	@ResponseBody
	@PostMapping("/stock/list2")
	public Map<String, Object> stockListPost2(@RequestParam String search) {
		List<BranchStockDTO> stList = hqService.getBranchStockList(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stList", stList);
	    return map;
	}
	@ResponseBody
	@PostMapping("/stock/insert")
	public Map<String, Object> stockInsertPost(@RequestParam String be_se_name, @RequestParam int be_amount, BranchEquipmentStockVO be) {
		String msg = hqService.insertBranchEquipmentStock(be);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", msg);
		return map;
	}
	
	@GetMapping("/order/list")
	public String orderList(Model model) {
		List<BranchOrderVO> boWaitList = hqService.getBranchOrderList("wait");
		List<BranchOrderVO> boDoneList = hqService.getBranchOrderList("done");
		model.addAttribute("boWaitList", boWaitList);
		model.addAttribute("boDoneList", boDoneList);
	    return "/hq/order/list";
	}
	@GetMapping("/order/accept/{bo_num}")
	public String orderAccpet(Model model, @PathVariable("bo_num") int bo_num) {
		String msg = hqService.acceptOrder(bo_num);
		model.addAttribute("url", "/hq/order/list");
		model.addAttribute("msg", msg);
	    return "/main/message";
	}
	@GetMapping("/order/deny/{bo_num}")
	public String orderDeny(Model model, @PathVariable("bo_num") int bo_num) {
		String msg = hqService.denyOrder(bo_num);
		model.addAttribute("url", "/hq/order/list");
		model.addAttribute("msg", msg);
	    return "/main/message";
	}
	
	@GetMapping("/paymentType/list")
	public String paymentTypeList(Model model) {
		List<PaymentTypeVO> ptList = hqService.getPaymentTypeList();
		model.addAttribute("ptList", ptList);
	    return "/hq/paymentType/list";
	}
	@PostMapping("/paymentType/insert")
	public String paymentTypeInsertPost(Model model, PaymentTypeVO pt) {
		String msg = hqService.insertPaymentType(pt);
		model.addAttribute("url", "/hq/paymentType/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	@ResponseBody
	@GetMapping("/paymentType/update")
	public Map<String, Object> paymentTypeUpdate(@RequestParam int pt_num, PaymentTypeVO ptVo) {
		PaymentTypeVO pt = hqService.getPaymentType(ptVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pt", pt);
		return map;
	}
	@PostMapping("/paymentType/update")
	public String paymentTypeUpdatePost(Model model, PaymentTypeVO pt) {
		String msg = hqService.updatePaymentType(pt);
		model.addAttribute("url", "/hq/paymentType/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/program/list")
	public String programList(Model model) {
		List<SportsProgramVO> spList = hqService.getSportsProgramList();
		model.addAttribute("spList", spList);
	    return "/hq/program/list";
	}
	@GetMapping("/program/insert")
	public String programInsert() {
	    return "/hq/program/insert";
	}
	@PostMapping("/program/insert")
	public String programInsertPost(Model model, SportsProgramVO sp, MultipartFile[] fileList) {
		String msg = hqService.insertSportsProgram(sp, fileList);
		if(msg.equals("")) {
			model.addAttribute("url", "/hq/program/list");
		}else {
			model.addAttribute("url", "/hq/program/insert");
		}
		model.addAttribute("msg", msg);
	    return "/main/message";
	}
	@GetMapping("/program/detail/{sp_name}")
	public String programDetail(Model model, @PathVariable("sp_name") String sp_name, SportsProgramVO spVo) {
		SportsProgramVO sp = hqService.getSportsProgram(spVo);
		List<ProgramFileVO> pfList = hqService.getProgramFileList(sp);
		model.addAttribute("sp", sp);
		model.addAttribute("pfList", pfList);
		return "/hq/program/detail";
	}
	@PostMapping("/program/update/{sp_ori_name}")
	public String branchUpdatePost(Model model, @PathVariable("sp_ori_name") String sp_ori_name, 
								SportsProgramVO sp, MultipartFile[] fileList, String[] numList) {
		String msg = hqService.updateSportsProgram(sp, fileList, sp_ori_name, numList);
		if(msg.equals("")) {
			model.addAttribute("url", "/hq/program/detail/" + sp.getSp_name());
		}else {
			model.addAttribute("url", "/hq/program/detail/" + sp_ori_name);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/member/list")
	public String memberList(Model model) {
		List<MemberVO> meList = hqService.getMemberList();
		model.addAttribute("meList", meList);
	    return "/hq/member/list";
	}
	@ResponseBody
	@GetMapping("/member/detail")
	public Map<String, Object> memberDetail(@RequestParam String me_id, MemberVO meVo) {
		MemberVO me = hqService.getMember(meVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("me", me);
		return map;
	}
	
	@GetMapping("/inquiry/list")
	public String inquiryList(Model model) {
		List<MemberInquiryVO> miWaitList = hqService.getMemberInquiryList("wait");
		List<MemberInquiryVO> miDoneList = hqService.getMemberInquiryList("done");
		model.addAttribute("miWaitList", miWaitList);
		model.addAttribute("miDoneList", miDoneList);
	    return "/hq/inquiry/list";
	}
	@ResponseBody
	@GetMapping("/inquiry/detail")
	public Map<String, Object> inquiryDetail(@RequestParam int mi_num, MemberInquiryVO miVo) {
		MemberInquiryVO mi = hqService.getMemberInquiry(miVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mi", mi);
		return map;
	}
	@PostMapping("/inquiry/update")
	public String inquiryUpdatePost(Model model, MemberInquiryVO mi) {
	    String msg = hqService.updateMemberInquiry(mi);
	    model.addAttribute("url", "/hq/inquiry/list");
	    model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/FAQ/list")
	public String FAQList(Model model) {
		List<MemberInquiryVO> FAQList = hqService.getMemberInquiryList("FAQ");
		List<InquiryTypeVO> itList = hqService.getInquiryTypeList();
		model.addAttribute("FAQList", FAQList);
		model.addAttribute("itList", itList);
	    return "/hq/FAQ/list";
	}
	@PostMapping("/FAQ/insert")
	public String FAQinsertPost(Model model, MemberInquiryVO mi) {
		String msg = hqService.insertFAQ(mi);
		model.addAttribute("url", "/hq/FAQ/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	@ResponseBody
	@GetMapping("/FAQ/detail")
	public Map<String, Object> FAQDetail(@RequestParam int mi_num, MemberInquiryVO miVo) {
		MemberInquiryVO mi = hqService.getMemberInquiry(miVo);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("mi", mi);
		return map;
	}
	@PostMapping("/FAQ/update")
	public String FAQupdatePost(Model model, MemberInquiryVO mi) {
		String msg = hqService.updateFAQ(mi);
		model.addAttribute("url", "/hq/FAQ/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/refund/list")
	public String refundList() {
	    return "/hq/refund/list";
	}
	@ResponseBody
	@PostMapping("/refund/list")
	public Map<String, Object> refundListPost() {
	    List<PaymentVO> paList = hqService.getPaymentList();
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("data", paList);
		return map;
	}
	@ResponseBody
	@GetMapping("/refund/insert")
	public Map<String, Object> refundInsert(@RequestParam int re_price, @RequestParam String re_reason, 
											@RequestParam int re_pa_num, RefundVO re) {
		String msg = hqService.insertRefund(re);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("msg", msg);
		return map;
	}
}