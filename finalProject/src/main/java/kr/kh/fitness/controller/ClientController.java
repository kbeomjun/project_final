package kr.kh.fitness.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.RefundVO;
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
	private String menuList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		model.addAttribute("user", user);
		
		return "/client/menuList";
	}
	
	@GetMapping("/mypage/{me_id}")
	private String mypage(Model model, @PathVariable("me_id")String me_id) {
		model.addAttribute("me_id", me_id);
		
		return "/client/mypage";
	}
	
	@GetMapping("/review/list")
	public String reviewList(Model model, HttpSession session, Criteria cri) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		cri.setPerPageNum(5);
	
		List<ReviewPostVO> reviewList = clientService.getReviewPostList(cri);
		PageMaker pm = clientService.getPageMakerInReview(cri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("user", user);
		model.addAttribute("pm", pm);
		return "/client/reviewList";
	}
	
	@GetMapping("/review/detail/{rp_num}")
	public String reviewDetail(Model model, @PathVariable("rp_num")int rp_num, HttpSession session, Criteria cri) {
		
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
		List<PaymentVO> paymentList = clientService.getPaymentListForReview(me_id);
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
	
	@GetMapping("/mypage/schedule/{me_id}")
	public String mypageSchedule(Model model, @PathVariable("me_id")String me_id, @RequestParam(value = "view", defaultValue = "present")String view, Criteria cri) {
		
		cri.setPerPageNum(5);
		
		List<BranchProgramScheduleVO> reservationList = clientService.getReservationList(view, me_id, cri);
		PageMaker pm = clientService.getPageMakerInSchedule(view, me_id, cri);
		
		model.addAttribute("reservationList", reservationList);
		model.addAttribute("view", view);
		model.addAttribute("me_id", me_id);
		model.addAttribute("pm", pm);
		
		return "/client/mypageSchedule";
	}
	
	@GetMapping("/mypage/schedule/cancel/{pr_num}/{bs_num}/{me_id}")
	public String mypageScheduleCancel(Model model, @PathVariable("pr_num")int pr_num, @PathVariable("bs_num")int bs_num, @PathVariable("me_id")String me_id) {
		
		if(clientService.deleteReservation(pr_num)) {
			clientService.updateScheduleCurrent(bs_num);
			model.addAttribute("msg", "성공적으로 취소되었습니다.");
		} else {
			model.addAttribute("msg", "취소에 실패했습니다.");
		}
		model.addAttribute("url", "/client/mypage/schedule/" + me_id);
		return "/main/message";
	}
	
	@GetMapping("/mypage/membership/{me_id}")
	public String mypageMembership(Model model, @PathVariable("me_id")String me_id, Criteria cri) {
		
		cri.setPerPageNum(5);
		
		List<PaymentVO> paymentList = clientService.getPaymentList(me_id, cri);
		PageMaker pm = clientService.getPageMakerInMemberShip(me_id, cri);
		
		model.addAttribute("me_id", me_id);
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("pm", pm);
		
		return "/client/mypageMembership";
	}
	
	@GetMapping("/mypage/review/insert/{pa_num}/{me_id}/{page}")
	public String mypageReviewInsert(Model model, @PathVariable("pa_num")int pa_num, @PathVariable("me_id")String me_id, @PathVariable("page")int page) {
		
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("pa_num", pa_num);
		model.addAttribute("me_id", me_id);
		model.addAttribute("page", page);
		model.addAttribute("branchList", branchList);
		return "/client/mypageReviewInsert";
	}
	
	@PostMapping("/mypage/review/insert")
	public String mypageReviewInsertPost(Model model, ReviewPostVO review, String me_id, int page) {
		
		String msg = clientService.insertReviewPost(review);
		
		if(msg == "") {
			model.addAttribute("url", "/client/mypage/membership/" + me_id + "?page=" + page);
		} else {
			model.addAttribute("url", "/client/mypage/review/insert/" + review.getRp_pa_num() + "/" + me_id + "/" + page);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@ResponseBody
	@GetMapping("/mypage/refundDetail")
	public Map<String, Object> mypageRefundDetail(@RequestParam("pa_num") int pa_num){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		RefundVO refund = clientService.getRefund(pa_num);
		
		map.put("refund", refund);
		return map;
	}
	
	@GetMapping("/mypage/review/list/{me_id}")
	public String mypageReviewList(Model model, @PathVariable("me_id")String me_id, Criteria cri) {
		
		cri.setPerPageNum(5);
		cri.setType("id");
		cri.setSearch(me_id);
		
		List<ReviewPostVO> reviewList = clientService.getReviewPostList(cri);
		PageMaker pm = clientService.getPageMakerInReview(cri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("me_id", me_id);
		model.addAttribute("pm", pm);
		
		return "/client/mypageReviewList";
	}
	
	@GetMapping("/mypage/review/detail/{rp_num}/{me_id}")
	public String mypageReviewDetail(Model model, @PathVariable("rp_num")int rp_num, @PathVariable("me_id")String me_id, Criteria cri) {
		
		clientService.updateReviewPostView(rp_num);
		
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		
		model.addAttribute("review", review);
		model.addAttribute("me_id", me_id);
		model.addAttribute("cri", cri);
		
		return "/client/mypageReviewDetail";
	}
	
	@GetMapping("/mypage/review/update/{rp_num}/{me_id}")
	public String mypageReviewUpdate(Model model, @PathVariable("rp_num")int rp_num, @PathVariable("me_id")String me_id) {
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("review", review);
		model.addAttribute("branchList", branchList);
		model.addAttribute("me_id", me_id);
		
		return "/client/mypageReviewUpdate";
	}
	
	@PostMapping("/mypage/review/update")
	public String mypageReviewUpdatePost(Model model, ReviewPostVO review, String me_id) {
		
		String msg = clientService.updateReviewPost(review);
		if(msg == "") {
			model.addAttribute("url", "/client/mypage/review/detail/" + review.getRp_num() + "/" + me_id);
		} else {
			model.addAttribute("url", "/client/mypage/review/update/" + review.getRp_num() + "/" + me_id);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	@GetMapping("/mypage/inquiry/list/{me_id}")
	public String mypageInquiryList(Model model, @PathVariable("me_id")String me_id, Criteria cri) {
		
		MemberVO user = clientService.getMember(me_id);
		
		cri.setPerPageNum(3);
		
		List<MemberInquiryVO> inquiryList = clientService.getInquiryList(user.getMe_email(), cri);
		PageMaker pm = clientService.getPageMakerInInquiry(user.getMe_email(), cri);
		
		model.addAttribute("me_id", me_id);
		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("pm", pm);
		
		return "/client/mypageInquiryList";
	}
	
	@GetMapping("/mypage/inquiry/detail/{mi_num}/{me_id}")
	public String mypageInquiryDetail(Model model, @PathVariable("mi_num")int mi_num, @PathVariable("me_id")String me_id, int page) {
		
		MemberInquiryVO inquiry = clientService.getInquiry(mi_num);
		
		model.addAttribute("inquiry", inquiry);
		model.addAttribute("me_id", me_id);
		model.addAttribute("page", page);
		
		return "/client/mypageInquiryDetail";
	}
	
	@GetMapping("/mypage/pwcheck/{me_id}")
	public String mypagePwCheck(Model model, @PathVariable("me_id")String me_id) {
		model.addAttribute("me_id", me_id);
		return "/client/mypagePwCheck";
	}
	
	@PostMapping("/mypage/pwcheck")
	public String mypagePwCheckPost(Model model, HttpSession session, MemberVO member) {
		
		String msg = clientService.checkPassword(member);
		
		if(msg == "") {
			session.setAttribute("pwVerified", true);
			return "redirect:/client/mypage/info/" + member.getMe_id();
		} else {
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/client/mypage/pwcheck/"+member.getMe_id());
			return "/main/message";
		}
	}
	
	@GetMapping("/mypage/info/{me_id}")
	public String mypageInfo(Model model, @PathVariable("me_id") String me_id, HttpSession session) {
	    Boolean pwVerified = (Boolean) session.getAttribute("pwVerified");
	    
	    if (pwVerified == null || !pwVerified) {
	        // 비밀번호 확인이 안 된 경우, 비밀번호 확인 페이지로 이동
	        return "redirect:/client/mypage/pwcheck" + me_id;
	    }
	    
	    MemberVO member = clientService.getMember(me_id);
	    
	    model.addAttribute("member", member);
	    
	    return "/client/mypageInfo";
	}
	
	@ResponseBody
    @PostMapping("/mypage/checkEmail")
    public boolean mypageCheckEmail(@RequestParam("email") String email) {
    	
    	return clientService.isEmailDuplicate(email);
    }
	
	@PostMapping("/mypage/info/update")
	public String mypageInfoUpdate(Model model, MemberVO member, HttpSession session, String birth) {
	    
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date me_birth;
		
		try {
			me_birth = formatter.parse(birth);
			member.setMe_birth(me_birth);
			String msg = clientService.updateMemberInfo(member);

			model.addAttribute("msg", msg);
			model.addAttribute("url", "/client/mypage/info/"+member.getMe_id());
			model.addAttribute("me_id", member.getMe_id());
			
			return "/main/message";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/main";
		}
		
		
	}
	
}
