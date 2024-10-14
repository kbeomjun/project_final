<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>회원 목록</title>
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
	                        <a class="nav-link active" href="<c:url value="/admin/member/list"/>">회원관리</a>
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
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">회원 목록</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>성별</th>
								<th>생년월일</th>
								<th>상세</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${memberList}" var="me">
								<tr>
									<td>${me.me_id}</td>
									<td>${me.me_name}</td>
									<td>${me.me_gender}</td>
									<td>
										<fmt:formatDate value="${me.me_birth}" pattern="yyyy.MM.dd"/>
									</td>
									<td>
										<a href="<c:url value="/admin/member/detail/${me.me_id}"/>">조회</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${memberList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="5">등록된 회원이 없습니다.</th>
								</tr>
							</c:if>
						</tbody>
					</table>
					<div class="text-right mb-3">
						<a href="#" class="btn btn-outline-success btn-sm">회원등록</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>	
	
</body>
</html>
