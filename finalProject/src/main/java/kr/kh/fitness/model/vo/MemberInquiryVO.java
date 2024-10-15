package kr.kh.fitness.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 1:1 문의
 * */

@Data
@NoArgsConstructor
public class MemberInquiryVO {
	
    private int mi_num;          // 문의 번호 
    private String mi_title;     // 문의 제목
    private String mi_content;   // 문의 내용
    private String mi_state;     // 문의 상태 (default: '답변대기중')
    private String mi_email;     // 회원 이메일
    @DateTimeFormat(pattern = "yyyy.MM.dd")
    private Date mi_date;        // 문의 작성일
    private String mi_br_name;   // 지점 이름
    private String mi_it_name;   // 문의 유형 이름
    private String mi_answer;
    
}
