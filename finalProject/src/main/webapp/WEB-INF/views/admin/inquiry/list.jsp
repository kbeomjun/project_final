<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>문의내역</title>
<style type="text/css">
	.error{color:red; margin-bottom: 10px;}
	.form-group{margin: 0;}
	.form-control{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
	#mi_content, #mi_answer, #mi_content2, #mi_answer2{min-height: 200px; resize: none; overflow-y: auto;}
	#thead th{text-align: center;}
	#tbody td{text-align: center;}
	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
   	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
</style>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">지점관리자 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/program/list"/>">프로그램관리</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/schedule/list"/>">프로그램일정관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/order/list"/>">운동기구 발주목록</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/employee/list"/>">직원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/member/list"/>">회원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/branch/detail"/>">지점 상세보기</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/equipment/list"/>">운동기구 보유목록</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/equipment/change"/>">운동기구 재고 변동내역</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/admin/inquiry/list"/>">문의내역</a>
	                    </li>	                    	                    	                    	                    	                    	                    
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${br_name} 문의내역</h2>
			    	<div>
				    	<button type="button" class="btn btn-outline-info btn-menu btn-wait active" data-name="wait">대기</button>
				    	<button type="button" class="btn btn-outline-info btn-menu btn-done" data-name="done">완료</button>
				    </div>
				    <hr>
			    	<div class="mt-3 box box-wait">
			    		<table class="table table-hover table-wait">
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
						        			<button type="button" class="btn btn-outline-info btn-detail" data-toggle="modal" data-target="#myModal" data-num="${mi.mi_num}">조회</button>
						        		</td>
						      		</tr>
					    		</c:forEach>
					    	</tbody>
						</table>
					</div>
					<div class="mt-3 box box-done" style="display: none;">
						<table class="table table-hover table-done">
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
						        			<button type="button" class="btn btn-outline-info btn-detail2" data-toggle="modal" data-target="#myModal2" data-num="${mi.mi_num}">조회</button>
						        		</td>
						      		</tr>
					    		</c:forEach>
					    	</tbody>
						</table>
					</div>
						
					<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-dialog-centered">
				    		<form action="<c:url value="/admin/inquiry/update"/>" method="post" id="form" class="modal-content">
					        	<div class="modal-header">
					          		<h4 class="modal-title">정보</h4>
					          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
					        	</div>
					        	<div class="modal-body">
					          		<div class="form-group">
										<label for="mi_title">제목:</label>
										<input type="text" class="form-control" id="mi_title" name="mi_title" readonly>
									</div>
									<div class="error"></div>
									<div class="form-group">
										<label for="mi_email">이메일:</label>
										<input type="text" class="form-control" id="mi_email" name="mi_email" readonly>
									</div>
									<div class="error"></div>
									<div class="form-group">
										<label for="mi_date">날짜:</label>
										<input type="text" class="form-control" id="mi_date" name="mi_date" readonly>
									</div>
									<div class="error"></div>
									<div class="form-group">
										<label for="mi_it_name">유형:</label>
										<input type="text" class="form-control" id="mi_it_name" name="mi_it_name" readonly>
									</div>
									<div class="error"></div>
									<div class="form-group">
										<label for="mi_content">내용:</label>
										<textarea class="form-control" id="mi_content" name="mi_content" readonly></textarea>
									</div>
									<div class="error"></div>
									<div class="form-group">
										<label for="mi_answer">답변:</label>
										<textarea class="form-control" id="mi_answer" name="mi_answer"></textarea>
									</div>
									<div class="error error-answer"></div>
									<input type="hidden" id="mi_num" name="mi_num">
									<button class="btn btn-outline-info col-12">답변 등록</button>
					        	</div>
					        	<div class="modal-footer">
					          		<button type="button" class="btn btn-danger btn-close" data-dismiss="modal">취소</button>
					        	</div>
				      		</form>
				    	</div>
			  		</div>
			  		
			  		<div class="modal fade" id="myModal2">
					    	<div class="modal-dialog modal-dialog-centered">
					    		<div class="modal-content">
						        	<div class="modal-header">
						          		<h4 class="modal-title">정보</h4>
						          		<button type="button" class="close" data-dismiss="modal">&times;</button>
						        	</div>
						        	<div class="modal-body">
						          		<div class="form-group">
											<label for="mi_title2">제목:</label>
											<input type="text" class="form-control" id="mi_title2" name="mi_title2" readonly>
										</div>
										<div class="error"></div>
										<div class="form-group">
											<label for="mi_email2">이메일:</label>
											<input type="text" class="form-control" id="mi_email2" name="mi_email2" readonly>
										</div>
										<div class="error"></div>
										<div class="form-group">
											<label for="mi_date2">날짜:</label>
											<input type="text" class="form-control" id="mi_date2" name="mi_date2" readonly>
										</div>
										<div class="error"></div>
										<div class="form-group">
											<label for="mi_it_name2">유형:</label>
											<input type="text" class="form-control" id="mi_it_name2" name="mi_it_name2" readonly>
										</div>
										<div class="error"></div>
										<div class="form-group">
											<label for="mi_content2">내용:</label>
											<textarea class="form-control" id="mi_content2" name="mi_content2" readonly></textarea>
										</div>
										<div class="error"></div>
										<div class="form-group">
											<label for="mi_answer2">답변:</label>
											<textarea class="form-control" id="mi_answer2" name="mi_answer2" readonly></textarea>
										</div>
										<div class="error error-answer"></div>
						        	</div>
						        	<div class="modal-footer">
						          		<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
						        	</div>
					      		</div>
					    	</div>
				  		</div>
					
	            </div>
	        </main>
	    </div>
	</div>
	
	
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
			    emptyTable: ""
			},
			scrollY: 600,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [5, 6], orderable: false },
		        { targets: [0, 1, 2, 3, 4, 5, 6], className: "align-content-center"}
		    ]
		});
	
		$('.btn-menu').click(function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("active");
			$('.btn-'+name).addClass("active");
			
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
					scrollY: 600,
				    paging: false,
				    info: false,
				    order: [[ 0, "asc" ]],
				    columnDefs: [
				        { targets: [5, 6], orderable: false },
				        { targets: [0, 1, 2, 3, 4, 5, 6], className: "align-content-center"}
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
					scrollY: 600,
				    paging: false,
				    info: false,
				    order: [[ 0, "desc" ]],
				    columnDefs: [
				        { targets: [5, 6], orderable: false },
				        { targets: [0, 1, 2, 3, 4, 5, 6], className: "align-content-center"}
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
</html>
