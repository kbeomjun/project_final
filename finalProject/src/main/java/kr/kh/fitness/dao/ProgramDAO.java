package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.dto.ProgramScheduleDTO;
import kr.kh.fitness.model.vo.BranchProgramScheduleVO;
import kr.kh.fitness.model.vo.BranchProgramVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.ProgramReservationVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface ProgramDAO {

	List<SportsProgramVO> selectProgramList();

	List<BranchVO> selectBranchList();

	List<ProgramScheduleDTO> selectProgramSchedule(@Param("searchMonth") String searchMonth, @Param("br_name") String br_name, @Param("pr_name") String pr_name);

	List<ProgramReservationVO> selectProgramReservationList(@Param("user") MemberVO user);

	BranchProgramScheduleVO selectBranchProgramSchedule(@Param("bs_num")Integer bs_num);

	BranchProgramVO selectBranchProgram(@Param("bp_num")int bs_num);

	boolean insertProgramReservationVO(@Param("user")MemberVO user, @Param("bs_num")Integer bs_num);

	void updateBranchProgramScheduleCurrent(@Param("bps")BranchProgramScheduleVO bps);

	ProgramReservationVO selectProgramReservation(@Param("user")MemberVO user, @Param("bs_num")int bs_num);

}
