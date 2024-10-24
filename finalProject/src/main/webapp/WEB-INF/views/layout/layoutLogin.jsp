<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <tiles:insertAttribute name="head"/>
    
	<title>
		<c:choose>
			<c:when test="${title ne null}">${title}</c:when>
			<c:otherwise>KH Fitness</c:otherwise>
		</c:choose>
	</title>
	
</head>
<body>
	<main class="login_container clearfix" id="skipnav_target"> 
		<tiles:insertAttribute name="body" />                                                 
    </main>
</body>
</html>
