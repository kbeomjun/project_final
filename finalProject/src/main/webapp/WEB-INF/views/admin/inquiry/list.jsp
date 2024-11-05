<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${br_name} 문의내역</h2>
					</div>
					
					<!-- 탭 버튼 -->
			    	<div class="sub_hd_wrap">
			    		<ul class="tab_list">
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-wait _active" data-name="wait">대기</button></li>
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-done" data-name="done">완료</button></li>
				    	</ul>
				    </div>
				    
					<!-- 문의 목록 -->
					<div class="table_wrap">
				    	<div class="box box-wait">
				    		<table class="table table_center table-wait">
						    	<thead id="thead">
						      		<tr>
						        		<th>문의번호</th>
						        		<th>제목</th>
						        		<th>작성자이메일</th>
						        		<th>날짜</th>
						        		<th>유형</th>
						        		<th>상태</th>
						        		<th></th>
						      		</tr>
						    	</thead>
						    	<tbody id="tbody">
						    		<c:forEach items="${miWaitList}" var="mi">
						    			<tr>
							        		<td class="align-content-center">${mi.mi_num}</td>
							        		<td class="align-content-center">${mi.mi_title}</td>
							        		<td class="align-content-center">${mi.mi_email}</td>
							        		<td class="align-content-center">
							        			<fmt:formatDate value="${mi.mi_date}" pattern="yyyy.MM.dd"/>
						        			</td>
							        		<td class="align-content-center">${mi.mi_it_name}</td>
							        		<td class="align-content-center">${mi.mi_state}</td>
							        		<td class="align-content-center">
							        			<button type="button" class="btn btn_green btn-detail" data-toggle="modal" data-target="#myModal" data-num="${mi.mi_num}">등록</button>
							        		</td>
							      		</tr>
						    		</c:forEach>
						    	</tbody>
							</table>
						</div>
						
						<div class="box box-done" style="display: none;">
							<table class="table table_center table-done">
						    	<thead id="thead">
						      		<tr>
						        		<th>문의번호</th>
						        		<th>제목</th>
						        		<th>작성자</th>
						        		<th>날짜</th>
						        		<th>유형</th>
						        		<th>상태</th>
						        		<th></th>
						      		</tr>
						    	</thead>
						    	<tbody id="tbody">
						    		<c:forEach items="${miDoneList}" var="mi">
						    			<tr>
							        		<td class="align-content-center">${mi.mi_num}</td>
							        		<td class="align-content-center">${mi.mi_title}</td>
							        		<td class="align-content-center">${mi.mi_email}</td>
							        		<td class="align-content-center">
							        			<fmt:formatDate value="${mi.mi_date}" pattern="yyyy.MM.dd"/>
						        			</td>
							        		<td class="align-content-center">${mi.mi_it_name}</td>
							        		<td class="align-content-center">${mi.mi_state}</td>
							        		<td class="align-content-center">
							        			<button type="button" class="btn btn_blue btn-detail2" data-toggle="modal" data-target="#myModal2" data-num="${mi.mi_num}">조회</button>
							        		</td>
							      		</tr>
						    		</c:forEach>
						    	</tbody>
							</table>
						</div>
					</div>			    
					
					<!-- 답변대기 조회 modal -->
					<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-dialog-centered">
				    		<form action="<c:url value="/admin/inquiry/update"/>" method="post" id="form" class="modal-content">
				    			<input type="hidden" id="mi_num" name="mi_num">
					        	<div class="modal-header">
					          		<h4 class="modal-title">정보</h4>
					          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
					        	</div>
					        	<div class="modal-body">
					        		<table class="table">
										<colgroup>
											<col style="width: 20%;">
											<col style="width: 80%;">
										</colgroup>
										
										<tbody>
											<tr>
												<th scope="row">
													<label for="mi_title">제목</label>
												</th>
												<td>
													<div class="form-group" id="mi_title"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_email">이메일</label>
												</th>
												<td>
													<div class="form-group" id="mi_email"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_date">날짜</label>
												</th>
												<td>
													<div class="form-group" id="mi_date"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_it_name">유형</label>
												</th>
												<td>
													<div class="form-group" id="mi_it_name"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_content">내용</label>
												</th>
												<td>
													<div class="form-group" id="mi_content"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_answer">답변</label>
												</th>
												<td>
													<div class="form-group">
														<textarea class="form-control" id="mi_answer" name="mi_answer"></textarea>
													</div>
													<div class="error error-answer"></div>
												</td>
											</tr>
										</tbody>
									</table>
									
					        	</div>
					        	<div class="modal-footer">
									<button type="submit" class="btn btn_insert">등록</button>
					          		<button type="button" class="btn btn_red" data-dismiss="modal">취소</button>
					        	</div>
				      		</form>
				    	</div>
			  		</div>
			  		
					<!-- 답변완료 조회 modal -->
					<div class="modal fade" id="myModal2">
				    	<div class="modal-dialog modal-dialog-centered">
				    		<form action="<c:url value="/admin/inquiry/update"/>" method="post" id="form" class="modal-content">
				    			<input type="hidden" id="mi_num" name="mi_num">
					        	<div class="modal-header">
					          		<h4 class="modal-title">정보</h4>
					          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
					        	</div>
					        	<div class="modal-body">
					        		<table class="table">
										<colgroup>
											<col style="width: 20%;">
											<col style="width: 80%;">
										</colgroup>
										
										<tbody>
											<tr>
												<th scope="row">
													<label for="mi_title2">제목</label>
												</th>
												<td>
													<div class="form-group" id="mi_title2"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_email2">이메일</label>
												</th>
												<td>
													<div class="form-group" id="mi_email2"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_date2">날짜</label>
												</th>
												<td>
													<div class="form-group" id="mi_date2"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_it_name2">유형</label>
												</th>
												<td>
													<div class="form-group" id="mi_it_name2"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">
													<label for="mi_content2">내용</label>
												</th>
												<td>
													<div class="form-group" id="mi_content2"></div>
												</td>
											</tr>
										</tbody>
									</table>
									
					        		<table class="table">
										<colgroup>
											<col style="width: 20%;">
											<col style="width: 80%;">
										</colgroup>
										
										<tbody>
											<tr>
												<th scope="row">
													<label for="mi_answer2">답변</label>
												</th>
												<td>
													<div class="form-group" id="mi_answer2"></div>
												</td>
											</tr>
										</tbody>
									</table>
					        	</div>
					        	<div class="modal-footer">
					          		<button type="button" class="btn btn_red" data-dismiss="modal">취소</button>
					        	</div>
				      		</form>
				    	</div>
			  		</div>			  		
			
				</section>
			</section>

	
	<script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		$('#mi_answer').keyup(function(){
			$('.error-answer').children().remove();
			
			if($('#mi_answer').val() == ''){
				$('.error-answer').append(msgRequired);
			}else{
				$('.error-answer').children().remove();	
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#mi_answer').val() == ''){
				$('.error-answer').append(msgRequired);
				$('#mi_answer').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
	
	<script type="text/javascript">
		var table = $('.table-wait').DataTable({
			language: {
			    search: "",
			    searchPlaceholder: "검색",
			    zeroRecords: "",
			    emptyTable: "",
			    lengthMenu: ""
			},
		    pageLength: 10,
		    info: false,
		    stateSave: true,
		    stateDuration: 300,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [5, 6], orderable: false }
		    ]
		});
	
		$('.btn-menu').click(function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("_active");
			$('.btn-'+name).addClass("_active");
			
			$('.box').css("display", "none");
			$('.box-'+name).css("display", "block");
			
			table.destroy();
			if(name == 'wait'){
				table = $('.table-'+name).DataTable({
					language: {
						search: "",
						searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: "",
				        lengthMenu: ""
				    },
				    pageLength: 10,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 0, "asc" ]],
				    columnDefs: [
				        { targets: [5, 6], orderable: false }
				    ]
				});
			}else{
				table = $('.table-'+name).DataTable({
					language: {
						search: "",
						searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: "",
				        lengthMenu: ""
				    },
				    pageLength: 10,				        
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 0, "desc" ]],
				    columnDefs: [
				        { targets: [5, 6], orderable: false }
				    ]
				});
			}
		});
	
		$('.btn-detail').click(function(){
			var mi_num = $(this).data("num"); 
			
			$.ajax({
				async : true,
				url : '<c:url value="/admin/inquiry/detail"/>', 
				type : 'get', 
				data : {mi_num : mi_num}, 
				dataType : "json",
				success : function (data){
					let mi = data.mi;
					var mi_date = (new Date(mi.mi_date)).toLocaleDateString('ko-KR', {
						year: 'numeric',
						month: '2-digit',
						day: '2-digit',
						})
						.replace(/\./g, '')
						.replace(/\s/g, '.')
					
					$('#mi_title').text(mi.mi_title);
					$('#mi_email').text(mi.mi_email);
					$('#mi_date').text(mi_date);
					$('#mi_it_name').text(mi.mi_it_name);
					$('#mi_content').text(mi.mi_content);
					$('#mi_num').val(mi.mi_num);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
		$('.btn-close').click(function(){
			$('.error').children().remove();
			$('#mi_answer').val("");
		});
		
		$('.btn-detail2').click(function(){
			var mi_num = $(this).data("num"); 
			
			$.ajax({
				async : true,
				url : '<c:url value="/admin/inquiry/detail"/>', 
				type : 'get', 
				data : {mi_num : mi_num}, 
				dataType : "json",
				success : function (data){
					let mi = data.mi;
					var mi_date = (new Date(mi.mi_date)).toLocaleDateString('ko-KR', {
						year: 'numeric',
						month: '2-digit',
						day: '2-digit',
						})
						.replace(/\./g, '')
						.replace(/\s/g, '.')
					
					$('#mi_title2').text(mi.mi_title);
					$('#mi_email2').text(mi.mi_email);
					$('#mi_date2').text(mi_date);
					$('#mi_it_name2').text(mi.mi_it_name);
					$('#mi_content2').text(mi.mi_content);
					$('#mi_answer2').text(mi.mi_answer);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
	</script>