package kr.kh.fitness.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kh.fitness.model.dto.MembershipDTO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ProgramReservationVO;
import kr.kh.fitness.model.vo.RefundVO;
import kr.kh.fitness.model.vo.ReviewPostVO;
import kr.kh.fitness.pagination.Criteria;
import kr.kh.fitness.pagination.PageMaker;
import kr.kh.fitness.service.ClientService;
import kr.kh.fitness.service.MemberService;
import kr.kh.fitness.service.MemberServiceImp;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private ClientService clientService;
	
	
	@Autowired
	private MemberService memberService;
	 
	
	//마이페이지 회원권 내역
	@GetMapping("/membership")
	public String mypageMembership(Model model, Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");

		cri.setPerPageNum(5);
		
		List<PaymentVO> paymentList = clientService.getPaymentList(user.getMe_id(), cri);
		PageMaker pm = clientService.getPageMakerInMemberShip(user.getMe_id(), cri);
		
		MembershipDTO currentMembership = clientService.getCurrentMembership(user.getMe_id());
		MembershipDTO currentPT = clientService.getCurrentPT(user.getMe_id());
		
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("pm", pm);
		model.addAttribute("currentMembership", currentMembership);
		model.addAttribute("currentPT", currentPT);
		
		return "/mypage/membership";
	}
	
	//마이페이지 회원권 -> 리뷰 작성 get
	@GetMapping("/review/insert/{pa_num}/{page}")
	public String mypageReviewInsert(Model model, @PathVariable("pa_num")int pa_num, @PathVariable("page")int page,
										HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    PaymentVO payment = clientService.getpayment(pa_num);

	    if (user == null || !user.getMe_id().equals(payment.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/mypage/membership/" + user.getMe_id();
	    }
		
		List<BranchVO> branchList = clientService.getBranchList();
		
		model.addAttribute("pa_num", pa_num);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("page", page);
		model.addAttribute("branchList", branchList);
		return "/mypage/review/insert";
	}
	
	//마이페이지 회원권 -> 리뷰 작성 post
	@PostMapping("/review/insert")
	public String mypageReviewInsertPost(Model model, ReviewPostVO review, String me_id, int page) {
		
		String msg = clientService.insertReviewPost(review);
		
		if(msg == "") {
			model.addAttribute("url", "/mypage/membership?page=" + page);
		} else {
			model.addAttribute("url", "/mypage/review/insert/" + review.getRp_pa_num() + "/" + me_id + "/" + page);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//마이페이지 회원권 환불내역 상세조회
	@ResponseBody
	@GetMapping("/refundDetail")
	public Map<String, Object> mypageRefundDetail(@RequestParam("pa_num") int pa_num){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		RefundVO refund = clientService.getRefund(pa_num);
		
		map.put("refund", refund);
		return map;
	}
		
	//마이페이지 스케줄 조회
	@GetMapping("/schedule")
	public String mypageSchedule(Model model, @RequestParam(value = "view", defaultValue = "present")String view, Criteria cri, HttpSession session) {
	    
	    MemberVO user = (MemberVO) session.getAttribute("user");

		cri.setPerPageNum(5);
		
		List<BranchProgramScheduleVO> reservationList = clientService.getReservationList(view, user.getMe_id(), cri);
		PageMaker pm = clientService.getPageMakerInSchedule(view, user.getMe_id(), cri);
		
		model.addAttribute("reservationList", reservationList);
		model.addAttribute("view", view);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("pm", pm);
		
		return "/mypage/schedule";
	}
	
	//마이페이지 스케줄 예약취소
	@GetMapping("/schedule/cancel/{pr_num}/{bs_num}")
	public String mypageScheduleCancel(Model model, @PathVariable("pr_num")int pr_num, @PathVariable("bs_num")int bs_num,
										HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    ProgramReservationVO reservation = clientService.getReservation(pr_num);

	    if (user == null || !user.getMe_id().equals(reservation.getPr_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/mypage/schedule";
	    }
		
		if(clientService.deleteReservation(pr_num)) {
			clientService.updateScheduleCurrent(bs_num);
			model.addAttribute("msg", "성공적으로 취소되었습니다.");
		} else {
			model.addAttribute("msg", "취소에 실패했습니다.");
		}
		model.addAttribute("url", "/mypage/schedule");
		return "/main/message";
	}

	//마이페이지 리뷰게시글 내역 조회
	@GetMapping("/review/list")
	public String mypageReviewList(Model model, Criteria cri, HttpSession session) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
		
		cri.setPerPageNum(5);
		cri.setType("id");
		cri.setSearch(user.getMe_id());
		
		List<ReviewPostVO> reviewList = clientService.getReviewPostList(cri);
		PageMaker pm = clientService.getPageMakerInReview(cri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("pm", pm);
		
		return "/mypage/review/list";
	}
	
	//마이페이지 리뷰게시글 상세
	@GetMapping("/review/detail/{rp_num}")
	public String mypageReviewDetail(Model model, @PathVariable("rp_num")int rp_num, Criteria cri, HttpSession session, RedirectAttributes redirectAttributes) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    ReviewPostVO review = clientService.getReviewPost(rp_num);

	    if (user == null || !user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/mypage/review/list";
	    }
		
		clientService.updateReviewPostView(rp_num);
		
		model.addAttribute("review", review);
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("cri", cri);
		
		return "/mypage/review/detail";
	}
	
	//마이페이지 리뷰게시글 수정 get
	@GetMapping("/review/update/{rp_num}")
	public String mypageReviewUpdate(Model model, @PathVariable("rp_num")int rp_num, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		List<BranchVO> branchList = clientService.getBranchList();
		
	    if (user == null || !user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "잘못된 접근입니다.");
	        return "redirect:/mypage/review/list/" + user.getMe_id();
	    }
		
		model.addAttribute("review", review);
		model.addAttribute("branchList", branchList);
		model.addAttribute("me_id", user.getMe_id());
		
		return "/mypage/review/update";
	}
	
	//마이페이지 리뷰게시글 수정 post
	@PostMapping("/review/update")
	public String mypageReviewUpdatePost(Model model, ReviewPostVO review, String me_id) {
		
		String msg = clientService.updateReviewPost(review);
		if(msg == "") {
			model.addAttribute("url", "/mypage/review/detail/" + review.getRp_num());
		} else {
			model.addAttribute("url", "/mypage/review/update/" + review.getRp_num());
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//마이페이지 리뷰게시글 삭제
	@GetMapping("/review/delete/{rp_num}")
	public String reviewDelete(Model model, @PathVariable("rp_num")int rp_num, HttpSession session, RedirectAttributes redirectAttributes) {
		ReviewPostVO review = clientService.getReviewPost(rp_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null || !user.getMe_id().equals(review.getPa_me_id())) {
	        redirectAttributes.addFlashAttribute("msg", "자신의 게시글만 접근 가능합니다.");
	        return "redirect:/mypage/review/list";
		}		
		
		String msg = clientService.deleteReviewPost(rp_num);
		
		if(msg == "") {
			model.addAttribute("url", "/mypage/review/list");
		} else {
			model.addAttribute("url", "/mypage/review/detail/" + rp_num);
		}
		model.addAttribute("msg", msg);
		return "/main/message";
	}
	
	//마이페이지 문의내역 목록
	@GetMapping("/inquiry/list")
	public String mypageInquiryList(Model model, Criteria cri, HttpSession session) {
		
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
		cri.setPerPageNum(3);
		
		List<MemberInquiryVO> inquiryList = clientService.getInquiryList(user.getMe_email(), cri);
		PageMaker pm = clientService.getPageMakerInInquiry(user.getMe_email(), cri);
		
		model.addAttribute("me_id", user.getMe_id());
		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("pm", pm);
		
		return "/mypage/inquiry/list";
	}
	
	//마이페이지 문의내역 상세
	@GetMapping("/inquiry/detail/{mi_num}")
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
		
		return "/mypage/inquiry/detail";
	}
	
	//마이페이지 개인정보수정 시 비밀번호 확인 get
	@GetMapping("/pwcheck")
	public String mypagePwCheck(Model model, HttpSession session) {
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    String social_type = (String) session.getAttribute("socialType");
	    if(social_type != null) {
	    	String social_id = clientService.getSocial_id(user, social_type);
	    	model.addAttribute("social_type", social_type);
	    	model.addAttribute("social_id", social_id);
	    }
		model.addAttribute("me_id", user.getMe_id());
		return "/mypage/pwCheck";
	}
	
	//마이페이지 개인정보수정 시 비밀번호 확인 post
	@PostMapping("/pwcheck")
	public String mypagePwCheckPost(Model model, HttpSession session, MemberVO member) {
		
		String msg = clientService.checkPassword(member);
		if(msg == "") {
			session.setAttribute("pwVerified", true);
			return "redirect:/mypage/info";
		} else {
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/mypage/pwcheck");
			return "/main/message";
		}
	}
	
	// 소셜 정보로 비밀번호 확인 대체 post 
	@PostMapping("/socialcheck")
	public String mypageSocialCheck(Model model, HttpSession session) {
		
		String social_type = (String) session.getAttribute("socialType");
		MemberVO member = (MemberVO) session.getAttribute("user");
		
		String msg = clientService.checkSocial(member, social_type);
		if(msg == "") {
			session.setAttribute("pwVerified", true);
			return "redirect:/mypage/info";
		} else {
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/mypage/pwcheck");
			return "/main/message";
		}
	}
	
	//마이페이지 개인정보수정 get
	@GetMapping("/info")
	public String mypageInfo(Model model, HttpSession session) {
	    Boolean pwVerified = (Boolean) session.getAttribute("pwVerified");
	    if (pwVerified == null || !pwVerified) {
	        // 비밀번호 확인이 안 된 경우, 비밀번호 확인 페이지로 이동
	        return "redirect:/mypage/pwCheck";
	    }
	    
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    model.addAttribute("member", user);
	    
	    return "/mypage/info";
	}
	
	//마이페이지 개인정보수정 email중복체크
	@ResponseBody
    @PostMapping("/checkEmail")
    public boolean mypageCheckEmail(@RequestParam("email") String email, @RequestParam("id") String me_id) {
    	MemberVO member = clientService.getMember(me_id);
    	if(email.equals(member.getMe_email())) {
    		return false;
    	}
    	return clientService.isEmailDuplicate(email);
    }
	
	//마이페이지 개인정보수정 post
	@PostMapping("/info/update")
	public String mypageInfoUpdate(Model model, MemberVO member, HttpSession session, String birth) {
	    
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date me_birth;
		
		try {
			me_birth = formatter.parse(birth);
			member.setMe_birth(me_birth);
			String msg = clientService.updateMemberInfo(member);
			
			MemberVO updatedUser = clientService.getMember(member.getMe_id());

			model.addAttribute("msg", msg);
			model.addAttribute("url", "/mypage/info");
			model.addAttribute("me_id", member.getMe_id());
			session.setAttribute("user", updatedUser);
			
			return "/main/message";
		} catch (Exception e) {
			e.printStackTrace();
			return "/main/main";
		}
	}
	
	//마이페이지 비밀번호 변경 get
	@GetMapping("/pwchange")
	public String mypagePwChange(Model model, HttpSession session) {
	    
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		model.addAttribute("me_id", user.getMe_id());
		return "/mypage/pwChange";
	}
	
	//마이페이지 비밀번호 변경 post
	@PostMapping("/pwchange/update")
	public String mypagePwChangePost(Model model, @RequestParam("current_pw") String currentPw, @RequestParam("new_pw") String newPw, @RequestParam("me_id") String me_id, HttpSession session, HttpServletResponse response) {

		MemberVO member = clientService.getMember(me_id);
	    
		String msg = clientService.updateMemberPw(member, currentPw, newPw);
		
		if(msg == "") {
			model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다. 다시 로그인하시기 바랍니다.");
			
			memberService.clearLoginCookie(me_id);
			// 로그아웃 시 쿠키 삭제
	        Cookie cookie = new Cookie("me_cookie", null);
	        cookie.setMaxAge(0); // 즉시 삭제
	        cookie.setPath("/");
	        response.addCookie(cookie);

	        session.removeAttribute("user");
			model.addAttribute("url", "/login");
		} else {
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/mypage/pwchange");
		}
	    return "/main/message";
	}
	
	//마이페이지 회원탈퇴 get
	@GetMapping("/unregister")
	public String mypageUnregister(Model model, HttpSession session, HttpServletRequest request) {
		
		MemberVO user = (MemberVO) session.getAttribute("user");

		MembershipDTO currentMembership = clientService.getCurrentMembership(user.getMe_id());
		MembershipDTO currentPT = clientService.getCurrentPT(user.getMe_id());	
		String prevUrl = request.getHeader("Referer");
	    if (prevUrl == null || prevUrl.isEmpty()) {
	        prevUrl = "/";
	    }

		if (user == null || !user.getMe_id().equals(user.getMe_id())) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("url", prevUrl);
	    } else if(currentMembership != null || currentPT != null) {
	    	model.addAttribute("msg", "현재 센터이용고객은 탈퇴할 수 없습니다.");
	    	model.addAttribute("url", prevUrl);
	    } else {
	    	model.addAttribute("me_id", user.getMe_id());
	    	return "/mypage/unregister";
	    }
	    
		return "/main/message";
	}
	
	@PostMapping("/unregister")
	public String mypageUnregisterPost(Model model, String me_id, String me_pw, HttpSession session, HttpServletRequest request) {
		
		MemberVO member = clientService.getMember(me_id);
	    
		String msg = clientService.removedMember(member, me_pw);
		
		String prevUrl = request.getHeader("Referer");
	    if (prevUrl == null || prevUrl.isEmpty()) {
	        prevUrl = "/";
	    }
		
		if(msg == "") {
			session.removeAttribute("user");
			model.addAttribute("msg", "회원탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("msg", msg);
			model.addAttribute("url", prevUrl);
		}
		
		return "/main/message";
	}
	
	@PostMapping("/unlinkSNS")
    @ResponseBody
    public boolean unlinkSNS(HttpSession session, @RequestParam("socialType") String social_type) {
        try {
            MemberVO user = (MemberVO) session.getAttribute("user");
            
            boolean result = clientService.unlinkSocialAccount(user, social_type);
            
            if (result) {
            	MemberVO updateUser = clientService.getMember(user.getMe_id());
            	String currentSocial = (String) session.getAttribute("socialType");
            	if(currentSocial != null && currentSocial.equals(social_type)) {
            		session.removeAttribute("socialType");
            	}
            	session.removeAttribute("user");
            	session.setAttribute("user", updateUser);
            	
            	String token = (String)session.getAttribute("access_token");
            	
                return true; // 성공 시
            } else {
                return false; // 실패 시
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 예외 발생 시
        }
    }
}
