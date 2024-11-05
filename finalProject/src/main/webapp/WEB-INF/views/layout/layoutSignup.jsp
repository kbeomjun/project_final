<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
    <tiles:insertAttribute name="head"/>
</head>
<body>
	<main class="sub_content" id="skipnav_target"> 
		<tiles:insertAttribute name="body" />                                                 
    </main>
    <footer>
        <tiles:insertAttribute name="footer" />
    </footer>
</body>
</html>