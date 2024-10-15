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
	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
</style>
</head>
<body>
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">마이페이지 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/schedule/${me_id}"/>">프로그램 일정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/membership/${me_id}"/>">회원권</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/client/mypage/review/list/${me_id}"/>">나의 작성글</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/inquiry/list/${me_id}"/>">문의내역</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwcheck/${me_id}"/>">개인정보수정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwchange/${me_id}"/>">비밀번호 변경</a>
	                    </li>
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<form action="<c:url value="/client/mypage/review/update"/>" method="post" id="form">
						<input type="hidden" name="rp_num" value="${review.rp_num}">
						<input type="hidden" name="me_id" value="${me_id}">
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
							<input type="text" class="form-control" id="rp_title" name="rp_title" placeholder="제목을 입력하세요." value="${review.rp_title}">
						</div>
						<div class="error error-title"></div>
						<div class="form-group">
							<label for="rp_content">내용:</label>
							<textarea class="form-control" id="rp_content" name="rp_content" style="min-height: 400px; height:auto" placeholder="내용을 입력하세요.">${review.rp_content }</textarea>
						</div>
						<div class="error error-content"></div>
						<div class="form-group">
							<button type="submit" class="btn btn-outline-info col-12">글 수정</button>
						</div>
					</form>
					<hr>
					<div>
						<a href="<c:url value="/client/mypage/review/detail/${review.rp_num}/${me_id}"/>" class="btn btn-outline-danger col-12">취소</a>
					</div>
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
    	
</body>
</html>
