package kr.kh.fitness.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MembershipDTO {

	private Date pa_start;			//시작날짜
	private Date pa_end;			//마감날짜
	private int total_count;		//전체 횟수
	private int remain_count;		//남은 횟수
}
