<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>발주 등록</title>
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
	                        <a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-info mb-2">프로그램관리</a>
	                    </li>
	                    <li class="nav-item">
	                        <a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-info mb-2">프로그램일정관리</a>
	                    </li>
						<li class="nav-item active">
	                        <a href="<c:url value="/admin/order/list"/>" class="btn btn-outline-info mb-2">운동기구 발주목록</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/employee/list"/>" class="btn btn-outline-info mb-2">직원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-info mb-2">회원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/branch/detail"/>" class="btn btn-outline-info mb-2">지점 상세보기</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/equipment/list"/>" class="btn btn-outline-info mb-2">운동기구 보유목록</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/equipment/change"/>" class="btn btn-outline-info mb-2">운동기구 재고 변동내역</a>
	                    </li>	                    	                    	                    	                    	                    
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${br_name} 발주 등록</h2>
					<form action="<c:url value="/admin/order/insert"/>" method="post" id="form">
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
						<div class="text-right mb-3">
							<button type="submit" class="btn btn-outline-success">발주 등록</button>
						</div>
					</form>
	                
	            </div>
	        </main>
	    </div>
	</div>

	
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
