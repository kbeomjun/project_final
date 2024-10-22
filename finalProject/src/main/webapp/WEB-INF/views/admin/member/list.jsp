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
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
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
										<c:url var="url" value="/admin/member/detail/${me.me_id}">
											<c:param name="page" value="${pm.cri.page}"/>
											<c:param name="search" value="${pm.cri.search}"/>
										</c:url>
										<a href="${url}">조회</a>
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
					
					<c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/admin/member/list">
									<c:param name="page" value="${pm.startPage - 1}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
								<c:url var="url" value="/admin/member/list">
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
								<c:url var="url" value="/admin/member/list">
									<c:param name="page" value="${pm.endPage + 1}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">다음</a>
								</li>
							</c:if>
						</ul>
					</c:if>
					<form action="<c:url value="/admin/member/list"/>">
						<div class="input-group mb-3 mt-3">
							<input type="text" class="form-control" placeholder="이름으로 검색" name="search" value="${pm.cri.search}">
							<div class="input-group-append">
								<button type="submit" class="btn btn-outline-info btn-sm col-12">검색</button>
							</div>
						</div>	
					</form>
					
					<div class="text-right mb-3">
						<a href="<c:url value="/terms"/>" class="btn btn-outline-success btn-sm">회원등록</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>	
	
</body>
</html>
