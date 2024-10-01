<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
</head>
<body>
	<h1>지점관리</h1>
	<div class="container" style="margin-top:30px">
	  	<div class="row">
	    	<div class="col-sm-2">
		    	<ul class="nav nav-pills flex-column">
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/branch/list"/>">지점 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">직원 관리</a>
	       	 		</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">운동기구 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">재고 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">발주 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">회원권 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">회원 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="#">문의 내역</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
			    <div>
			    	<a href="<c:url value="/hq/branch/insert"/>" class="btn btn-outline-success">등록</a>
			    </div>
		    	<div>
			    	<table class="table table-hover mt-3">
				    	<thead>
				      		<tr>
				        		<th>지점명</th>
				        		<th>지점번호</th>
				        		<th>지점주소</th>
				        		<th>관리자아이디</th>
				        		<th>상세</th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${brList}" var="br">
						      	<tr>
						        	<td>
								        ${br.br_name}
							        </td>
							        <td>
										${br.br_phone}							        	
						        	</td>
							        <td>
							        	${br.br_address}(${br.br_detailAddress})
						        	</td>
						        	<td>
						        		${br.br_admin}
						        	</td>
						        	<td>
						        		<a href="<c:url value="/hq/branch/detail/${br.br_name}"/>">조회</a>
						        	</td>
						      	</tr>
				    		</c:forEach>
				    		<c:if test="${brList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="5">등록된 지점이 없습니다.</th>
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
