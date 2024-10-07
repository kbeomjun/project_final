<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>고객센터 메뉴</title>
</head>
<body>
	<h1 class="mt-3 mb-3">고객센터 메뉴 목록</h1>
	<a href="<c:url value="/client/review/list"/>" class="btn btn-outline-info">리뷰게시판</a><br>
</body>
</html>
