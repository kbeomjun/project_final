<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>발주신청 목록</title>
	<style type="text/css">
		.error{color : red;}	
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
</head>
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
					<h2 class="mt-3 mb-3">${br_name} 발주신청 목록</h2>
					<div>
						<button type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#myModal">발주신청</button>
					</div>
					<!-- 발주신청 목록 -->
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>운동기구명</th>
								<th>발주수량</th>
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
												<a href="<c:url value="/admin/order/delete/${list.bo_num}"/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('취소하시겠습니까?');">신청취소</a>
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
	                
	                <!-- 발주신청 modal -->
					<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-dialog-centered">
				      		<form action="<c:url value="/admin/order/insert"/>" method="post" id="form" class="modal-content">
					        	<input type="hidden" name="bp_br_name" value="${br_name}">
					        	<div class="modal-header">
					          		<h4 class="modal-title">발주신청</h4>
					          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
					        	</div>
					        	<div class="modal-body">
									<input type="hidden" name="bo_br_name" value="${br_name}">
									<div class="form-group">
										<label>운동기구:</label>
										<select class="form-control" name="bo_se_name" id="programSelect">
											<c:forEach items="${equipmentList }" var="equip">
												<option value="${equip.be_se_name}" data-total="${equip.be_se_total}">${equip.be_se_name}(남은수량: ${equip.be_se_total})</option>
											</c:forEach>		
											<option>기타</option>
										</select>
									</div>
									<div class="form-group">
										<label>발주개수:</label>
										<input class="form-control" id="bo_amount" name="bo_amount" placeholder="숫자를 입력하세요."/>
									</div>
									<button type="submit" class="btn btn-outline-success col-12">발주 등록</button>
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
		    stateSave: true,
		    stateDuration: 300,
		    order: [[ 2, "desc" ]],
		    columnDefs: [
		    	{ targets: [4], orderable: false },
		        { targets: [0, 1, 2, 3, 4], className: "align-content-center"}
		    ]
		});
	</script>

	<script type="text/javascript">
	    $(document).ready(function() {
	        // 페이지가 로드될 때 기본 max 설정 (최초 선택된 값)
	        updateMaxAndPlaceholder();
	
	        // 프로그램 선택 시 max 값 설정 및 발주 개수 초기화
	        $('#programSelect').on('change', function() {
	            var selectedOption = $('#programSelect option:selected').val();
	            
	            if (selectedOption === '기타') {
	                // 기타가 선택되면 max 속성을 없애고 input 태그 생성
	                $('#bo_amount').removeAttr('max'); // 최대 수량 제한을 제거
	                $('#bo_amount').attr('placeholder', '숫자를 입력하세요.'); // placeholder 업데이트
	                
	                // 기타 입력 필드가 없으면 생성
	                if ($('#otherInput').length === 0) {
	                    $('<div class="form-group" id="otherInput"><label>기타 운동기구:</label><input class="form-control" id="bo_other" name="bo_other" placeholder="운동기구 이름을 입력하세요."/></div>').insertAfter('#programSelect');
	                }
	            } else {
	                // 기타가 아닌 다른 옵션을 선택하면 max 값 설정 및 기타 input 필드 제거
	                updateMaxAndPlaceholder();
	                $('#otherInput').remove(); // 기타 입력 필드 삭제
	            }
	            
	            // 발주 개수 필드 초기화
	            $('#bo_amount').val(''); // 입력 필드 값을 초기화
	        });
	
	        // 함수: 선택된 옵션에 따라 max와 placeholder 설정
	        function updateMaxAndPlaceholder() {
	            var selectedTotal = $('#programSelect option:selected').data('total');
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
	            bo_amount: {
	                required: true,
	                digits: true,
	                min: 1,
	                // '기타' 선택 시 max 제한 없음
	                max: function() {
	                    // 기타 선택 시 max 제한 없음
	                    if ($('#programSelect option:selected').val() === '기타') {
	                        return Number.MAX_VALUE; // 무제한 수량 허용
	                    } else {
	                        return parseInt($('#bo_amount').attr('max')) || false;
	                    }
	                }
	            },
	            bo_other: {
	                required: function() {
	                    // 기타 선택 시 bo_other 필드가 필수
	                    return $('#programSelect option:selected').val() === '기타';
	                }
	            }
	        },
	        messages: {
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
	        submitHandler: function(form) {
	            form.submit();
	        }
	    });
	</script>

</body>
</html>
