<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h1>Login</h1>
	<form action="<c:url value='/login'/>" method="post" id="loginfrom">
		<div class="form-group">
			<label for="id">아이디 : </label>
			<input type="text" class="from-control" id="id" name="me_id" required/>
		</div>
		<div class="form-group">
			<label for="pw">비밀번호 : </label>
			<input type="password" class="from-control" id="pw" name="me_pw" required/>
		</div>
		<div class="form-check">
			<label for="form-check-label">자동로그인
				<input type="checkbox" class="from-check-input" value="true" name="autologin"/>자동 로그인
			</label>
			<button type="submit" class="btn btn-outline-success col-12">로그인</button>
		</div>
	</form>
</body>
</html>