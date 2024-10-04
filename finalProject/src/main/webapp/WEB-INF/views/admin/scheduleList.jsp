<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>스케줄 목록</title>
</head>
<body>
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">${br_name} 스케줄 목록</h1>
		<table class="table text-center">
			<thead>
				<tr>
					<th>프로그램명</th>
					<th>트레이너명</th>
					<th>[예약인원 / 총인원]</th>
					<th>프로그램 날짜</th>
					<th>프로그램 시간</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${scheduleList}" var="list">
					<tr>
						<td>
							<a href="<c:url value="/admin/schedule/detail?bs_num=${list.bs_num}"/>">${list.bp_sp_name}</a>
						</td>
						<td>${list.em_name}</td>
						<td>${list.bs_current} / ${list.bp_total}</td>
						<td>
							<fmt:formatDate value="${list.bs_start}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<fmt:formatDate value="${list.bs_start}" pattern="HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
						</td>
						<td>
							<a href="<c:url value="/admin/schedule/update/${list.bs_num }"/>" class="btn btn-outline-warning btn-sm">수정</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${scheduleList.size() eq 0}">
					<tr>
						<th class="text-center" colspan="6">등록된 스케줄이 없습니다.</th>
					</tr>
				</c:if>				
			</tbody>
		</table>
		<div class="text-right mb-3">	
			<a href="<c:url value="/admin/schedule/insert/${br_name}"/>" class="btn btn-outline-success btn-sm">스케줄 추가</a>
		</div>
	<!-- </main> -->
</body>
</html>
