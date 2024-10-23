<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>발주신청 목록</title>
	<style type="text/css">
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${br_name} 발주신청 목록</h2>
					<div>
						<a href="<c:url value="/admin/order/insert"/>" class="btn btn-outline-success btn-sm">발주신청</a>
					</div>
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>운동기구명</th>
								<th>발주수량</th>
								<th>발주날짜</th>
								<th>발주상태</th>
								<th>신청취소</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${orderList}" var="list">
								<tr>
									<td>${list.bo_se_name}</td>
									<td>${list.bo_amount}</td>
									<td>
										<fmt:formatDate value="${list.bo_date}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${list.bo_state}</td>
									<td>
										<c:choose>
											<c:when test="${list.bo_state == '승인대기'}">
												<a href="<c:url value="/admin/order/delete/${list.bo_num}"/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('취소하시겠습니까?');">신청취소</a>
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
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
		    order: [[ 2, "desc" ]],
		    columnDefs: [
		    	{ targets: [4], orderable: false },
		        { targets: [0, 1, 2, 3, 4], className: "align-content-center"}
		    ]
		});
	</script>

</body>
</html>
