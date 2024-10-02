<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>발주신청 목록</title>
</head>
<body>
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">${br_name} 발주신청 목록</h1>
		<table class="table text-center">
			<thead>
				<tr>
					<th>운동기구명</th>
					<th>발주수량</th>
					<th>발주날짜</th>
					<th>발주상태</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderList}" var="list">
					<tr>
						<td>${list.bo_se_name}</td>
						<td>${list.bo_amount}</td>
						<td>
							<fmt:formatDate value="${list.bo_date}" pattern="yyyy-MM-dd"/>
						</td>
						<td>${list.bo_state}</td>
						<c:if test="${list.bo_state == '승인대기'}">
							<td>
								<a href="<c:url value="/admin/order/delete?bo_num=${list.bo_num}"/>" class="btn btn-outline-danger btn-sm">신청취소</a>
							</td>							
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="text-right mb-3">
			<a href="<c:url value="/admin/order/insert"/>" class="btn btn-outline-success btn-sm">발주신청</a>
		</div>
	<!-- </main> -->
</body>
</html>
