<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 등록</title>
<style type="text/css">
	.error{color : red;}
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
	                        <a class="nav-link active" href="<c:url value="/admin/program/list"/>">프로그램관리</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/schedule/list"/>">프로그램일정관리</a>
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
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/inquiry/list"/>">문의내역</a>
	                    </li>
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${branchName} 프로그램 등록</h2>
					<form action="<c:url value="/admin/program/insert"/>" method="post" id="form">
						<input type="hidden" name="bp_br_name" value="${branchName}">
						<div class="form-group">
							<label>프로그램:</label>
							<select class="form-control" name="bp_sp_name" id="programSelect">
								<c:forEach items="${programList }" var="program">
									<option value="${program.sp_name}" data-sp-type="${program.sp_type}">${program.sp_name}</option>
								</c:forEach>		
							</select>
						</div>
						<div class="form-group">
						<label>트레이너:</label>
							<select class="form-control" name="bp_em_num" id="trainerSelect">
								<c:forEach items="${employeeList }" var="employee">
									<option value="${employee.em_num}" data-em-position="${employee.em_position}">${employee.em_name}</option>
								</c:forEach>		
							</select>
						</div>
						<div class="form-group">
							<label>총 인원수:</label>
							<input class="form-control" id="bp_total" name="bp_total" placeholder="숫자를 입력하세요."/>
						</div>
						<div class="d-flex justify-content-between">
						
							<a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-danger">취소</a>
							
							<div class="text-right">
								<button type="submit" class="btn btn-outline-success">등록</button>
							</div>
						</div>
					</form>
	                
	            </div>
	        </main>
	    </div>
	</div>

	<script type="text/javascript">
		// 프로그램 선택 시 총 인원수 필드 조정 및 트레이너 목록 초기화
		function updateTotalInput() {
			var programSelect = document.getElementById('programSelect');
			var selectedOption = programSelect.options[programSelect.selectedIndex];
			var spType = selectedOption.getAttribute('data-sp-type');
			var totalInput = document.getElementById('bp_total');
			var trainerSelect = document.getElementById('trainerSelect');
	
			// 총 인원수 필드 조정
			if (spType === '단일') {
				totalInput.value = 1;  // 총 인원수를 1로 고정
				totalInput.setAttribute('readonly', true);  // 입력을 막음
			} else {
				totalInput.value = '';  // 다른 프로그램 선택 시 초기화
				totalInput.removeAttribute('readonly');  // 입력 가능하게 함
			}
	
			// 트레이너 목록 초기화
			trainerSelect.innerHTML = '';  // 기존 트레이너 목록 비우기
	
			// 트레이너 목록을 다시 채워 넣음
			<c:forEach items="${employeeList}" var="employee">
				var trainerPosition = '${employee.em_position}';  // 트레이너의 포지션
	
				if ((spType === '단일' && trainerPosition === 'PT트레이너') || 
					(spType === '그룹' && trainerPosition !== 'PT트레이너')) {
					// 조건에 맞는 트레이너만 추가
					var option = document.createElement('option');
					option.value = '${employee.em_num}';
					option.text = '${employee.em_name}';
					option.setAttribute('data-em-position', trainerPosition);
					trainerSelect.appendChild(option);  // 트레이너 옵션 추가
				}
			</c:forEach>
		}
	
		// 프로그램 선택 시 총 인원수 필드 초기화 및 트레이너 목록 필터링
		document.addEventListener('DOMContentLoaded', function() {
			updateTotalInput(); // 초기 상태 확인 후 실행
		});
	
		// 프로그램 선택 변경 시에도 총 인원수 필드와 트레이너 목록 초기화
		document.getElementById('programSelect').addEventListener('change', function() {
			updateTotalInput(); // 프로그램 변경 시 실행
		});
		
		// 폼 검증 설정
		$('#form').validate({
			rules : {
				bp_total : {
					required : true,
					digits : true,
					min : function() {
						var programType = $('#programSelect option:selected').data('sp-type');
						return programType === '단일' ? 1 : 1;
					},
					max : 30
				}
			},
			messages : {
				bp_total : {
					required : '필수 항목입니다.',
					digits : '숫자로만 입력하세요.',
					min : '1 이상으로 입력하세요.',
					max : '30 이하로 입력하세요.'
				}
			},
			submitHandler : function(form){
				form.submit();
			}
		});
	</script>
		
</body>
</html>
