<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>직원 목록</title>
</head>
<body>
	<h1 class="mt-3 mb-3">${br_name} 직원 목록</h1>
	<table class="table text-center">
		<thead>
			<tr>
				<th>직원번호</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>입사일</th>
				<th>직책</th>
				<th>상세</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${employeeList}" var="em">
				<tr>
					<td>${em.em_num}</td>
					<td>${em.em_name}</td>
					<td>${em.em_phone}</td>
					<td>${em.em_email}</td>
					<td>
						<fmt:formatDate value="${em.em_join}" pattern="yyyy.MM.dd"/>
					</td>
					<td>${em.em_position}</td>
					<td>
						<a href="<c:url value="/admin/employee/detail/${em.em_num}"/>">조회</a>
					</td>							
				</tr>
			</c:forEach>
			<c:if test="${employeeList.size() eq 0}">
				<tr>
					<th class="text-center" colspan="7">등록된 직원이 없습니다.</th>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="text-right mb-3">
		<a href="<c:url value="/admin/employee/insert/${br_name}"/>" class="btn btn-outline-success btn-sm">직원등록</a>
	</div>
</body>
</html>
