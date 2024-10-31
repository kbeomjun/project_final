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
				<h2 class="sub_title">프로그램 조회</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<form action="<c:url value="/hq/program/update/${sp.sp_name}"/>" method="post" enctype="multipart/form-data" id="form">
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
									<input type="text" class="form-control" id="sp_name" name="sp_name" placeholder="프로그램명을 입력해주세요." value="${sp.sp_name}">
									<div class="error error-name"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="sp_detail" class="">설명</label>
								</th>
								<td>
									<textarea class="form-control" id="sp_detail" name="sp_detail">${sp.sp_detail}</textarea>
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
											<option value="그룹" <c:if test="${sp.sp_type == '그룹'}">selected</c:if>>그룹</option>
											<option value="단일" <c:if test="${sp.sp_type == '단일'}">selected</c:if>>단일</option>
										</select>
									</div>
									<div class="error error-type"></div>
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
												<c:forEach items="${pfList}" var="pf">
													<div class="img-box">
														<button type="button" class="btn btn_delete btn-delete-img2" data-num="${pf.pf_num}">
															<img src="<c:url value="/uploads${pf.pf_name}"/>">
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
											<span>사진 추가 (</span><span class="img-count">${pfList.size()}</span><span>개)</span>
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
							<a href="<c:url value="/hq/program/list"/>" class="btn btn_cancel">취소</a>
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
			var pf_num = $(this).data("num");
			var str = `
				<input type="hidden" name="numList" value="\${pf_num}">
			`;
			$('.file-input').after(str);
			$('.img-count').text($("#fileList")[0].files.length + ${pfList.size()} - del);
			$(this).parent().remove();
		});
	
		function displayFileList(fileList){
			console.log(fileList);
			var count = fileList.length;
			$('.img-count').text(count + ${pfList.size()} - del);
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
		let msgRequired = `<span>필수항목입니다.</span>`;
		let imgRequired = `<span>사진은 최소 1장 등록해야합니다.</span>`;
		
		$('#sp_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#sp_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		
		$("#fileList").change(function(){
			$('.error-file').children().remove();
			
			var count = $('#fileList')[0].files.length + ${pfList.size()} - del;
			if(count == 0){
				$('.error-file').append(imgRequired);
			}else{
				$('.error-file').children().remove();
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			var count = $('#fileList')[0].files.length + ${pfList.size()} - del;
			
			if($('#sp_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#sp_name').focus();
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
	    $('#sp_detail').summernote({
			  tabsize: 2,
			  height: 350
		});
    </script>
    
    <script>
	    function validateForm() {
	        const maxFileSize = 10 * 1024 * 1024; // 개별 파일 최대 크기 10MB
	        const maxTotalSize = 10 * 1024 * 1024; // 총 파일 크기 제한 10MB
	        const fileInputs = document.querySelectorAll('input[type="file"]'); // 모든 파일 입력 요소 선택
	        let totalSize = 0; // 총 파일 크기 초기화
	
	        fileInputs.forEach(input => {
	            const files = input.files;
	            for (let i = 0; i < files.length; i++) {
	                const fileSize = files[i].size;
	                
	                // 개별 파일 크기 검사
	                if (fileSize > maxFileSize) {
	                    alert("파일의 크기가 10MB를 초과합니다.(업로드 불가)");
	                    return false;
	                }
	
	                totalSize += fileSize; // 총 파일 크기 누적
	            }
	        });
	
	        // 총 파일 크기 검사
	        if (totalSize > maxTotalSize) {
	            alert("첨부한 파일의 총 크기가 10MB를 초과합니다.");
	            return false;
	        }
	
	        return true; // 유효성 검사 통과 여부 반환
	    }
	</script>
</body>