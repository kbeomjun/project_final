package kr.kh.fitness.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
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
	
    @ModelAttribute
    public void addUserToModel(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
    }
	
	//리뷰 게시판 목록
	@GetMapping("/review/list")
	public String reviewList(Model model) {
		List<ReviewPostVO> reviewList = clientService.getReviewPostList();
		
		model.addAttribute("reviewList", reviewList);
		return "/client/review/list";
	}
	
	//리뷰 게시글 상세
	@GetMapping("/review/detail/{rp_num}")
	public String reviewDetail(Model model, @PathVariable("rp_num")int rp_num) {
		
		clientService.updateReviewPostView(rp_num);
		
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		
		model.addAttribute("review", review);
		return "/client/review/detail";
	}

	//리뷰 게시글 등록 get
	@GetMapping("/review/insert")
	public String reviewInsert(Model model, HttpSession session) {
		//결제내역이 있는지 체크, 있으면 등록가능 없으면 등록불가
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		String msg = clientService.checkMemberPayment(user.getMe_id());
		
		List<PaymentVO> paymentList = clientService.getPaymentListForReview(user.getMe_id());
		List<BranchVO> branchList = clientService.getBranchList();
		
		if(msg == "") {
			model.addAttribute("paymentList", paymentList);
			model.addAttribute("branchList", branchList);
			return "/client/review/insert";
		} else {
			model.addAttribute("url", "/client/review/list");
			model.addAttribute("msg", msg);
			return "/main/message";
		}
	}
	
	//리뷰 게시글 등록 post
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
	
	//리뷰 게시글 수정 get
	@GetMapping("/review/update/{rp_num}")
	public String reviewUpdate(Model model, @PathVariable("rp_num")int rp_num, HttpSession session, RedirectAttributes redirectAttributes) {
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		List<BranchVO> branchList = clientService.getBranchList();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(!user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "자신의 게시글만 접근 가능합니다.");
	        return "redirect:/client/review/list";
		}
		
		
		model.addAttribute("review", review);
		model.addAttribute("branchList", branchList);
		return "/client/review/update";
	}
	
	//리뷰 게시글 수정 post
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
	
	//리뷰 게시글 삭제
	@GetMapping("/review/delete/{rp_num}")
	public String reviewDelete(Model model, @PathVariable("rp_num")int rp_num, HttpSession session, RedirectAttributes redirectAttributes) {
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null || !user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "자신의 게시글만 접근 가능합니다.");
	        return "redirect:/client/review/list";
		}		
		
		String msg = clientService.deleteReviewPost(rp_num);
		
		if(msg == "") {
			model.addAttribute("url", "/client/review/list");
		} else {
			model.addAttribute("url", "/client/review/detail/" + rp_num);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//자주묻는질문
	@GetMapping("/inquiry/faq")
	public String inquiryFaq(Model model, @RequestParam(value = "category", defaultValue = "all")String category, Criteria cri) {

		cri.setPerPageNum(5);
		
		List<InquiryTypeVO> typeList = clientService.getInquiryTypeList();
		List<MemberInquiryVO> faqList = clientService.getFaqList(category, cri);
		PageMaker pm = clientService.getPageMakerInFaq(category, cri);
		
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("typeList", typeList);
		model.addAttribute("pm", pm);
		model.addAttribute("category", category);
		
		return "/client/inquiry/faq";
	}
	
	//1:1문의 등록 get
	@GetMapping("/inquiry/insert")
	public String inquiryInsert(Model model, HttpSession session) {
		List<InquiryTypeVO> inquiryTypeList = clientService.getInquiryTypeList();
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("inquiryTypeList", inquiryTypeList);
		model.addAttribute("branchList", branchList);
		
		return "/client/inquiry/insert";
	}
	
	//1:1문의 등록 post
	@PostMapping("/inquiry/insert")
	public String inquiryInsertPost(Model model, MemberInquiryVO inquiry) {
		
		if(clientService.insertInquiry(inquiry)) {
			model.addAttribute("msg", "등록에 성공했습니다.");
		} else {
			model.addAttribute("msg", "등록에 실패했습니다.");
		}
		model.addAttribute("url", "/client/inquiry/insert");
		
		return "/main/message";
	}
}
