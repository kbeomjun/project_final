<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 목록</title>
</head>
	<style type="text/css">
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
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
					<h2 class="mt-3 mb-3">${br_name} 프로그램 목록</h2>
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>프로그램명</th>
								<th>트레이너명</th>
								<th>총 인원수</th>
								<th>인원수 수정</th>
								<th>프로그램삭제</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${programList}" var="list">
								<tr>
									<td>${list.bp_sp_name}</td>
									<td>${list.em_name}</td>
									<td>${list.bp_total}</td>
									<td>
										<c:if test="${list.sp_type == '그룹'}">
											<a href="<c:url value="/admin/program/update/${list.bp_num}"/>" class="btn btn-outline-warning btn-sm">수정</a>
										</c:if>
										<c:if test="${list.sp_type == '단일'}">
											-
										</c:if>
									</td>
									<td>
										<a href="<c:url value="/admin/program/delete/${list.bp_num}"/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${programList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="5">등록된 프로그램이 없습니다.</th>
								</tr>
							</c:if>				
						</tbody>
					</table>
					<div class="text-right mb-3">	
						<a href="<c:url value="/admin/program/insert"/>" class="btn btn-outline-success btn-sm">프로그램 추가</a>
					</div>
	                
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
		        emptyTable: ""
		    },
			scrollY: 400,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [3, 4], orderable: false },
		        { targets: [0, 1, 2], className: "align-content-center"}
		    ]
		});
	</script>
	
</body>
</html>
