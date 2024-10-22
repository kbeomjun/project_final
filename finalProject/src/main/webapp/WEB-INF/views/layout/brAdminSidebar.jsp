<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<body>
	<!-- sidebar.jsp -->
    <div class="sidebar-sticky">
        <h4 class="sidebar-heading mt-3">지점관리자 메뉴</h4>
        <ul class="nav flex-column">
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/program/list"/>">프로그램관리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/schedule/list"/>">프로그램일정관리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/order/list"/>">운동기구 발주목록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/employee/list"/>">직원관리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/member/list"/>">회원관리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/branch/detail"/>">지점 상세보기</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/equipment/list"/>">운동기구 보유목록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/equipment/change"/>">운동기구 재고 변동내역</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/inquiry/list"/>">문의내역</a>
			</li>
        </ul>
    </div>
	
</body>
</html>
