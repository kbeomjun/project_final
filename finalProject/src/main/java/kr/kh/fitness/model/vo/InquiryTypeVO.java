package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 1:1문의에서 어떤 유형으로 문의 하는 지 (VO로 안쓸 것 같은데 일단 추가)
 * */

@Data
@NoArgsConstructor
public class InquiryTypeVO {
	
	    private String it_name;      // 문의 유형 이름 (예 : 서비스 문의, 기구 문의, PT체험 문의)
	    
}
