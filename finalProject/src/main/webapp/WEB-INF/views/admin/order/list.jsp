<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<c:if test="${not empty msg}">
			    <script type="text/javascript">
			        alert("${msg}");
			    </script>
			</c:if>

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>

				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${br_name} 발주신청 목록</h2>
					</div>
					
					<!-- 발주신청 목록 -->
					<div class="table_wrap">
						<table class="table table_center" id="table">
							<thead id="thead">
								<tr>
									<th>운동기구명</th>
									<th>신청수량</th>
									<th>발주날짜</th>
									<th>발주상태</th>
									<th>신청취소</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<c:forEach items="${orderList}" var="list">
									<tr>
										<td>${list.bo_se_name}</td>
										<td>${list.bo_amount}</td>
										<td>
											<fmt:formatDate value="${list.bo_date}" pattern="yyyy-MM-dd"/>
										</td>
										<td>${list.bo_state}</td>
										<td>
											<c:choose>
												<c:when test="${list.bo_state == '승인대기'}">
													<a href="<c:url value="/admin/order/delete/${list.bo_num}"/>" class="btn btn_red" onclick="return confirm('취소하시겠습니까?');">신청취소</a>
												</c:when>
												<c:otherwise>
													-
												</c:otherwise>
											</c:choose>
										</td>							
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 발주신청 버튼 -->
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<div class="btn_link_black">
								<button type="button" class="btn btn_black js-btn-insert" data-toggle="modal" data-target="#myModal">
									<span>발주신청<i class="ic_link_share"></i></span>
								</button>
								<div class="btn_black_top_line"></div>
								<div class="btn_black_right_line"></div>
								<div class="btn_black_bottom_line"></div>
								<div class="btn_black_left_line"></div>
							</div>
						</div>
					</div>					
					
	                <!-- 발주신청 modal -->
					<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-dialog-centered">
				      		<form action="<c:url value="/admin/order/insert"/>" method="post" id="form" class="modal-content">
								<input type="hidden" name="bo_br_name" value="${br_name}">
					        	<div class="modal-header">
					          		<h4 class="modal-title">발주신청</h4>
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
													<label for="bo_se_name" class="_asterisk">운동기구</label>
												</th>
												<td>
													<div class="form-group">
														<select name="bo_se_name" id="equipmentSelect" class="custom-select form-control" style="width:100%;">
															<option value="">선택</option>
															<c:forEach items="${equipmentList }" var="equip">
																<option value="${equip.be_se_name}" data-total="${equip.be_se_total}">${equip.be_se_name}(남은수량: ${equip.be_se_total})</option>
															</c:forEach>		
															<option>기타</option>
														</select>											
													</div>
												</td>
											</tr>
											<tr id="otherEquipment" style="display:none;">
												<th scope="row">
													<label for="bo_other" class="_asterisk">기구이름</label>
												</th>
												<td>
													<div class="form-group">
														<input class="form-control" id="bo_other" name="bo_other" placeholder="기구 이름을 입력하세요.">
													</div>
												</td>
											</tr>											
											<tr>
												<th scope="row">
													<label for="bp_total" class="_asterisk">발주개수</label>
												</th>
												<td>
													<div class="form-group">
														<input class="form-control" id="bo_amount" name="bo_amount" placeholder="숫자를 입력하세요."/>
													</div>
												</td>
											</tr>																										
										</tbody>
					        		</table>
					        		
					        	</div>
					        	<div class="modal-footer">
									<button type="submit" class="btn btn_insert">등록</button>
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
				    createdRow: function(row, data, dataIndex) {
				        if (data[3] == "승인거절") {
				        	$('td', row).eq(3).css('color', 'red');
				        }
				        if (data[3] == "입고완료") {
				        	$('td', row).eq(3).css('color', 'green');
				        }
				        if (data[3] == "승인대기") {
				        	$('td', row).eq(3).css('color', 'blue');
				        }
				    },
				    pageLength: 10,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 2, "desc" ]],
				    columnDefs: [
				    	{ targets: [4], orderable: false }
				    ]
				});
			</script>
		
			<script type="text/javascript">
			    $(document).ready(function() {
			        // 페이지가 로드될 때 기본 max 설정 (최초 선택된 값)
			        updateMaxAndPlaceholder();
			
			        // 운동기구 선택 시 max 값 설정 및 발주 개수 초기화
			        $('#equipmentSelect').on('change', function() {
			            var selectedOption = $('#equipmentSelect option:selected').val();
			            
			            if (selectedOption === '기타') {
			                // 기타가 선택되면 max 속성을 없애고 input 태그 생성
			                $('#otherEquipment').show();
			                $('#bo_amount').removeAttr('max'); // 최대 수량 제한을 제거
			                $('#bo_amount').attr('placeholder', '숫자를 입력하세요.'); // placeholder 업데이트
			                
			            } else {
			                // 기타가 아닌 다른 옵션을 선택하면 max 값 설정 및 기타 input 필드 제거
			                updateMaxAndPlaceholder();
			                $('#otherEquipment').hide(); // 기타 입력 필드 삭제
			            }
			            
			            // 발주 개수 필드 초기화
			            $('#bo_amount').val(''); // 입력 필드 값을 초기화
			        });
			
			        // 함수: 선택된 옵션에 따라 max와 placeholder 설정
			        function updateMaxAndPlaceholder() {
			            var selectedTotal = $('#equipmentSelect option:selected').data('total');
			            if (selectedTotal) {
			                $('#bo_amount').attr('max', selectedTotal);
			                $('#bo_amount').attr('placeholder', '최대: ' + selectedTotal); // placeholder 업데이트
			            } else {
			                $('#bo_amount').removeAttr('max'); // max 속성 제거
			                $('#bo_amount').attr('placeholder', '숫자를 입력하세요.'); // 기본 placeholder 설정
			            }
			        }
			    });
			
			    // 폼 검증 설정
			    $('#form').validate({
			        rules: {
			        	bo_se_name: {
			        		required: true
			        	},
			            bo_amount: {
			                required: true,
			                digits: true,
			                min: 1,
			                // '기타' 선택 시 max 제한 없음
			                max: function() {
			                    // 기타 선택 시 max 제한 없음
			                    if ($('#equipmentSelect option:selected').val() === '기타') {
			                        return Number.MAX_VALUE; // 무제한 수량 허용
			                    } else {
			                        return parseInt($('#bo_amount').attr('max')) || false;
			                    }
			                }
			            },
			            bo_other: {
			                required: function() {
			                    // 기타 선택 시 bo_other 필드가 필수
			                    return $('#equipmentSelect option:selected').val() === '기타';
			                }
			            }
			        },
			        messages: {
			        	bo_se_name:{
			        		required: '필수 항목입니다.'
			        	},
			            bo_amount: {
			                required: '필수 항목입니다.',
			                digits: '숫자로만 입력하세요.',
			                min: '1 이상으로 입력하세요.',
			                max: '선택한 운동기구의 남은 수량을 초과할 수 없습니다.'
			            },
			            bo_other: {
			                required: '기타 운동기구 이름을 입력하세요.'
			            }
			        },
				    errorPlacement: function(error, element) {
				        if (element.attr("name") == "bo_se_name") {
				            error.insertAfter("#equipmentSelect"); // 선택창 바로 밑에 오류 메시지 표시
				            error.css("display", "block"); // 오류 메시지 요소에 display:block 적용
				        } else if(element.attr("name") == "bo_other"){
				        	error.insertAfter("#bo_other");
				        } else if (element.attr("name") == "bo_amount") {
				            error.insertAfter("#bo_amount"); // 총 인원수 입력창 밑에 오류 메시지 표시
				        } else {
				            error.insertAfter(element); // 기본 위치에 표시
				        }
				    },			        
			        submitHandler: function(form) {
			            form.submit();
			        }
			    });
			</script>