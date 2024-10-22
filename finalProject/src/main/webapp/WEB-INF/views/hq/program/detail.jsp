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
    	.file-input{border: 1px solid gray; border-radius: 5px;}
    	.img-container{min-height: 400px;}
    	.img-container2{min-height: 200px;}
    	.btn-insert-img{line-height: 21px; width: 42px; height: 38px; border-radius: 50%; padding: 10px 6px;}
    	.btn-delete-img, .btn-delete-img2{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%;}
    	.img-box, .img-box2{border: 0; width:33.33%; height:200px; box-sizing: border-box; position: relative;}
    	#fileList, #fileList2{display: none;}
    </style>
</head>
<body>
	<div class="container" style="margin-top:30px">
		<form action="<c:url value="/hq/program/update/${sp.sp_name}"/>" method="post" enctype="multipart/form-data" id="form">
			<div class="form-group">
				<label for="sp_name">프로그램명:</label>
				<input type="text" class="form-control" id="sp_name" name="sp_name" value="${sp.sp_name}">
			</div>
			<div class="error error-name"></div>
			<div class="form-group">
				<label for="sp_detail">설명:</label>
				<textarea class="form-control" id="sp_detail" name="sp_detail">${sp.sp_detail}</textarea>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label for="sp_type">유형:</label>
				<select name="sp_type" class="custom-select form-control">
					<option value="그룹" <c:if test="${sp.sp_type == '그룹'}">selected</c:if>>그룹</option>
					<option value="단일" <c:if test="${sp.sp_type == '단일'}">selected</c:if>>단일</option>
			    </select>
			</div>
			<div class="error error-type"></div>
			<div class="form-group">
				<label>
					등록된 사진:
				</label>
				<div class="file-input">
					<div class="img-container2 d-flex flex-wrap">
						<c:forEach items="${pfList}" var="pf">
							<div class="img-box2">
					        	<img src="<c:url value="/uploads${pf.pf_name}"/>" style="width:100%; height:100%;">
						        	<button type="button" class="btn btn-outline-danger btn-delete-img2" data-num="${pf.pf_num}">
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
			<button class="btn btn-outline-info col-12">프로그램 수정</button>
		</form>
		<hr/>
		<a href="<c:url value="/hq/program/list"/>" class="btn btn-outline-danger col-12">취소</a>
	</div>
	
	<script>
		// 사진 파일
		var del = 0;
		displayFileList($("#fileList")[0].files);
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
</body>
</html>