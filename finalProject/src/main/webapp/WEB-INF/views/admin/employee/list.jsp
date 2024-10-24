<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>직원 목록</title>
	<style type="text/css">
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
</head>
<body>
	
	<c:if test="${not empty msg}">
	    <script type="text/javascript">
	        alert("${msg}");
	    </script>
	</c:if>	
	
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${br_name} 직원 목록</h2>
					<div>
						<a href="<c:url value="/admin/employee/insert"/>" class="btn btn-outline-success btn-sm">직원등록</a>
					</div>					
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>직원번호</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>입사일</th>
								<th>직책</th>
								<th>상세</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${employeeList}" var="em">
								<tr>
									<td>${em.em_num}</td>
									<td>${em.em_name}</td>
									<td>${em.em_phone}</td>
									<td>${em.em_email}</td>
									<td>
										<fmt:formatDate value="${em.em_join}" pattern="yyyy.MM.dd"/>
									</td>
									<td>${em.em_position}</td>
									<td>
										<a href="<c:url value="/admin/employee/detail/${em.em_num}"/>" class="btn btn-outline-info btn-sm">조회</a>
									</td>							
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
	            </div>
	        </main>
	    </div>
	</div>	

	<script type="text/javascript">
		// 데이터테이블
		$('#table').DataTable({
			language: {
		        search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: "",
		        lengthMenu: ""
		    },
			scrollY: 500,
		    pageLength: 10,
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
