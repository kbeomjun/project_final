<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
<style type="text/css">
	.error{color:red; margin-bottom: 10px;}
	.form-group{margin: 0;}
	.form-control{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
</style>
</head>
<body>
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2 class="mb-3">비밀번호 변경</h2>
					<form action="<c:url value='/mypage/pwchange/update'/>" method="post" id="form">
					    <input type="hidden" name="me_id" value="${me_id}">
					
					    <div class="form-group">
					        <label for="current_pw">현재 비밀번호:</label>
					        <input type="password" id="current_pw" name="current_pw" class="form-control" placeholder="현재 비밀번호를 입력하세요" required>
					    </div>
					    <div class="error error-current"></div>
					
					    <div class="form-group">
					        <label for="new_pw">새 비밀번호:</label>
					        <input type="password" id="new_pw" name="new_pw" class="form-control" placeholder="새 비밀번호를 입력하세요" required>
					    </div>
					    <div class="error error-new"></div>
					
					    <div class="form-group">
					        <label for="confirm_pw">새 비밀번호 확인:</label>
					        <input type="password" id="confirm_pw" name="confirm_pw" class="form-control" placeholder="새 비밀번호를 다시 입력하세요" required>
					    </div>
					    <div class="error error-confirm"></div>
					
					    <button type="submit" class="btn btn-primary">변경</button>
					</form>
					
	            </div>
	        </main>
	    </div>
	</div>
	
    <script type="text/javascript">
    	let regexPw = /^[a-zA-Z0-9!@#$]{4,15}$/;  // 정규식 정의 수정
    	let msgPw = `<span>비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.</span>`;
    	let msgPw2 = `<span>새 비밀번호는 현재 비밀번호와 같을 수 없습니다.</span>`;
    	let msgPw3 = `<span>비밀번호와 일치하지 않습니다.</span>`;
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		// 현재 비밀번호 유효성 체크
		$('#current_pw').keyup(function(){
			$('.error-current').children().remove();
			
			if($('#current_pw').val() == ''){
				$('.error-current').append(msgRequired);
			}else{
				if(!regexPw.test($('#current_pw').val())){
					$('.error-current').append(msgPw);
				}else{
					$('.error-current').children().remove();	
				}
			}
		});
		
		// 새 비밀번호 유효성 체크
		$('#new_pw').keyup(function(){
			$('.error-new').children().remove();
			
			if($('#new_pw').val() == ''){
				$('.error-new').append(msgRequired);
			}else{
				if(!regexPw.test($('#new_pw').val())){
					$('.error-new').append(msgPw);
				}else{
					$('.error-new').children().remove();	
				}
			}
		});
		
		// 새 비밀번호 확인 유효성 체크
		$('#confirm_pw').keyup(function(){
			$('.error-confirm').children().remove();
			
			if($('#confirm_pw').val() == ''){
				$('.error-confirm').append(msgRequired);
			}else{
				if(!regexPw.test($('#confirm_pw').val())){
					$('.error-confirm').append(msgPw);
				}else{
					if($('#new_pw').val() != $('#confirm_pw').val()){
						$('.error-confirm').append(msgPw3);
					} else{
						$('.error-confirm').children().remove();	
					}
				}
			}
		});
		
		// 폼 제출 시 유효성 체크
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			// 현재 비밀번호 확인
			if($('#current_pw').val() == ''){
				$('.error-current').append(msgRequired);
				$('#current_pw').focus();
				flag = false;
			}
			
			// 새 비밀번호 확인
			if($('#new_pw').val() == ''){
				$('.error-new').append(msgRequired);
				$('#new_pw').focus();
				flag = false;
			}
			
			// 새 비밀번호 확인 필드 확인
			if($('#confirm_pw').val() == ''){
				$('.error-confirm').append(msgRequired);
				$('#confirm_pw').focus();
				flag = false;
			}
			
			// 현재 비밀번호와 새 비밀번호 비교
			if($('#current_pw').val() == $('#new_pw').val()){
				$('.error-new').append(msgPw2);
				$('#new_pw').focus();
				flag = false;
			}
			
			// 새 비밀번호와 새 비밀번호 확인 비교
			if($('#new_pw').val() != $('#confirm_pw').val()){
				$('.error-confirm').append(msgPw3);
				$('#confirm_pw').focus();
				flag = false;
			}
			
			return flag;  // 모든 조건이 참이면 제출 진행
		});
		
    </script>
</body>
</html>
