<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 등록</title>
</head>
<body>
	<h1 class="mt-3 mb-3">${branchName} 프로그램 등록</h1>
	<form class="form-inline" action="<c:url value="/admin/program/insert"/>" method="post">
		<label>프로그램:</label>
		<select class="form-control" name="bp_sp_name">
			<c:forEach items="${programList }" var="program">
				<option value="${program.sp_name}">${program.sp_name}</option>
			</c:forEach>		
		</select>
		<label>트레이너:</label>
		<select class="form-control" name="bp_em_num">
			<c:forEach items="${employeeList }" var="employee">
				<option value="${employee.em_num}">${employee.em_name}</option>
			</c:forEach>		
		</select>
		<label>총 인원수:</label>
		<input class="form-control" name="bp_total" placeholder="숫자를 입력하세요."/>
		<button type="submit" class="btn btn-outline-success">등록</button>
	</form>
	
</body>
</html>
