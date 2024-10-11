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
		          		<a class="nav-link active" href="<c:url value="/hq/paymentType/list"/>">회원권 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/member/list"/>">회원 관리</a>
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
		    	<div class="mt-3">
		    		<table class="table table-hover">
				    	<thead>
				      		<tr>
				        		<th>회원권번호</th>
				        		<th>유형</th>
				        		<th>기한(일)</th>
				        		<th>PT횟수(회)</th>
				        		<th>가격(원)</th>
				        		<th></th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${ptList}" var="pt">
				    			<tr>
					        		<td class="align-content-center">${pt.pt_num}</td>
					        		<td class="align-content-center">${pt.pt_type}</td>
					        		<td class="align-content-center">${pt.pt_date}</td>
					        		<td class="align-content-center">${pt.pt_count}</td>
					        		<td class="align-content-center">${pt.formattedPrice}</td>
					        		<td class="align-content-center">
					        			<button type="button" class="btn btn-outline-warning btn-update" data-toggle="modal" data-target="#myModal2" data-num="${pt.pt_num}">수정</button>
					        		</td>
					      		</tr>
				    		</c:forEach>
				    		<c:if test="${ptList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="6">등록된 회원권이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<form action="<c:url value="/hq/paymentType/insert"/>" method="post" id="form" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">등록</h4>
				          		<button type="button" class="close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				        		<div class="form-group">
									<label for="pt_type">회원권 유형:</label>
									<input type="text" class="form-control" id="pt_type" name="pt_type">
								</div>
								<div class="error error-type"></div>
								<div class="form-group">
									<label for="pt_date">기한(일):</label>
									<input type="text" class="form-control" id="pt_date" name="pt_date">
								</div>
								<div class="error error-date"></div>
								<div class="form-group">
									<label for="pt_count">PT횟수(회):</label>
									<input type="text" class="form-control" id="pt_count" name="pt_count">
								</div>
								<div class="error error-count"></div>
								<div class="form-group">
									<label for="pt_price">가격(원):</label>
									<input type="text" class="form-control" id="pt_price" name="pt_price">
								</div>
								<div class="error error-price"></div>
								<button class="btn btn-outline-info col-12">회원권 등록</button>
				        	</div>
				        	<div class="modal-footer">
				          		<a href="#" class="btn btn-danger" data-dismiss="modal">취소</a>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
		  		<div class="modal fade" id="myModal2">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<form action="<c:url value="/hq/paymentType/update"/>" method="post" id="form2" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">수정</h4>
				          		<button type="button" class="close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				        		<div class="form-group">
									<label for="pt_type">회원권 유형:</label>
									<input type="text" class="form-control" id="pt_type2" name="pt_type">
								</div>
								<div class="error error-type2"></div>
								<div class="form-group">
									<label for="pt_date">기한(일):</label>
									<input type="text" class="form-control" id="pt_date2" name="pt_date">
								</div>
								<div class="error error-date2"></div>
								<div class="form-group">
									<label for="pt_count">PT횟수(회):</label>
									<input type="text" class="form-control" id="pt_count2" name="pt_count">
								</div>
								<div class="error error-count2"></div>
								<div class="form-group">
									<label for="pt_price">가격(원):</label>
									<input type="text" class="form-control" id="pt_price2" name="pt_price">
								</div>
								<div class="error error-price2"></div>
								<input type="hidden" id="pt_num2" name="pt_num">
								<button class="btn btn-outline-warning col-12">회원권 수정</button>
				        	</div>
				        	<div class="modal-footer">
				          		<a href="#" class="btn btn-danger" data-dismiss="modal">취소</a>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
	    	</div>
	  	</div>
	</div>
	
	<script type="text/javascript">
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		$('#pt_type').keyup(function(){
			$('.error-type').children().remove();
			
			if($('#pt_type').val() == ''){
				$('.error-type').append(msgRequired);
			}else{
				$('.error-type').children().remove();	
			}
		});
		$('#pt_date').keyup(function(){
			$('.error-date').children().remove();
			
			if($('#pt_date').val() == ''){
				$('.error-date').append(msgRequired);
			}else{
				$('.error-date').children().remove();	
			}
		});
		$('#pt_count').keyup(function(){
			$('.error-count').children().remove();
			
			if($('#pt_count').val() == ''){
				$('.error-count').append(msgRequired);
			}else{
				$('.error-count').children().remove();	
			}
		});
		$('#pt_price').keyup(function(){
			$('.error-price').children().remove();
			
			if($('#pt_price').val() == ''){
				$('.error-price').append(msgRequired);
			}else{
				$('.error-price').children().remove();	
			}
		});
		
		$('#pt_type2').keyup(function(){
			$('.error-type2').children().remove();
			
			if($('#pt_type2').val() == ''){
				$('.error-type2').append(msgRequired);
			}else{
				$('.error-type2').children().remove();	
			}
		});
		$('#pt_date2').keyup(function(){
			$('.error-date2').children().remove();
			
			if($('#pt_date2').val() == ''){
				$('.error-date2').append(msgRequired);
			}else{
				$('.error-date2').children().remove();	
			}
		});
		$('#pt_count2').keyup(function(){
			$('.error-count2').children().remove();
			
			if($('#pt_count2').val() == ''){
				$('.error-count2').append(msgRequired);
			}else{
				$('.error-count2').children().remove();	
			}
		});
		$('#pt_price2').keyup(function(){
			$('.error-price2').children().remove();
			
			if($('#pt_price2').val() == ''){
				$('.error-price2').append(msgRequired);
			}else{
				$('.error-price2').children().remove();	
			}
		});
		
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag1 = check("type");
			let flag2 = check("date");
			let flag3 = check("count");
			let flag4 = check("price");
			return flag1 && flag2 && flag3 && flag4;
		});
		$('#form2').submit(function(){
			$('.error').children().remove();
			let flag1 = check("type2");
			let flag2 = check("date2");
			let flag3 = check("count2");
			let flag4 = check("price2");
			return flag1 && flag2 && flag3 && flag4;
		});
		function check(str){
			$('.error-'+str).children().remove();
			
			if($('#pt_'+str).val() == ''){
				$('.error-'+str).append(msgRequired);
				return false;
			}else{
				$('.error-'+str).children().remove();	
				return true;
			}
		}
    </script>
    
    <script type="text/javascript">
    	$('.btn-update').click(function(){
    		var pt_num = $(this).data("num");
    		
    		$.ajax({
				async : true,
				url : '<c:url value="/hq/paymentType/data"/>', 
				type : 'get', 
				data : {pt_num : pt_num}, 
				dataType : "json",
				success : function (data){
					let pt = data.pt;
					$('#pt_type2').val(pt.pt_type);
					$('#pt_date2').val(pt.pt_date);
					$('#pt_count2').val(pt.pt_count);
					$('#pt_price2').val(pt.pt_price);
					$('#pt_num2').val(pt.pt_num);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
    	});
    </script>
</body>
</html>