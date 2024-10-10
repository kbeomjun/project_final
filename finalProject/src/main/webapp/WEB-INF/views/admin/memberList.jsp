<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>회원 목록</title>
</head>
<body>
	<h1 class="mt-3 mb-3">회원 목록</h1>
	<table class="table text-center">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>상세</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberList}" var="me">
				<tr>
					<td>${me.me_id}</td>
					<td>${me.me_name}</td>
					<td>${me.me_gender}</td>
					<td>
						<fmt:formatDate value="${me.me_birth}" pattern="yyyy.MM.dd"/>
					</td>
					<td>
						<a href="<c:url value="/admin/member/detail/${me.me_id}"/>">조회</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${memberList.size() eq 0}">
				<tr>
					<th class="text-center" colspan="5">등록된 회원이 없습니다.</th>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="text-right mb-3">
		<a href="#" class="btn btn-outline-success btn-sm">회원등록</a>
	</div>
</body>
</html>
