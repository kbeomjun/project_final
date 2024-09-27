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
	
	<a href="/contextPath/dowload/image">다운로드 테스트</a>
	
</body>
</html>
