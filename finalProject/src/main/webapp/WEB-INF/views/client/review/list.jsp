<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>리뷰게시글 목록</title>
	<style type="text/css">
		.error{color : red;}
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
				<%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>리뷰게시글 목록</h2>
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>번호</th>
								<th>지점</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${reviewList}" var="list">
								<tr>
									<td>${list.rp_num}</td>
									<td>${list.rp_br_name}</td>
									<td>
										<a href="<c:url value="/client/review/detail/${list.rp_num}"/>">${list.rp_title}</a>
									</td>
									<td>${list.pa_me_id}</td>
									<td>
										<fmt:formatDate value="${list.rp_date}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${list.rp_view}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<c:if test="${user ne null && user.me_authority eq 'USER'}">
						<div class="text-right mb-3">
							<a href="<c:url value="/client/review/insert"/>" class="btn btn-outline-info btn-sm">글쓰기</a>
						</div>
					</c:if>
		                
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
		    stateSave: true,
		    stateDuration: 300,
		    order: [[ 0, "desc" ]],
		    columnDefs: [
		        { targets: [0, 1, 2, 3, 4, 5], className: "align-content-center"}
		    ]
		});
	</script>

</body>
</html>
