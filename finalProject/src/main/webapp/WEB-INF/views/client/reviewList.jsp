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

	<h1 class="mt-3 mb-3">리뷰게시글 목록</h1>
	<table class="table text-center">
		<thead>
			<tr>
				<th>번호</th>
				<th>지점</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
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
			<c:if test="${reviewList.size() eq 0}">
				<tr>
					<th class="text-center" colspan="6">등록된 리뷰가 없습니다.</th>							
				</tr>
			</c:if>
		</tbody>
	</table>
	<c:if test="${user ne null}">
		<div class="text-right mb-3">
			<a href="<c:url value="/client/review/insert/${user.me_id}"/>" class="btn btn-outline-info">글쓰기</a>
		</div>
	</c:if>
</body>
</html>
