<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<section class="sub_banner sub_banner_07"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">비밀번호 변경</h2>
					</div>
					
		        	<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
					<form action="<c:url value="/mypage/pwchange/update"/>" method="post" id="form">
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
											<input type="password" class="form-control" id="current_pw" name="current_pw" placeholder="현재 비밀번호를 입력하세요">
										</div>
										<div class="error error-current"></div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="new_pw" class="_asterisk">새 비밀번호</label>
									</th>
									<td>
										<div class="form-group">
											<input type="password" class="form-control" id="new_pw" name="new_pw" placeholder="새 비밀번호를 입력하세요">
										</div>
										<div class="error error-new"></div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="confirm_pw" class="_asterisk">새 비밀번호 확인</label>
									</th>
									<td>
										<div class="form-group">
											<input type="password" class="form-control" id="confirm_pw" name="confirm_pw" placeholder="새 비밀번호를 다시 입력하세요">
										</div>
										<div class="error error-confirm"></div>
									</td>
								</tr>														
							</tbody>
						</table>
						
						<div class="btn_wrap">
							<div class="btn_right_wrap">
								<button type="submit" class="btn btn_insert">변경</button>
							</div>
						</div>					
						
					</form>				
						
				</section>
			
			</section>
	
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
					} else if(!regexPw.test($('#current_pw').val())){
						$('.error-current').append(msgPw);
						$('#current_pw').focus();
						flag = false;				
					}
					
					// 새 비밀번호 확인
					if($('#new_pw').val() == ''){
						$('.error-new').append(msgRequired);
						$('#new_pw').focus();
						flag = false;
					} else if(!regexPw.test($('#new_pw').val())){
						$('.error-new').append(msgPw);
						$('#new_pw').focus();
						flag = false;	
					}
					
					// 새 비밀번호 확인 필드 확인
					if($('#confirm_pw').val() == ''){
						$('.error-confirm').append(msgRequired);
						$('#confirm_pw').focus();
						flag = false;
					} else if(!regexPw.test($('#confirm_pw').val())){
						$('.error-confirm').append(msgPw);
						$('#confirm_pw').focus();
						flag = false;	
					} else if($('#current_pw').val() == $('#new_pw').val()){
						// 현재 비밀번호와 새 비밀번호 비교
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