package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 직원 정보
 * */

@Data
@NoArgsConstructor
public class EmployeeVO {
	private int em_num;               // 직원 번호
    private String em_name;           // 직원 이름
    private String em_phone;          // 직원 전화번호
    private String em_email;          // 직원 이메일
    private String em_gender;         // 직원 성별
    private String em_position;       // 직원 직책
    private Date em_join;             // 직원 입사일
    private String em_address;        // 직원 주소
    private String em_fi_name;        // 직원 사진 파일 이름
    private String em_br_name;        // 지점 이름
}
