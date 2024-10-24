<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>직원 상세</title>
<style type="text/css">
	.error{color:red; margin-bottom: 10px;}
	.form-group{margin: 0;}
	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
	.address-input{margin-bottom: 10px;}
	#file{display: none;}
</style>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${em.em_name} 직원 상세</h2>
					<div class="container" style="margin-top:30px">
						<form action="<c:url value="/admin/employee/update"/>" method="post" enctype="multipart/form-data" id="form">
							<input type="hidden" name="em_br_name" value="${em.em_br_name}">
							<input type="hidden" name="em_num" value="${em.em_num}">
							<div class="form-group">
								<label for="file" class="card mx-auto" style="width:250px; cursor:pointer">
								    <img class="card-img-top" src="<c:url value="/uploads${em.em_fi_name}"/>" alt="Card image" style="width:100%; height:100%;">
								</label>
								<input type="file" class="form-control" id="file" name="file" accept="image/*">
							</div>
							<div class="error error-file d-flex justify-content-center"></div>
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
									<c:forEach items="${programList}" var="program">
										<c:choose>
											<c:when test="${program.sp_type == '단일'}">
												<option value="${program.sp_name}트레이너" <c:if test='${em.em_position eq program.sp_name.concat("트레이너")}'>selected</c:if>>${program.sp_name}트레이너</option>
											</c:when>
											<c:otherwise>
												<option value="${program.sp_name}강사" <c:if test='${em.em_position eq program.sp_name.concat("강사")}'>selected</c:if>>${program.sp_name}강사</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
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
							<div class="error error-branch"></div>
							<div class="form-group">
								<label for="em_detail">직원설명:</label>
								<textarea class="form-control" id="em_detail" name="em_detail">${em.em_detail}</textarea>
							</div>
							<div class="error"></div>
											
							<button type="submit" class="btn btn-outline-info col-12">직원정보 수정</button>
						</form>
						<a href="<c:url value="/admin/employee/delete/${em.em_num}"/>" class="btn btn-outline-danger col-12 mt-3 btn-delete">직원 삭제</a>
						<hr/>
						<a href="<c:url value="/admin/employee/list"/>" class="btn btn-outline-danger col-12">취소</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>	
	
	<script type="text/javascript">
		$('.btn-delete').click(function(e){
			if(!confirm("정말 삭제하시겠습니까?\n삭제하시면 복구할 수 없습니다.")){
				e.preventDefault();
			}
		});
	</script>

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
			var count = $('#file')[0].files.length - del;
			if(count == 0){
				let fReader = new FileReader();
			    fReader.readAsDataURL(file[0]);
			    fReader.onloadend = function(event){
			    	let path = event.target.result;
			        img = `
			        	<img class="card-img-top" src="\${path}" alt="Card image" style="width:100%; height:100%;">
			        `;
			        $('.card').append(img);
			    }
			}else{
				let img = `
					<img class="card-img-top" src="https://www.w3schools.com/bootstrap4/img_avatar1.png" alt="Card image" style="width:100%; height:100%;">
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
			
			var count = $('#file')[0].files.length - del;
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
			var count = $('#file')[0].files.length - del;
			
			if(count < 0){
				$('.error-file').append(msgRequired);
				flag = false;
			}
			
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
	
    <script type="text/javascript">
    	// 썸머노트
    	$('#em_detail').summernote({
			  tabsize: 2,
			  height: 350
		});
    </script>

</body>
</html>
