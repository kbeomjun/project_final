<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
    <tiles:insertAttribute name="head"/>
    <style>
        /* 모달 배경 스타일 */
        .modal-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        /* 모달 콘텐츠 스타일 */
        .modal-email {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px; /* 모달 가로 크기 조정 */
        }

        /* 로딩 스피너 스타일 */
        .spinner-border {
            width: 3rem;
            height: 3rem;
            margin: 10px 0;
        }

        /* 모달 텍스트 스타일 */
        .modal-email p {
            margin-top: 15px;
            font-size: 16px;
            color: #333;
        }
    </style>
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
