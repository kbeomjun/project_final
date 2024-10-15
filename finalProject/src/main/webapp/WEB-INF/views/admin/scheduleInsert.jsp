<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>스케줄 등록</title>
<style type="text/css">
	table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 10px;
	}
</style>
<style>
/* 체크박스 숨기기 */
.checkbox-button,
.radio-button {
    display: none; /* 기본 체크박스 숨기기 */
}

/* 체크박스가 체크되었을 때를 위한 스타일 */
.checkbox-label,
.radio-label {
    display: inline-block;
    padding: 10px 20px;
    background-color: white; /* 기본 버튼 색상 */
    color: black; /* 글자 색상 */
    border : 1px solid black;
    border-radius: 5px;
    cursor: pointer; /* 포인터 커서 */
    transition: background-color 0.3s ease;
}

.checkbox-button:checked + .checkbox-label,
.radio-button:checked + .radio-label {
    background-color: #007bff; /* 체크박스 체크 시 버튼 색상 */
}

.checkbox-label:hover,
.radio-label:hover {
    background-color: #007bff; /* 마우스 오버 시 색상 변화 */
}

.radio-button:disabled,
.checkbox-button:disabled {
    cursor: not-allowed; /* 비활성화된 경우 커서 스타일 */
    opacity: 0.5; /* 비활성화된 체크박스 투명도 */
    color: #b0b0b0; /* 회색으로 비활성화 색상 */
}

/* 레이블 스타일 추가 */
.radio-button:disabled + .radio-label,
.checkbox-button:disabled + .checkbox-label {
    color: #b0b0b0; /* 비활성화 상태에서 레이블 색상 */
    text-decoration: line-through; /* 레이블에 취소선 추가 */
    pointer-events: none; /* 레이블 클릭 방지 */
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
					<p class="text-danger"> 안내: 이전에 등록한 프로그램과 일정이 겹치면 등록이 안됩니다. </p>
					<form action="<c:url value="/admin/schedule/insert"/>" method="post" id="form">
						<input type="hidden" name="bp_br_name" value="${branchName}">
    					<input type="hidden" name="sp_type" id="sp_type">
						
						<div class="form-group">
							<label>프로그램:</label>
							<select class="form-control" name="bs_bp_num" id="programSelect">
								<c:forEach items="${programList}" var="list">
									<option value="${list.bp_num}" data-sp-type="${list.program.sp_type}">
										${list.bp_sp_name}(${list.employee.em_name}, ${list.bp_total}인)
									</option>
								</c:forEach>		
								<option value="" disabled selected></option>
							</select>
						</div>
						
						<div class="form-group" id="select-date-form" style="display: none;">
							<label>날짜 선택:</label>
							<input class="form-control" type="date" name="selectDate" id="selectDate"/>
						</div>
						
						<div class="form-group" id="start-date-form" style="display: none;">
							<label>시작 날짜:</label>
							<input class="form-control" type="date" name="startDate" id="startDate"/>
						</div>
						
						<div class="form-group" id="end-date-form" style="display: none;">
							<label>마감 날짜:</label>
							<input class="form-control" type="date" name="endDate" id="endDate"/>
						</div>
						
						<div class="form-group" style="display: none;" id="weeks-program-table">  
					    <label for="weeks">요일 선택:</label>	
					    <c:forEach var="day" begin="1" end="7">
					        <input type="checkbox" id="checkbox-${day}" class="checkbox-button form-control" value="${day}" name="weeks"/>
					        <label for="checkbox-${day}" class="checkbox-label">
					            <c:choose>
					                <c:when test="${day == 1}">일요일</c:when>
					                <c:when test="${day == 2}">월요일</c:when>
					                <c:when test="${day == 3}">화요일</c:when>
					                <c:when test="${day == 4}">수요일</c:when>
					                <c:when test="${day == 5}">목요일</c:when>
					                <c:when test="${day == 6}">금요일</c:when>
					                <c:when test="${day == 7}">토요일</c:when>
					            </c:choose>
					        </label>
					    </c:forEach>
						</div>
														
				    <div class="form-group" id="program-time-table" style="display: none;">
					    <label for="hours">시간 선택:</label>
				        <c:forEach var="hour" begin="9" end="19">
					        <input type="checkbox" id="checkbox-${hour}" class="checkbox-button form-control" value="${hour}" name="hours"/>
					        <label for="checkbox-${hour}" class="checkbox-label">${hour}:00</label>
					    </c:forEach>
					</div>
					
					<div class="form-group" id="pt-time-table" style="display: none;">
					    <label for="hours">시간 선택:</label><br>
					    <c:forEach var="hour" begin="9" end="19">
					        <input type="radio" id="radio-${hour}" class="radio-button form-control" value="${hour}" name="hours"/>
					        <label for="radio-${hour}" class="radio-label">${hour}:00</label>
					    </c:forEach>
					</div>
		
					<!-- 회원 선택 테이블 -->
					<div class="form-group" id="memberListTable" style="display: none;" id="pt-time-table">
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
											<input type="radio" id="member-id" name="me_id" value="${member.me_id}"/>
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

<script type="text/javascript">
	
	// 현재 날짜 가져오기
	const today = new Date();
	
	// 날짜 형식 맞추기 (YYYY-MM-DD)
	const year = today.getFullYear();
	const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
	const day = String(today.getDate()).padStart(2, '0');
    
    // 현재 날짜를 기본값으로 설정
    const currentDate = year + '-' + month + '-' + day;
    // 현재 시간을 저장
    const currentHour = today.getHours();
    
	document.getElementById('startDate').value = currentDate;
	document.getElementById('endDate').value = currentDate;
	document.getElementById('selectDate').value = currentDate;
	
	// min 속성 설정하기
	document.getElementById('startDate').min = currentDate;
	document.getElementById('endDate').min = currentDate;
	document.getElementById('selectDate').min = currentDate;
	
	// 한 달 뒤 날짜 계산하기 (max 속성 설정)
	const nextMonth = new Date();
	nextMonth.setMonth(today.getMonth() + 1);
	
	// max 속성 설정하기
	const maxYear = nextMonth.getFullYear();
	const maxMonth = String(nextMonth.getMonth() + 1).padStart(2, '0'); 
	const maxDay = String(nextMonth.getDate()).padStart(2, '0');
	
	document.getElementById('startDate').max = maxYear + '-' + maxMonth + '-' + maxDay;
	document.getElementById('endDate').max = maxYear + '-' + maxMonth + '-' + maxDay;
	document.getElementById('selectDate').max = maxYear + '-' + maxMonth + '-' + maxDay;
	
    // startDate 값 변경 시 endDate의 min 값 변경
    document.getElementById('startDate').addEventListener('input', function() {
        const startDateValue = this.value;
        document.getElementById('endDate').min = startDateValue;
        document.getElementById('endDate').value = startDateValue;
    });
</script>
<script>
		
	// 프로그램 선택 시 테이블 표시 및 hiddenMeId 값 설정
	document.getElementById('programSelect').addEventListener('change', function() {
		var selectedOption = this.options[this.selectedIndex];
		var spType = selectedOption.getAttribute('data-sp-type');
		
		document.getElementById('sp_type').value = spType;
		
		// 현재 날짜 가져오기
		var today = new Date();
		
		// 날짜 형식 맞추기 (YYYY-MM-DD)
		var year = today.getFullYear();
		var month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		var day = String(today.getDate()).padStart(2, '0');
	    
		// 현재 시간을 불러옴
	    const currentHour = today.getHours();
		
		// 선택한 프로그램에 따른 UI 변경
	    if (spType === '단일') {
	        toggleVisibility(['select-date-form', 'pt-time-table', 'memberListTable'], true);
	        toggleVisibility(['start-date-form', 'end-date-form', 'program-time-table', 'weeks-program-table'], false);
	        
	        if (document.getElementById('selectDate').value === currentDate) {
	            toggleHourCheckboxes('radio', currentHour);
	        }
	    } else {
	        toggleVisibility(['start-date-form', 'end-date-form', 'weeks-program-table', 'program-time-table'], true);
	        toggleVisibility(['select-date-form', 'pt-time-table', 'memberListTable'], false);
	        if (document.getElementById('endDate').value === currentDate) {
	            toggleHourCheckboxes('checkbox', currentHour);
	        }
	    }
		
		// 프로그램 변경 시 모든 입력 초기화.
	    resetInputs();
		
	});		
	
	// 시간 변경 시 hours 박스 조정
	document.getElementById('selectDate').addEventListener('change', function() {
		
		const hourCheckboxes = document.querySelectorAll('input[type="radio"][name="hours"]');
			hourCheckboxes.forEach(radio => {
				radio.disabled = false; // 모든 체크박스 비활성화 해제
			});
			
        if (document.getElementById('selectDate').value === currentDate) {
            toggleHourCheckboxes('radio', currentHour);
            const hourRadioButtons = document.querySelectorAll('input[type="radio"][name="hours"]');
    	    hourRadioButtons.forEach(radio => {
    	        radio.checked = false; // 라디오 버튼 해제
    	    });
        }
	});		
	
	// 시간 변경 시 hours 박스 조정
	document.getElementById('endDate').addEventListener('change', function() {
		
		const hourCheckboxes = document.querySelectorAll('input[type="checkbox"][name="hours"]');
			hourCheckboxes.forEach(checkbox => {
			    checkbox.disabled = false; // 모든 체크박스 비활성화 해제
			});
			
        if (document.getElementById('endDate').value === currentDate) {
            toggleHourCheckboxes('checkbox', currentHour);
            const hourRadioButtons = document.querySelectorAll('input[type="checkbox"][name="hours"]');
    	    hourRadioButtons.forEach(check => {
    	    	check.checked = false; // 라디오 버튼 해제
    	    });
        }
	});		
	
	// 가시성을 토글하는 함수
	function toggleVisibility(elementIds, isVisible) {
	    elementIds.forEach(id => {
	        document.getElementById(id).style.display = isVisible ? 'block' : 'none';
	    });
	}

	// 시간 체크박스를 활성화/비활성화하는 함수
	function toggleHourCheckboxes(type, currentHour) {
	    const hourCheckboxes = document.querySelectorAll('input[type="'+type+'"][name="hours"]');
	    hourCheckboxes.forEach(checkbox => {
	        const hourValue = parseInt(checkbox.value);
	        checkbox.disabled = hourValue <= currentHour; // 비활성화 조건
	    });
	}
	
	function resetInputs() {
		
		document.getElementById('startDate').value = currentDate;
		document.getElementById('endDate').value = currentDate;
		document.getElementById('selectDate').value = currentDate;
		
	    // 체크박스 해제
	    const weekCheckboxes = document.querySelectorAll('input[type="checkbox"][name="weeks"]');
	    weekCheckboxes.forEach(checkbox => {
	        checkbox.checked = false; // 체크박스 해제
	    });

	    const hourCheckboxes = document.querySelectorAll('input[type="checkbox"][name="hours"]');
	    hourCheckboxes.forEach(checkbox => {
	        checkbox.checked = false; // 체크박스 해제
	    });

	    // 라디오 버튼 해제
	    const weekRadioButtons = document.querySelectorAll('input[type="radio"][name="weeks"]');
	    weekRadioButtons.forEach(radio => {
	        radio.checked = false; // 라디오 버튼 해제
	    });

	    const hourRadioButtons = document.querySelectorAll('input[type="radio"][name="hours"]');
	    hourRadioButtons.forEach(radio => {
	        radio.checked = false; // 라디오 버튼 해제
	    });
	    
	 	// 모든 라디오 버튼 해제
	    const radioButtons = document.querySelectorAll('input[type="radio"][name="me_id"]');
	    radioButtons.forEach(radio => {
	        radio.checked = false; // 라디오 버튼 해제
	    });
	    
	}
</script>		
<script type="text/javascript">
	// 폼 제출 시 유효성 검사 추가
	document.getElementById('form').addEventListener('submit', function(event) {
		
		const sp_type = document.getElementById('sp_type').value;
        const me_id = document.querySelector('input[name="me_id"]:checked');
        
        // const selectDate = document.getElementById('selectDate').value;
        const startDate = document.getElementById('startDate').value;
		const endDate = document.getElementById('endDate').value;
		
	    const weeks = document.querySelectorAll('input[name="weeks"]:checked');
	    const hours = document.querySelectorAll('input[name="hours"]:checked');
        
        // sp_type이 "단일"일 때
        if (sp_type === "단일") {
        	// 아이디가 null이거나 선택한 시간이 없다면 
        	if(!me_id || hours.length === 0) {
            alert("회원 및 시간을 선택해 주세요.");
            event.preventDefault(); 
	        }
        }
        // 그 외 프로그램일 때
       	else {
       		// weeks와 hours 선택된 값이 없는 경우
            if (weeks.length === 0 || hours.length === 0) {
                alert("요일 및 시간을 선택해 주세요.");
                event.preventDefault();
            }
       	}
        
       
	});
</script>	
</body>
</html>
