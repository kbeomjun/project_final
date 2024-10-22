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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kh.fitness.model.dto.MembershipDTO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ProgramReservationVO;
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
	
    @ModelAttribute
    public void addUserToModel(HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
    }
	
	//리뷰 게시판 목록
	@GetMapping("/review/list")
	public String reviewList(Model model, Criteria cri) {
		
		cri.setPerPageNum(5);
	
		List<ReviewPostVO> reviewList = clientService.getReviewPostList(cri);
		PageMaker pm = clientService.getPageMakerInReview(cri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pm", pm);
		return "/client/review/list";
	}
	
	//리뷰 게시글 상세
	@GetMapping("/review/detail/{rp_num}")
	public String reviewDetail(Model model, @PathVariable("rp_num")int rp_num, Criteria cri) {
		
		clientService.updateReviewPostView(rp_num);
		
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		
		model.addAttribute("review", review);
		model.addAttribute("cri", cri);
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
	
	//마이페이지 스케줄 조회
	@GetMapping("/mypage/schedule/{me_id}")
	public String mypageSchedule(Model model, @PathVariable("me_id")String me_id, 
								@RequestParam(value = "view", defaultValue = "present")String view, 
								Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
	    
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/schedule/" + user.getMe_id();
	    }
		
		
		cri.setPerPageNum(5);
		
		List<BranchProgramScheduleVO> reservationList = clientService.getReservationList(view, me_id, cri);
		PageMaker pm = clientService.getPageMakerInSchedule(view, me_id, cri);
		
		model.addAttribute("reservationList", reservationList);
		model.addAttribute("view", view);
		model.addAttribute("me_id", me_id);
		model.addAttribute("pm", pm);
		
		return "/client/mypage/schedule";
	}
	
	//마이페이지 스케줄 예약취소
	@GetMapping("/mypage/schedule/cancel/{pr_num}/{bs_num}")
	public String mypageScheduleCancel(Model model, @PathVariable("pr_num")int pr_num, @PathVariable("bs_num")int bs_num,
										HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    ProgramReservationVO reservation = clientService.getReservation(pr_num);

	    if (user == null || !user.getMe_id().equals(reservation.getPr_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/schedule/" + user.getMe_id();
	    }
		
		if(clientService.deleteReservation(pr_num)) {
			clientService.updateScheduleCurrent(bs_num);
			model.addAttribute("msg", "성공적으로 취소되었습니다.");
		} else {
			model.addAttribute("msg", "취소에 실패했습니다.");
		}
		model.addAttribute("url", "/client/mypage/schedule/" + user.getMe_id());
		return "/main/message";
	}
	
	//마이페이지 회원권 내역
	@GetMapping("/mypage/membership/{me_id}")
	public String mypageMembership(Model model, @PathVariable("me_id")String me_id, Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/membership/" + user.getMe_id();
	    }
		
		cri.setPerPageNum(5);
		
		List<PaymentVO> paymentList = clientService.getPaymentList(me_id, cri);
		PageMaker pm = clientService.getPageMakerInMemberShip(me_id, cri);
		
		MembershipDTO currentMembership = clientService.getCurrentMembership(me_id);
		MembershipDTO currentPT = clientService.getCurrentPT(me_id);
		
		model.addAttribute("me_id", me_id);
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("pm", pm);
		model.addAttribute("currentMembership", currentMembership);
		model.addAttribute("currentPT", currentPT);
		
		return "/client/mypage/membership";
	}
	
	//마이페이지 회원권 -> 리뷰 작성 get
	@GetMapping("/mypage/review/insert/{pa_num}/{page}")
	public String mypageReviewInsert(Model model, @PathVariable("pa_num")int pa_num, @PathVariable("page")int page,
										HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    PaymentVO payment = clientService.getpayment(pa_num);

	    if (user == null || !user.getMe_id().equals(payment.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/membership/" + user.getMe_id();
	    }
		
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("pa_num", pa_num);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("page", page);
		model.addAttribute("branchList", branchList);
		return "/client/mypage/reviewInsert";
	}
	
	//마이페이지 회원권 -> 리뷰 작성 post
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
	
	//마이페이지 회원권 환불내역 상세조회
	@ResponseBody
	@GetMapping("/mypage/refundDetail")
	public Map<String, Object> mypageRefundDetail(@RequestParam("pa_num") int pa_num){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		RefundVO refund = clientService.getRefund(pa_num);
		
		map.put("refund", refund);
		return map;
	}
	
	//마이페이지 리뷰게시글 내역 조회
	@GetMapping("/mypage/review/list/{me_id}")
	public String mypageReviewList(Model model, @PathVariable("me_id")String me_id, Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/review/list/" + user.getMe_id();
	    }
		
		cri.setPerPageNum(5);
		cri.setType("id");
		cri.setSearch(me_id);
		
		List<ReviewPostVO> reviewList = clientService.getReviewPostList(cri);
		PageMaker pm = clientService.getPageMakerInReview(cri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("me_id", me_id);
		model.addAttribute("pm", pm);
		
		return "/client/mypage/reviewList";
	}
	
	//마이페이지 리뷰게시글 상세
	@GetMapping("/mypage/review/detail/{rp_num}")
	public String mypageReviewDetail(Model model, @PathVariable("rp_num")int rp_num, Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    ReviewPostVO review = clientService.getReviewPost(rp_num);

	    if (user == null || !user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/review/list/" + user.getMe_id();
	    }
		
		clientService.updateReviewPostView(rp_num);
		
		model.addAttribute("review", review);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("cri", cri);
		
		return "/client/mypage/reviewDetail";
	}
	
	//마이페이지 리뷰게시글 수정 get
	@GetMapping("/mypage/review/update/{rp_num}")
	public String mypageReviewUpdate(Model model, @PathVariable("rp_num")int rp_num, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		List<BranchVO> branchList = clientService.getBranchList();
		
	    if (user == null || !user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/review/list/" + user.getMe_id();
	    }
		
		model.addAttribute("review", review);
		model.addAttribute("branchList", branchList);
		model.addAttribute("me_id", user.getMe_id());
		
		return "/client/mypage/reviewUpdate";
	}
	
	//마이페이지 리뷰게시글 수정 post
	@PostMapping("/mypage/review/update")
	public String mypageReviewUpdatePost(Model model, ReviewPostVO review, String me_id) {
		
		String msg = clientService.updateReviewPost(review);
		if(msg == "") {
			model.addAttribute("url", "/client/mypage/review/detail/" + review.getRp_num());
		} else {
			model.addAttribute("url", "/client/mypage/review/update/" + review.getRp_num());
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//마이페이지 문의내역 목록
	@GetMapping("/mypage/inquiry/list/{me_id}")
	public String mypageInquiryList(Model model, @PathVariable("me_id")String me_id, Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/inquiry/list/" + user.getMe_id();
	    }
	    
		cri.setPerPageNum(3);
		
		List<MemberInquiryVO> inquiryList = clientService.getInquiryList(user.getMe_email(), cri);
		PageMaker pm = clientService.getPageMakerInInquiry(user.getMe_email(), cri);
		
		model.addAttribute("me_id", me_id);
		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("pm", pm);
		
		return "/client/mypage/inquiryList";
	}
	
	//마이페이지 문의내역 상세
	@GetMapping("/mypage/inquiry/detail/{mi_num}")
	public String mypageInquiryDetail(Model model, @PathVariable("mi_num")int mi_num, int page, HttpSession session, RedirectAttributes redirectAttributes) {
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		MemberInquiryVO inquiry = clientService.getInquiry(mi_num);
		
	    if (user == null || !user.getMe_email().equals(inquiry.getMi_email())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/inquiry/list/" + user.getMe_id();
	    }
		
		model.addAttribute("inquiry", inquiry);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("page", page);
		
		return "/client/mypage/inquiryDetail";
	}
	
	//마이페이지 개인정보수정 시 비밀번호 확인 get
	@GetMapping("/mypage/pwcheck/{me_id}")
	public String mypagePwCheck(Model model, @PathVariable("me_id")String me_id, HttpSession session, RedirectAttributes redirectAttributes) {
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/pwcheck/" + user.getMe_id();
	    }
	    
		model.addAttribute("me_id", me_id);
		return "/client/mypage/pwCheck";
	}
	
	//마이페이지 개인정보수정 시 비밀번호 확인 post
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
	
	//마이페이지 개인정보수정 get
	@GetMapping("/mypage/info/{me_id}")
	public String mypageInfo(Model model, @PathVariable("me_id") String me_id, HttpSession session, RedirectAttributes redirectAttributes) {
	    Boolean pwVerified = (Boolean) session.getAttribute("pwVerified");
	    
	    if (pwVerified == null || !pwVerified) {
	        // 비밀번호 확인이 안 된 경우, 비밀번호 확인 페이지로 이동
	        return "redirect:/client/mypage/pwcheck" + me_id;
	    }
	    
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/pwcheck/" + user.getMe_id();
	    }
	    
	    model.addAttribute("member", user);
	    
	    return "/client/mypage/info";
	}
	
	//마이페이지 개인정보수정 email중복체크
	@ResponseBody
    @PostMapping("/mypage/checkEmail")
    public boolean mypageCheckEmail(@RequestParam("email") String email, @RequestParam("id") String me_id) {
    	MemberVO member = clientService.getMember(me_id);
    	if(email.equals(member.getMe_email())) {
    		return false;
    	}
    	return clientService.isEmailDuplicate(email);
    }
	
	//마이페이지 개인정보수정 post
	@PostMapping("/mypage/info/update")
	public String mypageInfoUpdate(Model model, MemberVO member, HttpSession session, String birth) {
	    
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date me_birth;
		
		try {
			me_birth = formatter.parse(birth);
			member.setMe_birth(me_birth);
			String msg = clientService.updateMemberInfo(member);
			
			MemberVO updatedUser = clientService.getMember(member.getMe_id());

			model.addAttribute("msg", msg);
			model.addAttribute("url", "/client/mypage/info/"+member.getMe_id());
			model.addAttribute("me_id", member.getMe_id());
			session.setAttribute("user", updatedUser);
			
			return "/main/message";
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/main";
		}
	}
	
	//마이페이지 비밀번호 변경 get
	@GetMapping("/mypage/pwchange/{me_id}")
	public String mypagePwChange(Model model, @PathVariable("me_id")String me_id, HttpSession session, RedirectAttributes redirectAttributes) {
	    
		MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null || !user.getMe_id().equals(me_id)) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/client/mypage/pwchange/" + user.getMe_id();
	    }
		
		model.addAttribute("me_id", me_id);
		return "/client/mypage/pwChange";
	}
	
	//마이페이지 비밀번호 변경 post
	@PostMapping("/mypage/pwchange/update")
	public String updatePassword(Model model, @RequestParam("current_pw") String currentPw, @RequestParam("new_pw") String newPw, @RequestParam("me_id") String me_id, HttpSession session) {

		MemberVO member = clientService.getMember(me_id);
	    
		String msg = clientService.updateMemberPw(member, currentPw, newPw);
		
		if(msg == "") {
			model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다. 다시 로그인하시기 바랍니다.");
			session.removeAttribute("user");
			model.addAttribute("url", "/login");
		} else {
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/client/mypage/pwchange/"+me_id);
		}
	    return "/main/message";
	}
	
}
