<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<style>
	.img-card{
		height: 300px;
	}
</style>
			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${em_br_name} 직원 등록</h2>
					</div>
				
					<div class="table_wrap">
						<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
						<form action="<c:url value="/admin/employee/insert"/>" method="post" enctype="multipart/form-data" id="form">
							<input type="hidden" name="em_br_name" value="${em_br_name}">
							<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="mi_it_name" class="_asterisk">프로필 사진 등록</label>
										</th>
										<td>
											<div class="form-group profile_img_wrap img-box">
												<label for="file">
													<img class="img-card" src="<c:url value='/resources/image/common/img_avatar1.jpg' />" alt="image">
												</label>
											</div>
											<input type="file" class="form-control display_none" id="file" name="file" accept="image/*">
											<div class="error error-file"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_name" class="_asterisk">이름</label>
										</th>
										<td>
											<input type="text" class="form-control" id="em_name" name="em_name" placeholder="이름을 입력해주세요.">
											<div class="error error-name"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_phone" class="_asterisk">전화번호</label>
										</th>
										<td>
											<input type="text" class="form-control" id="em_phone" name="em_phone" placeholder="전화번호를 입력해주세요.">
											<div class="error error-phone"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_email" class="_asterisk">이메일</label>
										</th>
										<td>
											<input type="text" class="form-control" id="em_email" name="em_email" placeholder="이메일을 입력해주세요.">
											<div class="error error-email"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_gender" class="_asterisk">성별</label>
										</th>
										<td>
											<div class="form-group">
												<div class="form-check-inline">
													<label class="form-check-label" for="radio1">
														<input type="radio" class="form-check-input" id="radio1" name="em_gender" value="남자">남
													</label>
												</div>
												<div class="form-check-inline">
													<label class="form-check-label" for="radio2">
														<input type="radio" class="form-check-input" id="radio2" name="em_gender" value="여자">여
													</label>
												</div>
											</div>
											<div class="error error-gender"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_position" class="_asterisk">직책</label>
										</th>
										<td>
											<div class="form-group">
												<select name="em_position" id="em_position" class="custom-select form-control">
													<option value="">선택</option>
													<c:forEach items="${programList}" var="program">
														<c:choose>
															<c:when test="${program.sp_type == '단일'}">
																<option value="${program.sp_name}트레이너">${program.sp_name}트레이너</option>
															</c:when>
															<c:otherwise>
																<option value="${program.sp_name}강사">${program.sp_name}강사</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</div>
											<div class="error error-position"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_address" class="_asterisk">주소</label>
										</th>
										<td>
											<div class="form-group">
												<div class="form-inline">
													<input type="text" class="form-control" id="em_postcode" name="em_postcode" placeholder="우편번호" readonly>
													<input class="btn btn_address" onclick="addressPostcode()" value="우편번호 찾기">
												</div>
												<div class="form-group">
													<input type="text" class="form-control" id="em_address" name="em_address" placeholder="주소" readonly>
												</div>
												<div class="form-inline form-inline-50">
													<input type="text" class="form-control" id="em_detailAddress" name="em_detailAddress" placeholder="상세주소">
													<input type="text" class="form-control" id="em_extraAddress" name="em_extraAddress" placeholder="참고항목" readonly>
												</div>
											</div>
											<div class="error error-address"></div>	
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="em_detail" class="_asterisk">직원설명</label>
										</th>
										<td>
											<textarea class="form-control" id="em_detail" name="em_detail">${em.em_detail}</textarea>
											<div class="error"></div>
										</td>
									</tr>									
								</tbody>								
							</table>
							
							<div class="btn_wrap">
								<div class="btn_right_wrap">
									<button type="submit" class="btn btn_insert">등록</button>
									<a href="<c:url value="/admin/employee/list"/>" class="btn btn_cancel">취소</a>
								</div>
							</div>								
														
						</form>
					</div>				
				
				</section>
			</section>

			<script>
				// 사진 파일
				function displayFileList(file){
					console.log(file);
					$('.img-box').children().remove();
					if(file.length > 0){
						let fReader = new FileReader();
					    fReader.readAsDataURL(file[0]);
					    fReader.onloadend = function(event){
					    	let path = event.target.result;
					        img = `
					        	<label for="file">
					        		<img class="img-card" src="\${path}" alt="Card image">
				        		</label>
					        `;
					        $('.img-box').append(img);
					    }
					}else{
						let img = `
							<label for="file">
								<img class="img-card" src="<c:url value='/resources/image/common/img_avatar1.jpg' />" alt="image">
			        		</label>
						`;
						$('.img-box').append(img);
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
					
					if($('#file')[0].files.length == 0){
						$('.error-file').append(imgRequired);
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
					
					if($('#em_position').val() == ''){
						$('.error-position').append(msgRequired);
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