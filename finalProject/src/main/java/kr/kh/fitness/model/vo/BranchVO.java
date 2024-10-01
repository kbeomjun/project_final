package kr.kh.fitness.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 지점 정보
 * */
@Data
@NoArgsConstructor
public class BranchVO {
	private String br_name;      // 지점 이름
    private String br_phone;     // 지점 전화번호
    private String br_postcode;
    private String br_address;   // 지점 주소
    private String br_detailAddress;
    private String br_extraAddress;
    private String br_detail;    // 지점 상세 정보
    private String br_admin;
}
