package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 프로그램 정보에서 사용할 이미지 등록
 * */

@Data
@NoArgsConstructor
public class ProgramFileVO {
	private int pf_num;          // 
    private String pf_name;      // 파일 이름 (형식 : 경로+이름.확장자)
    private String pf_sp_name;   // 프로그램 이름
    
    public ProgramFileVO(String pf_name, String sp_name) {
    	this.pf_name = pf_name;
    	this.pf_sp_name = sp_name;
    }
}
