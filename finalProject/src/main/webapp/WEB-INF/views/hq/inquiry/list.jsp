<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
    	.error{color:red; margin-bottom: 10px;}
    	.form-group{margin: 0;}
    	.form-control{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
    	#mi_content, #mi_answer, #mi_content2, #mi_answer2{min-height: 200px; resize: none; overflow-y: auto;}
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
		          		<a class="nav-link" href="<c:url value="/hq/equipment/list"/>">운동기구 관리</a>
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
		          		<a class="nav-link active" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
		    	<div>
			    	<button type="button" class="btn btn-outline-info btn-menu btn-wait active" data-name="wait">답변대기</button>
			    	<button type="button" class="btn btn-outline-info btn-menu btn-done" data-name="done">답변완료</button>
			    </div>
			    <hr>
		    	<div class="mt-3">
		    		<table class="table table-hover table-wait">
				    	<thead>
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
				    	<tbody>
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
				    		<c:if test="${miWaitList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="7">등록된 문의내역이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
					<table class="table table-hover table-done" style="display: none;">
				    	<thead>
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
				    	<tbody>
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
				    		<c:if test="${miDoneList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="7">완료된 문의내역이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
					<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-dialog-centered">
				    		<form action="<c:url value="/hq/inquiry/update"/>" method="post" id="form" class="modal-content">
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
	    	</div>
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
			
			console.log($('#mi_title').val());
			console.log($('#mi_content').val());
			
			return flag;
		});
    </script>
	
	<script type="text/javascript">
		$('.btn-menu').click(function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("active");
			$('.btn-'+name).addClass("active");
			
			$('.table').css("display", "none");
			$('.table-'+name).css("display", "block");
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
					$('#mi_num').val(mi_num);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
		$('.btn-close').click(function(){
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
</html>