<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<body>
	<section class="sub_banner sub_banner_06"></section>
	<section class="sub_content">
        <!-- 왼쪽 사이드바 -->
        <%@ include file="/WEB-INF/views/layout/hqSidebar.jsp" %>

        <!-- 오른쪽 컨텐츠 영역 -->
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">FAQ 관리</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			        		<th>FAQ번호</th>
			        		<th>제목</th>
			        		<th>작성날짜</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${FAQList}" var="mi" varStatus="status">
			    			<tr>
				        		<td>${status.count}</td>
				        		<td>${mi.mi_title}</td>
				        		<td>
				        			<fmt:formatDate value="${mi.mi_date}" pattern="yyyy.MM.dd"/>
			        			</td>
				        		<td>
				        			<button type="button" class="btn btn_yellow btn-detail" data-toggle="modal" data-target="#myModal2" data-num="${mi.mi_num}">수정</button>
				        		</td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<button type="button" class="btn btn_black js-btn-insert" data-toggle="modal" data-target="#myModal">
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
		    		<form action="<c:url value="/hq/FAQ/insert"/>" method="post" id="form" class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">등록</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
							<div class="table_wrap">
								<table class="table">
									<colgroup>
										<col style="width: 20%;">
										<col style="width: 80%;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="mi_title">제목</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_title" name="mi_title">
												</div>
												<div class="error error-title"></div>
							                </td>
							            </tr>
										<tr>
											<th scope="row">
												<label for="mi_it_name">유형</label>
											</th>
											<td>
												<div class="form-group">
													<select name="mi_it_name" class="custom-select form-control" style="width: 100%;">
														<option value="" selected>선택</option>
														<c:forEach items="${itList}" var="it">
															<option value="${it.it_name}">${it.it_name}</option>
														</c:forEach>
													</select>
												</div>
												<div class="error error-type"></div>
											</td>
										</tr>
										<tr>
											<th scope="col"><label for="mi_content">내용</label></th>
							                <td>
							                	<div>
													<textarea class="form-control" id="mi_content" name="mi_content"></textarea>
												</div>
												<div class="error error-content"></div>
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			        		<button class="btn btn_black">등록</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</form>
		    	</div>
	  		</div>
	  		
	  		<div class="modal fade" id="myModal2">
		    	<div class="modal-dialog modal-dialog-centered">
		    		<form action="<c:url value="/hq/FAQ/update"/>" method="post" id="form2" class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">수정</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
							<div class="table_wrap">
								<table class="table">
									<colgroup>
										<col style="width: 20%;">
										<col style="width: 80%;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="mi_title">제목</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_title2" name="mi_title">
												</div>
												<div class="error error-title2"></div>
							                </td>
							            </tr>
										<tr>
											<th scope="row">
												<label for="mi_it_name">유형</label>
											</th>
											<td>
												<div class="form-group">
													<select id="mi_it_name2" name="mi_it_name" class="custom-select form-control" style="width: 100%;">
														<c:forEach items="${itList}" var="it">
															<option value="${it.it_name}">${it.it_name}</option>
														</c:forEach>
													</select>
												</div>
												<div class="error error-type2"></div>
											</td>
										</tr>
										<tr>
											<th scope="col"><label for="mi_content">내용</label></th>
							                <td>
							                	<div>
													<textarea class="form-control" id="mi_content2" name="mi_content"></textarea>
												</div>
												<div class="error error-content2"></div>
												<input type="hidden" id="mi_num2" name="mi_num">
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			        		<button class="btn btn_black">수정</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</form>
		    	</div>
	  		</div>
    	</section>
	</section>
	
	<script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		$('#mi_title').keyup(function(){
			$('.error-title').children().remove();
			
			if($('#mi_title').val() == ''){
				$('.error-title').append(msgRequired);
			}else{
				$('.error-title').children().remove();	
			}
		});
		$('select[name=mi_it_name]').change(function(){
			$('.error-type').children().remove();
			if($("select[name=mi_it_name]").val() == ''){
				$('.error-type').append(msgRequired);
			}else{
				$('.error-type').children().remove();
			}
		});
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			let code = $('#mi_content').summernote("code");
			
			if($('#mi_title').val() == ''){
				$('.error-title').append(msgRequired);
				$('#mi_title').focus();
				flag = false;
			}
			if($("select[name=mi_it_name]").val() == ''){
				$('.error-type').append(msgRequired);
				flag = false;
			}
			if(code == '<p><br></p>' || code == '<br>' || code == ''){
				$('.error-content').append(msgRequired);
				flag = false;
			}
			
			return flag;
		});
		
		$('#mi_title2').keyup(function(){
			$('.error-title2').children().remove();
			
			if($('#mi_title2').val() == ''){
				$('.error-title2').append(msgRequired);
			}else{
				$('.error-title2').children().remove();	
			}
		});
		$('#form2').submit(function(){
			$('.error').children().remove();
			let flag = true;
			let code = $('#mi_content2').summernote("code");
			
			if($('#mi_title2').val() == ''){
				$('.error-title2').append(msgRequired);
				$('#mi_title2').focus();
				flag = false;
			}
			if(code == '<p><br></p>' || code == '<br>' || code == ''){
				$('.error-content2').append(msgRequired);
				flag = false;
			}
			
			return flag;
		});
    </script>
	
	<script type="text/javascript">
		// 데이터테이블
		var table = $('#table').DataTable({
			language: {
				search: "",
				searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
		    scrollY: 400,
		    stateSave: true,
		    stateDuration: 300,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [3], orderable: false }
		    ]
		});
	
		$('.btn-detail').click(function(){
			var mi_num = $(this).data("num"); 
			
			$.ajax({
				async : true,
				url : '<c:url value="/hq/FAQ/detail"/>', 
				type : 'get', 
				data : {mi_num : mi_num}, 
				dataType : "json",
				success : function (data){
					let mi = data.mi;
					
					$('#mi_title2').val(mi.mi_title);
					$('#mi_content2').summernote('code', mi.mi_content);
					$('#mi_num2').val(mi.mi_num);
					$("select[name=mi_it_name]").val(mi.mi_it_name).prop("selected", true);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
		
		$('.btn-close').click(function(){
			$('.error').children().remove();
			$('#mi_title').val("");
			$('#mi_content').summernote('reset');
			$("select[name=mi_it_name]").val("").prop("selected", true);
		});
	</script>
	
	<script type="text/javascript">
		// 썸머노트
		$('#mi_content').summernote({
			tabsize: 2,
			height: 350,
			callbacks: {
				onKeyup: function(e) {
					$('.error-content').children().remove();
					
					let code = $('#mi_content').summernote("code");
					if(code == '<p><br></p>' || code == '<br>' || code == ''){
						$('.error-content').append(msgRequired);
					}else{
						$('.error-content').children().remove();
					}
				}
			}
		});
		
		$('#mi_content2').summernote({
			tabsize: 2,
			height: 350,
			callbacks: {
				onKeyup: function(e) {
					$('.error-content2').children().remove();
					
					let code = $('#mi_content2').summernote("code");
					if(code == '<p><br></p>' || code == '<br>' || code == ''){
						$('.error-content2').append(msgRequired);
					}else{
						$('.error-content2').children().remove();
					}
				}
			}
		});
	</script>
</body>