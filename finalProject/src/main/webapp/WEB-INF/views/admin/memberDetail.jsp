<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>회원 상세</title>
<style type="text/css">
	.error{color:red; margin-bottom: 10px;}
	.form-group{margin: 0;}
	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
	.address-input{margin-bottom: 10px;}
	#file{display: none;}
</style>
</head>
<body>
	<h1 class="mt-3 mb-3">${me.me_name} 회원 상세</h1>
	<div class="container" style="margin-top:30px">
		<div class="form-group">
			<label for="me_id">아이디:</label>
			<input type="text" class="form-control" id="me_id" name="me_id" value="${me.me_id}" readonly>
		</div>
		<div class="form-group">
			<label for="me_name">이름:</label>
			<input type="text" class="form-control" id="me_name" name="me_name" value="${me.me_name}" readonly>
		</div>	
		<div class="form-group">
			<label for="me_gender">성별:</label>
			<input type="text" class="form-control" id="me_gender" name="me_gender" value="${me.me_gender}" readonly>
		</div>		
		<div class="form-group">
			<label for="me_birth">생년월일:</label>
			<c:set var="formattedBirth">
			    <fmt:formatDate value="${me.me_birth}" pattern="yyyy년 MM월 dd일" />
			</c:set>
			<input type="text" class="form-control" id="me_birth" name="me_birth" value="${formattedBirth}" readonly>
		</div>							
		<div class="form-group">
			<label for="me_phone">전화번호:</label>
			<input type="text" class="form-control" id="me_phone" name="me_phone" value="${me.me_phone}" readonly>
		</div>
		<div class="form-group">
			<label for="me_email">이메일:</label>
			<input type="text" class="form-control" id="me_email" name="me_email" value="${me.me_email}" readonly>
		</div>
		<div class="form-group">
			<label for="me_address">주소:</label> <br/>
			<input type="text" class="address-input" id="me_postcode" name="me_postcode" placeholder="우편번호" style="width:130px;" value="${me.me_postcode}" readonly>
			<input type="text" class="address-input" id="me_address" name="me_address" placeholder="주소" style="width:100%;" value="${me.me_address}" readonly> <br/>
			<input type="text" class="address-input" id="me_detailAddress" name="me_detailAddress" placeholder="상세주소" style="width:60%; margin-bottom: 0;" value="${me.me_detailAddress}" readonly>
			<input type="text" class="address-input" id="me_extraAddress" name="me_extraAddress" placeholder="참고항목" style="width:39.36%; margin-bottom: 0;" value="${me.me_extraAddress}" readonly>
		</div>
		
		<div class="form-group">
			<label>노쇼 경고 횟수: </label>
		    <div class="d-flex">
		        <input type="text" class="form-control mr-2" id="noshow-count" value="${me.me_noshow}" readonly style="width: 130px;">
		        <button type="button" class="btn btn-danger btn-sm mr-2" id="btn-noshow-minus" style="width: 30px;">-</button>
		        <button type="button" class="btn btn-danger btn-sm" id="btn-noshow-plus" style="width: 30px;">+</button>
		    </div>
		</div>
		<div class="form-group">
			<label>노쇼 제한시간: </label>
			<input type="text" class="form-control" id="noshow-limit-time" value="<fmt:formatDate value='${me.me_cancel}' pattern='yyyy/MM/dd HH:mm:ss' />" readonly>
		</div>	
				
		<hr>
		
		<div class="text-right mb-3">
			<a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-danger">취소</a>
		</div>
	</div>

	<script>
	    // - 버튼 클릭 시
	    document.getElementById("btn-noshow-minus").addEventListener("click", function() {
	        adjustNoshowCount(-1);
	    });
	
	    // + 버튼 클릭 시
	    document.getElementById("btn-noshow-plus").addEventListener("click", function() {
	        adjustNoshowCount(1);
	    });
	
	    function adjustNoshowCount(delta) {
	        // 현재 노쇼 카운트 가져오기
	        let currentCount = parseInt(document.getElementById("noshow-count").value);
	        
	        // 새로운 카운트 계산
	        let newCount = currentCount + delta;
	        if (newCount < 0) newCount = 0; // 0 이하로 내려가지 않게
	        if (newCount > 5) newCount = 5; // 5회 이상으로 올라가지 않게
	
	        // AJAX 요청을 통해 서버에 업데이트 요청
	        const xhr = new XMLHttpRequest();
	        xhr.open("POST", "<c:url value='/admin/member/update'/>", true);
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState == 4 && xhr.status == 200) {
	                const response = JSON.parse(xhr.responseText);
	                // 서버 업데이트 성공 시, UI 갱신
	                document.getElementById("noshow-count").value = newCount;
	                
	                // 노쇼 제한시간 UI 갱신
	                document.getElementById("noshow-limit-time").value = response.me_cancel ? response.me_cancel : "";
	            }
	        };
	        xhr.send("me_id=${me.me_id}&noshow=" + newCount);
	    }
	</script>

</body>
</html>
