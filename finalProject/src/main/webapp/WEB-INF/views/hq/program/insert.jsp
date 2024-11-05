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
				<h2 class="sub_title">프로그램 등록</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<form action="<c:url value="/hq/program/insert"/>" method="post" enctype="multipart/form-data" id="form">
					<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
					<table class="table">
						<colgroup>
							<col style="width: 12%;">
							<col style="width: 88%;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<label for="sp_name" class="_asterisk">프로그램명</label>
								</th>
								<td>
									<input type="text" class="form-control" id="sp_name" name="sp_name" placeholder="프로그램명을 입력해주세요.">
									<div class="error error-name"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="sp_detail" class="">설명</label>
								</th>
								<td>
									<textarea class="form-control" id="sp_detail" name="sp_detail"></textarea>
									<div class="error"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="sp_type" class="_asterisk">유형</label>
								</th>
								<td>
									<div class="form-group">
										<select name="sp_type" class="custom-select form-control">
											<option value="" selected>선택</option>
											<option value="그룹">그룹</option>
											<option value="단일">단일</option>
										</select>
									</div>
									<div class="error error-type"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label class="_asterisk">사진</label>
								</th>
								<td>
									<div class="form-group">
										<label for="fileList2" class="btn btn_img_insert">
											<span>사진 추가 (</span><span class="img-count">0</span><span>개)</span>
										</label>
										<div class="file-input">
											<div class="branch_img_container img-container">
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
							<button type="submit" class="btn btn_insert">등록</button>
							<a href="<c:url value="/hq/program/list"/>" class="btn btn_cancel">취소</a>
						</div>
					</div>
				</form>
	    	</div>
    	</section>
	</section>
	
	<script>
		// 사진 파일
		function displayFileList(fileList){
			console.log(fileList);
			var count = fileList.length;
			$('.img-count').text(count);
			$('.img-container').children().remove();
			console.log(count);
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
				        $('.img-container').append(img);
				    }
				}
				$('.error-file').children().remove();
			}
			else if(count == 0){
		        btn = `
		        	<div class="img_zero">사진 추가를 눌러 이미지를 추가해주세요.</div>
		        `;
		        $('.img-container').append(btn);
				$('.error-file').append(imgRequired);
			}
		}
		
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
		    
		    fileArray.forEach(file => { dataTransfer.items.add(file); });
		    $('#fileList')[0].files = dataTransfer.files;
		    
		    deleteFile2($('#fileList2')[0].files.length);
			displayFileList($("#fileList")[0].files);
		});
    </script>
    
    <script type="text/javascript">
    	// 필수항목 체크
		var msgRequired = `<span>필수항목입니다.</span>`;
		var imgRequired = `<span>사진은 최소 1장 등록해야합니다.</span>`;
		
		$('#sp_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#sp_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		
		$('select[name=sp_type]').change(function(){
			$('.error-type').children().remove();
			if($("select[name=sp_type]").val() == ''){
				$('.error-type').append(msgRequired);
			}else{
				$('.error-type').children().remove();
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#sp_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#sp_name').focus();
				flag = false;
			}
			
			if($("select[name=sp_type]").val() == ''){
				$('.error-type').append(msgRequired);
				flag = false;
			}
			
			if($('#fileList')[0].files.length == 0){
				$('.error-file').append(imgRequired);
				flag = false;
			}
			
			return flag;
		});
    </script>
    
    <script type="text/javascript">
    	// 썸머노트
	    $('#sp_detail').summernote({
			  tabsize: 2,
			  height: 350
		});
    </script>
</body>
