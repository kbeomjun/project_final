package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 지점 정보
 * */
@Data
@NoArgsConstructor
public class BranchVO {
	private String br_name;			// 지점 이름
    private String br_phone;		// 지점 전화번호
    private String br_postcode;		// 지점 우편번호
    private String br_address;		// 지점 주소
    private String br_detailAddress;// 지점 상세주소
    private String br_extraAddress;	// 지점 추가주소
    private String br_detail;		// 지점 상세 정보
}
