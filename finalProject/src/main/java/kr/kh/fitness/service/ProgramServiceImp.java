package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.ProgramDAO;
import kr.kh.fitness.model.dto.ProgramReservationMessage;
import kr.kh.fitness.model.dto.ProgramScheduleDTO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.ProgramFileVO;
import kr.kh.fitness.model.vo.ProgramReservationVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

@Service
public class ProgramServiceImp implements ProgramService {

	@Autowired
	private ProgramDAO programDao;

	@Override
	public List<SportsProgramVO> getProgramList() {

		return programDao.selectProgramList();
	}

	@Override
	public List<BranchVO> getBranchList() {

		return programDao.selectBranchList();
	}

	@Override
	public List<ProgramScheduleDTO> getProgramSchedule(String searchMonth, String br_name, String pr_name) {

		if (br_name == null || br_name.equals("null"))
			br_name = "";
		if (pr_name == null || pr_name.equals("null"))
			pr_name = "";

		return programDao.selectProgramSchedule(searchMonth, br_name, pr_name);
	}

	@Override
	public ProgramReservationMessage addProgramReservation(MemberVO user, Integer bs_num) {
		
		ProgramReservationMessage rm = new ProgramReservationMessage();
		
		user = new MemberVO();
		user.setMe_id("user1");

//		if(user == null) {
//			return false;
//		}

		// noshow 횟수가 초과되지 않았는지 확인
//		if (user.getMe_noshow() >= 5) {
//			return false;
//		}

		// bs_num으로 bps를 불러온다.
		BranchProgramScheduleVO bps = programDao.selectBranchProgramSchedule(bs_num);

		// bps의 bp_num으로 bp를 불러온다.
		BranchProgramVO bp = programDao.selectBranchProgram(bps.getBs_bp_num());

		// 총 인원과 현재 인원을 비교한다. 현재 인원이 같거나 크다면 예약 불가.
		if (bps.getBs_current() >= bp.getBp_total()) {
			rm.setResult(false);
			rm.setMessage("정원 초과");
			return rm;
		}

		// 회원의 예약 리스트
		List<ProgramReservationVO> pr_list = programDao.selectProgramReservationList(user);
		
		// System.out.println("bps.getBs_start().getTime() :" +bps.getBs_start() +"/"+ bps.getBs_start().getTime());
		// 기존 예약 리스트에서 동일한 시간에 예약이 있는 지 확인
		for (ProgramReservationVO prev_pr : pr_list) {
			BranchProgramScheduleVO prev_pr_bps = programDao.selectBranchProgramSchedule(prev_pr.getPr_bs_num());
			// 기존에 예약된 프로그램의 끝나는 시간이 현재 예약하려는 프로그램의 시작 시간보다 이전이면 가능
			if (prev_pr_bps.getBs_end().getTime() < bps.getBs_start().getTime()) {
				continue;
			}
			
			// 기존에 예약된 프로그램의 끝나는 시간이 현재 예약하려는 프로그램의 시작 시간이 같다면 같은 지점만 가능
			if (prev_pr_bps.getBs_end().getTime() == bps.getBs_start().getTime()) {
				if (prev_pr_bps.getBs_bp_num() == bps.getBs_bp_num())
					continue;
			}

			// 기존에 예약된 프로그램의 시작 시간이 현재 예약하려는 프로그램의 끝나는 시간 이후라면 가능
			if (prev_pr_bps.getBs_start().getTime() > bps.getBs_end().getTime()) {
				continue;
			}
			
			// 기존에 예약된 프로그램의 시작 시간이 현재 예약하려는 프로그램의 끝나는 시간과 같다면 같은 지점만 가능
			if (prev_pr_bps.getBs_start().getTime() == bps.getBs_end().getTime()) {
				if (prev_pr_bps.getBs_bp_num() == bps.getBs_bp_num())
					continue;
			}

			// 모두 해당이 안된다면 시간이 겹치는 것이므로 예약이 불가능
			rm.setResult(false);
			rm.setMessage("이미 예약한 프로그램과 시간이 겹침");
			return rm;
		}

		try {
			// 디비에 예약 추가
			boolean res = programDao.insertProgramReservationVO(user, bs_num);
			if (res) {
				// bps에 current를 1추가한다.
				programDao.updateBranchProgramScheduleCurrent(bps);
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			rm.setResult(false);
			rm.setMessage("예약 등록중 에러 발생");
			return rm;
		}
		
		rm.setResult(true);
		rm.setMessage("예약 등록 성공");
		return rm;
	}

	@Override
	public boolean checkReservation(MemberVO user, int bs_num) {
		
		user = new MemberVO();
		user.setMe_id("user1");
		
//		if(user == null) {
//			return false;
//		}
		
		ProgramReservationVO pr = programDao.selectProgramReservation(user, bs_num);
		
		if(pr == null) {
			return false;
		}
		
		return true;
	}

	@Override
	public List<String> getImageName(String pr_name) {
		
		return programDao.selectProgramFileList(pr_name);
	}

}
