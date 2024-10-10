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
	                        <a class="nav-link" href="<c:url value="/client/mypage/schedule/${me_id}"/>">프로그램 일정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/membership/${me_id}"/>">회원권</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/review/list/${me_id}"/>">나의 작성글</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/client/mypage/inquiry/list/${me_id}"/>">문의내역</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwcheck/${me_id}"/>">개인정보수정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwchange/${me_id}"/>">비밀번호 변경</a>
	                    </li>
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<div>
						<div class="form-group">
							<label>문의유형:</label>
							<input type="text" class="form-control" readonly value="${inquiry.mi_it_name}">
						</div>
						<div class="form-group">
							<label>지점명:</label>
							<input type="text" class="form-control" readonly value="${inquiry.mi_br_name}">
						</div>
						<div class="form-group">
							<label>문의날짜:</label>
							<c:set var="formattedDate">
							    <fmt:formatDate value="${inquiry.mi_date}" pattern="yyyy-MM-dd" />
							</c:set>
							<input type="text"class="form-control"  readonly value="${formattedDate}">
						</div>
						<div class="form-group">
							<label>제목:</label>
							<input type="text" class="form-control" readonly value="${inquiry.mi_title}">
						</div>
						<div class="form-group">
							<label for="po_content">내용:</label>
							<div class="form-control" id="po_content" style="min-height: 400px; height:auto">${inquiry.mi_content}</div>
						</div>
						
						<div>
							<a href="<c:url value="/client/mypage/inquiry/list/${me_id}?page=${page}"/>" class="btn btn-outline-info">목록</a>
						</div>
					</div>
	            </div>
	        </main>
	    </div>
	</div>
</body>
</html>
