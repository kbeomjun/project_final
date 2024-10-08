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
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">마이페이지 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/client/mypage/program/${me_id}"/>">프로그램 일정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="#">회원권</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/review/list/${me_id}"/>">나의 작성글</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="#">문의내역</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="#">개인정보수정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="#">비밀번호 변경</a>
	                    </li>
	                </ul>
	            </div>
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
								<th>지점명</th>
								<th>프로그램명</th>
								<th>트레이너명</th>
								<th>[예약인원 / 총인원]</th>
								<th>프로그램 날짜</th>
								<th>프로그램 시간</th>
								<c:if test="${view eq 'present'}">
									<th>예약취소</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${reservationList}" var="list">
								<tr>
									<td>${list.bp_br_name}</td>
									<td>${list.bp_sp_name}</td>
									<td>${list.em_name}</td>
									<td>${list.bs_current} / ${list.bp_total}</td>
									<td>
										<fmt:formatDate value="${list.bs_start}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<fmt:formatDate value="${list.bs_start}" pattern="HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
									</td>
									<c:if test="${view eq 'present'}">
										<td>
											<a href="#">취소</a>
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
	            </div>
	        </main>
	    </div>
	</div>
</body>
</html>
