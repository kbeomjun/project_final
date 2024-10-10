package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.ClientDAO;
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

@Service
public class ClientServiceImp implements ClientService{
	
	@Autowired
	private ClientDAO clientDao;

	@Override
	public MemberVO getMember(String me_id) {
		if(me_id == null) {
			return null;
		}
		return clientDao.selectMember(me_id);
	}
	
	@Override
	public List<ReviewPostVO> getReviewPostList(Criteria cri) {
		if(cri == null) {
			return null;
		}
		return clientDao.selectReviewPostList(cri);
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
	public PageMaker getPageMakerInReview(Criteria cri) {
		if(cri == null) {
			return null;
		}
		int totalCount = clientDao.selectReviewPostTotalCount(cri);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public List<InquiryTypeVO> getInquiryTypeList() {
		return clientDao.selectInquiryTypeList();
	}

	@Override
	public List<BranchProgramScheduleVO> getReservationList(String view, String me_id, Criteria cri) {
		if(me_id == null) {
			return null;
		}
		if(cri == null) {
			return null;
		}
		return clientDao.selectReservationList(view, me_id, cri);
	}

	@Override
	public PageMaker getPageMakerInSchedule(String view, String me_id, Criteria cri) {
		if(me_id == null) {
			return null;
		}
		if(cri == null) {
			return null;
		}
		int totalCount = clientDao.selectScheduleTotalCount(view, me_id, cri);
		return new PageMaker(3, cri, totalCount);
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
	public List<PaymentVO> getPaymentList(String me_id, Criteria cri) {
		if(me_id == null) {
			return null;
		}
		if(cri == null) {
			return null;
		}
		return clientDao.selectPaymentList(me_id, cri);
	}

	@Override
	public PageMaker getPageMakerInMemberShip(String me_id, Criteria cri) {
		if(me_id == null) {
			return null;
		}
		if(cri == null) {
			return null;
		}
		int totalCount = clientDao.selectPaymentTotalCount(me_id);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public RefundVO getRefund(int pa_num) {
		return clientDao.selectRefund(pa_num);
	}

	@Override
	public List<MemberInquiryVO> getInquiryList(String me_email, Criteria cri) {
		if(me_email == null) {
			return null;
		}
		if(cri == null) {
			return null;
		}
		return clientDao.selectInquiryList(me_email, cri);
	}

	@Override
	public PageMaker getPageMakerInInquiry(String me_email, Criteria cri) {
		if(me_email == null) {
			return null;
		}
		if(cri == null) {
			return null;
		}
		int totalCount = clientDao.selectInquiryTotalCount(me_email);
		return new PageMaker(3, cri, totalCount);
	}

	@Override
	public MemberInquiryVO getInquiry(int mi_num) {
		return clientDao.selectInquiry(mi_num);
	}

}
