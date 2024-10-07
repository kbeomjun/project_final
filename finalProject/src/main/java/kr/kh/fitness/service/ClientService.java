package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ReviewPostVO;

public interface ClientService {

	List<ReviewPostVO> getReviewPostList();

	void updateReviewPostView(int rp_num);

	ReviewPostVO getReviewPost(int rp_num);

	String checkMemberPayment(String me_id);

	List<PaymentVO> getPaymentList(String me_id);

	List<BranchVO> getBranchList();

	String insertReviewPost(ReviewPostVO review);

}
