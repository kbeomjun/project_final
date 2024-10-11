<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>리뷰게시글 등록</title>
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
	                    <li class="nav-item active">
	                        <a href="<c:url value="/client/review/list"/>" class="btn btn-outline-info mb-2">리뷰게시판</a>
	                    </li>
	                    <li class="nav-item">
	                        <a href="<c:url value="/client/inquiry/insert"/>" class="btn btn-outline-info mb-2">1:1문의</a>
	                    </li>
	                    <c:if test="${user ne null && user.me_authority eq 'USER'}">
		                    <li class="nav-item">
		                        <a href="<c:url value="/client/mypage/schedule/${user.me_id}"/>" class="btn btn-outline-info mb-2">마이페이지</a>
		                    </li>
	                    </c:if>
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>리뷰게시글 등록</h2>
					<form action="<c:url value="/client/review/insert"/>" method="post" id="form">
						<div class="form-group">
							<label for="rp_pa_num">리뷰에 작성할 결제내역:</label>
							<select name="rp_pa_num" class="custom-select mb-3 form-control">
								<c:forEach items="${paymentList}" var="pa">
									<c:set var="formattedDate">
									    <fmt:formatDate value="${pa.pa_date}" pattern="yyyy년 MM월 dd일" />
									</c:set>
									<option value="${pa.pa_num}">${formattedDate} ${pa.pt_type}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="rp_br_name">지점명:</label>
							<select name="rp_br_name" class="custom-select mb-3 form-control">
								<c:forEach items="${branchList}" var="br">
								<option value="${br.br_name}">${br.br_name}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="form-group">
							<label for="rp_title">제목:</label>
							<input type="text" class="form-control" id="rp_title" name="rp_title" placeholder="제목을 입력하세요.">
						</div>
						<div class="error error-title"></div>
						<div class="form-group">
							<label for="rp_content">내용:</label>
							<textarea class="form-control" id="rp_content" name="rp_content" style="min-height: 400px; height:auto" placeholder="내용을 입력하세요."></textarea>
						</div>
						<div class="error error-content"></div>
						<div class="form-group">
							<button type="submit" class="btn btn-outline-info col-12">글 등록</button>
						</div>
					</form>
	                
	            </div>
	        </main>
	    </div>
	</div>

    <script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		
		$('#rp_title').keyup(function(){
			$('.error-title').children().remove();
			
			if($('#rp_title').val() == ''){
				$('.error-title').append(msgRequired);
			}else{
				$('.error-title').children().remove();	
			}
		});
		
	    $('#rp_content').on('summernote.change', function() {
	        $('.error-content').children().remove();
	        
	        if ($('#rp_content').summernote('isEmpty')) {
	            $('.error-content').append(msgRequired);
	        } else {
	            $('.error-content').children().remove();
	        }
	    });
		
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#rp_title').val() == ''){
				$('.error-title').append(msgRequired);
				$('#rp_title').focus();
				flag = false;
			}
			
	        if ($('#rp_content').summernote('isEmpty')) {
	            $('.error-content').append(msgRequired);
	            $('#rp_content').focus();
	            flag = false;
	        }
			
			return flag;
		});
    </script>
    
	<script>
		$('#rp_content').summernote({
			placeholder: '내용을 작성하세요.',
			tabsize: 2,
			height: 350
		});
    </script>
</body>
</html>
