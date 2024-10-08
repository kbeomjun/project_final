package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.InquiryTypeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.model.vo.ProgramReservationVO;
import kr.kh.fitness.model.vo.ReviewPostVO;
import kr.kh.fitness.pagination.Criteria;
import kr.kh.fitness.pagination.PageMaker;

public interface ClientService {
	
	MemberVO getMember(String me_id);

	List<ReviewPostVO> getReviewPostList(Criteria cri);

	void updateReviewPostView(int rp_num);

	ReviewPostVO getReviewPost(int rp_num);

	String checkMemberPayment(String me_id);

	List<PaymentVO> getPaymentList(String me_id);

	List<BranchVO> getBranchList();

	String insertReviewPost(ReviewPostVO review);

	String updateReviewPost(ReviewPostVO review);

	String deleteReviewPost(int rp_num);

	PageMaker getPageMaker(Criteria cri);

	List<InquiryTypeVO> getInquiryTypeList();

	List<BranchProgramScheduleVO> getReservationList(String me_id);

}
