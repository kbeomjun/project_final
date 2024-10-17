<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
		.img-container{height: 800px; overflow-y: auto;}
    	.img-box{width:33%; height:220px; box-sizing: border-box; position: relative; margin: 20px 0; cursor:pointer;}
    	.img-name{border: 1px solid gray;}
    	.img-text{margin-bottom: 0; padding: 5px;}
    	.btn-update{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%;}
    	.error{color:red; margin-bottom: 10px;}
    	.form-group{margin: 0;}
    	.form-control{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
    	#file, #file2{display: none;}
	</style>
</head>
<body>
	<div class="container" style="margin-top:30px">
	  	<div class="row">
	    	<div class="col-sm-2">
		    	<ul class="nav nav-pills flex-column">
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/branch/list"/>">지점 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/employee/list"/>">직원 관리</a>
	       	 		</li>
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/equipment/list"/>">운동기구 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/stock/list"/>">재고 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/order/list"/>">발주 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/paymentType/list"/>">회원권 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/member/list"/>">회원 조회</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
			    <div>
			    	<button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#myModal">등록</button>
			    </div>
			    <hr>
		    	<div class="img-container d-flex flex-wrap">
		    		<c:forEach items="${seList}" var="se">
						<div class="card img-box">
				        	<img class="card-img-top" src="<c:url value="/uploads${se.se_fi_name}"/>" style="width:100%; height:100%;">
					        	<button type="button" class="btn btn-outline-warning btn-update" data-toggle="modal" data-target="#myModal2" data-name="${se.se_name}">
									<i class="fi fi-br-edit"></i>
								</button>
							</img>
					    	<div class="img-name d-flex align-content-center">
					      		<p class="img-text mx-auto">${se.se_name}</p>
					    	</div>
						</div>
		    		</c:forEach>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<form action="<c:url value="/hq/equipment/insert"/>" method="post" enctype="multipart/form-data" id="form" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">등록</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				        		<div class="form-group">
									<label for="file" class="card card-insert mx-auto" style="width:250px; cursor:pointer">
									    <img class="card-img-top" alt="Card image" style="width:100%; height:100%;"
									    	src="https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo-available_87543-11093.jpg?size=626&ext=jpg">
									    <div class="card-img-overlay d-flex flex-wrap align-items-center">
										    <div class="mx-auto">
										      	<label for="file" class="btn">사진등록</label>
										    </div>
									    </div>
									</label>
									<input type="file" class="form-control" id="file" name="file" accept="image/*">
								</div>
								<div class="error error-file d-flex justify-content-center"></div>
								<div class="form-group">
									<label for="se_name">기구명:</label>
									<input type="text" class="form-control" id="se_name" name="se_name">
								</div>
								<div class="error error-name"></div>
								<button class="btn btn-outline-info col-12">기구 등록</button>
				        	</div>
				        	<div class="modal-footer">
				          		<a href="#" class="btn btn-danger btn-close" data-dismiss="modal">취소</a>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
		  		<div class="modal fade" id="myModal2">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<form action="<c:url value="/hq/equipment/update"/>" method="post" enctype="multipart/form-data" id="form2" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">등록</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				        		<div class="form-group">
									<label for="file2" class="card card-update mx-auto" style="width:250px; cursor:pointer">
									    
									</label>
									<input type="file" class="form-control" id="file2" name="file2" accept="image/*">
								</div>
								<div class="error error-file2 d-flex justify-content-center"></div>
								<div class="form-group">
									<label for="se_name">기구명:</label>
									<input type="text" class="form-control" id="se_name2" name="se_name">
								</div>
								<div class="error error-name2"></div>
								<input type="hidden" id="se_ori_name" name="se_ori_name">
								<button class="btn btn-outline-warning col-12">기구 수정</button>
				        	</div>
				        	<div class="modal-footer">
				          		<a href="#" class="btn btn-danger btn-close" data-dismiss="modal">취소</a>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
	    	</div>
	  	</div>
	</div>
	
	<script>
		// 사진 파일
		function displayFileList(file){
			console.log(file);
			$('.card-insert').children().remove();
			let fReader = new FileReader();
		    fReader.readAsDataURL(file[0]);
		    fReader.onloadend = function(event){
		    	let path = event.target.result;
		        let img = `
		        	<img class="card-img-top" src="\${path}" alt="Card image" style="width:100%">
		        `;
		        $('.card-insert').append(img);
		    }
		}
		$(document).on("change", "#file", function(){
			displayFileList($("#file")[0].files);
		});
		
		var del = 0;
		function displayFileList2(file){
			console.log(file);
			$('.card-update').children().remove();
			if(del == 0){
				var str = `
					<input type="hidden" name="isDel" value="Y">
				`;
				$('#file2').after(str);
				del++;
			}
			let fReader = new FileReader();
		    fReader.readAsDataURL(file[0]);
		    fReader.onloadend = function(event){
		    	let path = event.target.result;
		    	console.log(path);
		        let img = `
		        	<img class="card-img-top card-img" alt="Card image" style="width:100%; height:100%;" src="\${path}">
		        `;
		        $('.card-update').append(img);
		    }
		}
		$(document).on("change", "#file2", function(){
			displayFileList2($("#file2")[0].files);
		});
    </script>
    
    <script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		$("#file").change(function(){
			$('.error-file').children().remove();
			
			var count = $('#file')[0].files.length;
			if(count == 0){
				$('.error-file').append(msgRequired);
			}else{
				$('.error-file').children().remove();
			}
		});
		$('#se_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#se_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#file')[0].files.length == 0){
				$('.error-file').append(msgRequired);
				flag = false;
			}
			
			if($('#se_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#se_name').focus();
				flag = false;
			}
			
			return flag;
		});
		
		$('#se_name2').keyup(function(){
			$('.error-name2').children().remove();
			
			if($('#se_name2').val() == ''){
				$('.error-name2').append(msgRequired);
			}else{
				$('.error-name2').children().remove();	
			}
		});
		$('#form2').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#se_name2').val() == ''){
				$('.error-name2').append(msgRequired);
				$('#se_name2').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
    
    <script>
	    $('.btn-update').click(function(){
			var se_name = $(this).data("name");
			
			$.ajax({
				async : true,
				url : '<c:url value="/hq/equipment/update"/>', 
				type : 'get', 
				data : {se_name : se_name}, 
				dataType : "json",
				success : function (data){
					let se = data.se;
					$('#se_name2').val(se.se_name);
					$('#se_ori_name').val(se.se_name);
					
					let img = `
						<img class="card-img-top card-img" alt="Card image" style="width:100%; height:100%;" src="<c:url value="/uploads\${se.se_fi_name}"/>">
			        `;
			        $('.card-update').children().remove();
			        $('.card-update').append(img);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
	    
	    $('.btn-close').click(function(){
	    	$('.error').children().remove();
	    });
    </script>
</body>
</html>