<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style type="text/css">
	/* 하위 메뉴 숨김 처리 (기본적으로 display: none) */
	.submenu {
	    margin-left: 15px;
	}
	
	/* 하위 메뉴 항목 스타일 */
	.submenu .nav-link {
	    color: black;
	    text-decoration: none;
	    padding: 5px 10px;
	    display: flex;
	    align-items: center;
	}
	
	.submenu .nav-link::before {
	    content: "▶"; /* 화살표 추가 */
	    margin-right: 10px;
	    font-size: 12px;
	}	
	
	.submenu .nav-link:hover {
	    background-color: #f1f1f1;
	}
</style>
</head>
<body>
	<!-- sidebar.jsp -->
    <div class="sidebar-sticky">
        <h4 class="sidebar-heading mt-3">고객센터 메뉴</h4>
        <ul class="nav flex-column">
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/membership'/>">회원권</a>
			</li>
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/schedule'/>">프로그램 일정</a>
			</li>
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/review/list'/>">나의 작성글</a>
			</li>
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/inquiry/list'/>">문의내역</a>
			</li>
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/pwcheck'/>">개인정보수정</a>
			</li>
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/pwchange'/>">비밀번호 변경</a>
			</li>
			<li class="nav-item">
			    <a class="nav-link" href="<c:url value='/mypage/unregister'/>">회원탈퇴</a>
			</li>
        </ul>
    </div>
	
</body>
</html>
