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
    private String pt_type;			// 결제 유형 (예: 1개월 이용권, 3개월 이용권, 6개월 이용권)
    private int pt_date;			// 결제 기간 (일수)
    private int pt_count;			// 결제 수량
    private int pt_price;			// 결제 가격 (원 단위)
    
    // 결제 관련 추가 필드
    // 추후에 payment_category로 빼낼 예정 pc_ 로 쓸 예정
    // private int pc_num;
    private String formattedPrice;	// 포맷된 가격 (예: 300,000원)
    private String imp_uid;			// 결제 고유 ID
    private String merchant_uid;	// 가맹점에서 설정한 주문 ID
    private String pg_tid;			// 결제 거래 ID
    private int pt_amount;			// 결제 총 금액
    private String pt_status;		// 결제 상태 (예: paid(결제완료), cancelled(결제취소))
    private long paid_at;			// 결제 완료 시간 (Unix Timestamp) 
    // 예시) paid_at : 1728525901 나오는데 Unix 타임스탬프(또는 Epoch 타임) 형식으로, 1970년 1월 1일 00:00:00 UTC부터 경과된 초의 수를 나타냄. 1728525901은 2024년 10월 10일 00:00:01 UTC에 해당함.
    private String card_name;		// 결제 카드 이름
    private long card_number;		// 결제 카드 번호
    private String card_quota;		// 결제 카드 할부 개월 수(0: 일시불, 2: 2개월 할부 등)
    private String pt_me_id;		// 사용자 ID
    private String pt_me_email;		// 사용자 Email
}
