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
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
</head>
<body>
	<div style="margin-top:30px; padding:0 20px;">
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
		          		<a class="nav-link" href="<c:url value="/hq/member/list"/>">회원 조회</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/FAQ/list"/>">FAQ</a>
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
				      			<th>회원권</th>
				        		<th>유형</th>
				        		<th>기한(달)</th>
				        		<th>PT횟수(회)</th>
				        		<th>가격(원)</th>
				        		<th></th>
				      		</tr>
				    	</thead>
				    	<tbody id="tbody">
				    		<c:forEach items="${ptList}" var="pt">
				    			<tr>
				    				<td class="align-content-center">${pt.pt_name}</td>
					        		<td class="align-content-center">${pt.pt_type}</td>
					        		<td class="align-content-center">${pt.pt_date}</td>
					        		<td class="align-content-center">${pt.pt_count}</td>
					        		<td class="align-content-center">${pt.formattedPrice}</td>
					        		<td class="align-content-center">
					        			<button type="button" class="btn btn-outline-warning btn-update" data-toggle="modal" data-target="#myModal2" data-num="${pt.pt_num}">수정</button>
					        		</td>
					      		</tr>
				    		</c:forEach>
				    	</tbody>
					</table>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<form action="<c:url value="/hq/paymentType/insert"/>" method="post" id="form" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">등록</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				        		<div class="form-group">
									<label for="pt_name">회원권명:</label>
									<input type="text" class="form-control" id="pt_name" name="pt_name">
								</div>
								<div class="error error-name"></div>
				        		<div class="form-group">
									<label for="pt_type">회원권 유형:</label>
									<select name="pt_type" class="custom-select form-control">
										<option value="이용권">이용권</option>
										<option value="PT">PT</option>
								    </select>
								</div>
								<div class="error error-type"></div>
								<div class="form-group">
									<label for="pt_date">기한(달):</label>
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
				          		<a href="#" class="btn btn-danger btn-close" data-dismiss="modal">취소</a>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
		  		<div class="modal fade" id="myModal2">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<form action="<c:url value="/hq/paymentType/update"/>" method="post" id="form2" class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">수정</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				        		<div class="form-group">
									<label for="pt_name2">회원권명:</label>
									<input type="text" class="form-control" id="pt_name2" name="pt_name">
								</div>
								<div class="error error-name"></div>
				        		<div class="form-group">
									<label for="pt_type2">회원권 유형:</label>
									<select id="pt_type2" name="pt_type" class="custom-select form-control">
										<option value="이용권">이용권</option>
										<option value="PT">PT</option>
								    </select>
								</div>
								<div class="error error-type2"></div>
								<div class="form-group">
									<label for="pt_date">기한(달):</label>
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
				          		<a href="#" class="btn btn-danger btn-close" data-dismiss="modal">취소</a>
				        	</div>
			      		</form>
			    	</div>
		  		</div>
	    	</div>
	  	</div>
	</div>
	
	<script type="text/javascript">
		let msgRequired = `<span>필수항목입니다.</span>`;
		let msgNum = `<span>정상적인 숫자가 아닙니다.</span>`;
		let regexNum = /^[0-9]{1,}$/;
		
		$('#pt_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#pt_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		$('#pt_date').keyup(function(){
			$('.error-date').children().remove();
			
			if($('#pt_date').val() == ''){
				$('.error-date').append(msgRequired);
			}else if(!regexNum.test($('#pt_date').val())){
				$('.error-date').append(msgNum);
			}else if($('#pt_date').val() == '0'){
				$('.error-date').append(msgNum);
			}else{
				$('.error-date').children().remove();	
			}
		});
		$('#pt_count').keyup(function(){
			$('.error-count').children().remove();
			
			if($('#pt_count').val() == ''){
				$('.error-count').append(msgRequired);
			}else if(!regexNum.test($('#pt_count').val())){
				$('.error-count').append(msgNum);
			}else if($('#pt_count').val() == '0'){
				$('.error-count').append(msgNum);
			}else{
				$('.error-count').children().remove();	
			}
		});
		$('#pt_price').keyup(function(){
			$('.error-price').children().remove();
			
			if($('#pt_price').val() == ''){
				$('.error-price').append(msgRequired);
			}else if(!regexNum.test($('#pt_price').val())){
				$('.error-price').append(msgNum);
			}else if($('#pt_price').val() == '0'){
				$('.error-price').append(msgNum);
			}else{
				$('.error-price').children().remove();	
			}
		});
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag1 = check("name");
			let flag2 = check("date");
			let flag3 = check("count");
			let flag4 = check("price");
			return flag1 && flag2 && flag3 && flag4;
		});
		
		$('#pt_name2').keyup(function(){
			$('.error-name2').children().remove();
			
			if($('#pt_name2').val() == ''){
				$('.error-name2').append(msgRequired);
			}else{
				$('.error-name2').children().remove();	
			}
		});
		$('#pt_date2').keyup(function(){
			$('.error-date2').children().remove();
			
			if($('#pt_date2').val() == ''){
				$('.error-date2').append(msgRequired);
			}else if(!regexNum.test($('#pt_date2').val())){
				$('.error-date2').append(msgNum);
			}else if($('#pt_date2').val() == '0'){
				$('.error-date2').append(msgNum);
			}else{
				$('.error-date2').children().remove();	
			}
		});
		$('#pt_count2').keyup(function(){
			$('.error-count2').children().remove();
			
			if($('#pt_count2').val() == ''){
				$('.error-count2').append(msgRequired);
			}else if(!regexNum.test($('#pt_count2').val())){
				$('.error-count2').append(msgNum);
			}else if($('#pt_count2').val() == '0'){
				$('.error-count2').append(msgNum);
			}else{
				$('.error-count2').children().remove();	
			}
		});
		$('#pt_price2').keyup(function(){
			$('.error-price2').children().remove();
			
			if($('#pt_price2').val() == ''){
				$('.error-price2').append(msgRequired);
			}else if(!regexNum.test($('#pt_price2').val())){
				$('.error-price2').append(msgNum);
			}else if($('#pt_price2').val() == '0'){
				$('.error-price2').append(msgNum);
			}else{
				$('.error-price2').children().remove();	
			}
		});
		$('#form2').submit(function(){
			$('.error').children().remove();
			let flag1 = check("name2");
			let flag2 = check("date2");
			let flag3 = check("count2");
			let flag4 = check("price2");
			return flag1 && flag2 && flag3 && flag4;
		});
		
		function check(str){
			$('.error-'+str).children().remove();
			
			if(str == 'name' || str == 'name2'){
				if($('#pt_'+str).val() == ''){
					$('.error-'+str).append(msgRequired);
					return false;
				}else{
					$('.error-'+str).children().remove();	
					return true;
				}
			}else{
				if($('#pt_'+str).val() == ''){
					$('.error-'+str).append(msgRequired);
					return false;
				}else if(!regexNum.test($('#pt_'+str).val())){
					$('.error-'+str).append(msgNum);
					return false;
				}else if($('#pt_'+str).val() == '0'){
					$('.error-'+str).append(msgNum);
					return false;
				}else{
					$('.error-'+str).children().remove();	
					return true;
				}
			}
		}
    </script>
    
    <script type="text/javascript">
    	$('.btn-close').click(function(){
    		$('.error').children().remove();
    		$('#pt_name').val("");
			$('#pt_date').val("");
			$('#pt_count').val("");
			$('#pt_price').val("");
			$('#pt_num').val("");
    	});
    
    	$('.btn-update').click(function(){
    		var pt_num = $(this).data("num");
    		
    		$.ajax({
				async : true,
				url : '<c:url value="/hq/paymentType/update"/>', 
				type : 'get', 
				data : {pt_num : pt_num}, 
				dataType : "json",
				success : function (data){
					let pt = data.pt;
					$('#pt_name2').val(pt.pt_name);
					$("select[name=pt_type]").val(pt.pt_type).prop("selected", true);
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
    
    <script type="text/javascript">
		// 테이블 api
		$('#table').DataTable({
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
		        { targets: [5], orderable: false }
		    ]
		});
	</script>
</body>
</html>