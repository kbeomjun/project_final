<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 목록</title>
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
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">지점관리자 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/admin/program/list"/>">프로그램관리</a>
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
					<h2 class="mt-3 mb-3">${br_name} 프로그램 목록</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>프로그램명</th>
								<th>트레이너명</th>
								<th>총 인원수</th>
								<th>수정 / 삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${programList}" var="list">
								<tr>
									<td>${list.bp_sp_name}</td>
									<td>${list.employee.em_name}</td>
									<td>${list.bp_total}</td>
									<td>
										<c:if test="${list.program.sp_type == '그룹'}">
											<a href="<c:url value="/admin/program/update/${list.bp_num}"/>" class="btn btn-outline-warning btn-sm">수정</a>
										</c:if>
										<a href="<c:url value="/admin/program/delete/${list.bp_num}"/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${programList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="4">등록된 프로그램이 없습니다.</th>
								</tr>
							</c:if>				
						</tbody>
					</table>
					<div class="text-right mb-3">	
						<a href="<c:url value="/admin/program/insert"/>" class="btn btn-outline-success btn-sm">프로그램 추가</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>
</body>
</html>
