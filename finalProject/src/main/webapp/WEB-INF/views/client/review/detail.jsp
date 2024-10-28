<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>리뷰게시글 상세</title>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>리뷰게시글 상세</h2>
					<div>
						<div class="form-group">
							<label>제목:</label>
							<input type="text" class="form-control" readonly value="${review.rp_title}">
						</div>
						<div class="form-group">
							<label>지점명:</label>
							<input type="text" class="form-control" readonly value="${review.rp_br_name}">
						</div>
						<div class="form-group">
							<label>작성자:</label>
							<input type="text" class="form-control" readonly value="${review.pa_me_id}">
						</div>
						<div class="form-group">
							<label>작성일:</label>
							<c:set var="formattedDate">
							    <fmt:formatDate value="${review.rp_date}" pattern="yyyy-MM-dd" />
							</c:set>
							<input type="text"class="form-control"  readonly value="${formattedDate}">
						</div>
						<div class="form-group">
							<label>조회수:</label>
							<input type="text" class="form-control" readonly value="${review.rp_view}">
						</div>
						<div class="form-group">
							<label for="po_content">내용:</label>
							<div class="form-control" id="po_content" style="min-height: 400px; height:auto">${review.rp_content}</div>
						</div>
						
						<div class="d-flex justify-content-between">
							<a href="<c:url value="/client/review/list"/>" class="btn btn-outline-info">목록</a>
							
							<div>
								<c:if test="${review.pa_me_id eq user.me_id }">
									<a href="<c:url value="/client/review/update/${review.rp_num}"/>" class="btn btn-outline-warning ml-2">수정</a>
									<a href="<c:url value="/client/review/delete/${review.rp_num}"/>" class="btn btn-outline-danger ml-2" 
												onclick="return confirm('삭제하면 해당 결제내역의 리뷰 게시글은 다시 작성할 수 없습니다. 삭제하시겠습니까?');">삭제</a>
								</c:if>
							</div>
						</div>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>
	
</body>
</html>
