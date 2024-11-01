<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

   <style type="text/css">
   	.file-input{border: 1px solid gray; border-radius: 5px;}
   	.img-container{min-height: 400px;}
   	.btn-insert-img{line-height: 21px; width: 42px; height: 38px; border-radius: 50%; padding: 8px;}
   	.btn-delete-img, .btn-delete-img2{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%;}
   	.img-box, .img-box2{border: 0; width:33.33%; height:200px; box-sizing: border-box; position: relative;}
   	#fileList, #fileList2{display: none;}
   </style>

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${br.br_name} 상세보기</h2>
						<p class="sub_title__txt">※ <b>지점명, 지점 주소</b>는 본사 관리자만 수정할 수 있습니다.</p>
					</div>
				
					<div class="table_wrap">
						<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
						<form action="<c:url value="/admin/branch/update"/>" method="post" enctype="multipart/form-data" id="form">
							<input type="hidden" name="me_id" value="${me.me_id}">
							<input type="hidden" name="br_name" value="${br.br_name}">
							<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="br_name">지점명</label>
										</th>
										<td>
											<div class="form-group">${br.br_name}</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="br_address">주소</label>
										</th>
										<td>
											<div class="form-group">(${br.br_postcode}) ${br.br_address}${br.br_extraAddress} ${br.br_detailAddress}</div>
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
											<label for="me_id">${br.br_name} 관리자 아이디</label>
										</th>
										<td>
											<div class="form-group">${me.me_id}</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="me_pw" class="_asterisk">관리자 비밀번호</label>
										</th>
										<td>
											<div class="form-group">
												<input type="password" class="form-control" id="me_pw" name="me_pw" placeholder="비밀번호를 입력하세요.">
											</div>
											<div class="error error-pw"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="me_pw2" class="_asterisk">비밀번호 확인</label>
										</th>
										<td>
											<div class="form-group">
												<input type="password" class="form-control" id="me_pw2" name="me_pw2" placeholder="비밀번호를 다시 입력하세요.">
											</div>
											<div class="error error-pw2"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="me_email">${br.br_name} 관리자 이메일</label>
										</th>
										<td>
											<div class="form-group">${me.me_email}</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="br_detail" class="_asterisk">지점설명</label>
										</th>
										<td>
											<textarea class="form-control" id="br_detail" name="br_detail">${br.br_detail}</textarea>
											<div class="error"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="bf_name" class="_asterisk">등록된 사진</label>
										</th>
										<td>
											<div class="form-group file-input">
												<div class="img-container2 d-flex flex-wrap">
													<c:forEach items="${bfList}" var="bf">
														<div class="img-box2">
												        	<img src="<c:url value="/uploads${bf.bf_name}"/>" style="width:100%; height:100%">
													        	<button type="button" class="btn btn-outline-danger btn-delete-img2" data-num="${bf.bf_num}">
																	<i class="fi fi-bs-cross"></i>
																</button>
															</img>
														</div>
													</c:forEach>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="bf_name2">추가할 사진</label>
										</th>
										<td>
											<div class="form-group file-input">
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
											<div class="error error-file"></div>											
										</td>
									</tr>
								</tbody>
							</table>
							
							<div class="btn_wrap">
								<div class="btn_right_wrap">
									<button type="submit" class="btn btn_insert">수정</button>
								</div>
							</div>
														
						</form>
					</div>				
				
				</section>
			</section>
	
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
				let msgRequired = `<span>필수항목입니다.</span>`;
				let imgRequired = `<span>사진은 최소 1장 등록해야합니다.</span>`;
				
				$('#br_phone').keyup(function(){
					$('.error-phone').children().remove();
					
					if($('#br_phone').val() == ''){
						$('.error-phone').append(msgRequired);
					}else{
						$('.error-phone').children().remove();	
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
					
					if($('#br_phone').val() == ''){
						$('.error-phone').append(msgRequired);
						$('#br_phone').focus();
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
					
					if(count == 0){
						$('.error-file').append(imgRequired);
						flag = false;
					}
		
					return flag;
				});
		    </script>
		    
		    <script type="text/javascript">
		    	// 썸머노트
			    $('#br_detail').summernote({
					  tabsize: 2,
					  height: 350
				});
		    </script>
