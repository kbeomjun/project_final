package kr.kh.fitness.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.BranchDAO;
import kr.kh.fitness.model.vo.BranchFileVO;
import kr.kh.fitness.model.vo.BranchVO;
import kr.kh.fitness.model.vo.EmployeeVO;

@Service
public class BranchServiceImp implements BranchService{

	@Autowired
	private BranchDAO branchDao;

	@Override
	public List<BranchVO> getBranchList() {
		
		return branchDao.selectBranchList();
	}

	@Override
	public List<EmployeeVO> getEmployeeList(String br_name) {
		return branchDao.selectEmployeeList(br_name);
	}

	@Override
	public List<BranchFileVO> getBranchImageList(String br_name) {
		return branchDao.selectBranchImageList(br_name);
	}
	
	
}
