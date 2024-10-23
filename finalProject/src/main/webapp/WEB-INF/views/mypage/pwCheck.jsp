<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2 class="mb-3">비밀번호 확인</h2>
			        <form action="<c:url value='/mypage/pwcheck'/>" method="post">
			        	<input type="hidden" name="me_id" value="${me_id}">
			            <div class="form-group">
			                <label for="me_pw">비밀번호:</label>
			                <input type="password" id="me_pw" name="me_pw" class="form-control" placeholder="비밀번호를 입력하세요" required>
			            </div>
			            <button type="submit" class="btn btn-primary">확인</button>
			        </form>
					
	            </div>
	        </main>
	    </div>
	</div>
</body>
</html>
