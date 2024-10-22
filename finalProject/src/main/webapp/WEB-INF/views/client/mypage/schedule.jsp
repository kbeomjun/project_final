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

	<c:if test="${not empty msg}">
	    <script type="text/javascript">
	        alert("${msg}");
	    </script>
	</c:if>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2 class="mb-3">내 예약내역</h2>
			   		<form action="<c:url value="/client/mypage/schedule/${me_id}"/>" method="get">
					    <button type="submit" name="view" value="present" class="btn btn<c:if test="${view ne 'present'}">-outline</c:if>-info mb-3">현재예약현황</button>
					    <button type="submit" name="view" value="past" class="btn btn<c:if test="${view ne 'past'}">-outline</c:if>-info mb-3">이전예약내역</button>
					</form>
					<table class="table text-center">
						<thead>
							<tr>
								<th>연도</th>
								<th>지점명</th>
								<th>프로그램명</th>
								<th>트레이너명</th>
								<th>[예약인원 / 총인원]</th>
								<th>프로그램 예정 시간</th>
								<th>신청 날짜</th>
								<c:if test="${view eq 'present'}">
									<th>예약취소</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${reservationList}" var="list">
								<tr>
									<td>
										<fmt:formatDate value="${list.bs_start}" pattern="yyyy"/>
									</td>
									<td>
										<c:url var="url" value="/client/mypage/schedule/${me_id}">
											<c:param name="view" value="${view}"/>
											<c:param name="type" value="branch"/>
											<c:param name="search" value="${list.bp_br_name}"/>
										</c:url>
										<a href="${url}">${list.bp_br_name}</a>
									</td>
									<td>
										<c:url var="url" value="/client/mypage/schedule/${me_id}">
											<c:param name="view" value="${view}"/>
											<c:param name="type" value="program"/>
											<c:param name="search" value="${list.bp_sp_name}"/>
										</c:url>
										<a href="${url}">${list.bp_sp_name}</a>
									</td>
									<td>
										<c:url var="url" value="/client/mypage/schedule/${me_id}">
											<c:param name="view" value="${view}"/>
											<c:param name="type" value="trainer"/>
											<c:param name="search" value="${list.em_name}"/>
										</c:url>
										<a href="${url}">${list.em_name}</a>
									</td>
									<td>${list.bs_current} / ${list.bp_total}</td>
									<td>
										<fmt:formatDate value="${list.bs_start}" pattern="MM/dd HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
									</td>
									<td>
										<fmt:formatDate value="${list.pr_date}" pattern="MM/dd HH:mm"/>
									</td>
									<c:if test="${view eq 'present'}">
										<td>
											<a href="<c:url value="/client/mypage/schedule/cancel/${list.pr_num}/${list.bs_num}"/>" 
															class="btn btn-outline-danger btn-sm"
															onclick="return confirm('취소하시겠습니까?');">취소</a>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${reservationList.size() eq 0}">
								<tr>
									<c:if test="${view eq 'present'}">
										<th class="text-center" colspan="7">등록된 스케줄이 없습니다.</th>
									</c:if>
									<c:if test="${view eq 'past'}">
										<th class="text-center" colspan="6">등록된 스케줄이 없습니다.</th>
									</c:if>
								</tr>
							</c:if>				
						</tbody>
					</table>
					
					<c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/client/mypage/schedule/${me_id}">
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
								<c:url var="url" value="/client/mypage/schedule/${me_id}">
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
								<c:url var="url" value="/client/mypage/schedule/${me_id}">
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
					<form action="<c:url value="/client/mypage/schedule/${me_id}"/>">
						<input type="hidden" name="view" value="${view}">
						<div class="input-group mb-3 mt-3">
							<select class="form-control col-md-1" name="type">
								<option value="branch"	<c:if test="${pm.cri.type eq 'branch'}">selected</c:if>>지점명</option>
								<option value="program"	<c:if test="${pm.cri.type eq 'program'}">selected</c:if>>프로그램명</option>
								<option value="trainer"	<c:if test="${pm.cri.type eq 'trainer'}">selected</c:if>>트레이너명</option>
							</select>
							<input type="text" class="form-control" placeholder="검색어" name="search" value="${pm.cri.search}">
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
