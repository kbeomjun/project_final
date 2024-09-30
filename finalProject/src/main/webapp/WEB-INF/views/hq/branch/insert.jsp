<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-bold-rounded/css/uicons-bold-rounded.css'>
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-bold-straight/css/uicons-bold-straight.css'>
    
    <style type="text/css">
    	.error{color:red; margin-bottom: 10px;}
    	.form-group{margin: 0;}
    	.file-input, .form-control{border: 1px solid gray; border-radius: 5px;}
    	.img-container{min-height: 400px;}
    	.btn-insert-img{line-height: 21px; width: 42px; height: 38px; border-radius: 50%; padding: 8px;}
    	.btn-delete-img{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%;}
    	.img-box{border: 0; width:33.33%; height:200px; box-sizing: border-box; position: relative;}
    	#fileList, #fileList2{display: none;}
    </style>
</head>
<body>
	<h1>지점 등록</h1>
	<form action="<c:url value="/hq/branch/insert"/>" method="post" enctype="multipart/form-data" id="form">
		<div class="form-group">
			<label for="br_name">지점명:</label>
			<input type="text" class="form-control" id="br_name" name="br_name">
		</div>
		<div class="error error-name"></div>
		<div class="form-group">
			<label for="br_phone">전화번호:</label>
			<input type="text" class="form-control" id="br_phone" name="br_phone">
		</div>
		<div class="error error-phone"></div>
		<div class="form-group">
			<label for="br_address">주소:</label>
			<input type="text" class="form-control" id="br_address" name="br_address">
		</div>
		<div class="error error-address"></div>
		<div class="form-group">
			<label for="me_id">관리자 아이디:</label>
			<input type="text" class="form-control" id="me_id" name="me_id">
		</div>
		<div class="error error-id"></div>
		<div class="form-group">
			<label for="me_pw">관리자 비밀번호:</label>
			<input type="password" class="form-control" id="me_pw" name="me_pw">
		</div>
		<div class="error error-pw"></div>
		<div class="form-group">
			<label for="me_pw2">비밀번호 확인:</label>
			<input type="password" class="form-control" id="me_pw2" name="me_pw2">
		</div>
		<div class="error error-pw2"></div>
		<div class="form-group">
			<label for="me_email">관리자 이메일:</label>
			<input type="text" class="form-control" id="me_email" name="me_email">
		</div>
		<div class="error error-email"></div>
		<div class="form-group">
			<label>
				사진:
			</label>
			<div class="file-input">
				<div class="img-container d-flex flex-wrap align-items-center">
					<div class="mx-auto">
						<label for="fileList" class="btn btn-outline-success btn-insert-img">
							<i class="fi fi-br-plus align-items-center"></i>
						</label>
					</div>
				</div>
			</div>
			<label for="fileList2" class="btn btn-outline-success col-12 mt-3">
				<span>사진 추가(</span>
				<span class="img-count">0</span>
				<span>개)</span>
			</label>
			<input type="file" class="form-control" id="fileList" name="fileList" multiple="multiple" accept="image/*">
			<input type="file" class="form-control" id="fileList2" name="fileList2" multiple="multiple" accept="image/*">
		</div>
		<div class="error error-file"></div>
		<button class="btn btn-outline-info col-12">지점 등록</button>
	</form>
	<hr/>
	<a href="<c:url value="/hq/branch/list"/>" class="btn btn-outline-danger col-12">취소</a>
	
	<script>
		function displayFileList(fileList){
			console.log(fileList);
			var count = fileList.length;
			$('.img-count').text(count);
			if(count > 0){
				for(var i = 0; i < count; i++){
					$('.img-container').children().remove();
					$('.img-container').removeClass('align-items-center')
					let fReader = new FileReader();
				    fReader.readAsDataURL(fileList[i]);
				    fReader.num = i;
				    fReader.onloadend = function(event){
				        var num = this.num;
				    	let path = event.target.result;
				        img = `
				        	<div class="img-box">
					        	<img src="\${path}" style="width:100%; height:100%">
						        	<button type="button" class="btn btn-outline-danger btn-delete-img" data-num="\${num}">
										<i class="fi fi-bs-cross"></i>
									</button>
								</img>
							</div>
				        `;
				        $('.img-container').append(img);
				    }
				}
			}
			else if(count == 0){
				$('.img-container').children().remove();
				$('.img-container').addClass('align-items-center')
		        btn = `
		        	<div class="mx-auto">
						<label for="fileList" class="btn btn-outline-success btn-insert-img">
							<i class="fi fi-br-plus align-items-center"></i>
						</label>
					</div>
		        `;
		        $('.img-container').append(btn);
			}
		}
		
		$(document).on("change", "#fileList", function(){
			displayFileList($("#fileList")[0].files);
		});
		
		const deleteFile = (fileNum) => {
		    const dataTransfer = new DataTransfer();
		    let files = $('#fileList')[0].files;
		    
		    let fileArray = Array.from(files);
		    fileArray.splice(fileNum, 1);
		    
		    fileArray.forEach(file => { dataTransfer.items.add(file); });
		    $('#fileList')[0].files = dataTransfer.files;
		}
		
		$(document).on("click", ".btn-delete-img", function(){
			let fileNum = $(this).data("num");
			console.log(fileNum);
			deleteFile(fileNum);
		    displayFileList($('#fileList')[0].files);
			$(this).parent().remove();
		});
		
		$(document).on("change", "#fileList2", function(){
			const dataTransfer = new DataTransfer();
		    
			let files = $('#fileList')[0].files;
		    let fileArray = Array.from(files);
		    
			let files2 = $('#fileList2')[0].files;
		    let fileArray2 = Array.from(files2);
		    
		    for(var i = 0; i < fileArray2.length; i++){
		    	fileArray.push(fileArray2[i]);
		    }
		    
		    fileArray.forEach(file => { dataTransfer.items.add(file); });
		    $('#fileList')[0].files = dataTransfer.files;
		    
			displayFileList($("#fileList")[0].files);
		});
    </script>
    
    <script type="text/javascript">
		let msgPw2 = `<span>비밀번호와 일치하지 않습니다.</span>`;
		let regexEmail = /^\w{6,13}@\w{4,8}.[a-z]{2,3}$/;
		let msgEmail = `<span>email 형식이 아닙니다.</span>`;
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		$('#br_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#br_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		
		$('#br_phone').keyup(function(){
			$('.error-phone').children().remove();
			
			if($('#br_phone').val() == ''){
				$('.error-phone').append(msgRequired);
			}else{
				$('.error-phone').children().remove();	
			}
		});
		
		$('#br_address').keyup(function(){
			$('.error-address').children().remove();
			
			if($('#br_address').val() == ''){
				$('.error-address').append(msgRequired);
			}else{
				$('.error-address').children().remove();	
			}
		});
		
		$('#me_id').keyup(function(){
			$('.error-id').children().remove();
			
			if($('#me_id').val() == ''){
				$('.error-id').append(msgRequired);
			}else{
				$('.error-id').children().remove();	
			}
		});
		
		$('#me_pw').keyup(function(){
			$('.error-pw').children().remove();
			
			if($('#me_pw').val() == ''){
				$('.error-pw').append(msgRequired);
			}else{
				$('.error-pw').children().remove();	
			}
		});
		
		$('#me_pw2').keyup(function(){
			$('.error-pw2').children().remove();
			
			if($('#me_pw').val() != $('#me_pw2').val()){
				$('.error-pw2').append(msgPw2);
			}else{
				$('.error-pw2').children().remove();	
			}
		});
		
		$('#me_email').keyup(function(){
			$('.error-email').children().remove();
			
			if($('#me_email').val() == ''){
				$('.error-email').append(msgRequired);
			}else{
				if(!regexEmail.test($('#me_email').val())){
					$('.error-email').append(msgEmail);
				}else{
					$('.error-email').children().remove();
				}
			}
		});
		
		$("#fileList").change(function(){
			$('.error-file').children().remove();
			
			var count = $('#fileList')[0].files.length;
			if(count == 0){
				$('.error-file').append(msgRequired);
			}else{
				$('.error-file').children().remove();
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#br_name').val() == ''){
				$('.error-name').append(msgRequired);
				flag = false;
			}
			
			if($('#br_phone').val() == ''){
				$('.error-phone').append(msgRequired);
				flag = false;
			}
			
			if($('#br_address').val() == ''){
				$('.error-address').append(msgRequired);
				flag = false;
			}
			
			if($('#me_id').val() == ''){
				$('.error-id').append(msgRequired);
				flag = false;
			}
			
			if($('#me_pw').val() == ''){
				$('.error-pw').append(msgRequired);
				flag = false;
			}
			
			if($('#me_pw').val() != $('#me_pw2').val()){
				$('.error-pw2').append(msgPw2);
				flag = false;
			}
			
			if($('#me_email').val() == ''){
				$('.error-email').append(msgRequired);
				flag = false;
			}else{
				if(!regexEmail.test($('#me_email').val())){
					$('.error-email').append(msgEmail);
					flag = false;
				}
			}
			
			if($('#fileList')[0].files.length == 0){
				$('.error-file').append(msgRequired);
				flag = false;
			}
			
			return flag;
		});
    </script>
</body>
</html>