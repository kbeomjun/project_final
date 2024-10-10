package kr.kh.fitness.model.dto;

import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PaymentRequestDTO {
	private PaymentTypeVO paymentType;
    private PaymentCategoryVO paymentCategory;
}
