package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 지점에 등록된 프로그램
 * 예: 
 * 프로그램 이름 : 요가
 * 담당 직원 : 1(김아무개)
 * 총 참가 가능 인원 : 12 ... 
 * */

@Data
@NoArgsConstructor
public class BranchProgramVO {
    private int bp_num;           // 프로그램 번호
    private int bp_total;         // 총 참가 가능 인원
    private String bp_br_name;    // 지점 이름
    private String bp_sp_name;    // 프로그램 이름
    private int bp_em_num;        // 담당 직원 번호
    
    private EmployeeVO employee;
}
