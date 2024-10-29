<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>리뷰게시글 목록</title>
</head>
<body>

	<c:if test="${not empty msg}">
	    <script type="text/javascript">
	        alert("${msg}");
	    </script>
	</c:if>

	<main class="sub_container" id="skipnav_target">
		<section class="sub_banner sub_banner_04"></section>
		<section class="sub_content">
		
			<!-- 왼쪽 사이드바 -->
			<%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
			
			<!-- 오른쪽 컨텐츠 영역 -->
			<section class="sub_content_group">
				<div class="sub_title_wrap">
					<h2 class="sub_title">리뷰게시판</h2>
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
				</div>
				
				<c:if test="${user ne null && user.me_authority eq 'USER'}">
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<div class="btn_link_black">
								<a href="<c:url value="/client/review/insert"/>" class="btn btn_black js-btn-insert">
									<span>글쓰기<i class="ic_link_share"></i></span>
								</a>
								<div class="btn_black_top_line"></div>
								<div class="btn_black_right_line"></div>
								<div class="btn_black_bottom_line"></div>
								<div class="btn_black_left_line"></div>
							</div>
						</div>
					</div>				
				</c:if>		
						
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
			//scrollY: 500,
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
