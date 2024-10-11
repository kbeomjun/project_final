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
		        <button type="button" class="btn btn-danger btn-sm mr-2" id="btn-noshow-plus" style="width: 30px;">+</button>
		        <button type="button" class="btn btn-warning btn-sm" id="btn-noshow-reset" style="width: 60px;">초기화</button>
		    </div>
		</div>
		<div class="form-group">
			<label>노쇼 제한시간: </label>
			<input type="text" class="form-control" id="noshow-limit-time" value="<fmt:formatDate value='${me.me_cancel}' pattern='yyyy/MM/dd HH:mm:ss' />" readonly>
		</div>	
				
		<hr>
		
		<div class="text-right mb-3">
			<a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-danger">뒤로가기</a>
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
	    
	    // 초기화 버튼 클릭 시
	    document.getElementById("btn-noshow-reset").addEventListener("click", function() {
	        resetNoshow();
	    });
	
	    function adjustNoshowCount(delta) {
	        // 현재 노쇼 카운트 가져오기
	        let currentCount = parseInt(document.getElementById("noshow-count").value);
	        let memberId = document.getElementById("me_id").value;
	        
	        // 새로운 카운트 계산
	        let newCount = currentCount + delta;
	        if (newCount < 0) newCount = 0; // 0 이하로 내려가지 않게
	        if (newCount > 5) newCount = 5; // 5회 이상으로 올라가지 않게
	        
	        $.ajax({
	            async: true,
	            url: '<c:url value="/admin/member/update"/>', 
	            type: 'post', 
	            data: {noshow: newCount, me_id: memberId}, 
	            dataType: "json", 
	            success: function(data) {
	                document.getElementById("noshow-count").value = data.me.me_noshow;
	                // 'me_cancel' 값을 Unix Timestamp에서 사람이 읽을 수 있는 형식으로 변환
	                if (data.me.me_cancel) {
	                    let date = new Date(data.me.me_cancel); // Unix Timestamp를 Date 객체로 변환
	                    let formattedDate = date.getFullYear() + '/' +
	                        ('0' + (date.getMonth() + 1)).slice(-2) + '/' +
	                        ('0' + date.getDate()).slice(-2) + ' ' +
	                        ('0' + date.getHours()).slice(-2) + ':' +
	                        ('0' + date.getMinutes()).slice(-2) + ':' +
	                        ('0' + date.getSeconds()).slice(-2);
	                    document.getElementById("noshow-limit-time").value = formattedDate;
	                } else {
	                    document.getElementById("noshow-limit-time").value = '';
	                }
	            }, 
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.log(jqXHR);
	            }
	        });
	    }
	    
	    // 노쇼 경고횟수 초기화 함수
	    function resetNoshow() {
	        let memberId = document.getElementById("me_id").value;

	        // 초기화 요청 보내기
	        $.ajax({
	            async: true,
	            url: '<c:url value="/admin/member/reset"/>',  // 초기화용 별도의 URL로 요청 보냄
	            type: 'post',
	            data: {me_id: memberId},
	            dataType: "json",
	            success: function(data) {
	                // 노쇼 횟수 0으로 설정
	                document.getElementById("noshow-count").value = 0;
	                // 노쇼 제한시간 비우기
	                document.getElementById("noshow-limit-time").value = '';
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.log(jqXHR);
	            }
	        });
	    }	    
	</script>

</body>
</html>
