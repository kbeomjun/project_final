<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>운동기구 재고 변동내역</title>
</head>
<body>

	<h1 class="mt-3 mb-3">${br_name} 재고 변동내역</h1>
	<table class="table text-center">
		<thead>
			<tr>
				<th>운동기구명</th>
				<th>제조년월일</th>
				<th>수량</th>
				<th>기록날짜</th>
				<th>기록유형</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${equipmentChange}" var="change">
				<tr>
					<td>${change.be_se_name}</td>
					<td>
						<fmt:formatDate value="${change.be_birth}" pattern="yyyy-MM-dd"/>
					</td>
					<td>${change.be_amount}</td>
					<td>
						<fmt:formatDate value="${change.be_record}" pattern="yyyy-MM-dd"/>
					</td>
					<td>${change.be_type}</td>
				</tr>
			</c:forEach>
			<c:if test="${equipmentChange.size() eq 0}">
				<tr>
					<th class="text-center" colspan="5">변동내역이 없습니다.</th>							
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>
