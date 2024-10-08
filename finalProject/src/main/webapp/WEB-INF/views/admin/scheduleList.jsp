<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>스케줄 목록</title>
</head>
<body>
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h1 class="mt-3 mb-3">${pm.cri.br_name} 스케줄 목록</h1>
		<form action="<c:url value="/admin/schedule/list"/>" method="get">
		    <button type="submit" name="view" value="present" class="btn btn<c:if test="${view ne 'present'}">-outline</c:if>-info mb-3">현재예약현황</button>
		    <button type="submit" name="view" value="past" class="btn btn<c:if test="${view ne 'past'}">-outline</c:if>-info mb-3">이전예약내역</button>
		</form>
		<table class="table text-center">
			<thead>
				<tr>
					<th>프로그램명</th>
					<th>트레이너명</th>
					<th>[예약인원 / 총인원]</th>
					<th>프로그램 날짜</th>
					<th>프로그램 시간</th>
					<th>예약회원보기</th>
					<c:if test="${view eq 'present'}">
						<th>수정</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${scheduleList}" var="list">
					<tr>
						<td>
							<c:url var="url" value="/admin/schedule/list">
								<c:param name="view" value="${view}"/>
								<c:param name="type" value="program"/>
								<c:param name="search" value="${list.bp_sp_name}"/>
							</c:url>
							<a href="${url}">${list.bp_sp_name}</a>
						</td>
						<td>
							<c:url var="url" value="/admin/schedule/list">
								<c:param name="view" value="${view}"/>
								<c:param name="type" value="trainer"/>
								<c:param name="search" value="${list.em_name}"/>
							</c:url>
							<a href="${url}">${list.em_name}</a>
						</td>
						<td>${list.bs_current} / ${list.bp_total}</td>
						<td>
							<fmt:formatDate value="${list.bs_start}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<fmt:formatDate value="${list.bs_start}" pattern="HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
						</td>
						<td>
							<c:url var="url" value="/admin/schedule/detail">
								<c:param name="bs_num" value="${list.bs_num}"/>
								<c:param name="view" value="${view}"/>
								<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
							</c:url>
							<a href="${url}">조회</a>
						</td>
						<c:if test="${view eq 'present'}">
							<td>
								<c:url var="url" value="/admin/schedule/update">
									<c:param name="bs_num" value="${list.bs_num}"/>
									<c:param name="view" value="${view}"/>
									<c:param name="page" value="${pm.cri.page}"/>
									<c:param name="type" value="${pm.cri.type}"/>
									<c:param name="search" value="${pm.cri.search}"/>
								</c:url>
								<a href="${url}" class="btn btn-outline-warning btn-sm">수정</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
				<c:if test="${scheduleList.size() eq 0}">
					<tr>
						<th class="text-center" colspan="6">등록된 스케줄이 없습니다.</th>
					</tr>
				</c:if>				
			</tbody>
		</table>
		
		<c:if test="${pm.totalCount ne 0}">
			<ul class="pagination justify-content-center">
				<c:if test="${pm.prev}">
					<c:url var="url" value="/admin/schedule/list">
						<c:param name="view" value="${view}"/>
						<c:param name="page" value="${pm.startPage - 1}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="search" value="${pm.cri.search}"/>
					</c:url>
					<li class="page-item">
						<a class="page-link" href="${url}">이전</a>
					</li>
				</c:if>
				<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
					<c:url var="url" value="/admin/schedule/list">
						<c:param name="view" value="${view}"/>
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
					<c:url var="url" value="/admin/schedule/list">
						<c:param name="view" value="${view}"/>
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
		<form action="<c:url value="/admin/schedule/list"/>">
			<input type="hidden" name="view" value="${view}">
			<div class="input-group mb-3 mt-3">
				<select class="form-control col-md-1" name="type">
					<option value="program"	<c:if test="${pm.cri.type eq 'program'}">selected</c:if>>프로그램명</option>
					<option value="trainer"	<c:if test="${pm.cri.type eq 'trainer'}">selected</c:if>>트레이너명</option>
				</select>
				<input type="text" class="form-control" placeholder="검색어" name="search" value="${pm.cri.search}">
				<div class="input-group-append">
					<button type="submit" class="btn btn-outline-info btn-sm col-12">검색</button>
				</div>
			</div>	
		</form>
		<div class="text-right mb-3">	
			<a href="<c:url value="/admin/schedule/insert/${pm.cri.br_name}"/>" class="btn btn-outline-success btn-sm">스케줄 추가</a>
		</div>
	<!-- </main> -->
</body>
</html>
