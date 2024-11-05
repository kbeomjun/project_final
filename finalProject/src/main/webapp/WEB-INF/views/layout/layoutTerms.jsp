<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<style>
    .header-wrap {
        display: flex;
        align-items: center;
        margin-top: 20px; /* 상단 여백 */
        margin-bottom: 10px; /* 링크와 제목 간 간격 */
    }

    .header-wrap .login_prev_wrap {
        margin-right: 10px; /* Return Home과 제목 사이 간격 */
    }

    .sub_title_wrap {
        text-align: left;
        margin: 0;
    }

    .terms_content {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        font-family: Arial, sans-serif;
        line-height: 1.6;
    }
</style>



<head>
    <tiles:insertAttribute name="head"/>
</head>
<body>
	<main class="terms_content" id="skipnav_target"> 
		<tiles:insertAttribute name="body" />                                                 
    </main>
    <footer>
        <tiles:insertAttribute name="footer" />
    </footer>
</body>
</html>
