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
    	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
    	.address-input{margin-bottom: 10px;}
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
		          		<a class="nav-link" href="<c:url value="/hq/paymentType/list"/>">회원권 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/member/list"/>">회원 조회</a>
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
		    	<div class="mt-3">
		    		<table class="table table-hover" id="table">
				    	<thead id="thead">
				      		<tr>
				        		<th>이름</th>
				        		<th>생년월일</th>
				        		<th>성별</th>
				        		<th>전화번호</th>
				        		<th>계정</th>
				        		<th>이메일</th>
				        		<th></th>
				      		</tr>
				    	</thead>
				    	<tbody id="tbody">
				    		<c:forEach items="${meList}" var="me">
				    			<tr>
					        		<td>${me.me_name}</td>
					        		<td>
					        			<fmt:formatDate value="${me.me_birth}" pattern="yyyy.MM.dd"/>
				        			</td>
					        		<td>${me.me_gender}</td>
					        		<td>${me.me_phone}</td>
					        		<td>${me.me_id}</td>
					        		<td>${me.me_email}</td>
					        		<td>
					        			<button type="button" class="btn btn-outline-info btn-detail" data-toggle="modal" data-target="#myModal" data-id="${me.me_id}">조회</button>
					        		</td>
					      		</tr>
				    		</c:forEach>
				    	</tbody>
					</table>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<div class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">정보</h4>
				          		<button type="button" class="close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				          		<div class="form-group">
									<label for="me_name">이름:</label>
									<input type="text" class="form-control" id="me_name" name="me_name" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_birth">생년월일:</label>
									<input type="text" class="form-control" id="me_birth" name="me_birth" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_phone">전화번호:</label>
									<input type="text" class="form-control" id="me_phone" name="me_phone" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_address">주소:</label> <br/>
									<input type="text" class="address-input" id="me_postcode" name="me_postcode" placeholder="우편번호" style="width:20%;" readonly>
									<input type="text" class="address-input" id="me_address" name="me_address" placeholder="주소" style="width:100%;" readonly> <br/>
									<input type="text" class="address-input" id="me_detailAddress" name="me_detailAddress" placeholder="상세주소" style="width:60%; margin-bottom: 0;" readonly>
									<input type="text" class="address-input" id="me_extraAddress" name="me_extraAddress" placeholder="참고항목" style="width:39.3%; margin-bottom: 0;" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_id">아이디:</label>
									<input type="text" class="form-control" id="me_id" name="me_id" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_email">이메일:</label>
									<input type="text" class="form-control" id="me_email" name="me_email" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_noshow">경고횟수:</label>
									<input type="text" class="form-control" id="me_noshow" name="me_noshow" readonly>
								</div>
								<div class="error"></div>
								<div class="form-group">
									<label for="me_cancel">정지기한:</label>
									<input type="text" class="form-control" id="me_cancel" name="me_cancel" readonly>
								</div>
								<div class="error"></div>
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
	
	<script type="text/javascript">
		$('.btn-detail').click(function(){
			var me_id = $(this).data("id"); 
			
			$.ajax({
				async : true,
				url : '<c:url value="/hq/member/detail"/>', 
				type : 'get', 
				data : {me_id : me_id}, 
				dataType : "json",
				success : function (data){
					let me = data.me;
					var me_birth = (new Date(me.me_birth)).toLocaleDateString('ko-KR', {
						year: 'numeric',
						month: '2-digit',
						day: '2-digit',
						})
						.replace(/\./g, '')
						.replace(/\s/g, '.')
					var me_cancel = "";
					if(me.me_cancel != null){
						me_cancel = (new Date(me.me_cancel)).toLocaleDateString('ko-KR', {
							year: 'numeric',
							month: '2-digit',
							day: '2-digit',
							})
							.replace(/\./g, '')
							.replace(/\s/g, '.')	
					}
					
					$('#me_name').val(me.me_name);
					$('#me_birth').val(me_birth);
					$('#me_phone').val(me.me_phone);
					$('#me_postcode').val(me.me_postcode);
					$('#me_address').val(me.me_address);
					$('#me_detailAddress').val(me.me_detailAddress);
					$('#me_extraAddress').val(me.me_extraAddress);
					$('#me_id').val(me.me_id);
					$('#me_email').val(me.me_email);
					$('#me_noshow').val(me.me_noshow);
					$('#me_cancel').val(me_cancel);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
	</script>
	
	<script type="text/javascript">
		// 데이터테이블
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
		        { targets: [6], orderable: false },
		        { targets: [0, 1, 2, 3, 4, 5, 6], className: "align-content-center"}
		    ]
		});
	</script>
</body>
</html>