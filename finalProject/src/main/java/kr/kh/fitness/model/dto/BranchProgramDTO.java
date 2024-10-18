package kr.kh.fitness.model.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
	지점 프로그램 객체
*/
@Data
@NoArgsConstructor
public class BranchProgramDTO {
	
	private int bp_num;			//프로그램번호
    private int bp_total;		// 총 참가 가능 인원
    private String bp_br_name;	// 지점 이름
    private String bp_sp_name;	// 프로그램 이름
    
    private String em_name;		// 직원 이름

    private String sp_type;		// 프로그램 타입(단일, 그룹)

    

}