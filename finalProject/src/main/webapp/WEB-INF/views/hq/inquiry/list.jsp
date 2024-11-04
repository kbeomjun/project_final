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
				<h2 class="sub_title">문의 내역</h2>
			</div>
			
			<div class="sub_hd_wrap">
	    		<ul class="tab_list">
			    	<li class="tab_item">
			    		<button type="button" class="tab_link btn-menu btn-menu btn-wait _active" data-name="wait">대기</button>
		    		</li>
			    	<li class="tab_item">
			    		<button type="button" class="tab_link btn-menu btn-menu btn-done" data-name="done">완료</button>
		    		</li>
		    	</ul>
		    </div>
			
	    	<div class="table_wrap box box-wait">
		    	<table class="table table_center table-wait">
			    	<thead id="thead">
			      		<tr>
			        		<th>문의번호</th>
			        		<th>제목</th>
			        		<th>작성자이메일</th>
			        		<th>작성날짜</th>
			        		<th>유형</th>
			        		<th>상태</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${miWaitList}" var="mi">
			    			<tr>
				        		<td>${mi.mi_num}</td>
				        		<td>${mi.mi_title}</td>
				        		<td>${mi.mi_email}</td>
				        		<td>
				        			<fmt:formatDate value="${mi.mi_date}" pattern="yyyy.MM.dd"/>
			        			</td>
				        		<td>${mi.mi_it_name}</td>
				        		<td>${mi.mi_state}</td>
				        		<td>
				        			<button type="button" class="btn btn_green btn-detail" data-toggle="modal" data-target="#myModal" data-num="${mi.mi_num}">등록</button>
				        		</td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="table_wrap box box-done" style="display: none;">
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
				        		<td>${mi.mi_num}</td>
				        		<td>${mi.mi_title}</td>
				        		<td>${mi.mi_email}</td>
				        		<td>
				        			<fmt:formatDate value="${mi.mi_date}" pattern="yyyy.MM.dd"/>
			        			</td>
				        		<td>${mi.mi_it_name}</td>
				        		<td>${mi.mi_state}</td>
				        		<td>
				        			<button type="button" class="btn btn_blue btn-detail2" data-toggle="modal" data-target="#myModal2" data-num="${mi.mi_num}">조회</button>
				        		</td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="modal fade" id="myModal">
		    	<div class="modal-dialog modal-dialog-centered">
		    		<form action="<c:url value="/hq/inquiry/update"/>" method="post" id="form" class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">조회</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
							<div class="table_wrap">
								<table class="table">
									<colgroup>
										<col style="width: auto;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="mi_title">제목</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_title" name="mi_title" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_email">이메일</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_email" name="mi_email" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_date">날짜</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_date" name="mi_date" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_it_name">유형</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_it_name" name="mi_it_name" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_content">내용</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_content" name="mi_content" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_answer">답변</label></th>
							                <td>
							                	<div>
													<textarea class="form-control" id="mi_answer" name="mi_answer"></textarea>
												</div>
												<div class="error error-answer"></div>
												<input type="hidden" id="mi_num" name="mi_num">
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			        		<button class="btn btn_black">답변 등록</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</form>
		    	</div>
	  		</div>
	    	
	    	<div class="modal fade" id="myModal2">
		    	<div class="modal-dialog modal-dialog-centered">
		    		<div class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">조회</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
							<div class="table_wrap">
								<table class="table">
									<colgroup>
										<col style="width: auto;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="mi_title">제목</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_title2" name="mi_title" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_email">이메일</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_email2" name="mi_email" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_date">날짜</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_date2" name="mi_date" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_it_name">유형</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_it_name2" name="mi_it_name" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_content">내용</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="mi_content2" name="mi_content" readonly>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label for="mi_answer">답변</label></th>
							                <td>
							                	<div>
													<textarea class="form-control" id="mi_answer2" name="mi_answer" readonly></textarea>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</div>
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
		// 데이터테이블
		var table = $('.table-wait').DataTable({
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
				        emptyTable: ""
				    },
				    scrollY: 400,
				    stateSave: true,
				    stateDuration: 300,
				    paging: false,
				    info: false,
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
				        emptyTable: ""
				    },
				    scrollY: 400,
				    stateSave: true,
				    stateDuration: 300,
				    paging: false,
				    info: false,
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
				url : '<c:url value="/hq/inquiry/detail"/>', 
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
					
					$('#mi_title').val(mi.mi_title);
					$('#mi_email').val(mi.mi_email);
					$('#mi_date').val(mi_date);
					$('#mi_it_name').val(mi.mi_it_name);
					$('#mi_content').val(mi.mi_content);
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
				url : '<c:url value="/hq/inquiry/detail"/>', 
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
					
					$('#mi_title2').val(mi.mi_title);
					$('#mi_email2').val(mi.mi_email);
					$('#mi_date2').val(mi_date);
					$('#mi_it_name2').val(mi.mi_it_name);
					$('#mi_content2').val(mi.mi_content);
					$('#mi_answer2').val(mi.mi_answer);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
	</script>
</body>