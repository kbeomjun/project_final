package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 등록된 프로그램 정보
 * 예: 요가, 필라테스, 1:1PT 등등.. 
 * */
@Data
@NoArgsConstructor
public class SportsProgramVO {
    private String sp_name;       // 프로그램 이름
    private String sp_detail;     // 프로그램 상세 정보
    private String sp_type;       // 프로그램 유형 (1:1PT or else)
}
