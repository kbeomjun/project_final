<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
    	.img-container{max-height: 800px; overflow-y: auto; padding-bottom: 20px;}
    	.img-box{width:20%; height:220px; box-sizing: border-box; position: relative; margin: 20px 0; cursor:pointer;}
    	.img-name{border: 1px solid gray;}
    	.img-text{margin-bottom: 0; padding: 5px;}
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
		          		<a class="nav-link active" href="<c:url value="/hq/stock/list"/>">재고 관리</a>
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
		          		<a class="nav-link" href="<c:url value="/hq/refund/list"/>">환불 처리</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
			    <div>
			    	<button type="button" class="btn btn-outline-info btn-menu btn-record active" data-name="record">내역</button>
			    	<button type="button" class="btn btn-outline-info btn-menu btn-img" data-name="img">현황</button>
			    	<button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#myModal">입고</button>
			    </div>
			    <hr>
		    	<div class="mt-3 box box-record">
		    		<table class="table table-hover" id="table">
				    	<thead id="thead">
				      		<tr>
				        		<th>내역번호</th>
				        		<th>기록날짜</th>
				        		<th>기구명</th>
				        		<th>제조일</th>
				        		<th>수량</th>
				        		<th>상태</th>
				      		</tr>
				    	</thead>
				    	<tbody id="tbody">
				    	
				    	</tbody>
					</table>
				</div>
				<div class="mt-3 box box-img" style="display: none;">
					<div class="form-group">
						<input type="text" class="form-control" id="search" name="search" placeholder="검색">
					</div>
					<div class="img-container d-flex flex-wrap mt-3">
						
					</div>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<div class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">입고</h4>
				          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				          		<div class="form-group">
									<label for="be_se_name">기구명:</label>
									<select name="be_se_name" class="custom-select form-control">
										
								    </select>
								</div>
								<div class="error error-name"></div>
								<div class="form-group">
									<label for="be_amount">수량:</label>
									<input type="text" class="form-control" id="be_amount" name="be_amount">
								</div>
								<div class="error error-amount"></div>
								<button class="btn btn-outline-info col-12 btn-insert">재고 추가</button>
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
		// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		let msgNum = `<span>정상적인 숫자가 아닙니다.</span>`;
		let regexNum = /^[0-9]{1,}$/;

		$('#be_amount').keyup(function(){
			$('.error-amount').children().remove();
			
			if($('#be_amount').val() == ''){
				$('.error-amount').append(msgRequired);
			}else if(!regexNum.test($('#be_amount').val())){
				$('.error-amount').append(msgNum);
			}else if($('#be_amount').val() == '0'){
				$('.error-amount').append(msgNum);
			}else{
				$('.error-amount').children().remove();	
			}
		});
		
		$(document).on('click', '.btn-insert', function(){
			let flag = true;
			
			$('.error').children().remove();
			if($('#be_amount').val() == ''){
				$('.error-amount').append(msgRequired);
				$('#be_amount').focus();
				flag = false;
			}else if(!regexNum.test($('#be_amount').val())){
				$('.error-amount').append(msgNum);
				$('#be_amount').focus();
				flag = false;
			}else if($('#be_amount').val() == '0'){
				$('.error-amount').append(msgNum);
				$('#be_amount').focus();
				flag = false;
			}
			
			if(flag){
				var be_se_name = $("select[name=be_se_name]").val();
				var be_amount = $("#be_amount").val();
				
				$.ajax({
					async : true,
					url : '<c:url value="/hq/stock/insert"/>', 
					type : 'post', 
					data : {be_se_name : be_se_name, be_amount : be_amount}, 
					dataType : "json",
					success : function (data){
						let msg = data.msg;
						if(!msg == ""){
							alert(msg);
						}
						displayList(search);
						$('#myModal').modal("hide");
						$('#be_amount').val("");
					},
					error : function(jqXHR, textStatus, errorThrown){
						console.log(jqXHR);
					}
				});
			}
		});
	</script>
	
	<script type="text/javascript">
		var search = "";

		$(document).ready(function(){
			displayList(search);
		});
		
		$('#search').keyup(function(){
	    	search = $('#search').val();
	    	displayList(search);
	    });
		
		function displayList(search){
			$.ajax({
				async : true,
				url : '<c:url value="/hq/stock/list/items"/>', 
				type : 'get', 
				data : {search : search}, 
				dataType : "json",
				success : function (data){
					let stList = data.stList;
					let str = ``;
					for(var st of stList){
						str += `
							<div class="card img-box">
					        	<img class="card-img-top" style="width:100%; height:100%;" src="<c:url value="/uploads\${st.be_se_fi_name}"/>"></img>
						    	<div class="img-name d-flex align-content-center">
						      		<p class="img-text mx-auto">\${st.be_se_name}(수량 : \${st.be_se_total})</p>
						    	</div>
							</div>
						`;
					}
					$('.img-container').html(str);
					
					let seList = data.seList;
					str = ``;
					for(var se of seList){
						str += `
							<option value="\${se.se_name}">\${se.se_name}</option>
						`;
					}
					$('.custom-select').html(str);
					
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
				        	url:'<c:url value="/hq/stock/list"/>',
				        	type:"post",
				        	dataSrc :"data"
				        },
				        columns:[
				        	{data:"be_num"},
				        	{data:"be_recordStr"},
				        	{data:"be_se_name"},
				        	{data:"be_birthStr"},
				        	{data:"be_amount"},
				        	{data:"be_type"}
				        ]
					});
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		}
		
		$('.btn-close').click(function(){
    		$('.error').children().remove();
    		$('#be_amount').val("");
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
			scrollY: 600,
		    paging: false,
		    info: false,
		    order: [[ 0, "desc" ]],
		    ajax:{
	        	url:'<c:url value="/hq/stock/list"/>',
	        	type:"post",
	        	dataSrc :"data"
	        },
	        columns:[
	        	{data:"be_num"},
	        	{data:"be_recordStr"},
	        	{data:"be_se_name"},
	        	{data:"be_birthStr"},
	        	{data:"be_amount"},
	        	{data:"be_type"}
	        ]
		});	
	
		$(document).on('click', '.btn-menu', function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("active");
			$('.btn-'+name).addClass("active");
			$('.box').css("display", "none");
			$('.box-'+name).css("display", "block");
			
			if(name == 'record'){
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
			        	url:'<c:url value="/hq/stock/list"/>',
			        	type:"post",
			        	dataSrc :"data"
			        },
			        columns:[
			        	{data:"be_num"},
			        	{data:"be_recordStr"},
			        	{data:"be_se_name"},
			        	{data:"be_birthStr"},
			        	{data:"be_amount"},
			        	{data:"be_type"}
			        ]
				});
				$('#search').val("");
				search = "";
				$(document).ready(function(){
					displayList(search);
				});
			}
		});
	</script>
</body>
</html>