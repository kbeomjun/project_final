package kr.kh.fitness.model.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
	스케쥴 등록시 정보를 받아올 객체
*/
@Data
@NoArgsConstructor
public class ProgramInsertFormDTO {
	
	private String bp_br_name;			// 프로그램이 등록된 지점의 이름
	private int bs_bp_num;				// 지점에 등록된 스케쥴 번호
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date selectDate;				// 선택된 날짜 PT일 경우 사용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;				// 스케쥴 시작 날짜
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;				// 스케쥴 마감 날짜
	private List<Integer> weeks;		// 무슨 요일에 할 지 1~6: 일~토
	private List<Integer> hours;		// 시간 선택하기
	
	private String me_id;
	private String sp_type;				// 스포츠의 타입. 

}