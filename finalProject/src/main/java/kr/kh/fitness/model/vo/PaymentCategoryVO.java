package kr.kh.fitness.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 결제 유형. 결제 된 값들에 대한 VO
 * */
@Data
@NoArgsConstructor
//@AllArgsConstructor
public class PaymentCategoryVO {
	
    private int pc_num;                   // 결제 카테고리 번호
    private String pc_imp_uid;            // 결제 고유 ID
    private String pc_merchant_uid;       // 가맹점에서 설정한 주문 ID
    private String pc_pg_tid;              // 결제 거래 ID
    private String pc_status;              // 결제 상태 (예: paid(결제완료), cancelled(결제취소))
    private int pc_amount;                 // 결제 총 금액
    private long pc_paid_at;               // 결제 완료 시간 (Unix Timestamp) 
    // 예시) paid_at : 1728525901 나오는데 Unix 타임스탬프(또는 Epoch 타임) 형식으로, 1970년 1월 1일 00:00:00 UTC부터 경과된 초의 수를 나타냄. 1728525901은 2024년 10월 10일 00:00:01 UTC에 해당함.
    private String pc_card_name;           // 결제 카드 이름
    private long pc_card_number;           // 결제 카드 번호
    private String pc_card_quota;          // 결제 카드 할부 개월 수 (0: 일시불, 2: 2개월 할부 등)
    private String pc_me_id;               // 사용자 ID (외부 키)
    private String pc_me_email;            // 사용자 이메일
    private int pc_pt_num;                 // 결제 이용권 번호 (외부 키)
    
}
