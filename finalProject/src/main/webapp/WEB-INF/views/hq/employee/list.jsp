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
		          		<a class="nav-link active" href="<c:url value="/hq/employee/list"/>">직원 관리</a>
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
			    	<a href="<c:url value="/hq/employee/insert"/>" class="btn btn-outline-success">등록</a>
			    </div>
		    	<div class="mt-3">
			    	<table class="table table-hover">
				    	<thead>
				      		<tr>
				        		<th>직원번호</th>
				        		<th>이름</th>
				        		<th>전화번호</th>
				        		<th>이메일</th>
				        		<th>입사일</th>
				        		<th>소속</th>
				        		<th>직책</th>
				        		<th>상세</th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${emList}" var="em">
						      	<tr>
						        	<td>
								        ${em.em_num}
							        </td>
							        <td>
								        ${em.em_name}
							        </td>
							        <td>
								        ${em.em_phone}
							        </td>
							        <td>
								        ${em.em_email}
							        </td>
							        <td>
							        	<fmt:formatDate value="${em.em_join}" pattern="yyyy.MM.dd"/>
							        </td>
							        <td>
								        ${em.em_br_name}
							        </td>
							        <td>
								        ${em.em_position}
							        </td>
						        	<td>
						        		<a href="<c:url value="/hq/employee/detail/${em.em_num}"/>">조회</a>
						        	</td>
						      	</tr>
				    		</c:forEach>
				    		<c:if test="${emList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="8">등록된 직원이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
		    	</div>
	    	</div>
	  	</div>
	</div>
</body>
</html>
