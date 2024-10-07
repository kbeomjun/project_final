package kr.kh.fitness.service;

import java.util.List;

import kr.kh.fitness.model.dto.ProgramReservationMessage;
import kr.kh.fitness.model.dto.ProgramScheduleDTO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.SportsProgramVO;

public interface BranchService {

	List<BranchVO> getBranchList();

	List<EmployeeVO> getEmployeeList(String br_name);

	List<String> getImageName(String br_name);


}
