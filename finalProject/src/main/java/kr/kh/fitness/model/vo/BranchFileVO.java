package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 지점 이미지 파일
 * */
@Data
@NoArgsConstructor
public class BranchFileVO {
    private int bf_num;         // 파일 번호
    private String bf_name;     // 파일 이름 (형식 : 경로+이름.확장자)
    private String bf_br_name;	// 지점 이름
}
