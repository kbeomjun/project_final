<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

	<section class="sub_banner sub_banner_06"></section>
	<section class="sub_content">
        <!-- 왼쪽 사이드바 -->
        <%@ include file="/WEB-INF/views/layout/hqSidebar.jsp" %>

        <!-- 오른쪽 컨텐츠 영역 -->
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">기구 관리</h2>
			</div>
			
			<div class="form-group">
				<input type="text" class="form-control" id="search" name="search" placeholder="검색">
			</div>
		
			<ul class="img-container equipment_warp">
		    		
			</ul>
	    	
	    	<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<button class="btn btn_black js-btn-insert" data-toggle="modal" data-target="#myModal">
							<span>등록<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_black_top_line"></div>
						<div class="btn_black_right_line"></div>
						<div class="btn_black_bottom_line"></div>
						<div class="btn_black_left_line"></div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="myModal">
		    	<div class="modal-dialog modal-dialog-centered">
		      		<form action="<c:url value="/hq/equipment/insert"/>" method="post" enctype="multipart/form-data" id="form" class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">등록</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
			        		<div class="form-group my-3">
								<label for="file" class="equipment_img_insert card-insert">
								    <img class="equipment_img" alt="Card image"
								    	src="https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo-available_87543-11093.jpg?size=626&ext=jpg">
								</label>
								<input type="file" class="form-control display_none" id="file" name="file" accept="image/*">
							</div>
							<div class="error error-file d-flex justify-content-center"></div>
							
							<div class="table_wrap">
								<table class="table">
									<caption class="blind">회원권의 이용권 종류와 기간, 횟수, 가격이 있는 테이블</caption>
									<colgroup>
										<col style="width: auto;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="se_name">기구명</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="se_name" name="se_name">
												</div>
												<div class="error error-name"></div>
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
							<button class="btn btn_black">기구 등록</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
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
			        		<div class="form-group my-3">
								<label for="file2" class="equipment_img_update card-update">
								    
								</label>
								<input type="file" class="form-control display_none" id="file2" name="file2" accept="image/*">
							</div>
							<div class="error error-file2 d-flex justify-content-center"></div>
							
							<div class="table_wrap">
								<table class="table">
									<caption class="blind">회원권의 이용권 종류와 기간, 횟수, 가격이 있는 테이블</caption>
									<colgroup>
										<col style="width: auto;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="se_name">기구명</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="se_name2" name="se_name">
												</div>
												<div class="error error-name2"></div>
												<input type="hidden" id="se_ori_name" name="se_ori_name">
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
			        	</div>
			        	<div class="modal-footer">
							<button class="btn btn_black">기구 수정</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		      		</form>
		    	</div>
	  		</div>
    	</section>
	</section>
	
	<script>
		// 사진 파일
		function displayFileList(file){
			console.log(file);
			$('.card-insert').children().remove();
			if(file.length > 0){
				let fReader = new FileReader();
			    fReader.readAsDataURL(file[0]);
			    fReader.onloadend = function(event){
			    	let path = event.target.result;
			        let img = `
			        	<img class="equipment_img" src="\${path}" alt="Card image">
			        `;
			        $('.card-insert').append(img);
			    }
			}else{
			    let img = `
		    		<img class="equipment_img" alt="Card image"
			    		src="https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo-available_87543-11093.jpg?size=626&ext=jpg">
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
			var count = $('#file2')[0].files.length - del;
			if(count == 0){
				let fReader = new FileReader();
			    fReader.readAsDataURL(file[0]);
			    fReader.onloadend = function(event){
			    	let path = event.target.result;
			    	console.log(path);
			        let img = `
			        	<img class="equipment_img" alt="Card image" src="\${path}">
			        `;
			        $('.card-update').append(img);
			    }
			}else{
				let img = `
		    		<img class="equipment_img" alt="Card image"
			    		src="https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo-available_87543-11093.jpg?size=626&ext=jpg">
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
		
		$("#file2").change(function(){
			$('.error-file2').children().remove();
			
			var count = $('#file2')[0].files.length - del;
			if(count < 0){
				$('.error-file2').append(msgRequired);
			}else{
				$('.error-file2').children().remove();
			}
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
			var count = $('#file2')[0].files.length - del;
			
			if(count < 0){
				$('.error-file2').append(msgRequired);
				flag = false;
			}
			if($('#se_name2').val() == ''){
				$('.error-name2').append(msgRequired);
				$('#se_name2').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
    
    <script>
	    $(document).on('click', '.btn_update', function(){
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
						<img class="equipment_img" alt="Card image" src="<c:url value="/uploads\${se.se_fi_name}"/>">
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
	    	if($('#file')[0].files.length > 0){
		    	deleteFile($('#file')[0].files.length);
	    		let img = `
		    		<img class="card-img-top" alt="Card image"
			    		src="https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo-available_87543-11093.jpg?size=626&ext=jpg">
		    	`;
		    	$('.card-insert').children().remove();
		        $('.card-insert').append(img);
	    	}
	    	
	    	$('.error').children().remove();
	    	$('#se_name').val("");
	    	
	    });
	    const deleteFile = (length) => {
		    const dataTransfer = new DataTransfer();
		    let files = $('#file')[0].files;
		    
		    let fileArray = Array.from(files);
		    fileArray.splice(0, length);
		    
		    fileArray.forEach(file => { dataTransfer.items.add(file); });
		    $('#file')[0].files = dataTransfer.files;
		}
	    
	    var search = "";
	    $('#search').keyup(function(){
	    	search = $('#search').val();
	    	displayList(search);
	    });
	    $(document).ready(function(){
	    	displayList(search);
	    });
	    function displayList(search){
	    	$.ajax({
				async : true,
				url : '<c:url value="/hq/equipment/list"/>', 
				type : 'post', 
				data : {search : search}, 
				dataType : "json",
				success : function (data){
					let seList = data.seList;
					
					var str = ``;
					for(se of seList){
						str += `
							<li class="equipment_item">
								<div class="equipment_img_wrap">
					        		<img class="equipment_img" src="<c:url value="/uploads\${se.se_fi_name}"/>" />
					        	</div>
						    	<div class="equipment_info_wrap">
									<button type="button" class="btn btn_update" data-toggle="modal" data-target="#myModal2" data-name="\${se.se_name}">
										<i class="fi fi-br-edit"></i>
										<p class="">\${se.se_name}</p>
									</button>
								</div>
					    	</li>
						`;
					}
					
					$('.img-container').html(str);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
	    }
    </script>