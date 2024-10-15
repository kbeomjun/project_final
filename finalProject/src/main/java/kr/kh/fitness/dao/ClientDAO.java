package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberInquiryVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.RefundVO;
import kr.kh.fitness.model.vo.ReviewPostVO;
import kr.kh.fitness.pagination.Criteria;

public interface ClientDAO {

	MemberVO selectMember(String me_id);
	
	List<ReviewPostVO> selectReviewPostList(Criteria cri);

	void updateReviewPostView(int rp_num);

	ReviewPostVO selectReviewPost(int rp_num);

	List<PaymentVO> checkMemberPayment(String me_id);

	List<BranchVO> selectBranchList();

	boolean insertReviewPost(ReviewPostVO review);

	void updatePaymentReview(int pa_num);

	boolean updateReviewPost(ReviewPostVO review);

	boolean deleteReviewPost(int rp_num);

	int selectReviewPostTotalCount(Criteria cri);

	List<InquiryTypeVO> selectInquiryTypeList();
	
	boolean insertInquiry(MemberInquiryVO inquiry);

	List<BranchProgramScheduleVO> selectReservationList(@Param("view")String view, @Param("me_id")String me_id, @Param("cri")Criteria cri);

	int selectScheduleTotalCount(@Param("view")String view, @Param("me_id")String me_id, @Param("cri")Criteria cri);

	boolean deleteReservation(int pr_num);

	void updateScheduleCurrent(int bs_num);

	List<PaymentVO> selectPaymentList(@Param("me_id")String me_id, @Param("cri")Criteria cri);

	int selectPaymentTotalCount(String me_id);

	RefundVO selectRefund(int pa_num);

	List<MemberInquiryVO> selectInquiryList(@Param("me_email")String me_email, @Param("cri")Criteria cri);

	int selectInquiryTotalCount(String me_email);

	MemberInquiryVO selectInquiry(int mi_num);

	int isEmailDuplicate(String email);

	boolean updateMemberInfo(MemberVO member);

	boolean updateMemberPw(MemberVO member);

}
