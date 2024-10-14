<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>스케줄 등록</title>
<style type="text/css">
	table {
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
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">지점관리자 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/program/list"/>">프로그램관리</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/admin/schedule/list"/>">프로그램일정관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/order/list"/>">운동기구 발주목록</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/employee/list"/>">직원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/member/list"/>">회원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/branch/detail"/>">지점 상세보기</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/equipment/list"/>">운동기구 보유목록</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/equipment/change"/>">운동기구 재고 변동내역</a>
	                    </li>	                    	                    	                    	                    	                    
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${branchName} 스케줄 등록</h2>
					<form action="<c:url value="/admin/schedule/insert"/>" method="post" id="form">
						<input type="hidden" name="bp_br_name" value="${branchName}">
						
						<div class="form-group">
							<label>프로그램:</label>
							<select class="form-control" name="bs_bp_num" id="programSelect">
								<c:forEach items="${programList}" var="list">
									<option value="${list.bp_num}" data-sp-type="${list.program.sp_type}">
										${list.bp_sp_name}(${list.employee.em_name}, ${list.bp_total}인)
									</option>
								</c:forEach>		
							</select>
						</div>
						
						<div class="form-group">
							<label>날짜:</label>
							<input type="date" id="currentDate" name="date"/>
						</div>
						
						<div class="form-group">
							<label>시작시간:</label>
							<input type="time" id="startTime" name="startTime" step="3600"/>
						</div>
						
						<div class="form-group">
							<label>마감시간:</label>
							<input type="time" id="endTime" name="endTime" step="3600"/>
						</div>
						
						<!-- 회원 선택 테이블 -->
						<div class="form-group" id="memberListTable" style="display: none;">
							<label>회원 선택:</label>
							<table class="table text-center">
								<thead>
									<tr>
										<th></th>
										<th>회원 이름</th>
										<th>번호</th>
										<th>이메일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${memberList}" var="member">
										<tr>
											<td>
												<input type="radio" name="me_id" value="${member.me_id}"/>
											</td>
											<td>${member.me_name} (${member.me_gender})</td>
											<td>${member.me_phone}</td>
											<td>${member.me_email}</td>
										</tr>
									</c:forEach>
									<c:if test="${memberList.size() eq 0}">
										<tr>
											<th class="text-center" colspan="4">등록된 회원이 없습니다.</th>
										</tr>
									</c:if>						
								</tbody>
							</table>
						</div>		
						
						<div class="text-right mb-3">
							<button type="submit" class="btn btn-outline-success">등록</button>
						</div>
					</form>
	                
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
		
		// 시작 시간과 마감 시간 비교 로직
		function validateTime() {
			var startTime = startTimeField.value;
			var endTime = endTimeField.value;

			if (startTime >= endTime) {
				alert("시작시간은 마감시간보다 빨라야 합니다.");
				return false; // 유효하지 않으면 폼 제출을 막음
			}
			return true; // 유효하면 제출 허용
		}

		// 폼 제출 시 유효성 검사 추가
		document.getElementById('form').addEventListener('submit', function(event) {
			if (!validateTime()) {
				event.preventDefault(); // 유효하지 않으면 제출을 막음
			}
		});
		
		// 프로그램 선택 시 테이블 표시 및 hiddenMeId 값 설정
		document.getElementById('programSelect').addEventListener('change', function() {
			var selectedOption = this.options[this.selectedIndex];
			var spType = selectedOption.getAttribute('data-sp-type');

			// 프로그램의 sp_type이 '단일'인 경우 테이블 표시
			if (spType === '단일') {
				document.getElementById('memberListTable').style.display = 'block';
			} else {
				document.getElementById('memberListTable').style.display = 'none';
				document.getElementById('hiddenMeId').value = ""; // 테이블이 보이지 않으면 me_id 초기화
			}
		});		
	</script>			
</body>
</html>
