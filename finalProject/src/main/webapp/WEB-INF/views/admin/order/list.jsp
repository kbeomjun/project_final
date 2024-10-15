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
	                        <a class="nav-link" href="<c:url value="/admin/program/list"/>">프로그램관리</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/admin/schedule/list"/>">프로그램일정관리</a>
	                    </li>
						<li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/admin/order/list"/>">운동기구 발주목록</a>
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
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${pm.cri.br_name} 발주신청 목록</h2>
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
											<a href="<c:url value="/admin/order/delete?bo_num=${list.bo_num}"/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('취소하시겠습니까?');">신청취소</a>
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
					
					<c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/admin/order/list">
									<c:param name="page" value="${pm.startPage - 1}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
								<c:url var="url" value="/admin/order/list">
									<c:param name="page" value="${i}"/>
								</c:url>
								<c:choose>
									<c:when test="${pm.cri.page eq i}">
										<c:set var="active" value="active"/>
									</c:when>
									<c:otherwise>
										<c:set var="active" value=""/>
									</c:otherwise>
								</c:choose>
								<li class="page-item ${active}">
									<a class="page-link" href="${url}">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${pm.next}">
								<c:url var="url" value="/admin/order/list">
									<c:param name="page" value="${pm.endPage + 1}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">다음</a>
								</li>
							</c:if>
						</ul>
					</c:if>
					
					<div class="text-right mb-3">
						<a href="<c:url value="/admin/order/insert"/>" class="btn btn-outline-success btn-sm">발주신청</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>

</body>
</html>
