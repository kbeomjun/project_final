package kr.kh.fitness.model.dto;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProgramScheduleDTO{

    private int bs_num;          // 스케줄 번호
    
    private Date bs_start;       // 시작일
    private Date bs_end;         // 종료일
    private int bs_current;      // 현재 참가자 수
	    
    private int bp_total;        // 총 참가 가능 인원
    private String bp_br_name;   // 지점 이름
    private String bp_sp_name;   // 프로그램 이름
    
    private String em_name;      // 직원 이름
    private String em_gender;    // 직원 성별
}

