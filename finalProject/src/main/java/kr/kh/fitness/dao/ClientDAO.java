package kr.kh.fitness.dao;

import java.util.List;

import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ReviewPostVO;
import kr.kh.fitness.pagination.Criteria;

public interface ClientDAO {

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

}
