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
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">고객센터 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/review/list"/>">리뷰게시판</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/client/inquiry/insert"/>">1:1문의</a>
	                    </li>
	                    <c:if test="${user ne null && user.me_authority eq 'USER'}">
		                    <li class="nav-item">
		                        <a class="nav-link" href="<c:url value="/client/mypage/schedule/${user.me_id}"/>">마이페이지</a>
		                    </li>
	                    </c:if>
	                </ul>
	            </div>
	        </nav>
	
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
						<div class="form-group">
							<label for="mi_email">이메일:</label>
							<span>답변은 이메일을 통해 받아보실 수 있습니다. </span>
							<input type="email" class="form-control" id="mi_email" name="mi_email" placeholder="이메일을 입력하세요." value="${user.me_email}">
						</div>
						<div class="error error-email"></div>
						
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
		
		
		$('#mi_title').keyup(function(){
			$('.error-title').children().remove();
			
			if($('#mi_title').val() == ''){
				$('.error-title').append(msgRequired);
			}else{
				$('.error-title').children().remove();	
			}
		});
		
	    $('#mi_content').on('summernote.change', function() {
	        $('.error-content').children().remove();
	        
	        if ($('#mi_content').summernote('isEmpty')) {
	            $('.error-content').append(msgRequired);
	        } else {
	            $('.error-content').children().remove();
	        }
	    });
	    
		$('#mi_email').keyup(function(){
			$('.error-email').children().remove();
			
			if($('#mi_email').val() == ''){
				$('.error-email').append(msgRequired);
			}else{
				$('.error-email').children().remove();	
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
			
	        if ($('#mi_content').summernote('isEmpty')) {
	            $('.error-content').append(msgRequired);
	            $('#mi_content').focus();
	            flag = false;
	        }
	        
			if($('#mi_email').val() == ''){
				$('.error-email').append(msgRequired);
				$('#mi_email').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
    
	<script>
		$('#mi_content').summernote({
			placeholder: '내용을 작성하세요.',
			tabsize: 2,
			height: 350
		});
    </script>
</body>
</html>
