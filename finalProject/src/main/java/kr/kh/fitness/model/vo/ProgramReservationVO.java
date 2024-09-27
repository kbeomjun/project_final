package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 회원이 예약한 프로그램 정보를 저장
 * */

@Data
@NoArgsConstructor
public class ProgramReservationVO {
	
    private int pr_num;          // 예약 번호
    private Date pr_date;        // 예약일
    private String pr_me_id;     // 회원 ID
    private int pr_bs_num;       // 예약한 지점의 프로그램 번호

}
