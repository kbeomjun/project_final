<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
	<style type="text/css">
		.error{color : red;}
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
	            <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>나의 문의내역</h2>
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>문의유형</th>
								<th>지점</th>
								<th>제목</th>
								<th>문의날짜</th>
								<th>문의상태</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${inquiryList}" var="list">
								<tr>
									<td>${list.mi_it_name}</td>
									<td>${list.mi_br_name}</td>
									<td>
										<a href="<c:url value="/mypage/inquiry/detail/${list.mi_num}"/>">${list.mi_title}</a>
									</td>
									<td>
										<fmt:formatDate value="${list.mi_date}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${list.mi_state}</td>
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
		    stateSave: true,
		    stateDuration: 300,
		    order: [[ 3, "desc" ]],
		    columnDefs: [
		        { targets: [0, 1, 2, 3, 4], className: "align-content-center"}
		    ]
		});
	</script>	
	
</body>
</html>
