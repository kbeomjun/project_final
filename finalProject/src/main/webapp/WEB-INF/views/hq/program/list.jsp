<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
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
		          		<a class="nav-link active" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/member/list"/>">회원 조회</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
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
				    	<thead>
				      		<tr>
				        		<th class="text-center">프로그램명</th>
				        		<th class="text-center">유형</th>
				        		<th class="text-center"></th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${spList}" var="sp">
				    			<tr>
					        		<td class="align-content-center text-center">${sp.sp_name}</td>
					        		<td class="align-content-center text-center">${sp.sp_type}</td>
					        		<td class="align-content-center text-center">
					        			<a href="<c:url value="/hq/program/detail/${sp.sp_name}"/>" class="btn btn-outline-info">상세</a>
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
		// 테이블 api
		$('#table').DataTable({
			language: {
		        search: "검색:",
		        zeroRecords: "",
		        emptyTable: "등록된 프로그램이 없습니다."
		    },
			scrollY: 600,
		    paging: false,
		    info: false,
		    columnDefs: [
		        {
		        	targets: [2], 
		        	orderable: false
	        	}
		    ]
		});
	</script>
</body>
</html>