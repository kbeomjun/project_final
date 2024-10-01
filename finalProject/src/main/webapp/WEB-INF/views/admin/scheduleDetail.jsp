<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>예약회원 목록</title>
</head>
<body>
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">${branchProgram.bp_br_name} ${branchProgram.bp_sp_name} 예약회원 목록</h1>
		<table class="table">
			<thead>
				<tr>
					<th>회원명</th>
					<th>전화번호</th>
					<th>생년월일</th>
					<th>성별</th>
					<th>노쇼경고횟수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${memberList}" var="list">
					<tr>
						<td>${list.me_name}</td>
						<td>${list.me_phone}</td>
						<td>
							<fmt:formatDate value="${list.me_birth}" pattern="yyyy년 MM월 dd일"/> 
						</td>
						<td>${list.me_gender}</td>
						<td>${list.me_noshow}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	<!-- </main> -->
</body>
</html>
