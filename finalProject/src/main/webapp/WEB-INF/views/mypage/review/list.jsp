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
	                <h2>나의 작성글</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>지점</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${reviewList}" var="list">
								<tr>
									<td>${list.rp_num}</td>
									<td>${list.rp_br_name}</td>
									<td>
										<c:url var="url" value="/mypage/review/detail/${list.rp_num}">
											<c:param name="page" value="${pm.cri.page}"/>
											<c:param name="type" value="${pm.cri.type}"/>
											<c:param name="search" value="${pm.cri.search}"/>
										</c:url>
										<a href="${url}">${list.rp_title}</a>
									</td>
									<td>${list.pa_me_id}</td>
									<td>
										<fmt:formatDate value="${list.rp_date}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${list.rp_view}</td>
								</tr>
							</c:forEach>
							<c:if test="${reviewList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="6">등록된 리뷰가 없습니다.</th>							
								</tr>
							</c:if>
						</tbody>
					</table>
					
					<c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/mypage/review/list">
									<c:param name="page" value="${pm.startPage - 1}"/>
									<c:param name="type" value="${pm.cri.type}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
								<c:url var="url" value="/mypage/review/list">
									<c:param name="page" value="${i}"/>
									<c:param name="type" value="${pm.cri.type}"/>
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
								<c:url var="url" value="/mypage/review/list">
									<c:param name="page" value="${pm.endPage + 1}"/>
									<c:param name="type" value="${pm.cri.type}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">다음</a>
								</li>
							</c:if>
						</ul>
					</c:if>
	            </div>
	        </main>
	    </div>
	</div>
</body>
</html>
