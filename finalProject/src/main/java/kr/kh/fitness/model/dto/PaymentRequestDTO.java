package kr.kh.fitness.model.dto;

import kr.kh.fitness.model.vo.PaymentHistoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor // 기본 생성자 추가
public class PaymentRequestDTO {
	private PaymentVO payment;
	private PaymentTypeVO paymentType;
    private PaymentHistoryVO paymentHistory;
}
