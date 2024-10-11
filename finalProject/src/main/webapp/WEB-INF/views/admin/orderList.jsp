<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>발주신청 목록</title>
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
						<li class="nav-item active">
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
					<h2 class="mt-3 mb-3">${br_name} 발주신청 목록</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>운동기구명</th>
								<th>발주수량</th>
								<th>발주날짜</th>
								<th>발주상태</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderList}" var="list">
								<tr>
									<td>${list.bo_se_name}</td>
									<td>${list.bo_amount}</td>
									<td>
										<fmt:formatDate value="${list.bo_date}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${list.bo_state}</td>
									<c:if test="${list.bo_state == '승인대기'}">
										<td>
											<a href="<c:url value="/admin/order/delete?bo_num=${list.bo_num}"/>" class="btn btn-outline-danger btn-sm">신청취소</a>
										</td>							
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${orderList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="5">신청목록이 없습니다.</th>
								</tr>
							</c:if>
						</tbody>
					</table>
					<div class="text-right mb-3">
						<a href="<c:url value="/admin/order/insert"/>" class="btn btn-outline-success btn-sm">발주신청</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>

</body>
</html>
