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
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
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
	public String branchUpdate(Model model, @PathVariable("br_ori_name") String br_ori_name, 
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
		List<SportsProgramVO> programList = hqService.getProgramList();
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
		List<SportsProgramVO> programList = hqService.getProgramList();
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
	
	@GetMapping("/equipment/list")
	public String equipmentList(Model model) {
		List<SportsEquipmentVO> seList = hqService.getSportsEquipmentList();
		model.addAttribute("seList", seList);
	    return "/hq/equipment/list";
	}
	@PostMapping("/equipment/insert")
	public String equipmentInsertPost(Model model, SportsEquipmentVO se, MultipartFile file) {
		String msg = hqService.insertSportsEquipment(se, file);
		model.addAttribute("url", "/hq/equipment/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	@ResponseBody
	@GetMapping("/equipment/data")
	public Map<String, Object> equipmentData(@RequestParam String se_name, SportsEquipmentVO seVo) {
		SportsEquipmentVO se = hqService.getSportsEquipment(seVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("se", se);
		return map;
	}
	@PostMapping("/equipment/update")
	public String equipmentUpdatePost1(Model model, String se_ori_name, SportsEquipmentVO se, MultipartFile file2, String isDel) {
		String msg = hqService.updateSportsEquipment(se, file2, se_ori_name, isDel);
		model.addAttribute("url", "/hq/equipment/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/stock/list")
	public String stockList(Model model) {
		List<SportsEquipmentVO> seList = hqService.getSportsEquipmentList();
		model.addAttribute("seList", seList);
	    return "/hq/stock/list";
	}
	@ResponseBody
	@GetMapping("/stock/lists")
	public Map<String, Object> stockLists() {
		List<BranchEquipmentStockVO> beList = hqService.getBranchEquipmentStockList();
		List<BranchStockDTO> stList = hqService.getBranchStockList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beList", beList);
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
		List<BranchOrderVO> boList = hqService.getBranchOrderList();
		model.addAttribute("boList", boList);
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
	public String paymentTypeInsert(Model model, PaymentTypeVO pt) {
		String msg = hqService.insertPaymentType(pt);
		model.addAttribute("url", "/hq/paymentType/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	@ResponseBody
	@GetMapping("/paymentType/data")
	public Map<String, Object> paymentTypeData(@RequestParam int pt_num, PaymentTypeVO ptVo) {
		PaymentTypeVO pt = hqService.getPaymentType(ptVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pt", pt);
		return map;
	}
	@PostMapping("/paymentType/update")
	public String paymentTypeUpdate(Model model, PaymentTypeVO pt) {
		String msg = hqService.updatePaymentType(pt);
		model.addAttribute("url", "/hq/paymentType/list");
		model.addAttribute("msg", msg);
		return "/main/message";
	}
}