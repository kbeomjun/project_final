<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>운동기구 보유 목록</title>
</head>
<body>

	<h1 class="mt-3 mb-3">${br_name} 보유 목록</h1>
	<form action="<c:url value="/admin/equipment/list"/>" method="get">
	    <button type="submit" name="view" value="all" class="btn btn<c:if test="${view ne 'all'}">-outline</c:if>-info">전체보기</button>
	    <button type="submit" name="view" value="equipment" class="btn btn<c:if test="${view ne 'equipment'}">-outline</c:if>-info">기구별보기</button>
	</form>	
	<table class="table text-center">
		<thead>
			<tr>
				<th>운동기구명</th>
				<c:if test="${view eq 'all'}">
					<th>제조년월일</th>
				</c:if>
				<th>총 갯수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${equipmentList}" var="list">
				<tr>
					<td>${list.be_se_name}</td>
					<c:if test="${view eq 'all'}">
						<td>
							<fmt:formatDate value="${list.be_birth}" pattern="yyyy-MM-dd"/>
						</td>
					</c:if>
					<td>${list.be_se_total}</td>
				</tr>
			</c:forEach>
			<c:if test="${equipmentList.size() eq 0}">
				<tr>
					<c:choose>
						<c:when test="${view eq 'all'}">
							<th class="text-center" colspan="3">등록된 기구가 없습니다.</th>							
						</c:when>
						<c:otherwise>
							<th class="text-center" colspan="2">등록된 기구가 없습니다.</th>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>
