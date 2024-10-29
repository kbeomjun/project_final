<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>

	<main class="sub_container" id="skipnav_target">
		<section class="sub_banner sub_banner_04"></section>
		<section class="sub_content">
		
			<!-- 왼쪽 사이드바 -->
			<%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
			
			<!-- 오른쪽 컨텐츠 영역 -->
			<section class="sub_content_group">
				<div class="sub_title_wrap">
					<h2 class="sub_title">회원탈퇴</h2>
				</div>
				
	        	<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
				<form action="<c:url value="/mypage/unregister"/>" method="post" id="form">
					<input type="hidden" name="me_id" value="${me_id}">
					<table class="table">
						<colgroup>
							<col style="width: 20%;">
							<col style="width: 80%;">
						</colgroup>
						
						<tbody>
							<tr>
								<th scope="row">
									<label for="current_pw" class="_asterisk">현재 비밀번호</label>
								</th>
								<td>
									<div class="form-group">
										<input type="password" class="form-control" id="current_pw" name="me_pw" placeholder="현재 비밀번호를 입력하세요">
									</div>
									<div class="error error-current"></div>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<button type="submit" class="btn btn_insert">회원탈퇴</button>
						</div>
					</div>					
					
				</form>				
					
			</section>
		
		</section>
	</main>

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
			} else if(!regexPw.test($('#current_pw').val())){
				$('.error-current').append(msgPw);
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
