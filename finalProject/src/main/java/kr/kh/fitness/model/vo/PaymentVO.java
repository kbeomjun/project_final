package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 회원권, 1:1 PT 결제 내역을 저장. 
 * */

@Data
@NoArgsConstructor
public class PaymentVO {
	
    private int pa_num;          // 결제 번호 
    private Date pa_date;        // 결제한 날짜
    private int pa_price;        // 결제 금액
    private Date pa_start;       // 회원권(혹은 1:1PT) 시작 기간
    private Date pa_end;         // 회원권(혹은 1:1PT) 종료 기간
    private char pa_review;      // 리뷰 작성했는 지 여부 (default: 'N') 'N' or 'Y'
    private String pa_state;     // 결제 상태 ('결제완료' or ...) 
    private String pa_me_id;     // 회원 ID
    private int pa_pt_num;       // 결제 유형 번호
    
    private String pt_name;
}
