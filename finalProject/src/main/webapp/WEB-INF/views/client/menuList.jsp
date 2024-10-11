<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>지점관리자 메뉴</title>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">지점관리자 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-info mb-2">프로그램관리</a>
	                    </li>
	                    <li class="nav-item active">
	                        <a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-info mb-2">프로그램일정관리</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/order/list"/>" class="btn btn-outline-info mb-2">운동기구 발주목록</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/employee/list"/>" class="btn btn-outline-info mb-2">직원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/member/list"/>" class="btn btn-outline-info mb-2">회원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/branch/detail"/>" class="btn btn-outline-info mb-2">지점 상세보기</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/equipment/list"/>" class="btn btn-outline-info mb-2">운동기구 보유목록</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/equipment/change"/>" class="btn btn-outline-info mb-2">운동기구 재고 변동내역</a>
	                    </li>	                    	                    	                    	                    	                    
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                
	            </div>
	        </main>
	    </div>
	</div>	
	
	
</body>
</html>
