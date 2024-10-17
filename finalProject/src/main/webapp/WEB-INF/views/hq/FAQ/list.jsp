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
    	#thead th{text-align: center;}
    	#tbody td{text-align: left;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
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
		          		<a class="nav-link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/FAQ/list"/>">FAQ</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/refund/list"/>">환불 처리</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
		    	<div>
			    	<button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#myModal">등록</button>
			    </div>
			    <hr>
		    	<div class="mt-3">
		    		<table class="table table-hover" id="table">
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
					        		<td class="align-content-center">${status.count}</td>
					        		<td class="align-content-center">${mi.mi_title}</td>
					        		<td class="align-content-center">
					        			<fmt:formatDate value="${mi.mi_date}" pattern="yyyy.MM.dd"/>
				        			</td>
					        		<td class="align-content-center">
					        			<button type="button" class="btn btn-outline-info btn-detail" data-toggle="modal" data-target="#myModal2" data-num="${mi.mi_num}">조회</button>
					        		</td>
					      		</tr>
				    		</c:forEach>
				    	</tbody>
					</table>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			    		<form action="<c:url value="/hq/FAQ/insert"/>" method="post" id="form" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">정보</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				          		<div class="form-group">
									<label for="mi_title">제목:</label>
									<input type="text" class="form-control" id="mi_title" name="mi_title">
								</div>
								<div class="error error-title"></div>
								<div class="form-group">
									<label for="mi_it_name">유형:</label>
									<select name="mi_it_name" class="custom-select mb-3 form-control">
										<c:forEach items="${itList}" var="it">
											<option value="${it.it_name}">${it.it_name}</option>
										</c:forEach>
								    </select>
								</div>
								<div class="error error-position"></div>
								<div class="form-group">
									<label for="mi_content">내용:</label>
									<textarea class="form-control" id="mi_content" name="mi_content"></textarea>
								</div>
								<div class="error error-content"></div>
								<button class="btn btn-outline-info col-12">FAQ 등록</button>
				        	</div>
				        	<div class="modal-footer">
				          		<button type="button" class="btn btn-danger btn-close" data-dismiss="modal">취소</button>
				        	</div>
			      		</form>
			    	</div>
		    	</div>
		    	<div class="modal fade" id="myModal2">
			    	<div class="modal-dialog modal-dialog-centered">
			    		<form action="<c:url value="/hq/FAQ/update"/>" method="post" id="form2" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">정보</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				          		<div class="form-group">
									<label for="mi_title">제목:</label>
									<input type="text" class="form-control" id="mi_title2" name="mi_title">
								</div>
								<div class="error error-title2"></div>
								<div class="form-group">
									<label for="mi_it_name">유형:</label>
									<select id="mi_it_name2" name="mi_it_name" class="custom-select mb-3 form-control">
										<c:forEach items="${itList}" var="it">
											<option value="${it.it_name}">${it.it_name}</option>
										</c:forEach>
								    </select>
								</div>
								<div class="error error-position2"></div>
								<div class="form-group">
									<label for="mi_content">내용:</label>
									<textarea class="form-control" id="mi_content2" name="mi_content"></textarea>
								</div>
								<div class="error error-content2"></div>
								<input type="hidden" id="mi_num2" name="mi_num">
								<button class="btn btn-outline-warning col-12">FAQ 수정</button>
				        	</div>
				        	<div class="modal-footer">
				          		<button type="button" class="btn btn-danger btn-close" data-dismiss="modal">취소</button>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
	    	</div>
	  	</div>
	</div>
	
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
		$('#mi_content').keyup(function(){
			$('.error-content').children().remove();
			
			if($('#mi_content').val() == ''){
				$('.error-content').append(msgRequired);
			}else{
				$('.error-content').children().remove();	
			}
		});
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#mi_title').val() == ''){
				$('.error-title').append(msgRequired);
				$('#mi_title').focus();
				flag = false;
			}
			if($('#mi_content').val() == ''){
				$('.error-content').append(msgRequired);
				$('#mi_content').focus();
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
		$('#mi_content2').keyup(function(){
			$('.error-content2').children().remove();
			
			if($('#mi_content2').val() == ''){
				$('.error-content2').append(msgRequired);
			}else{
				$('.error-content2').children().remove();	
			}
		});
		$('#form2').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#mi_title2').val() == ''){
				$('.error-title2').append(msgRequired);
				$('#mi_title2').focus();
				flag = false;
			}
			if($('#mi_content2').val() == ''){
				$('.error-content2').append(msgRequired);
				$('#mi_content2').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
	
	<script type="text/javascript">
		var table = $('#table').DataTable({
			language: {
				search: "",
				searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
			scrollY: 600,
		    paging: false,
		    info: false,
		    order: [[ 2, "asc" ]],
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
					$('#mi_content2').val(mi.mi_content);
					$('#mi_num2').val(mi.mi_num);
					$("select[name=mi_it_name]").val(mi.mi_it_name).prop("selected", true);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
		
		$('.btn-close').click(function(){
			$('#mi_title').val("");
			$('#mi_content').val("");
		});
	</script>
</body>
</html>