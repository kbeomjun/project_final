package kr.kh.fitness.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;

public interface BranchDAO {

	List<BranchVO> selectBranchList();

	List<EmployeeVO> selectEmployeeList(@Param("br_name") String br_name);

	List<BranchFileVO> selectBranchImageList(@Param("br_name")String br_name);
	
}
