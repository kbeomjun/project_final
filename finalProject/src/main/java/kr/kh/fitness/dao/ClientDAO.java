package kr.kh.fitness.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

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

public interface ClientDAO {

	MemberVO selectMember(String me_id);
	
	List<ReviewPostVO> selectReviewPostList();

	void updateReviewPostView(int rp_num);

	ReviewPostVO selectReviewPost(int rp_num);

	List<PaymentVO> checkMemberPayment(String me_id);

	List<BranchVO> selectBranchList();

	boolean insertReviewPost(ReviewPostVO review);

	void updatePaymentReview(int pa_num);

	boolean updateReviewPost(ReviewPostVO review);

	boolean deleteReviewPost(int rp_num);

	List<MemberInquiryVO> selectFaqList(@Param("ca")String category, @Param("cri")Criteria cri);
	
	int selectFaqTotalCount(@Param("ca")String category, @Param("cri")Criteria cri);

	List<InquiryTypeVO> selectInquiryTypeList();
	
	boolean insertInquiry(MemberInquiryVO inquiry);

	List<BranchProgramScheduleVO> selectReservationList(@Param("view")String view, @Param("me_id")String me_id);

	ProgramReservationVO selectReservation(int pr_num);

	boolean deleteReservation(int pr_num);

	void updateScheduleCurrent(int bs_num);

	List<PaymentVO> selectPaymentList(@Param("me_id")String me_id, @Param("cri")Criteria cri);

	int selectPaymentTotalCount(String me_id);

	MembershipDTO selectCurrentMembership(String me_id);

	MembershipDTO selectCurrentPT(String me_id);

	int selectScheduledPT(@Param("me_id")String me_id, @Param("pa_start")Date pa_start, @Param("pa_end")Date pa_end);

	PaymentVO selectPayment(int pa_num);

	RefundVO selectRefund(int pa_num);

	List<MemberInquiryVO> selectInquiryList(String me_email);

	MemberInquiryVO selectInquiry(int mi_num);

	int isEmailDuplicate(String email);

	boolean updateMemberInfo(MemberVO member);

	boolean updateMemberPw(MemberVO member);

	boolean updateMemberStatusToRemoved(MemberVO member);

	MemberVO selectMemberFromSocial(@Param("user")MemberVO member, @Param("social_type")String social_type);

	String selectSocialId(@Param("me_id")String me_id, @Param("social_type")String social_type);

	int updateSocialIdSetNull(@Param("user")MemberVO user, @Param("social_type")String social_type);

	List<ReviewPostVO> selectMypageReviewPostList(String me_id);

}
