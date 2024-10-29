<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>

	<main class="sub_container" id="skipnav_target">
		<section class="sub_banner sub_banner_04"></section>
		<section class="sub_content">
		
			<!-- 왼쪽 사이드바 -->
			<%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
			
			<!-- 오른쪽 컨텐츠 영역 -->
			<section class="sub_content_group">
				<div class="sub_title_wrap">
					<h2 class="sub_title">나의 작성글</h2>
				</div>
				
				<div class="table_wrap">
					<table class="table table_center" id="table">
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
										<a href="<c:url value="/mypage/review/detail/${list.rp_num}"/>">${list.rp_title}</a>
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
				</div>
				
			</section>
			
		</section>
	</main>

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
