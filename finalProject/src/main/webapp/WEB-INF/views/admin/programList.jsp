<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 목록</title>
</head>
<body>
	<h1 class="mt-3 mb-3">${branchName} 프로그램 목록</h1>
	<table class="table">
		<thead>
			<tr>
				<th>프로그램명</th>
				<th>트레이너명</th>
				<th>총 인원수</th>
				<th>수정 / 삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.bp_sp_name}</td>
					<td>${list.employee.em_name}</td>
					<td>${list.bp_total}</td>
					<td>
						<a href="<c:url value="/admin/program/update?bp_sp_name=${list.bp_sp_name}&bp_em_num=${list.bp_em_num}&bp_total=${list.bp_total}&employee.em_name=${list.employee.em_name}"/>" class="btn btn-outline-warning btn-sm">수정</a>
						<a href="<c:url value="/admin/program/delete?bp_sp_name=${list.bp_sp_name}&bp_em_num=${list.bp_em_num}"/>" class="btn btn-outline-danger btn-sm">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="<c:url value="/admin/program/insert"/>" class="btn btn-outline-success btn-sm">프로그램 추가</a>
</body>
</html>
