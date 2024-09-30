<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 수정</title>
</head>
<body>
	<h1 class="mt-3 mb-3">${branchName} 프로그램 수정</h1>
	<form class="form-inline mb-3" action="<c:url value="/admin/program/update?bp_em_num=${branchProgram.bp_em_num}"/>" method="post">
		<label>프로그램:</label>
		<input class="form-control" name="bp_sp_name" value="${branchProgram.bp_sp_name}" readonly/>
		<label>트레이너:</label>
		<input class="form-control" value="${branchProgram.employee.em_name}" readonly/>
		<label>총 인원수:</label>
		<input class="form-control" name="bp_total" value="${branchProgram.bp_total}" placeholder="숫자를 입력하세요."/>
		<button type="submit" class="btn btn-outline-success">수정</button>
	</form>
	
</body>
</html>
