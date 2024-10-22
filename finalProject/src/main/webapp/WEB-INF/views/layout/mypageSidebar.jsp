<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<body>
	<!-- sidebar.jsp -->
    <div class="sidebar-sticky">
        <h4 class="sidebar-heading mt-3">마이페이지</h4>
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
