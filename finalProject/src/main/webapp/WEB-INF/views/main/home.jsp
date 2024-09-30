<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world!</h1>

	<P>The time on the server is ${serverTime}.</P>

	<form method="post" enctype="multipart/form-data" action="<c:url value="/test/saveFile"/>">
		<div class="form-group">
			<label>파일 테스트</label> <input type="file" class="form-control" name="file" />
		</div>
		<button type="submit">저장</button>
	</form>
	
	<a href="<c:url value="/login"/>">로그인</a>
	
	<a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-info">프로그램관리</a><br>
	<a href="<c:url value="/admin/program/schedule"/>" class="btn btn-outline-info">프로그램일정관리</a><br>
	<a href="<c:url value="/admin/order/list"/>" class="btn btn-outline-info">운동기구 발주목록</a><br>
	<a href="<c:url value="/admin/order/insert"/>" class="btn btn-outline-info">운동기구 발주신청</a><br>
	<a href="<c:url value="/admin/employee/list"/>" class="btn btn-outline-info">직원관리</a><br>
	<a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-info">회원관리</a><br>
	<a href="<c:url value="/admin/branch/detial"/>" class="btn btn-outline-info">지점 상세보기</a><br>
	<a href="<c:url value="/admin/equipment/list"/>" class="btn btn-outline-info">운동기구 재고조회</a>
	
</body>
</html>
