<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<head>
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

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
	        	<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        
		        <!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${branchName} 스케줄 등록</h2>
						<p class="sub_title__txt">* 이전에 등록한 프로그램과 일정이 겹치면 등록이 불가능합니다.</p>						
					</div>
					
					<div class="table_wrap">
						<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
						<form action="<c:url value="/admin/schedule/regist"/>" method="post" id="form">
							<input type="hidden" name="bp_br_name" value="${branchName}">
	    					<input type="hidden" name="sp_type" id="sp_type">
	    					
	    					<!-- 스케줄 선택 테이블 -->
							<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="bs_bp_num" class="_asterisk">프로그램</label>
										</th>
										<td>
											<div class="form-group">
												<select name="bs_bp_num" id="programSelect" class="custom-select form-control">
													<option value="">선택</option>
													<c:forEach items="${programList}" var="list">
														<option value="${list.bp_num}" data-sp-type="${list.sp_type}">
															${list.bp_sp_name}(${list.em_name}, ${list.bp_total}인)
														</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>		
									<tr id="select-date-form" style="display: none;">
										<th scope="row">
											<label for="selectDate" class="_asterisk">날짜 선택</label>
										</th>
										<td>
											<div class="form-group">
												<input type="date" class="form-control custom-calender" id="selectDate" name="selectDate">
											</div>
										</td>
									</tr>
									<tr id="start-date-form" style="display: none;">
										<th scope="row">
											<label for="startDate" class="_asterisk">시작 날짜</label>
										</th>
										<td>
											<div class="form-group">
												<input type="date" class="form-control custom-calender" id="startDate" name="startDate">
											</div>
										</td>
									</tr>
									<tr id="end-date-form" style="display: none;">
										<th scope="row">
											<label for="endDate" class="_asterisk">마감 날짜</label>
										</th>
										<td>
											<div class="form-group">
												<input type="date" class="form-control custom-calender" id="endDate" name="endDate">
											</div>
										</td>
									</tr>	
									<tr id="weeks-program-table" style="display: none;">
										<th scope="row">
											<label for="weeks" class="_asterisk">요일 선택</label>
										</th>
										<td>
											<div class="form-group">
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
										</td>
									</tr>
									<tr id="program-time-table" style="display: none;">
										<th scope="row">
											<label for="hours" class="_asterisk">시간 선택</label>
										</th>
										<td>
											<div class="form-group">
										        <c:forEach var="hour" begin="9" end="19">
											        <input type="checkbox" id="checkbox-${hour}" class="checkbox-button form-control" value="${hour}" name="hours"/>
											        <label for="checkbox-${hour}" class="checkbox-label">${hour}:00</label>
											    </c:forEach>
											</div>
										</td>
									</tr>
									<tr id="pt-time-table" style="display: none;">
										<th scope="row">
											<label for="hours" class="_asterisk">시간 선택</label>
										</th>
										<td>
											<div class="form-group">
											    <c:forEach var="hour" begin="9" end="19">
											        <input type="radio" id="radio-${hour}" class="radio-button form-control" value="${hour}" name="hours"/>
											        <label for="radio-${hour}" class="radio-label">${hour}:00</label>
											    </c:forEach>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							
							<!-- 회원 선택 테이블 -->
							<div class="form-group" id="memberListTable" style="display: none;" id="pt-time-table">
								<table class="table table_center" id="table">
									<thead id="thead">
										<tr>
											<th>회원 선택</th>
											<th>회원 이름</th>
											<th>번호</th>
											<th>이메일</th>
										</tr>
									</thead>
									<tbody id="tbody">
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
									</tbody>
								</table>
							</div>							

							<div class="btn_wrap">
								<div class="btn_right_wrap">
									<button type="submit" class="btn btn_insert">등록</button>
									<a href="<c:url value="/admin/schedule/list"/>" class="btn btn_cancel">취소</a>
								</div>
							</div>

						</form>
					</div>
					
				</section>		        
		        
			</section>

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
			    // endDate value는  StartDate보다 작을때만 변경
			    document.getElementById('startDate').addEventListener('input', function() {
			    	const startDateValue = this.value;
			    	const endDateInput = document.getElementById('endDate');
			
			    	// 최소 선택 가능 날짜 설정
			    	endDateInput.min = startDateValue;
			
			    	// 현재 endDate의 값
			    	const endDateValue = endDateInput.value;
			
			    	// 날짜 객체로 변환
			    	const startDate = new Date(startDateValue);
			    	const endDate = new Date(endDateValue);
			
			    	// endDate가 startDate보다 이전인 경우에만 값을 업데이트
			    	if (endDate < startDate) {
			    	    endDateInput.value = startDateValue;
			    	}
			    });
			</script>
			
			<script>
					
				var table = null;	
			
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
					
				    // 기존 테이블이 초기화되어 있는지 확인하고 초기화된 경우 destroy() 호출
				    if ($.fn.DataTable.isDataTable('#table')) {
				        table.destroy(); // 테이블이 이미 초기화된 경우 파괴
				    }		
					
					// 선택한 프로그램에 따른 UI 변경
				    if (spType === '단일') {
				        toggleVisibility(['select-date-form', 'pt-time-table', 'memberListTable'], true);
				        toggleVisibility(['start-date-form', 'end-date-form', 'program-time-table', 'weeks-program-table'], false);
						
				        table = $('#table').DataTable({
							language: {
						        search: "",
						        searchPlaceholder: "검색",
						        zeroRecords: "",
						        emptyTable: "",
						        lengthMenu: ""
						    },
						    pageLength: 10,
						    info: false,
						    order: [[ 1, "asc" ]],
						    columnDefs: [
						        { targets: [0], orderable: false }
						    ]
						});
				        
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
					
					// 테이블 초기화 또는 크기 조정
			        initializeTable();
					
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
				document.getElementById('startDate').addEventListener('change', function() {
					const hourCheckboxes = document.querySelectorAll('input[type="checkbox"][name="hours"]');
						hourCheckboxes.forEach(radio => {
							radio.disabled = false; // 모든 체크박스 비활성화 해제
						});
						
			        if (document.getElementById('startDate').value === currentDate) {
			            toggleHourCheckboxes('radio', currentHour);
			            const hourRadioButtons = document.querySelectorAll('input[type="checkbox"][name="hours"]');
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
				        document.getElementById(id).style.display = isVisible ? '' : 'none';
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