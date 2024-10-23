<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>예약회원 목록</title>
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
					<h2 class="mt-3 mb-3">예약회원 목록</h2>
					<a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-danger btn-sm">뒤로</a>
					<table class="table" id="table">
						<thead id="thead">
							<tr>
								<th>회원명</th>
								<th>전화번호</th>
								<th>생년월일</th>
								<th>성별</th>
								<th>노쇼경고횟수</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${memberList}" var="list">
								<tr>
									<td>${list.me_name}</td>
									<td>${list.me_phone}</td>
									<td>
										<fmt:formatDate value="${list.me_birth}" pattern="yyyy년 MM월 dd일"/> 
									</td>
									<td>${list.me_gender}</td>
									<td>${list.me_noshow}</td>
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
		        emptyTable: ""
		    },
			scrollY: 400,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [0, 1, 2, 3, 4], className: "align-content-center"}
		    ]
		});
	</script>

</body>
</html>
