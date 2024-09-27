package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 헬스 기구 발주 정보
 * */

@Data
@NoArgsConstructor
public class BranchOrderVO {
	
    private int bo_num;           // 주문 번호 
    private int bo_amount;        // 주문 수량
    private String bo_state;      // 주문 상태
    private Date bo_date;         // 주문일
    private String bo_br_name;    // 지점 이름
    private String bo_se_name;    // 헬스 기구 이름

}
