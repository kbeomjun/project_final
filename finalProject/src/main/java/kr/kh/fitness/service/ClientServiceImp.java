package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.ClientDAO;
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

@Service
public class ClientServiceImp implements ClientService{
	
	@Autowired
	private ClientDAO clientDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;	

	@Override
	public MemberVO getMember(String me_id) {
		if(me_id == null) {
			return null;
		}
		return clientDao.selectMember(me_id);
	}
	
	@Override
	public List<ReviewPostVO> getReviewPostList() {
		return clientDao.selectReviewPostList();
	}

	@Override
	public void updateReviewPostView(int rp_num) {
		clientDao.updateReviewPostView(rp_num);
	}

	@Override
	public ReviewPostVO getReviewPost(int rp_num) {
		return clientDao.selectReviewPost(rp_num);
	}

	@Override
	public String checkMemberPayment(String me_id) {
		if(me_id == null) {
			return "아이디가 존재하지 않습니다";
		}
		List<PaymentVO> checkPayment = clientDao.checkMemberPayment(me_id); 
		if(checkPayment.size() == 0) {
			return "리뷰를 작성할 결제내역이 존재하지 않습니다.";
		}
		return "";
	}

	@Override
	public List<PaymentVO> getPaymentListForReview(String me_id) {
		if(me_id == null) {
			return null;
		}
		return clientDao.checkMemberPayment(me_id);
	}

	@Override
	public List<BranchVO> getBranchList() {
		return clientDao.selectBranchList();
	}

	@Override
	public String insertReviewPost(ReviewPostVO review) {
		if(review == null) {
			return "작성한 글이 존재하지 않습니다.";
		}
		if(review.getRp_title() == null || review.getRp_title().trim().length() == 0) {
			return "제목을 작성하세요.";
		}
		if(review.getRp_content() == null || review.getRp_content().trim().length() == 0) {
			return "내용을 작성하세요";
		}
		if(!clientDao.insertReviewPost(review)) {
			return "등록에 실패했습니다.";
		}
		clientDao.updatePaymentReview(review.getRp_pa_num());
		return "";
	}

	@Override
	public String updateReviewPost(ReviewPostVO review) {
		if(review == null) {
			return "작성한 글이 존재하지 않습니다.";
		}
		if(review.getRp_title() == null || review.getRp_title().trim().length() == 0) {
			return "제목을 작성하세요.";
		}
		if(review.getRp_content() == null || review.getRp_content().trim().length() == 0) {
			return "내용을 작성하세요";
		}
		if(!clientDao.updateReviewPost(review)) {
			return "수정에 실패했습니다.";
		}
		return "";
	}

	@Override
	public String deleteReviewPost(int rp_num) {
		if(!clientDao.deleteReviewPost(rp_num)) {
			return "삭제에 실패했습니다.";
		}
		return "";
	}

	@Override
	public List<MemberInquiryVO> getFaqList(String category, Criteria cri) {
		if(category == null || cri == null) {
			return null;
		}
		return clientDao.selectFaqList(category, cri);
	}
	
	@Override
	public PageMaker getPageMakerInFaq(String category, Criteria cri) {
		if(category == null || cri == null) {
			return null;
		}
		int totalCount = clientDao.selectFaqTotalCount(category, cri);
		return new PageMaker(3, cri, totalCount);
	}


	@Override
	public List<InquiryTypeVO> getInquiryTypeList() {
		return clientDao.selectInquiryTypeList();
	}

	@Override
	public boolean insertInquiry(MemberInquiryVO inquiry) {
		if(inquiry == null) {
			return false;
		}
		return clientDao.insertInquiry(inquiry);
	}

	@Override
	public List<BranchProgramScheduleVO> getReservationList(String view, String me_id) {
		if(me_id == null) {
			return null;
		}
		return clientDao.selectReservationList(view, me_id);
	}
	
	@Override
	public ProgramReservationVO getReservation(int pr_num) {
		return clientDao.selectReservation(pr_num);
	}
	
	@Override
	public boolean deleteReservation(int pr_num) {
		return clientDao.deleteReservation(pr_num);
	}

	@Override
	public void updateScheduleCurrent(int bs_num) {
		clientDao.updateScheduleCurrent(bs_num);
	}

	@Override
	public List<PaymentVO> getPaymentList(String me_id) {
		if(me_id == null) {
			return null;
		}
		return clientDao.selectPaymentList(me_id);
	}

	@Override
	public MembershipDTO getCurrentMembership(String me_id) {
		return clientDao.selectCurrentMembership(me_id);
	}

	@Override
	public MembershipDTO getCurrentPT(String me_id) {
		MembershipDTO pt = clientDao.selectCurrentPT(me_id);
		if(pt == null) {
			return null;
		}
		int scheduled = clientDao.selectScheduledPT(me_id, pt.getPa_start(), pt.getPa_end());
		pt.setRemain_count(pt.getTotal_count()-scheduled);
		return pt;
	}

	@Override
	public PaymentVO getpayment(int pa_num) {
		return clientDao.selectPayment(pa_num);
	}

	@Override
	public RefundVO getRefund(int pa_num) {
		return clientDao.selectRefund(pa_num);
	}

	@Override
	public List<MemberInquiryVO> getInquiryList(String me_email) {
		if(me_email == null) {
			return null;
		}
		return clientDao.selectInquiryList(me_email);
	}

	@Override
	public MemberInquiryVO getInquiry(int mi_num) {
		return clientDao.selectInquiry(mi_num);
	}

	@Override
	public String checkPassword(MemberVO member) {
		if(member == null) {
			return "회원 정보가 없습니다.";
		}
		if(member.getMe_id() == null || member.getMe_id().trim().length() == 0) {
			return "아이디가 존재하지 않습니다.";
		}
		if(member.getMe_pw() == null || member.getMe_pw().trim().length() == 0) {
			return "비밀번호가 존재하지 않습니다.";
		}
		
		MemberVO checkMember = clientDao.selectMember(member.getMe_id());
		
		boolean res = passwordEncoder.matches(member.getMe_pw(), checkMember.getMe_pw());
		
		if(!res) {
			return "비밀번호가 일치하지 않습니다.";
		}
		
		return "";
	}

	@Override
	public boolean isEmailDuplicate(String email) {
		if(email == null || email.trim().length() == 0) {
			return false;
		}
		
		int count = clientDao.isEmailDuplicate(email); 
		return count > 0;
	}

	@Override
	public String updateMemberInfo(MemberVO member) {
		if(member == null) {
			return "회원 정보가 없습니다.";
		}
		if(member.getMe_email() == null || member.getMe_email().trim().length() == 0) {
			return "이메일이 존재하지 않습니다.";
		}
		if(member.getMe_name() == null || member.getMe_name().trim().length() == 0) {
			return "이름이 존재하지 않습니다.";
		}
		if(member.getMe_phone() == null || member.getMe_phone().trim().length() == 0) {
			return "전화번호가 존재하지 않습니다.";
		}
		if(member.getMe_postcode() == null || member.getMe_postcode().trim().length() == 0 ||
			member.getMe_address() == null || member.getMe_address().trim().length() == 0 ||
			member.getMe_detailAddress() == null || member.getMe_detailAddress().trim().length() == 0 ||
			member.getMe_extraAddress() == null || member.getMe_extraAddress().trim().length() == 0) {
			return "주소 정보가 존재하지 않습니다.";
		}
		if(!clientDao.updateMemberInfo(member)) {
			return "개인정보 수정에 실패했습니다.";
		}
		return "개인정보 수정에 성공했습니다.";
	}

	@Override
	public String updateMemberPw(MemberVO member, String currentPw, String newPw) {
		if(member == null) {
			return "회원 정보가 없습니다.";
		}
		
		boolean res = passwordEncoder.matches(currentPw, member.getMe_pw());
		
		if(!res) {
			return "현재 비밀번호가 일치하지 않습니다.";
		}
		if(currentPw.equals(newPw)) {
			return "새 비밀번호는 현재 비밀번호와 같을 수 없습니다.";
		}
		
	    String encPw = passwordEncoder.encode(newPw);
		
		member.setMe_pw(encPw);
		if(!clientDao.updateMemberPw(member)) {
			return "비밀번호 변경에 실패했습니다.";
		}
		
		return "";
	}

	@Override
	public String removedMember(MemberVO member, String me_pw) {
		if(member == null) {
			return "회원 정보가 없습니다.";
		}
		
		boolean res = passwordEncoder.matches(me_pw, member.getMe_pw());
		
		if(!res) {
			return "현재 비밀번호가 일치하지 않습니다.";
		}
		
		MembershipDTO membership = clientDao.selectCurrentMembership(member.getMe_id());
		MembershipDTO pt = clientDao.selectCurrentPT(member.getMe_id());
		
		if(membership != null || pt != null) {
			return "현재 센터이용고객은 탈퇴할 수 없습니다.";
		}
		
		if(!clientDao.updateMemberStatusToRemoved(member)) {
			return "회원탈퇴에 실패했습니다. 관리자에게 문의하세요.";
		}
		
		return "";
	}

	@Override
	public String getSocial_id(MemberVO user, String social_type) {
		try {
			return clientDao.selectSocialId(user.getMe_id(), social_type);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public String checkSocial(MemberVO member, String social_type) {
		
		if(member == null) {
			return "회원 정보가 없습니다.";
		}
		if(member.getMe_id() == null || member.getMe_id().trim().length() == 0) {
			return "아이디가 존재하지 않습니다.";
		}
		if(social_type == null || social_type.trim().length() == 0) {
			return "SNS 타입이 입력되지 않았습니다.";
		}
		MemberVO checkMember = clientDao.selectMemberFromSocial(member, social_type);
		if(checkMember == null) {
			return "연동된 SNS 계정이 존재하지 않습니다.";
		}
		
//		if(checkMember.getMe_authority().equals("REMOVED")) {
//			return "탈퇴한 계정에 접근하였습니다.";
//		}
		
		return "";
	}

	@Override
	public boolean unlinkSocialAccount(MemberVO user, String social_type) {

		if(user == null) {
			return false;
		}
		if(social_type == null || social_type.trim().length() ==0) {
			return false;
		}
		return clientDao.updateSocialIdSetNull(user,social_type)==1?true:false;
	}

	@Override
	public List<ReviewPostVO> getMypageReviewPostList(String me_id) {
		if(me_id == null) {
			return null;
		}
		return clientDao.selectMypageReviewPostList(me_id);
	}

}
