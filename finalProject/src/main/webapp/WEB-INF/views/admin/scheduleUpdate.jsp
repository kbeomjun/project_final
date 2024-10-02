<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>스케줄 수정</title>
</head>
<body>
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">스케줄 수정</h1>
		<form action="<c:url value="/admin/schedule/update"/>" method="post" id="form">
			<input type="hidden" name="br_name" value="${schedule.bp_br_name}">
			<input type="hidden" name="bs_bp_num" value="${schedule.bs_bp_num}">
			<input type="hidden" name="bs_num" value="${schedule.bs_num}">
			
			<div class="form-group">
				<label>프로그램:</label>
				<input class="form-control" value="${schedule.bp_sp_name}(${schedule.em_name}, ${schedule.bp_total}인)" readonly>
			</div>
			<div class="form-group">
				<label>현재일정:</label>
				<input class="form-control" value="<fmt:formatDate value="${schedule.bs_start}" pattern="MM월dd일"/> <fmt:formatDate value="${schedule.bs_start}" pattern="hh"/>-<fmt:formatDate value="${schedule.bs_end}" pattern="hh시"/>" readonly/>
			</div>
			<div class="form-group">
				<label>수정날짜:</label>
				<input type="date" id="currentDate" name="date"/>
			</div>
			
			<div class="form-group">
				<label>수정시작시간:</label>
				<input type="time" id="startTime" name="startTime" step="3600"/>
			</div>
			
			<div class="form-group">
				<label>수정마감시간:</label>
				<input type="time" id="endTime" name="endTime" step="3600"/>
			</div>
			
			<div class="text-right mb-3">
				<button type="submit" class="btn btn-outline-warning">수정</button>
			</div>
		</form>
	<!-- </main> -->

	<script>
		// 현재 날짜 계산
		var today = new Date();
		var lastDay = new Date();
		lastDay.setDate(today.getDate() + 30); // 현재 날짜에서 30일 더함

		// 오늘 날짜 포맷팅 (YYYY-MM-DD)
		var formattedToday = today.toISOString().substring(0, 10);
		var formattedLastDay = lastDay.toISOString().substring(0, 10);

		// input 필드의 min과 max 값을 설정
		document.getElementById('currentDate').value = formattedToday;
		document.getElementById('currentDate').min = formattedToday;
		document.getElementById('currentDate').max = formattedLastDay;
		
		// 시간 필드에 시작 시간 및 마감 시간 설정 (분 단위 00 고정)
		var startTimeField = document.getElementById('startTime');
		var endTimeField = document.getElementById('endTime');

		// 기본 시작 시간과 마감 시간 (예: 09:00, 10:00)
		var defaultStartTime = "09:00";
		var defaultEndTime = "10:00";

		// 시간 필드 설정
		startTimeField.value = defaultStartTime;
		startTimeField.min = "09:00";
		startTimeField.max = "19:00";

		endTimeField.value = defaultEndTime;
		endTimeField.min = "10:00";
		endTimeField.max = "20:00";	
		
		// 시간 선택 시, 분을 항상 00으로 설정
		startTimeField.addEventListener('input', function() {
			var time = this.value.split(":");
			this.value = time[0] + ":00"; // 분을 00으로 고정
		});

		endTimeField.addEventListener('input', function() {
			var time = this.value.split(":");
			this.value = time[0] + ":00"; // 분을 00으로 고정
		});		
	</script>			
</body>
</html>
