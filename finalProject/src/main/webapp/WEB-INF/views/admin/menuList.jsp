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
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">지점관리자 메뉴 목록</h1>
		<a href="<c:url value="/admin/login"/>" class="btn btn-success mb-2">로그인</a><br>
		<a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-info mb-2">프로그램관리</a><br>
		<a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-info mb-2">프로그램일정관리</a><br>
		<a href="<c:url value="/admin/order/list"/>" class="btn btn-outline-info mb-2">운동기구 발주목록</a><br>
		<a href="<c:url value="/admin/employee/list"/>" class="btn btn-outline-info mb-2">직원관리</a><br>
		<a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-info mb-2">회원관리</a><br>
		<a href="<c:url value="/admin/branch/detail"/>" class="btn btn-outline-info mb-2">지점 상세보기</a><br>
		<a href="<c:url value="/admin/equipment/list"/>" class="btn btn-outline-info mb-2">운동기구 보유목록</a><br>
		<a href="<c:url value="/admin/equipment/change"/>" class="btn btn-outline-info mb-2">운동기구 재고 변동내역</a>
	<!-- </main> -->
</body>
</html>
