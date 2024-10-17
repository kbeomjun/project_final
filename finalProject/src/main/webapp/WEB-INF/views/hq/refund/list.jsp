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
		          		<a class="nav-link" href="<c:url value="/hq/FAQ/list"/>">FAQ</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/refund/list"/>">환불 처리</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
		    	<div class="mt-3">
		    		<table class="table table-hover" id="table">
				    	<thead id="thead">
				      		<tr>
				      			<th>결제번호</th>
				        		<th>회원계정</th>
				        		<th>이메일</th>
				        		<th>결제날짜</th>
				        		<th>금액(원)</th>
				        		<th>회원권유형</th>
				        		<th>시작일</th>
				        		<th>마감일</th>
				        		<th></th>
				      		</tr>
				    	</thead>
				    	<tbody id="tbody">
				    		
				    	</tbody>
					</table>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<div class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">환불</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				          		<div class="form-group">
									<label for="re_price">금액:</label>
									<input type="text" class="form-control" id="re_price" name="re_price">
								</div>
								<div class="error error-price"></div>
								<div class="form-group">
									<label for="re_reason">사유:</label>
									<select id="re_reason" name="re_reason" class="custom-select mb-3 form-control">
										<option value="중도 해지">중도 해지</option>
										<option value="시작전 계약 취소">시작전 계약 취소</option>
										<option value="PT트레이너 불만">PT트레이너 불만</option>
										<option value="서비스 불만">서비스 불만</option>
								    </select>
								</div>
								<div class="error error-reason"></div>
								<input type="hidden" id="re_pa_num" name="re_pa_num">
								<button class="btn btn-outline-danger col-12 btn-refund">환불</button>
				        	</div>
				        	<div class="modal-footer">
				          		<button type="button" class="btn btn-danger btn-close" data-dismiss="modal">취소</button>
				        	</div>
			      		</div>
			    	</div>
		  		</div>
	    	</div>
	  	</div>
	</div>
	
	<script type="text/javascript">
		var price = "";
		var pa_num = "";
		let msgPrice = `<span>결제금액을 초과합니다.</span>`;
		let msgRequired = `<span>필수항목입니다.</span>`;
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
		    order: [[ 0, "desc" ]],
		    ajax:{
	        	url:'<c:url value="/hq/refund/list"/>',
	        	type:"post",
	        	dataSrc :"data"
	        },
	        columns:[
	        	{data:"pa_num"},
	        	{data:"pa_me_id"},
	        	{data:"pa_me_email"},
	        	{data:"pa_dateStr"},
	        	{data:"pa_price"},
	        	{data:"pa_pt_name"},
	        	{data:"pa_startStr"},
	        	{data:"pa_endStr"},
	        	{
	        		data: null,
		        	defaultContent : '<button type="button" class="btn btn-outline-danger btn-refund-modal" data-toggle="modal" data-target="#myModal">환불</button>'
        		}
	        ],
	        columnDefs: [
		        { targets: [0, 1, 2, 4, 5, 6, 8], orderable: false },
		        { targets: [0, 1, 2, 3, 4, 5, 6, 7, 8], className: "align-content-center"},
		    ]
		});

		$(document).on("click", ".btn-refund-modal", function(){
			price = $(this).parent().prev().prev().prev().prev().text();
			pa_num = $(this).parent().prev().prev().prev().prev().prev().prev().prev().prev().text();
			$('#re_pa_num').val(pa_num);
		});
		$(document).on("keyup", "#re_price", function(){
			$('.error').children().remove();
			if($('#re_price').val() == ''){
				$('.error-price').append(msgRequired);
			}else if($('#re_price').val() > price || $('#re_price').val().length > price.length){
				$('.error-price').append(msgPrice);
			}
		});
		
		$(document).on("click", ".btn-refund", function(){
			let flag = true;
			
			$('.error').children().remove();
			if($('#re_price').val() == ''){
				$('.error-price').append(msgRequired);
				$('#re_price').focus();
				flag = false;
			}else if($('#re_price').val() > price || $('#re_price').val().length > price.length){
				$('.error-price').append(msgPrice);
				$('#re_price').focus();
				flag = false;
			}
			
			if(flag){
				if(confirm("정말 환불처리 하시겠습니까?\n환불처리 후 복구할 수 없습니다.")){
					var re_price = $("#re_price").val();
					var re_reason = $("select[name=re_reason] option:selected").val();
					var re_pa_num = $('#re_pa_num').val();
					$.ajax({
						async : true,
						url : '<c:url value="/hq/refund/insert"/>', 
						type : 'get', 
						data : {re_price : re_price, re_reason : re_reason, re_pa_num : re_pa_num}, 
						dataType : "json",
						success : function (data){
							var msg = data.msg;
							if(msg != ""){
								alert(msg);
							}
							$('#myModal').modal("hide");
							
							table.destroy();
							table = $('#table').DataTable({
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
							    ajax:{
						        	url:'<c:url value="/hq/refund/list"/>',
						        	type:"post",
						        	dataSrc :"data"
						        },
						        columns:[
						        	{data:"pa_num"},
						        	{data:"pa_me_id"},
						        	{data:"pa_me_email"},
						        	{data:"pa_dateStr"},
						        	{data:"pa_price"},
						        	{data:"pa_pt_name"},
						        	{data:"pa_startStr"},
						        	{data:"pa_endStr"},
						        	{
						        		data: null,
							        	defaultContent : '<button type="button" class="btn btn-outline-danger btn-refund-modal" data-toggle="modal" data-target="#myModal">환불</button>'
					        		}
						        ],
						        columnDefs: [
							        { targets: [0, 1, 2, 4, 5, 6, 8], orderable: false },
							        { targets: [0, 1, 2, 3, 4, 5, 6, 7, 8], className: "align-content-center"},
							    ]
							});
						},
						error : function(jqXHR, textStatus, errorThrown){
							console.log(jqXHR);
						}
					});
				}
			}
		});
		
		$('.btn-close').click(function(){
			$('.error').children().remove();
			$('#re_price').val("");
			$('#re_pa_num').val("");
		});
	</script>
</body>
</html>