<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>예약회원 목록</title>
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
	                        <a class="nav-link active" href="<c:url value="/admin/schedule/list"/>">프로그램일정관리</a>
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
					<h2 class="mt-3 mb-3">예약회원 목록</h2>
					<table class="table">
						<thead>
							<tr>
								<th>회원명</th>
								<th>전화번호</th>
								<th>생년월일</th>
								<th>성별</th>
								<th>노쇼경고횟수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${memberList}" var="list">
								<tr>
									<td>${list.me_name}</td>
									<td>${list.me_phone}</td>
									<td>
										<fmt:formatDate value="${list.me_birth}" pattern="yyyy년 MM월 dd일"/> 
									</td>
									<td>${list.me_gender}</td>
									<td>${list.me_noshow}</td>
								</tr>
							</c:forEach>
							<c:if test="${memberList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="5">등록된 회원이 없습니다.</th>
								</tr>
							</c:if>
						</tbody>
					</table>
					<c:url var="url" value="/admin/schedule/list">
						<c:param name="view" value="${view}"/>
						<c:param name="page" value="${cri.page}"/>
						<c:param name="type" value="${cri.type}"/>
						<c:param name="search" value="${cri.search}"/>
					</c:url>
					<a href="${url}" class="btn btn-outline-info">목록</a>
	                
	            </div>
	        </main>
	    </div>
	</div>

</body>
</html>
