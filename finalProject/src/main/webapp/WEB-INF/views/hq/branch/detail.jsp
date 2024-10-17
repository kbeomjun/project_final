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
    	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
    	.file-input{border: 1px solid gray; border-radius: 5px;}
    	.address-input{margin-bottom: 10px;}
    	.img-container{min-height: 400px;}
    	.btn-insert-img{line-height: 21px; width: 42px; height: 38px; border-radius: 50%; padding: 10px 6px;}
    	.btn-delete-img, .btn-delete-img2{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%;}
    	.img-box, .img-box2{border: 0; width:33.33%; height:200px; box-sizing: border-box; position: relative;}
    	#fileList, #fileList2{display: none;}
    </style>
</head>
<body>
	<div class="container" style="margin-top:30px">
		<form action="<c:url value="/hq/branch/update/${br.br_name}"/>" method="post" enctype="multipart/form-data" id="form">
			<div class="form-group">
				<label for="br_name">지점명:</label>
				<input type="text" class="form-control" id="br_name" name="br_name" value="${br.br_name}">
			</div>
			<div class="error error-name"></div>
			<div class="form-group">
				<label for="br_phone">전화번호:</label>
				<input type="text" class="form-control" id="br_phone" name="br_phone" value="${br.br_phone}">
			</div>
			<div class="error error-phone"></div>
			<div class="form-group">
				<label for="br_address">주소:</label> <br/>
				<input type="text" class="address-input" id="br_postcode" name="br_postcode" placeholder="우편번호" style="width:130px;" readonly value="${br.br_postcode}">
				<input class="btn btn-info" onclick="addressPostcode()" value="우편번호 찾기" style="width:130px; margin-bottom:5px;"> <br/>
				<input type="text" class="address-input" id="br_address" name="br_address" placeholder="주소" style="width:100%;" readonly value="${br.br_address}"> <br/>
				<input type="text" class="address-input" id="br_detailAddress" name="br_detailAddress" placeholder="상세주소" style="width:60%; margin-bottom: 0;" value="${br.br_detailAddress}">
				<input type="text" class="address-input" id="br_extraAddress" name="br_extraAddress" placeholder="참고항목" style="width:39.36%; margin-bottom: 0;" readonly value="${br.br_extraAddress}">
			</div>
			<div class="error error-address"></div>
			<div class="form-group">
				<label for="br_detail">지점설명:</label>
				<textarea class="form-control" id="br_detail" name="br_detail">${br.br_detail}</textarea>
			</div>
			<div class="form-group">
				<label for="me_id">관리자 아이디:</label>
				<input type="text" class="form-control" id="me_id" name="me_id" value="${me.me_id}">
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
				<input type="text" class="form-control" id="me_email" name="me_email" value="${me.me_email}">
			</div>
			<div class="error error-email"></div>
			<div class="form-group">
				<label>
					등록된 사진:
				</label>
				<div class="file-input">
					<div class="img-container2 d-flex flex-wrap">
						<c:forEach items="${bfList}" var="bf">
							<div class="img-box2">
					        	<img src="<c:url value="/uploads${bf.bf_name}"/>" style="width:100%; height:100%;">
						        	<button type="button" class="btn btn-outline-danger btn-delete-img2" data-num="${bf.bf_num}">
										<i class="fi fi-bs-cross"></i>
									</button>
								</img>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="error"></div>
			<div class="form-group">
				<label>
					추가할 사진:
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
			<button class="btn btn-outline-info col-12">지점 수정</button>
		</form>
		<hr/>
		<a href="<c:url value="/hq/branch/list"/>" class="btn btn-outline-danger col-12">취소</a>
	</div>
	
	<script>
		// 사진 파일
		var del = 0;
		displayFileList($("#fileList")[0].files);
		$('.btn-delete-img2').click(function(){
			del++;
			var bf_num = $(this).data("num");
			var str = `
				<input type="hidden" name="numList" value="\${bf_num}">
			`;
			$('.file-input').after(str);
			$('.img-count').text($("#fileList")[0].files.length + ${bfList.size()} - del);
			$(this).parent().remove();
		});
	
		function displayFileList(fileList){
			console.log(fileList);
			var count = fileList.length;
			$('.img-count').text(count + ${bfList.size()} - del);
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
					        	<img src="\${path}" style="width:100%; height:100%;">
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
		const deleteFile2 = (length) => {
		    const dataTransfer = new DataTransfer();
		    let files = $('#fileList2')[0].files;
		    
		    let fileArray = Array.from(files);
		    fileArray.splice(0, length);
		    
		    fileArray.forEach(file => { dataTransfer.items.add(file); });
		    $('#fileList2')[0].files = dataTransfer.files;
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
		    deleteFile2($('#fileList2')[0].files.length);
		    
		    fileArray.forEach(file => { dataTransfer.items.add(file); });
		    $('#fileList')[0].files = dataTransfer.files;
		    
			displayFileList($("#fileList")[0].files);
		});
    </script>
    
    <script type="text/javascript">
	 	// 필수항목 체크
		let msgPw2 = `<span>비밀번호와 일치하지 않습니다.</span>`;
		let regexEmail = /^\w{6,13}@\w{4,8}.[a-z]{2,3}$/;
		let msgEmail = `<span>email 형식이 아닙니다.</span>`;
		let msgRequired = `<span>필수항목입니다.</span>`;
		let imgRequired = `<span>사진은 최소 1장 등록해야합니다.</span>`;
		
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
		
		$('#br_detailAddress').keyup(function(){
			$('.error-address').children().remove();
			
			if($('#br_address').val() == '' || $('#br_detailAddress').val() == ''){
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
			
			var count = $('#fileList')[0].files.length + ${bfList.size()} - del;
			if(count == 0){
				$('.error-file').append(imgRequired);
			}else{
				$('.error-file').children().remove();
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			var count = $('#fileList')[0].files.length + ${bfList.size()} - del;
			
			if($('#br_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#br_name').focus();
				flag = false;
			}
			
			if($('#br_phone').val() == ''){
				$('.error-phone').append(msgRequired);
				$('#br_phone').focus();
				flag = false;
			}
			
			if($('#br_address').val() == '' || $('#br_detailAddress').val() == ''){
				$('.error-address').append(msgRequired);
				$('#br_detailAddress').focus();
				flag = false;
			}
			
			if($('#me_id').val() == ''){
				$('.error-id').append(msgRequired);
				$('#me_id').focus();
				flag = false;
			}
			
			if($('#me_pw').val() == ''){
				$('.error-pw').append(msgRequired);
				$('#me_pw').focus();
				flag = false;
			}
			
			if($('#me_pw').val() != $('#me_pw2').val()){
				$('.error-pw2').append(msgPw2);
				$('#me_pw2').focus();
				flag = false;
			}
			
			if($('#me_email').val() == ''){
				$('.error-email').append(msgRequired);
				$('#me_email').focus();
				flag = false;
			}else{
				if(!regexEmail.test($('#me_email').val())){
					$('.error-email').append(msgEmail);
					$('#me_email').focus();
					flag = false;
				}
			}
			
			if(count == 0){
				$('.error-file').append(imgRequired);
				flag = false;
			}

			return flag;
		});
    </script>
    
    <script type="text/javascript">
    	// 주소 api, 썸머노트
	    function addressPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("br_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("br_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('br_postcode').value = data.zonecode;
	                document.getElementById("br_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("br_detailAddress").focus();
	            }
	        }).open();
	    }
    	
	    $('#br_detail').summernote({
			  tabsize: 2,
			  height: 350
		});
    </script>
</body>
</html>