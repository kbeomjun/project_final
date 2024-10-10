<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <style type="text/css">
    	.error{color:red; margin-bottom: 10px;}
    	.form-group{margin: 0;}
    	.form-control{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
    	#file{display: none;}
    </style>
</head>
<body>
	<div class="container" style="margin-top:30px">
		<form action="<c:url value="/hq/equipment/update/${se.se_name}"/>" method="post" enctype="multipart/form-data" id="form">
			<div class="form-group">
				<label for="file" class="card mx-auto" style="width:250px; cursor:pointer">
				    <img class="card-img-top" alt="Card image" style="width:100%" src="<c:url value="/uploads${se.se_fi_name}"/>">
				</label>
				<input type="file" class="form-control" id="file" name="file" accept="image/*">
			</div>
			<div class="error error-file"></div>
			<div class="form-group">
				<label for="se_name">기구명:</label>
				<input type="text" class="form-control" id="se_name" name="se_name" value="${se.se_name}">
			</div>
			<div class="error error-name"></div>
			<button class="btn btn-outline-info col-12">기구 수정</button>
		</form>
		<hr/>
		<a href="<c:url value="/hq/equipment/list"/>" class="btn btn-outline-danger col-12">취소</a>
	</div>
	
	<script>
		// 사진 파일
		var del = 0;
		
		function displayFileList(file){
			console.log(file);
			$('.card').children().remove();
			if(del == 0){
				var str = `
					<input type="hidden" name="isDel" value="Y">
				`;
				$('#file').after(str);
				del++;
			}
			let fReader = new FileReader();
		    fReader.readAsDataURL(file[0]);
		    fReader.onloadend = function(event){
		    	let path = event.target.result;
		        img = `
		        	<img class="card-img-top" src="\${path}" alt="Card image" style="width:100%">
		        `;
		        $('.card').append(img);
		    }
		}
		
		$(document).on("change", "#file", function(){
			displayFileList($("#file")[0].files);
		});
    </script>
    
    <script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		$("#file").change(function(){
			$('.error-file').children().remove();
			
			var count = $('#file')[0].files.length;
			if(count == 0){
				$('.error-file').append(msgRequired);
			}else{
				$('.error-file').children().remove();
			}
		});
		
		$('#se_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#se_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#se_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#se_name').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
</body>
</html>