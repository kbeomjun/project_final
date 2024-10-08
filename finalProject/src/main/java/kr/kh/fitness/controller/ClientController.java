package kr.kh.fitness.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ReviewPostVO;
import kr.kh.fitness.pagination.Criteria;
import kr.kh.fitness.pagination.PageMaker;
import kr.kh.fitness.service.ClientService;

@Controller
@RequestMapping("/client")
public class ClientController {
	
	@Autowired
	private ClientService clientService;
	
	@GetMapping("/menu/list")
	private String menuList() {
		return "/client/menuList";
	}
	
	@GetMapping("/review/list")
	public String reviewList(Model model, HttpSession session, Criteria cri) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		cri.setPerPageNum(5);
	
		List<ReviewPostVO> reviewList = clientService.getReviewPostList(cri);
		PageMaker pm = clientService.getPageMaker(cri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("user", user);
		model.addAttribute("pm", pm);
		return "/client/reviewList";
	}
	
	@GetMapping("/review/detail")
	public String reviewDetail(Model model, Integer rp_num, HttpSession session, Criteria cri) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		clientService.updateReviewPostView(rp_num);
		
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		
		model.addAttribute("review", review);
		model.addAttribute("user", user);
		model.addAttribute("cri", cri);
		return "/client/reviewDetail";
	}

	@GetMapping("/review/insert/{me_id}")
	public String reviewInsert(Model model, @PathVariable("me_id")String me_id) {
		//결제내역이 있는지 체크, 있으면 등록가능 없으면 등록불가
		String msg = clientService.checkMemberPayment(me_id);
		List<PaymentVO> paymentList = clientService.getPaymentList(me_id);
		List<BranchVO> branchList = clientService.getBranchList();
		
		if(msg == "") {
			model.addAttribute("paymentList", paymentList);
			model.addAttribute("branchList", branchList);
			return "/client/reviewInsert";
		} else {
			model.addAttribute("url", "/client/review/list");
			model.addAttribute("msg", msg);
			return "/main/message";
		}
	}
	
	@PostMapping("/review/insert")
	public String reviewInsertPost(Model model, ReviewPostVO review, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		String msg = clientService.insertReviewPost(review);
		
		if(msg == "") {
			model.addAttribute("url", "/client/review/list");
		} else {
			model.addAttribute("url", "/client/review/" + user.getMe_id());
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/review/update/{rp_num}")
	public String reviewUpdate(Model model, @PathVariable("rp_num")int rp_num) {
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("review", review);
		model.addAttribute("branchList", branchList);
		return "/client/reviewUpdate";
	}
	
	@PostMapping("/review/update")
	public String reviewUpdatePost(Model model, ReviewPostVO review) {
		
		String msg = clientService.updateReviewPost(review);
		
		if(msg == "") {
			model.addAttribute("url", "/client/review/detail/" + review.getRp_num());
		} else {
			model.addAttribute("url", "/client/review/update/" + review.getRp_num());
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/review/delete/{rp_num}")
	public String reviewDelete(Model model, @PathVariable("rp_num")int rp_num) {
		
		String msg = clientService.deleteReviewPost(rp_num);
		
		if(msg == "") {
			model.addAttribute("url", "/client/review/list");
		} else {
			model.addAttribute("url", "/client/review/detail/" + rp_num);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/inquiry/insert")
	public String inquiryInsert(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<InquiryTypeVO> inquiryTypeList = clientService.getInquiryTypeList();
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("user", user);
		model.addAttribute("inquiryTypeList", inquiryTypeList);
		model.addAttribute("branchList", branchList);
		
		return "/client/inquiryInsert";
	}
}
