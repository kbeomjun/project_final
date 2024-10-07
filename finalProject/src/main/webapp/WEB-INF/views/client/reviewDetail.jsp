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

	<h1 class="mt-3 mb-3">리뷰게시글 상세</h1>
	<div>
		<div class="form-group">
			<label>제목:</label>
			<input type="text" class="form-control" readonly value="${review.rp_title}">
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
		<a href="<c:url value="/client/review/list"/>" class="btn btn-outline-info">목록</a>
		<c:if test="${review.pa_me_id eq user.me_id }">
			<a href="<c:url value="/client/review/update/${review.rp_num}"/>" class="btn btn-outline-warning">수정</a>
			<a href="<c:url value="/client/review/delete/${review.rp_num}"/>" class="btn btn-outline-danger">삭제</a>
		</c:if>
	</div>
</body>
</html>
