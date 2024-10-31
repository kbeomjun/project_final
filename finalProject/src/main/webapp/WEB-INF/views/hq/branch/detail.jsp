<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>
	<section class="sub_banner sub_banner_06"></section>
	<section class="sub_content">
        <!-- 왼쪽 사이드바 -->
        <%@ include file="/WEB-INF/views/layout/hqSidebar.jsp" %>

        <!-- 오른쪽 컨텐츠 영역 -->
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">지점 조회</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<form action="<c:url value="/hq/branch/update/${br.br_name}"/>" method="post" enctype="multipart/form-data" id="form">
					<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
					<table class="table">
						<colgroup>
							<col style="width: 12%;">
							<col style="width: 88%;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<label for="br_name" class="_asterisk">지점명</label>
								</th>
								<td>
									<input type="text" class="form-control" id="br_name" name="br_name" placeholder="지점명을 입력해주세요." value="${br.br_name}">
									<div class="error error-name"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="br_phone" class="_asterisk">전화번호</label>
								</th>
								<td>
									<input type="text" class="form-control" id="br_phone" name="br_phone" placeholder="전화번호를 입력해주세요." value="${br.br_phone}">
									<div class="error error-phone"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="br_address" class="_asterisk">주소</label>
								</th>
								<td>
									<div class="form-group">
										<div class="form-inline">
											<input type="text" class="form-control" id="br_postcode" name="br_postcode" placeholder="우편번호" readonly value="${br.br_postcode}">
											<input class="btn btn_address" onclick="addressPostcode()" value="우편번호 찾기">
										</div>
										<div class="form-group">
											<input type="text" class="form-control" id="br_address" name="br_address" placeholder="주소" readonly value="${br.br_address}">
										</div>
										<div class="form-inline form-inline-50">
											<input type="text" class="form-control" id="br_detailAddress" name="br_detailAddress" placeholder="상세주소" value="${br.br_detailAddress}">
											<input type="text" class="form-control" id="br_extraAddress" name="br_extraAddress" placeholder="참고항목" readonly value="${br.br_extraAddress}">
										</div>
									</div>
									<div class="error error-address"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="br_detail" class="">설명</label>
								</th>
								<td>
									<textarea class="form-control" id="br_detail" name="br_detail">${br.br_detail}</textarea>
									<div class="error"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="me_id" class="_asterisk">관리자 아이디</label>
								</th>
								<td>
									<input type="text" class="form-control" id="me_id" name="me_id" placeholder="아이디를 입력해주세요." value="${me.me_id}">
									<div class="error error-id"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="me_email" class="_asterisk">관리자 이메일</label>
								</th>
								<td>
									<input type="text" class="form-control" id="me_email" name="me_email" placeholder="이메일를 입력해주세요." value="${me.me_email}">
									<div class="error error-email"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label>등록된 사진</label>
								</th>
								<td>
									<div class="form-group">
										<div class="file-input">
											<div class="branch_img_container img-container">
												<c:forEach items="${bfList}" var="bf">
													<div class="img-box">
														<button type="button" class="btn btn_delete btn-delete-img2" data-num="${bf.bf_num}">
															<img src="<c:url value="/uploads${bf.bf_name}"/>">
														</button>
													</div>
												</c:forEach>
											</div>
										</div>
										<div class="error"></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label>사진</label>
								</th>
								<td>
									<div class="form-group">
										<label for="fileList2" class="btn btn_img_insert">
											<span>사진 추가 (</span><span class="img-count">${bfList.size()}</span><span>개)</span>
										</label>
										<div class="file-input">
											<div class="branch_img_container img-container img-container1">
												<div class="img_zero">사진 추가를 눌러 이미지를 추가해주세요.</div>
											</div>
										</div>
										<input type="file" class="form-control display_none" id="fileList" name="fileList" multiple="multiple" accept="image/*">
										<input type="file" class="form-control display_none" id="fileList2" name="fileList2" multiple="multiple" accept="image/*">
									</div>
									<div class="error error-file"></div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<button type="submit" class="btn btn_insert">수정</button>
							<a href="<c:url value="/hq/branch/list"/>" class="btn btn_cancel">취소</a>
						</div>
					</div>
				</form>
	    	</div>
    	</section>
	</section>
	
	<script>
		// 사진 파일
		var del = 0;
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
			$('.img-container1').children().remove();
			if(count > 0){
				for(var i = 0; i < count; i++){
					let fReader = new FileReader();
				    fReader.readAsDataURL(fileList[i]);
				    fReader.num = i;
				    fReader.onloadend = function(event){
				        var num = this.num;
				    	let path = event.target.result;
				        img = `
				        	<div class="img-box">
								<button type="button" class="btn btn_delete btn-delete-img" data-num="\${num}">
									<img src="\${path}">
								</button>
							</div>
				        `;
				        $('.img-container1').append(img);
				    }
				}
				$('.error-file').children().remove();
			}
			else if(count == 0){
		        btn = `
		        	<div class="img_zero">사진 추가를 눌러 이미지를 추가해주세요.</div>
		        `;
		        $('.img-container1').append(btn);
		        $('.error-file').append(imgRequired);
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
		var msgPw2 = `<span>비밀번호와 일치하지 않습니다.</span>`;
		var regexEmail = /^\w{6,13}@\w{4,8}.[a-z]{2,3}$/;
		var msgEmail = `<span>email 형식이 아닙니다.</span>`;
		var msgRequired = `<span>필수항목입니다.</span>`;
		var imgRequired = `<span>사진은 최소 1장 등록해야합니다.</span>`;
		
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