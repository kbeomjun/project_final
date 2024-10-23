<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>스케줄 수정</title>
<style type="text/css">
	.form-control{
		width: 100%;
		border-collapse: collapse;
		margin-top: 10px;	
	}
</style>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">스케줄 수정</h2>
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
							<input class="form-control" value="<fmt:formatDate value="${schedule.bs_start}" pattern="MM월dd일"/> <fmt:formatDate value="${schedule.bs_start}" pattern="HH"/>-<fmt:formatDate value="${schedule.bs_end}" pattern="HH시"/>" readonly/>
						</div>
						<div class="form-group">
							<label>수정날짜:</label>
							<input class="form-control" type="date" id="currentDate" name="date" value="<fmt:formatDate value='${schedule.bs_start}' pattern='yyyy-MM-dd'/>" />
						</div>
						
						<div class="form-group row">
							<div class="col-md-6">
								<label>수정시작시간:</label>
								<input class="form-control" type="time" id="startTime" name="startTime" step="3600" value="<fmt:formatDate value='${schedule.bs_start}' pattern='HH:mm'/>" />
							</div>
							<div class="col-md-6">
								<label>수정마감시간:</label>
								<input class="form-control" type="time" id="endTime" name="endTime" step="3600" value="<fmt:formatDate value='${schedule.bs_end}' pattern='HH:mm'/>" />
							</div>
						</div>
					    <button type="submit" class="btn btn-outline-success col-12">수정</button>
					</form>
					<hr>
				    <a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-danger col-12">취소</a>
	                
	            </div>
	        </main>
	    </div>
	</div>

			
	<script>
		// 현재 날짜 계산
		var today = new Date();
		var lastDay = new Date();
		lastDay.setDate(today.getDate() + 30); // 현재 날짜에서 30일 더함

		// 오늘 날짜 포맷팅 (YYYY-MM-DD)
		var formattedToday = today.toISOString().substring(0, 10);
		var formattedLastDay = lastDay.toISOString().substring(0, 10);

	    var currentDateField = document.getElementById('currentDate');
	    var startTimeField = document.getElementById('startTime');
	    var endTimeField = document.getElementById('endTime');

	    // 만약 input 값이 없으면 기본값 설정
	    if (!currentDateField.value) {
	        currentDateField.value = formattedToday;
	        currentDateField.min = formattedToday;
	        currentDateField.max = formattedLastDay;
	    }
		
	    // 시간 필드에 시작 시간 및 마감 시간 설정 (분 단위 00 고정)
	    if (!startTimeField.value) {
	        startTimeField.value = "09:00";
	        startTimeField.min = "09:00";
	        startTimeField.max = "19:00";
	    }

	    if (!endTimeField.value) {
	        endTimeField.value = "10:00";
	        endTimeField.min = "10:00";
	        endTimeField.max = "20:00";
	    }
		
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
