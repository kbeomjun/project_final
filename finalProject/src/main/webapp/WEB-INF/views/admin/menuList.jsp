<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>지점관리자메뉴</title>
</head>
<body>
		<h1 class="mt-3 mb-3">지점관리자 메뉴 목록</h1>
		<a href="<c:url value="/admin/login"/>" class="btn btn-success">로그인</a><br>
		<a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-info">프로그램관리</a><br>
		<a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-info">프로그램일정관리</a><br>
		<a href="<c:url value="/admin/order/list"/>" class="btn btn-outline-info">운동기구 발주목록</a><br>
		<a href="<c:url value="/admin/order/insert"/>" class="btn btn-outline-info">운동기구 발주신청</a><br>
		<a href="<c:url value="/admin/employee/list"/>" class="btn btn-outline-info">직원관리</a><br>
		<a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-info">회원관리</a><br>
		<a href="<c:url value="/admin/branch/detial"/>" class="btn btn-outline-info">지점 상세보기</a><br>
		<a href="<c:url value="/admin/equipment/list"/>" class="btn btn-outline-info">운동기구 재고조회</a>
</body>
</html>
