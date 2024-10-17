<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>자주 묻는 질문</title>
<style>
    .q {
        cursor: pointer;
        background-color: #f1f1f1; 
        padding: 15px;
        margin: 5px 0;
        border-radius: 5px;
        border: 1px solid #ddd; 
        font-weight: bold;
        transition: background-color 0.3s ease;
    }

    .q:hover {
        background-color: #e0e0e0; 
    }

    .a {
        display: none;
        padding: 15px;
        margin: 0 0 10px 0;
        background-color: #ffffff;
        border-left: 3px solid #007bff;
        border-radius: 0 5px 5px 5px; 
        color: #333;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .list-group-item {
        border: none;
    }
</style>
</head>
<body>
	<script>
	    $(document).ready(function () {
	        $('.q').click(function () {
	            $(this).siblings(".a").slideToggle("fast"); // q 클릭 시 a 영역 토글
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
						<ul class="list-group">
							<c:forEach items="${faqList}" var="faq">
								<li class="list-group-item">
			                        <div class="q">[${faq.mi_it_name}] ${faq.mi_title}</div>
			                        <div class="a mt-3"><p>${faq.mi_content}</p></div>								
								</li>
							</c:forEach>
						</ul>
	                </div>

	            </div>
	        </main>
	    </div>
	</div>

</body>
</html>
