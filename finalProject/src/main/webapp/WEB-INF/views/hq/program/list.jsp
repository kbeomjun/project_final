<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
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
		          		<a class="nav-link active" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
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
			    	<a href="<c:url value="/hq/program/insert"/>" class="btn btn-outline-success">등록</a>
			    </div>
			    <hr>
		    	<div class="mt-3">
		    		<table class="table table-hover" id="table">
				    	<thead id="thead">
				      		<tr>
				        		<th>프로그램</th>
				        		<th>유형</th>
				        		<th></th>
				      		</tr>
				    	</thead>
				    	<tbody id="tbody">
				    		<c:forEach items="${spList}" var="sp">
				    			<tr>
					        		<td>${sp.sp_name}</td>
					        		<td>${sp.sp_type}</td>
					        		<td>
					        			<a href="<c:url value="/hq/program/detail/${sp.sp_name}"/>" class="btn btn-outline-info">조회</a>
					        		</td>
					      		</tr>
				    		</c:forEach>
				    	</tbody>
					</table>
				</div>
	    	</div>
	  	</div>
	</div>
	
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
		        { targets: [2], orderable: false },
		        { targets: [0, 1, 2], className: "align-content-center"}
		    ]
		});
	</script>
</body>
</html>