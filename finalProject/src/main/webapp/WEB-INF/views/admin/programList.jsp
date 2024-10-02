<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 목록</title>
</head>
<body>
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">${br_name} 프로그램 목록</h1>
		<table class="table text-center">
			<thead>
				<tr>
					<th>프로그램명</th>
					<th>트레이너명</th>
					<th>총 인원수</th>
					<th>수정 / 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${programList}" var="list">
					<tr>
						<td>${list.bp_sp_name}</td>
						<td>${list.employee.em_name}</td>
						<td>${list.bp_total}</td>
						<td>
							<c:if test="${list.program.sp_type == '그룹'}">
								<c:url var="url" value="/admin/program/update">
									<c:param name="bp_num" value="${list.bp_num}"/>
									<c:param name="bp_sp_name" value="${list.bp_sp_name}"/>
									<c:param name="bp_em_num" value="${list.bp_em_num}"/>
									<c:param name="bp_total" value="${list.bp_total}"/>
									<c:param name="employee.em_name" value="${list.employee.em_name}"/>
								</c:url>
								<a href="${url}" class="btn btn-outline-warning btn-sm">수정</a>
							</c:if>
							<a href="<c:url value="/admin/program/delete?bp_num=${list.bp_num}"/>" class="btn btn-outline-danger btn-sm">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="text-right mb-3">	
			<a href="<c:url value="/admin/program/insert"/>" class="btn btn-outline-success btn-sm">프로그램 추가</a>
		</div>
	<!-- </main> -->
</body>
</html>
