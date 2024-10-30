<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

	<c:if test="${not empty msg}">
	    <script type="text/javascript">
	        alert("${msg}");
	    </script>
	</c:if>
	
	<section class="sub_banner sub_banner_07"></section>
	<section class="sub_content">
	
		<!-- 왼쪽 사이드바 -->
		<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>
		
		<!-- 오른쪽 컨텐츠 영역 -->
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">${br_name} 프로그램 목록</h2>
			</div>
			
			<!-- 프로그램 목록 -->
			<table class="table table_center" id="table">
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
									<button type="button" class="btn btn_yellow btn-update" data-toggle="modal" data-target="#myModal2" data-num="${list.bp_num}">수정</button>
								</c:if>
								<c:if test="${list.sp_type == '단일'}">
									-
								</c:if>
							</td>
							<td>
								<a href="<c:url value="/admin/program/delete/${list.bp_num}"/>" class="btn btn_red" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 프로그램 등록 버튼 -->
			<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<button type="button" class="btn btn_black js-btn-insert" data-toggle="modal" data-target="#myModal">
							<span>프로그램 추가<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_black_top_line"></div>
						<div class="btn_black_right_line"></div>
						<div class="btn_black_bottom_line"></div>
						<div class="btn_black_left_line"></div>
					</div>
				</div>
			</div>					
			
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
			        		<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="bp_sp_name" class="_asterisk">프로그램</label>
										</th>
										<td>
											<div class="form-group">
												<select name="bp_sp_name" id="programSelect" class="custom-select form-control">
													<option value="">선택</option>
													<c:forEach items="${programList }" var="program">
														<option value="${program.sp_name}" data-sp-type="${program.sp_type}">${program.sp_name}</option>
													</c:forEach>
												</select>											
											</div>
										</td>
									</tr>
									<tr id="trainerRow" style="display:none;">
										<th scope="row">
											<label for="bp_em_num" class="_asterisk">트레이너</label>
										</th>
										<td>
											<div class="form-group">
												<select name="bp_em_num" id="trainerSelect" class="custom-select form-control">
													<c:forEach items="${employeeList}" var="employee">
														<option value="${employee.em_num}" data-em-position="${employee.em_position}">${employee.em_name}</option>
													</c:forEach>
												</select>											
											</div>
										</td>
									</tr>
									<tr id="totalRow" style="display:none;">
										<th scope="row">
											<label for="bp_total" class="_asterisk">총 인원수</label>
										</th>
										<td>
											<div class="form-group">
												<div id="selectPT" style="display:none;">1</div>
												<input type="text" class="form-control" id="bp_total" name="bp_total" placeholder="숫자를 입력하세요.">
											</div>
											<div class="error error-total"></div>
										</td>
									</tr>																										
								</tbody>
			        		</table>
			        		
			        		<div class="btn_wrap">
								<div class="btn_right_wrap">
									<button type="submit" class="btn btn_green">프로그램 등록</button>
								</div>
							</div>
			        	</div>
			        	<div class="modal-footer">
			          		<button type="button" class="btn btn_red" data-dismiss="modal">취소</button>
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
				        	<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
							<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="bp_sp_name" class="_asterisk">프로그램</label>
										</th>
										<td>
											<div class="form-group" id="bp_sp_name"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="bp_em_num" class="_asterisk">트레이너</label>
										</th>
										<td>
											<div class="form-group" id="em_name"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="bp_total" class="_asterisk">총 인원수</label>
										</th>
										<td>
											<div class="form-group">
												<input type="text" class="form-control" id="bp_total2" name="bp_total" placeholder="숫자를 입력하세요.">
											</div>
											<div class="error error-total"></div>
										</td>
									</tr>																										
								</tbody>
			        		</table>
			        		
			        		<div class="btn_wrap">
								<div class="btn_right_wrap">
									<button type="submit" class="btn btn_yellow">프로그램 수정</button>
								</div>
							</div>							
							
			        	</div>
			        	<div class="modal-footer">
			          		<button type="button" class="btn btn_red" data-dismiss="modal">취소</button>
			        	</div>
		      		</form>
		    	</div>
	  		</div>			
			
		</section>
		
	</section>
	
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
		    pageLength: 10,
		    info: false,
		    stateSave: true,
		    stateDuration: 300,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [3, 4], orderable: false }
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
			
			if($('#programSelect').val() == ''){
				$('#trainerRow').hide();
				$('#totalRow').hide();
			} else{
				$('#trainerRow').show();
				$('#totalRow').show();
			}
			
			// 총 인원수 필드 조정
			if (spType === '단일') {
				$('#selectPT').show();
				$('#bp_total').hide();
				totalInput.value = 1;  // 총 인원수를 1로 고정
			} else {
				$('#selectPT').hide();
				$('#bp_total').show();
				totalInput.value = '';  // 다른 프로그램 선택 시 초기화
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
					$('#bp_sp_name').text(bp.bp_sp_name);
					$('#em_name').text(bp.em_name);
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
