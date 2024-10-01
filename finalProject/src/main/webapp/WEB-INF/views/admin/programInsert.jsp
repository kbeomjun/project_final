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
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">${branchName} 프로그램 등록</h1>
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
				<select class="form-control" name="bp_em_num">
					<c:forEach items="${employeeList }" var="employee">
						<option value="${employee.em_num}">${employee.em_name}</option>
					</c:forEach>		
				</select>
			</div>
			<div class="form-group">
				<label>총 인원수:</label>
				<input class="form-control" id="bp_total" name="bp_total" placeholder="숫자를 입력하세요."/>
			</div>
			<div class="text-right mb-3">
				<button type="submit" class="btn btn-outline-success">등록</button>
			</div>
		</form>
	<!-- </main> -->
	<script type="text/javascript">
		// 프로그램 선택 시 총 인원수 필드 조정
		function updateTotalInput() {
			var programSelect = document.getElementById('programSelect');
			var selectedOption = programSelect.options[programSelect.selectedIndex];
			var spType = selectedOption.getAttribute('data-sp-type');
			var totalInput = document.getElementById('bp_total');
			
			if (spType === '단일') {
				totalInput.value = 1;  // 총 인원수를 1로 고정
				totalInput.setAttribute('readonly', true);  // 입력을 막음
			} else {
				totalInput.value = '';  // 다른 프로그램 선택 시 초기화
				totalInput.removeAttribute('readonly');  // 입력 가능하게 함
			}
		}

		// 페이지가 로드될 때도 초기 상태 확인
		document.addEventListener('DOMContentLoaded', function() {
			updateTotalInput(); // 초기 상태 확인 후 실행
		});

		// 프로그램 선택 변경 시에도 총 인원수 필드 업데이트
		document.getElementById('programSelect').addEventListener('change', function() {
			updateTotalInput(); // 선택 변경 시 실행
		});
		
		// 폼 검증 설정
		$('#form').validate({
			rules : {
				bp_total : {
					required : true,
					digits : true,
					min : 1,
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
