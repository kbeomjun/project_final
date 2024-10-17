package kr.kh.fitness.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 회원권, 1:1 PT 등 결제할 수 있는 상품의 종류
 * */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentTypeVO {
	
    private int pt_num;				// 결제 유형 번호
    private String pt_name;
    private String pt_type;			// 결제 유형 (예: 1개월 이용권, 3개월 이용권, 6개월 이용권)
    private int pt_date;			// 결제 기간 (일수)
    private int pt_count;			// 결제 수량
    private int pt_price;			// 결제 가격 (원 단위)
    
    // 결제 관련 추가 필드
    private String formattedPrice;	// 포맷된 가격 (예: 300,000원)
    
    // PaymentCategoryVO 타입의 필드 추가
    private PaymentCategoryVO paymentCategory;

}
