package kr.kh.fitness.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 회원권, 1:1 PT 등 결제할 수 있는 상품의 종류
 * */

@Data
@NoArgsConstructor
@AllArgsConstructor // 매개변수를 받는 생성자 추가
public class PaymentTypeVO {
	
 	private int pt_num;          // 결제 유형 번호
    private String pt_type;      // 결제 유형 ( 1개월 이용권, 3개월 이용권, 6개월 이용권 ..  )
    private int pt_date;         // 결제 유형 날짜
    private int pt_count;        // 결제 유형 수량
    private int pt_price;        // 결제 유형 가격
    
    // 추가된 필드
    private String formattedPrice; // 포맷된 가격을 저장할 필드
    private int amount;            // 결제 금액을 저장할 필드 추가
    private String imp_uid;        // 결제 고유 ID를 저장할 필드 추가
    private String status;        // 결제 고유 ID를 저장할 필드 추가
    
}
