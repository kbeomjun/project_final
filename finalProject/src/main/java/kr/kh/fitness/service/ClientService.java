package kr.kh.fitness.service;

import java.util.List;

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

public interface ClientService {
	
	MemberVO getMember(String me_id);

	List<ReviewPostVO> getReviewPostList();

	void updateReviewPostView(int rp_num);

	ReviewPostVO getReviewPost(int rp_num);

	String checkMemberPayment(String me_id);

	List<PaymentVO> getPaymentListForReview(String me_id);

	List<BranchVO> getBranchList();

	String insertReviewPost(ReviewPostVO review);

	String updateReviewPost(ReviewPostVO review);

	String deleteReviewPost(int rp_num);

	List<InquiryTypeVO> getInquiryTypeList();
	
	List<MemberInquiryVO> getFaqList(String category, Criteria cri);
	
	PageMaker getPageMakerInFaq(String category, Criteria cri);
	
	boolean insertInquiry(MemberInquiryVO inquiry);

	List<BranchProgramScheduleVO> getReservationList(String view, String me_id, Criteria cri);

	PageMaker getPageMakerInSchedule(String view, String me_id, Criteria cri);

	ProgramReservationVO getReservation(int pr_num);
	
	boolean deleteReservation(int pr_num);

	void updateScheduleCurrent(int bs_num);

	List<PaymentVO> getPaymentList(String me_id, Criteria cri);

	PageMaker getPageMakerInMemberShip(String me_id, Criteria cri);

	MembershipDTO getCurrentMembership(String me_id);

	MembershipDTO getCurrentPT(String me_id);

	PaymentVO getpayment(int pa_num);

	RefundVO getRefund(int pa_num);

	List<MemberInquiryVO> getInquiryList(String me_email);

	MemberInquiryVO getInquiry(int mi_num);

	String checkPassword(MemberVO member);

	boolean isEmailDuplicate(String email);

	String updateMemberInfo(MemberVO member);

	String updateMemberPw(MemberVO member, String currentPw, String newPw);

	String removedMember(MemberVO member, String me_pw);

	String getSocial_id(MemberVO user, String social_type);

	String checkSocial(MemberVO member, String social_type);

	boolean unlinkSocialAccount(MemberVO user, String social_type);

	List<ReviewPostVO> getMypageReviewPostList(String me_id);

}
