package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 회원권, 1:1 PT 등 결제할 수 있는 상품의 종류
 * */

@Data
@NoArgsConstructor
public class PaymentTypeVO {
	
 	private int pt_num;          // 결제 유형 번호
    private String pt_type;      // 결제 유형 ( 1개월 이용권, 3개월 이용권, 6개월 이용권 ..  )
    private int pt_date;         // 결제 유형 날짜
    private int pt_count;        // 결제 유형 수량
    private int pt_price;        // 결제 유형 가격
	    
}
