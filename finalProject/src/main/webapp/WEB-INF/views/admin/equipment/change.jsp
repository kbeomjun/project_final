<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>운동기구 재고 변동내역</title>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${pm.cri.br_name} 재고 변동내역</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>운동기구명</th>
								<th>제조년월일</th>
								<th>수량</th>
								<th>기록날짜</th>
								<th>기록유형</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${equipmentChange}" var="change">
								<tr>
									<td>${change.be_se_name}</td>
									<td>
										<fmt:formatDate value="${change.be_birth}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${change.be_amount}</td>
									<td>
										<fmt:formatDate value="${change.be_record}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${change.be_type}</td>
								</tr>
							</c:forEach>
							<c:if test="${equipmentChange.size() eq 0}">
								<tr>
									<th class="text-center" colspan="5">변동내역이 없습니다.</th>							
								</tr>
							</c:if>
						</tbody>
					</table>
	                
	                <c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/admin/equipment/change">
									<c:param name="page" value="${pm.startPage - 1}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
								<c:url var="url" value="/admin/equipment/change">
									<c:param name="page" value="${i}"/>
									<c:param name="search" value="${pm.cri.search}"/>
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
								<c:url var="url" value="/admin/equipment/change">
									<c:param name="page" value="${pm.endPage + 1}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">다음</a>
								</li>
							</c:if>
						</ul>
					</c:if>
					<form action="<c:url value="/admin/equipment/change"/>">
						<div class="input-group mb-3 mt-3">
							<input type="text" class="form-control" placeholder="기구명으로 검색" name="search" value="${pm.cri.search}">
							<div class="input-group-append">
								<button type="submit" class="btn btn-outline-info btn-sm col-12">검색</button>
							</div>
						</div>	
					</form>
	                
	            </div>
	        </main>
	    </div>
	</div>	

</body>
</html>
