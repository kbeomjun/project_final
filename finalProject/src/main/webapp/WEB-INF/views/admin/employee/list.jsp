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
	
	<c:if test="${not empty msg}">
	    <script type="text/javascript">
	        alert("${msg}");
	    </script>
	</c:if>
	
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${pm.cri.br_name} 직원 목록</h2>
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
					
					<c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/admin/employee/list">
									<c:param name="page" value="${pm.startPage - 1}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
								<c:url var="url" value="/admin/employee/list">
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
								<c:url var="url" value="/admin/employee/list">
									<c:param name="page" value="${pm.endPage + 1}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">다음</a>
								</li>
							</c:if>
						</ul>
					</c:if>
					
					<div class="text-right mb-3">
						<a href="<c:url value="/admin/employee/insert"/>" class="btn btn-outline-success btn-sm">직원등록</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>	

</body>
</html>
