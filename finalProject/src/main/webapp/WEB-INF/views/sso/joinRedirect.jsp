<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
    <h1>간편 가입 페이지로 이동합니다...</h1>

    <form id="socialJoinForm" action=<c:url value="/sso/joinRedirect"/> method="post">
        <input type="hidden" name="socialType" value="${socialType}" />
        <input type="hidden" name="me_email" value="${email}" />
        <c:choose>
        <c:when test="${ socialType eq 'KAKAO'}">
	        <input type="hidden" name="me_kakaoUserId" value="${id}" />
        </c:when>
        <c:when test="${ socialType eq 'NAVER'}">
	        <input type="hidden" name="me_naverUserId" value="${id}" />
        </c:when>
        </c:choose>
        <input type="hidden" name="me_gender" value="${gender}" />
        <input type="hidden" name="me_phone" value="${phone}" />
        <input type="hidden" name="me_name" value="${name}" />
    </form>
    <script>
        // DOMContentLoaded 이벤트가 발생하면 폼을 자동으로 제출합니다.
        window.onload = function() {
            document.getElementById("socialJoinForm").submit();
        };  
    </script>
</body>
</html>
