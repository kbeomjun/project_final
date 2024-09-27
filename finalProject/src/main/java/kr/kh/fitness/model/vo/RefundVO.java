package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 환불 내역 관리
 * 환불 요청한 날, 내부 Rule에 맞춰 환불 비율을 책정하고 결제한 금액에서 환불을 진행. 
 * 예 :	3달 사용 기간중 1달만 사용하고 환불 요청
 * 		환불 비율 = (결제한 금액 * 0.9)(1달<이용기간> / 3달<총 사용 가능기간>)  
 * */

@Data
@NoArgsConstructor
public class RefundVO {
	
    private int re_num;           // 환불 번호 
    private Date re_date;         // 환불일
    private int re_percent;       // 환불 비율
    private int re_price;         // 환불 금액
    private String re_reason;     // 환불 사유
    private int re_pa_num;        // 결제 번호
    
}
