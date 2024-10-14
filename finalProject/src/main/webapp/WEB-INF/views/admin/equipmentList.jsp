<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>운동기구 보유 목록</title>
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
	                        <a class="nav-link" href="<c:url value="/admin/member/list"/>">회원관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/branch/detail"/>">지점 상세보기</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/admin/equipment/list"/>">운동기구 보유목록</a>
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
					<h2 class="mt-3 mb-3">${br_name} 보유 목록</h2>
					<form action="<c:url value="/admin/equipment/list"/>" method="get">
					    <button type="submit" name="view" value="all" class="btn btn<c:if test="${view ne 'all'}">-outline</c:if>-info">전체보기</button>
					    <button type="submit" name="view" value="equipment" class="btn btn<c:if test="${view ne 'equipment'}">-outline</c:if>-info">기구별보기</button>
					</form>	
					<table class="table text-center">
						<thead>
							<tr>
								<th>운동기구명</th>
								<c:if test="${view eq 'all'}">
									<th>제조년월일</th>
								</c:if>
								<th>총 갯수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${equipmentList}" var="list">
								<tr>
									<td>${list.be_se_name}</td>
									<c:if test="${view eq 'all'}">
										<td>
											<fmt:formatDate value="${list.be_birth}" pattern="yyyy-MM-dd"/>
										</td>
									</c:if>
									<td>${list.be_se_total}</td>
								</tr>
							</c:forEach>
							<c:if test="${equipmentList.size() eq 0}">
								<tr>
									<c:choose>
										<c:when test="${view eq 'all'}">
											<th class="text-center" colspan="3">등록된 기구가 없습니다.</th>							
										</c:when>
										<c:otherwise>
											<th class="text-center" colspan="2">등록된 기구가 없습니다.</th>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:if>
						</tbody>
					</table>
	                
	            </div>
	        </main>
	    </div>
	</div>	

</body>
</html>
