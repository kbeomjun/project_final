package kr.kh.fitness.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentDetailsDTO {
	// 회원권 정보
	private String firstStartDate;
	private String lastEndDate;
	private boolean isRePayment;
    private LocalDate newStartDate;
    
    // PT 관련 정보 추가
    private String ptFirstStartDate; // PT 첫 시작일
    private String ptLastEndDate; // PT 만료일
    private boolean isRePaymentForPT;
}
