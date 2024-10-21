<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>자주 묻는 질문</title>
<style>
    .faq-item {
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f8f9fa;
    }

    .faq-question {
        cursor: pointer;
        padding: 15px;
        margin: 0;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #ffffff;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .faq-question:hover {
        background-color: #e0e0e0;
    }

    .faq-answer {
        display: none;
        padding: 15px;
        background-color: #ffffff;
        border-top: 1px solid #ddd;
    }

    .faq-question em {
        font-style: normal;
        color: #6c757d;
        margin-right: 10px;
    }

    .faq-question span {
        text-align: left;
    }

    .faq-icon {
        font-size: 1.2rem;
        transition: transform 0.3s ease;
        margin-left: auto;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .faq-question.collapsed .faq-icon {
        transform: rotate(180deg);
    }

    .contentWarp {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap; /* 요소가 한 줄에 들어가지 않으면 줄 바꿈을 하도록 설정 */
    }

    .faqTab {
        display: flex;
        flex-wrap: wrap;
        flex-grow: 1;
        max-width: 70%; /* 탭의 최대 너비를 70%로 제한 */
    }

    .searchBoxWarp {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        flex-grow: 1;
        max-width: 30%; /* 검색 박스의 최대 너비를 30%로 설정 */
    }

    .searchTextBox {
        display: flex;
        align-items: center;
        border: 1px solid #ddd;
        border-radius: 5px;
        overflow: hidden;
        max-width: 100%;
    }
    
	.searchTextBox select {
		height: auto;
	    width: 100px; /* 원하는 너비 값 설정 */
	    max-width: 100%; /* 너비가 너무 커지지 않도록 제한 */
	}
	
    .searchTextBox input {
        border: none;
        padding: 10px;
        outline: none;
        flex-grow: 1;
        width: 200px;
	    max-width: 100%;
    }

    .searchTextBox button {
        border: none;
        background-color: #007bff;
        color: white;
        padding: 10px 15px;
        cursor: pointer;
        white-space: nowrap;
        height: auto;
    }
	.noList {
	    text-align: center;
	    background-color: #f8f9fa; /* 연한 배경색 */
	    padding: 20px;
	    margin: 10px 0;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    font-size: 1.1em;
	    color: #666;
	}
	
	.noList p {
	    margin: 0;
	    font-weight: bold;
	    color: #555;
	}    
</style>
</head>
<body>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.faq-question').click(function () {
                $(this).next(".faq-answer").slideToggle("fast");
                $(this).toggleClass('collapsed'); // 아이콘 회전 토글
            });
        });
    </script>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>자주 묻는 질문</h2>
	                <div class="mt-3">
						<div class="contentWarp">
							<div class="faqTab">
								<form action="<c:url value='/client/inquiry/faq'/>" method="get">
									<ul class="tabList">
										<c:choose>
											<c:when test="${category == 'all'}">
											    <button type="submit" name="category" value="all" class="btn btn-secondary">전체</button>
											</c:when>
											<c:otherwise>
											    <button type="submit" name="category" value="all" class="btn btn-outline-secondary">전체</button>
											</c:otherwise>
										</c:choose>
										<c:forEach items="${typeList}" var="tl">
										    <button type="submit" name="category" value="${tl.it_name}" class="btn btn<c:if test='${category ne tl.it_name}'>-outline</c:if>-secondary">${tl.it_name}</button>
										</c:forEach>
									</ul>
								</form>
							</div>
			                <div class="searchBoxWarp">
		                    	<form action="<c:url value='/client/inquiry/faq'/>" method="get">
				                    <div class="searchTextBox">
						                <select class="form-control" name="type">
											<option value="all" <c:if test="${pm.cri.type eq 'all'}">selected</c:if>>전체</option>
											<option value="title" <c:if test="${pm.cri.type eq 'title'}">selected</c:if>>제목</option>
											<option value="content" <c:if test="${pm.cri.type eq 'content'}">selected</c:if>>내용</option>
										</select>
										<input type="text" class="form-control" placeholder="검색어" name="search" value="${pm.cri.search}">
										<button type="submit" class="btn btn-outline-info btn-sm">검색</button>
			                    	</div>
		                    	</form>
			                </div>
						</div>
						<div class="faqList">
					        <c:forEach items="${faqList}" var="faq">
					            <div class="faq-item">
					                <div class="faq-question">
					                    <em>${faq.mi_it_name}</em>
					                    <span>${faq.mi_title}</span>
					                    <span class="faq-icon">▼</span>
					                </div>
					                <div class="faq-answer">
					                    <p>${faq.mi_content}</p>
					                </div>
					            </div>
					        </c:forEach>
							<c:if test="${empty faqList}">
								<div class="noList">
									<p>등록된 답변이 없습니다.</p>
								</div>
							</c:if>
				        </div>
					    <c:if test="${pm.totalCount ne 0}">
							<ul class="pagination justify-content-center">
								<c:if test="${pm.prev}">
									<c:url var="url" value="/client/inquiry/faq">
										<c:param name="page" value="${pm.startPage - 1}"/>
										<c:param name="type" value="${pm.cri.type}"/>
										<c:param name="search" value="${pm.cri.search}"/>
									</c:url>
									<li class="page-item">
										<a class="page-link" href="${url}">이전</a>
									</li>
								</c:if>
								<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
									<c:url var="url" value="/client/inquiry/faq">
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
									<c:url var="url" value="/client/inquiry/faq">
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
	            </div>
	        </main>
	    </div>
	</div>

</body>
</html>
