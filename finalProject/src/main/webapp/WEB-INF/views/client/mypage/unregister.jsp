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
	            <%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2 class="mb-3">회원탈퇴</h2>
					<form action="<c:url value='/client/mypage/unregister'/>" method="post" id="form">
					    <input type="hidden" name="me_id" value="${me_id}">
					
					    <div class="form-group">
					        <label for="current_pw">현재 비밀번호:</label>
					        <input type="password" id="current_pw" name="me_pw" class="form-control" placeholder="현재 비밀번호를 입력하세요" required>
					    </div>
					    <div class="error error-current"></div>
					
					    <button type="submit" class="btn btn-primary">회원탈퇴</button>
					</form>
					
	            </div>
	        </main>
	    </div>
	</div>
	
    <script type="text/javascript">
    	let regexPw = /^[a-zA-Z0-9!@#$]{4,15}$/; 
    	let msgPw = `<span>비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.</span>`;
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
			
		    if (flag) {
		        const userConfirmed = confirm("                                    <경고>\n\n탈퇴 시 지점 내에 저장된 모든 회원정보는 사라집니다.\n(복구가 불가능합니다.)\n\n정말 탈퇴 하시겠습니까?");
		        
		        if (!userConfirmed) {
		            event.preventDefault();
		        }
		    } else {
		        event.preventDefault();
		    }
			
		});
		
    </script>
    
</body>
</html>
