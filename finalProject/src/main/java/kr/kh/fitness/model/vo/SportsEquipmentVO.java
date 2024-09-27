package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 헬스기구 정보
 * */
@Data
@NoArgsConstructor
public class SportsEquipmentVO {
	
    private String se_name;      // 장비 이름
    private String se_fi_name;    // 파일 이름
    
}
