package kr.kh.fitness.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

/*
	year: 현재 달력이 표시하는 연도
	month: 현재 달력이 표시하는 월. (값 :0 ~11)
	day: 달력에서 현재 선택된 날짜
	firstDay: 현재 달의 첫 번째 날의 요일, 만약 1일이 수요일이라면, 이 변수의 값은 4입니다.
	lastDate: 현재 달의 마지막 날짜, 2월의 경우 윤년에는 29일, 평년에는 28일이 됩니다.
	startBlankCnt: 현재 달의 첫 번째 날이 위치하는 요일 이전에 표시해야 할 빈 공간의 개수
	endBlankCnt: 현재 달의 마지막 날짜 이후에 표시해야 할 빈 공간의 개수
	tdCnt: 달력에서 표시해야 할 총 <td>(테이블 데이터) 셀의 개수, (startBlankCnt + lastDate + endBlankCnt)
*/

@Data
@NoArgsConstructor
public class CalendarDTO {

	private int year;
	private int month;
	private int day;
	private int firstDay;
	private int lastDate;
	private int startBlankCnt;
	private int endBlankCnt;
	private int tdCnt;

}

