package kr.kh.fitness.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 리뷰 게시판
 * - 결제 내역이 있어야만 게시판을 작성 가능
 * */

@Data
@NoArgsConstructor
public class ReviewPostVO {
	
    private int rp_num;          // 리뷰 번호
    private String rp_title;     // 리뷰 제목
    private String rp_content;   // 리뷰 내용
    private Date rp_date;        // 리뷰 작성일
    private int rp_view;         // 조회 수
    private String rp_br_name;   // 지점 이름
    private int rp_pa_num;       // 결제 번호

}
