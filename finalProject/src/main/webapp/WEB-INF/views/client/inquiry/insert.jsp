<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>1:1문의</title>
<style type="text/css">
	.error{color:red; margin-bottom: 10px;}
	.form-group{margin: 0;}
	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
</style>
</head>
<body>
	
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <div class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
	        </div>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>1:1 문의</h2>
					<form action="<c:url value="/client/inquiry/insert"/>" method="post" id="form">
						<div class="form-group">
							<label for="mi_it_name">문의유형:</label>
							<select name="mi_it_name" class="custom-select mb-3 form-control">
								<c:forEach items="${inquiryTypeList}" var="it">
									<option value="${it.it_name}">${it.it_name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="mi_br_name">지점명:</label>
							<select name="mi_br_name" class="custom-select mb-3 form-control">
								<c:forEach items="${branchList}" var="br">
								<option value="${br.br_name}">${br.br_name}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="form-group">
							<label for="mi_title">제목:</label>
							<input type="text" class="form-control" id="mi_title" name="mi_title" placeholder="제목을 입력하세요.">
						</div>
						<div class="error error-title"></div>
						<div class="form-group">
							<label for="mi_content">내용:</label>
							<textarea class="form-control" id="mi_content" name="mi_content" style="min-height: 400px; height:auto" placeholder="내용을 입력하세요."></textarea>
						</div>
						<div class="error error-content"></div>
						<!-- 
						<div class="form-group">
							<label for="mi_email">이메일:</label>
							<c:choose>
								<c:when test="${user eq null}">
									<span>답변은 이메일을 통해 받아보실 수 있습니다. </span>	
								</c:when>
								<c:when test="${user ne null}">
									<span>답변은 마이페이지에서 확인하실 수 있습니다.</span>
								</c:when>
							</c:choose>
							<input type="email" class="form-control" id="mi_email" name="mi_email" placeholder="이메일을 입력하세요." value="${user.me_email}" <c:if test="${user ne null}">readonly</c:if> >
						</div>
						 -->
						<div class="form-group">
			                <label for="mi_email">이메일:</label>
			                <div style="display: flex; align-items: center;">
			                    <input type="text" class="form-control" id="mi_emailId" name="mi_emailId" placeholder="이메일 아이디" required style="flex: 6; margin-right: 10px;">
			                    <span style="margin-right: 10px;">@</span>
			                    <select class="form-control" id="mi_emailDomain" name="mi_emailDomain" style="flex: 4; margin-right: 10px;">
			                        <option value="">선택</option>
			                        <option value="naver.com">naver.com</option>
			                        <option value="daum.net">daum.net</option>
			                        <option value="google.com">google.com</option>
			                        <option value="yahoo.com">yahoo.com</option>
			                        <option value="custom">직접 입력</option>
			                    </select>
			                    <input type="text" class="form-control" id="mi_customEmailDomain" name="mi_customEmailDomain" placeholder="도메인 직접 입력" style="display: none; flex: 4;">
			                </div>
			            </div>
		            	<div style="display: flex;">
							<div class="error error-emailId" style="flex: 24;"></div>
				            <div class="error error-emailDomain" style="flex: 5;"></div>
				            <div class="error error-customEmailDomain" style="flex: 11;"></div>
			            </div>
						
						<div class="form-group">
							<button type="submit" class="btn btn-outline-info col-12">문의 등록</button>
						</div>
					</form>
	                
	            </div>
	        </main>
	    </div>
	</div>
	
    <script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		let msgEmailId = `<span>아이디가 올바르지 않습니다.</span>`;
		let msgEmailDomain = `<span>도메인이 올바르지 않습니다.</span>`;
		let regexEmailId = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/;
		let regexEmailDomain = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
		
		$('#mi_title').keyup(function(){
			$('.error-title').children().remove();
			
			if($('#mi_title').val() == ''){
				$('.error-title').append(msgRequired);
			}else{
				$('.error-title').children().remove();	
			}
		});
		
		$('#mi_content').keyup(function(){
			$('.error-content').children().remove();
			
			if($('#mi_content').val() == ''){
				$('.error-content').append(msgRequired);
			}else{
				$('.error-content').children().remove();	
			}
		});
	    
		
		$('#mi_emailId').keyup(function(){
			$('.error-emailId').children().remove();
			
			if($('#mi_emailId').val() == ''){
				$('.error-emailId').append(msgRequired);
			}else{
				if(!regexEmailId.test($('#mi_emailId').val())){
					$('.error-emailId').append(msgEmailId);
				}else{
					$('.error-emailId').children().remove();	
				}
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#mi_title').val() == ''){
				$('.error-title').append(msgRequired);
				$('#mi_title').focus();
				flag = false;
			}
			
			if($('#mi_content').val() == ''){
				$('.error-content').append(msgRequired);
				$('#mi_content').focus();
				flag = false;
			}
			
			if($('#mi_emailId').val() == ''){
				$('.error-emailId').append(msgRequired);
				$('#mi_emailId').focus();
				flag = false;
			} else if(!regexEmailId.test($('#mi_emailId').val())){
				$('.error-emailId').append(msgEmailId);
				$('#mi_emailId').focus();
				flag = false;
			}
			
			if($('#mi_emailDomain').val() == ''){
				$('.error-emailDomain').append(msgRequired);
				flag = false;
			}
			
			if($('#mi_emailDomain').val() == 'custom'){
				if($('#mi_customEmailDomain').val() == ''){
					$('.error-customEmailDomain').append(msgRequired);
					$('#mi_customEmailDomain').focus();
					flag = false;
				} else if(!regexEmailDomain.test($('#mi_customEmailDomain').val())){
					$('.error-customEmailDomain').append(msgEmailDomain);
					$('#mi_customEmailDomain').focus();
					flag = false;
				}			
			}
			
		    if (flag) {
		        combineEmail();
		    } else {
		        event.preventDefault();
		    }
			
			return flag;
		});
		
        // 이메일 도메인 선택 변경 시 처리
       document.getElementById('mi_emailDomain').addEventListener('change', function() {
    	   $('.error-emailDomain').children().remove();
    	   $('.error-customEmailDomain').children().remove();
           var customDomainInput = document.getElementById('mi_customEmailDomain');
           if (this.value === 'custom') {
               customDomainInput.style.display = 'block';
               customDomainInput.required = true;
               
	   			$('#mi_customEmailDomain').off('keyup').on('keyup', function(){
					$('.error-customEmailDomain').children().remove();
					
					if($('#mi_customEmailDomain').val() == ''){
						$('.error-customEmailDomain').append(msgRequired);
					}else{
						if(!regexEmailDomain.test($('#mi_customEmailDomain').val())){
							$('.error-customEmailDomain').append(msgEmailDomain);
						}else{
							$('.error-customEmailDomain').children().remove();	
						}
					}
				});               
           } else {
               customDomainInput.style.display = 'none';
               customDomainInput.value = '';
               customDomainInput.required = false;
               $('#mi_customEmailDomain').off('keyup');               
           }
       });

       // 폼 제출 시 이메일을 하나의 필드로 결합하여 숨겨진 필드에 저장
       function combineEmail() {
           const emailId = document.getElementById("mi_emailId").value;
           const emailDomain = document.getElementById("mi_emailDomain").value === 'custom' ? 
                               document.getElementById("mi_customEmailDomain").value : 
                               document.getElementById("mi_emailDomain").value;
           console.log(document.getElementById("mi_emailDomain").value === 'custom')                    
           const emailField = document.createElement("input");
           emailField.setAttribute("type", "hidden");
           emailField.setAttribute("name", "mi_email");
           emailField.setAttribute("value", emailId + "@" + emailDomain);
           document.getElementById("form").appendChild(emailField);
       }

    </script>
        
</body>
</html>
