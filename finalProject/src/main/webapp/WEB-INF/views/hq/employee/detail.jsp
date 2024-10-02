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
    	.address-input{margin-bottom: 10px;}
    	#file{display: none;}
    </style>
</head>
<body>
	<div class="container" style="margin-top:30px">
		<form action="<c:url value="/hq/employee/update/${em.em_num}"/>" method="post" enctype="multipart/form-data" id="form">
			<div class="form-group">
				<label for="file" class="card mx-auto" style="width:250px; cursor:pointer">
				    <img class="card-img-top" src="<c:url value="/uploads${em.em_fi_name}"/>" alt="Card image" style="width:100%">
				</label>
				<input type="file" class="form-control" id="file" name="file" accept="image/*">
			</div>
			<div class="error error-file"></div>
			<div class="form-group">
				<label for="em_name">이름:</label>
				<input type="text" class="form-control" id="em_name" name="em_name" value="${em.em_name}">
			</div>
			<div class="error error-name"></div>
			<div class="form-group">
				<label for="em_phone">전화번호:</label>
				<input type="text" class="form-control" id="em_phone" name="em_phone" value="${em.em_phone}">
			</div>
			<div class="error error-phone"></div>
			<div class="form-group">
				<label for="em_email">이메일:</label>
				<input type="text" class="form-control" id="em_email" name="em_email" value="${em.em_email}">
			</div>
			<div class="error error-email"></div>
			<div class="form-group">
				<label for="em_gender" style="margin-right: 10px;">성별:</label>
				<div class="form-check-inline">
	  				<label class="form-check-label" for="radio1">
	    				<input type="radio" class="form-check-input" id="radio1" name="em_gender" value="남자" <c:if test='${em.em_gender == "남자"}'>checked</c:if>>남
	  				</label>
				</div>
				<div class="form-check-inline">
	  				<label class="form-check-label" for="radio2">
	   			 		<input type="radio" class="form-check-input" id="radio2" name="em_gender" value="여자" <c:if test='${em.em_gender == "여자"}'>checked</c:if>>여
	  				</label>
				</div>	
			</div>
			<div class="error error-gender"></div>
			<div class="form-group">
				<label for="em_position">직책:</label>
				<select name="em_position" class="custom-select mb-3 form-control">
			      	<option value="요가강사" <c:if test='${em.em_position == "요가강사"}'>selected</c:if>>요가강사</option>
			      	<option value="필라테스강사" <c:if test='${em.em_position == "필라테스강사"}'>selected</c:if>>필라테스강사</option>
			      	<option value="PT트레이너" <c:if test='${em.em_position == "PT트레이너"}'>selected</c:if>>PT트레이너</option>
			    </select>
			</div>
			<div class="error error-position"></div>
			<div class="form-group">
				<label for="em_address">주소:</label> <br/>
				<input type="text" class="address-input" id="em_postcode" name="em_postcode" placeholder="우편번호" style="width:130px;" value="${em.em_postcode}">
				<input class="btn btn-outline-dark" onclick="addressPostcode()" value="우편번호 찾기" style="width:130px; margin-bottom:5px;"> <br/>
				<input type="text" class="address-input" id="em_address" name="em_address" placeholder="주소" style="width:100%;" value="${em.em_address}"> <br/>
				<input type="text" class="address-input" id="em_detailAddress" name="em_detailAddress" placeholder="상세주소" style="width:60%; margin-bottom: 0;" value="${em.em_detailAddress}">
				<input type="text" class="address-input" id="em_extraAddress" name="em_extraAddress" placeholder="참고항목" style="width:39.36%; margin-bottom: 0;" value="${em.em_extraAddress}">
			</div>
			<div class="error error-address"></div>
			<div class="form-group">
				<label for="em_br_name">소속:</label>
				<select name="em_br_name" class="custom-select mb-3 form-control">
			      	<c:forEach items="${brList}" var="br">
				      	<option value="${br.br_name}" <c:if test='${em.em_br_name == br.br_name}'>selected</c:if>>${br.br_name}</option>
			      	</c:forEach>
			    </select>
			</div>
			<div class="error error-branch"></div>
			<button class="btn btn-outline-info col-12">직원 수정</button>
		</form>
		<hr/>
		<a href="<c:url value="/hq/employee/list"/>" class="btn btn-outline-danger col-12">취소</a>
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
		let msgPw2 = `<span>비밀번호와 일치하지 않습니다.</span>`;
		let regexEmail = /^\w{4,13}@\w{4,8}.[a-z]{2,3}$/;
		let msgEmail = `<span>email 형식이 아닙니다.</span>`;
		let msgRequired = `<span>필수항목입니다.</span>`;
		let imgRequired = `<span>필수항목입니다.</span>`;
		
		$("#file").change(function(){
			$('.error-file').children().remove();
			
			var count = $('#file')[0].files.length;
			if(count == 0){
				$('.error-file').append(imgRequired);
			}else{
				$('.error-file').children().remove();
			}
		});
		
		$('#em_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#em_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		
		$('#em_phone').keyup(function(){
			$('.error-phone').children().remove();
			
			if($('#em_phone').val() == ''){
				$('.error-phone').append(msgRequired);
			}else{
				$('.error-phone').children().remove();	
			}
		});
		
		$('#em_email').keyup(function(){
			$('.error-email').children().remove();
			
			if($('#em_email').val() == ''){
				$('.error-email').append(msgRequired);
			}else{
				if(!regexEmail.test($('#em_email').val())){
					$('.error-email').append(msgEmail);
				}else{
					$('.error-email').children().remove();
				}
			}
		});
		
		$('#em_detailAddress').keyup(function(){
			$('.error-address').children().remove();
			
			if($('#em_address').val() == '' || $('#em_detailAddress').val() == ''){
				$('.error-address').append(msgRequired);
			}else{
				$('.error-address').children().remove();	
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#em_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#em_name').focus();
				flag = false;
			}
			
			if($('#em_phone').val() == ''){
				$('.error-phone').append(msgRequired);
				$('#em_phone').focus();
				flag = false;
			}
			
			if($('#em_email').val() == ''){
				$('.error-email').append(msgRequired);
				$('#em_email').focus();
				flag = false;
			}else{
				if(!regexEmail.test($('#em_email').val())){
					$('.error-email').append(msgEmail);
					$('#em_email').focus();
					flag = false;
				}
			}
			
			if($('input[name=em_gender]:checked').val() == null){
				$('.error-gender').append(msgRequired);
				$('#em_gender').focus();
				flag = false;
			}
			
			if($('#em_address').val() == '' || $('#em_detailAddress').val() == ''){
				$('.error-address').append(msgRequired);
				$('#em_detailAddress').focus();
				flag = false;
			}

			return flag;
		});
    </script>
    
    <script type="text/javascript">
    	// 주소 api
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
	                    document.getElementById("em_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("em_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('em_postcode').value = data.zonecode;
	                document.getElementById("em_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("em_detailAddress").focus();
	            }
	        }).open();
	    }
    </script>
</body>
</html>