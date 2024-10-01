package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.ProgramDAO;
import kr.kh.fitness.model.dto.ProgramScheduleDTO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.MemberVO;
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
	public boolean addProgramReservation(MemberVO user, Integer bs_num) {

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
		System.out.println(bps);
		// bps의 bp_num으로 bp를 불러온다.
		BranchProgramVO bp = programDao.selectBranchProgram(bps.getBs_bp_num());
		System.out.println(bp);

		// 총 인원과 현재 인원을 비교한다. 현재 인원이 같거나 크다면 예약 불가.
		if (bps.getBs_current() >= bp.getBp_total()) {
			return false;
		}

		List<ProgramReservationVO> pr_list = programDao.selectProgramReservationList(user);
		System.out.println(pr_list);

		// 기존 예약 리스트에서 동일한 시간에 예약이 있는 지 확인
		for (ProgramReservationVO pr : pr_list) {
			BranchProgramScheduleVO pr_bps = programDao.selectBranchProgramSchedule(pr.getPr_bs_num());
			// 기존에 예약된 프로그램의 끝나는 시간이 현재 예약하려는 프로그램의 시작 시간보다 이전이고
			// 끝나는 시간이 현재 예약하려는 프로그램의 시작 시간보다 이전이라면 가능
			if (pr_bps.getBs_start().compareTo(bps.getBs_start()) < 0) {
				if (pr_bps.getBs_end().compareTo(bps.getBs_start()) < 0) {
					continue;
				}
				// 현제 예약하려는 프로그램의 시작시간과 기존의 프로그램의 끝나는 시간이 같다면
				// 같은 지점일 경우에만 예약 가능.
				else if (pr_bps.getBs_end().compareTo(bps.getBs_start()) == 0) {
					if (pr_bps.getBs_bp_num() == bps.getBs_bp_num())
						continue;
				}
			}
			// 기존에 예약된 프로그램의 시작 시간의 현재 예약하려는 프로그램의 끝나는 시간 이후라면 가능
			if (pr_bps.getBs_start().compareTo(bps.getBs_end()) > 0) {
				continue;
			}
			// 기존에 예약된 프로그램의 시작 시간이 현재 예약하려는 프로그램의 끝나는 시간과 같다면 같은 지점만 가능
			else if (pr_bps.getBs_start().compareTo(bps.getBs_end()) == 0) {
				if (pr_bps.getBs_bp_num() == bps.getBs_bp_num())
					continue;
			}
			System.out.println("hell~");
			// 모두 해당이 안된다면 시간이 겹치는 것이므로 예약이 불가능
			return false;
		}

		try {
			// 디비에 예약 추가
			System.out.println("hell2~");
			boolean res = programDao.insertProgramReservationVO(user, bs_num);
			System.out.println("hell3~");
			if (res) {
				// bps에 current를 1추가한다.
				System.out.println("hell3.5~");
				programDao.updateBranchProgramScheduleCurrent(bps);
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

}
