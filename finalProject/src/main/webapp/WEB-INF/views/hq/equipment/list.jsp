<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
    	.img-box{width:33.33%; height:200px; box-sizing: border-box; position: relative; margin: 20px 0;}
    	.img-name{border: 1px solid gray;}
    	.img-text{margin-bottom: 0; padding: 5px;}
    	.btn-update-img{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%; padding: 9px 6px 6px;}
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
		          		<a class="nav-link active" href="<c:url value="/hq/equipment/list"/>">운동기구 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/stock/list"/>">재고 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/order/list"/>">발주 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/payment/list"/>">회원권 관리</a>
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
			    	<a href="<c:url value="/hq/equipment/insert"/>" class="btn btn-outline-success">등록</a>
			    </div>
		    	<div class="img-container d-flex flex-wrap">
		    		<c:forEach items="${seList}" var="se">
						<div class="card img-box" style="width:250px; cursor:pointer">
				        	<img class="card-img-top" src="<c:url value="/uploads${se.se_fi_name}"/>" style="width:100%; height:100%">
					        	<a href="<c:url value="/hq/equipment/update/${se.se_name}"/>" class="btn btn-outline-warning btn-update-img">
									<i class="fi fi-br-edit"></i>
								</a>
							</img>
					    	<div class="img-name d-flex align-content-center">
					      		<p class="img-text mx-auto">${se.se_name}</p>
					    	</div>
						</div>
		    		</c:forEach>
				</div>
	    	</div>
	  	</div>
	</div>
</body>
</html>