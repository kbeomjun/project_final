<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 목록</title>
</head>
	<style type="text/css">
		.error{color : red;}
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
<body>
	<c:if test="${not empty msg}">
	    <script type="text/javascript">
	        alert("${msg}");
	    </script>
	</c:if>
	
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${br_name} 프로그램 목록</h2>
					<div>	
						<button type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#myModal">프로그램 추가</button>
					</div>
					<!-- 프로그램 목록 -->
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>프로그램명</th>
								<th>트레이너명</th>
								<th>총 인원수</th>
								<th>인원수 수정</th>
								<th>프로그램삭제</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${branchProgramList}" var="list">
								<tr>
									<td>${list.bp_sp_name}</td>
									<td>${list.em_name}</td>
									<td>${list.bp_total}</td>
									<td>
										<c:if test="${list.sp_type == '그룹'}">
											<button type="button" class="btn btn-outline-warning btn-sm btn-update" data-toggle="modal" data-target="#myModal2" data-num="${list.bp_num}">수정</button>
										</c:if>
										<c:if test="${list.sp_type == '단일'}">
											-
										</c:if>
									</td>
									<td>
										<a href="<c:url value="/admin/program/delete/${list.bp_num}"/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- 프로그램 등록 modal -->
					<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-dialog-centered">
				      		<form action="<c:url value="/admin/program/insert"/>" method="post" id="form" class="modal-content">
					        	<input type="hidden" name="bp_br_name" value="${br_name}">
					        	<div class="modal-header">
					          		<h4 class="modal-title">등록</h4>
					          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
					        	</div>
					        	<div class="modal-body">
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
									<div class="error error-date"></div>
									<button type="submit" class="btn btn-outline-success col-12">프로그램 등록</button>
					        	</div>
					        	<div class="modal-footer">
					          		<button type="button" class="btn btn-danger btn-close" data-dismiss="modal">취소</button>
					        	</div>
				      		</form>
				    	</div>
			  		</div>

					<!-- 프로그램 수정 modal -->
			  		<div class="modal fade" id="myModal2">
				    	<div class="modal-dialog modal-dialog-centered">
				      		<form action="<c:url value="/admin/program/update"/>" method="post" id="form2" class="modal-content">
					        	<div class="modal-header">
					          		<h4 class="modal-title">수정</h4>
					          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
					        	</div>
					        	<div class="modal-body">
									<input type="hidden" id="bp_num" name="bp_num">
									<div class="form-group">
										<label>프로그램:</label>
										<input class="form-control" id="bp_sp_name" name="bp_sp_name" readonly/>
									</div>
									<div class="form-group">
										<label>트레이너:</label>
										<input class="form-control" id="em_name" name="em_name" readonly/>
									</div>
									<div class="form-group">
										<label>총 인원수:</label>
										<input class="form-control" id="bp_total2" name="bp_total" placeholder="숫자를 입력하세요."/>
									</div>
									<button type="submit" class="btn btn-outline-warning col-12">회원권 수정</button>
					        	</div>
					        	<div class="modal-footer">
					          		<button type="button" class="btn btn-danger btn-close" data-dismiss="modal">취소</button>
					        	</div>
				      		</form>
				    	</div>
			  		</div>
		  					  		
	            </div>
	            
	        </main>
	    </div>
	</div>
	
	<script type="text/javascript">
		// 데이터테이블
		$('#table').DataTable({
			language: {
		        search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: "",
		        lengthMenu: ""
		    },
			scrollY: 500,
		    pageLength: 10,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [3, 4], orderable: false },
		        { targets: [0, 1, 2], className: "align-content-center"}
		    ]
		});
	</script>
	
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
	
	<script type="text/javascript">
		$('.btn-update').click(function(){
			var bp_num = $(this).data("num");
			
			$.ajax({
				async : true,
				url : '<c:url value="/admin/program/update"/>', 
				type : 'get', 
				data : {bp_num : bp_num}, 
				dataType : "json",
				success : function (data){
					let bp = data.branchProgram;
					$('#bp_num').val(bp.bp_num);
					$('#bp_sp_name').val(bp.bp_sp_name);
					$('#em_name').val(bp.em_name);
					$('#bp_total2').val(bp.bp_total);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});	
	</script>
	
	<script type="text/javascript">
		$('#form2').validate({
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
		$.validator.addMethod('regex', function(value, element, regex){
			var re = new RegExp(regex);
			return this.optional(element) || re.test(value);
		}, "정규표현식을 확인하세요.");		
	</script>		
	
</body>
</html>
