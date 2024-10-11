<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>직원 목록</title>
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
	                    <li class="nav-item">
	                        <a href="<c:url value="/admin/schedule/list"/>" class="btn btn-outline-info mb-2">프로그램일정관리</a>
	                    </li>
						<li class="nav-item">
	                        <a href="<c:url value="/admin/order/list"/>" class="btn btn-outline-info mb-2">운동기구 발주목록</a>
	                    </li>
						<li class="nav-item active">
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
					<h2 class="mt-3 mb-3">${br_name} 직원 목록</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>직원번호</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>입사일</th>
								<th>직책</th>
								<th>상세</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${employeeList}" var="em">
								<tr>
									<td>${em.em_num}</td>
									<td>${em.em_name}</td>
									<td>${em.em_phone}</td>
									<td>${em.em_email}</td>
									<td>
										<fmt:formatDate value="${em.em_join}" pattern="yyyy.MM.dd"/>
									</td>
									<td>${em.em_position}</td>
									<td>
										<a href="<c:url value="/admin/employee/detail/${em.em_num}"/>">조회</a>
									</td>							
								</tr>
							</c:forEach>
							<c:if test="${employeeList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="7">등록된 직원이 없습니다.</th>
								</tr>
							</c:if>
						</tbody>
					</table>
					<div class="text-right mb-3">
						<a href="<c:url value="/admin/employee/insert/${br_name}"/>" class="btn btn-outline-success btn-sm">직원등록</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>	

</body>
</html>
