package kr.kh.fitness.model.dto;

import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor // 기본 생성자 추가
public class PaymentRequestDTO {
	private PaymentTypeVO paymentType;
    private PaymentCategoryVO paymentCategory;
}
