<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
<style>
    .inquiry-section {
        border: 1px solid #e0e0e0;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 8px;
        background-color: #f9f9f9;
    }
    .response-section {
        border: 1px solid #a0d1f9;
        padding: 20px;
        border-radius: 8px;
        background-color: #e6f2ff;
        margin-top: 30px;
    }
    .section-title {
        font-weight: bold;
        margin-bottom: 15px;
    }
    .form-control[readonly] {
        background-color: #fff;
        border: none;
    }
    .btn-outline-info {
        margin-top: 20px;
    }
</style>
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
					<div class="inquiry-section">
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
							<div class="form-control" id="po_content" style="min-height: 200px; height:auto">${inquiry.mi_content}</div>
						</div>
						
						<!-- 문의 답변 섹션 -->
	                    <div class="response-section">
	                        <div class="section-title">답변</div>
	                        <c:choose>
	                            <c:when test="${inquiry.mi_answer != null}">
	                                <div class="form-group">
	                                    <label for="response_content">답변:</label>
	                                    <div class="form-control" id="response_content" style="min-height: 200px; height:auto">${inquiry.mi_answer}</div>
	                                </div>
	                            </c:when>
	                            <c:otherwise>
	                                <div class="form-group">
	                                    <p class="text-muted">아직 답변이 등록되지 않았습니다.</p>
	                                </div>
	                            </c:otherwise>
	                        </c:choose>
	                    </div>
						
						<div>
							<a href="<c:url value="/mypage/inquiry/list"/>" class="btn btn-outline-info">목록</a>
						</div>
					</div>
	            </div>
	        </main>
	    </div>
	</div>
</body>
</html>
