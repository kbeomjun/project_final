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
	<h1 class="mt-3 mb-3">리뷰게시글 등록</h1>
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
		<div class="text-right mb-3">
			<button type="submit" class="btn btn-outline-info col-12">글 등록</button>
		</div>
	</form>
	
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
