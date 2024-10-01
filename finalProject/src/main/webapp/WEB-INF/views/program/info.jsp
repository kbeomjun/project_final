<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<h1>프로그램 안내</h1>
	<a class="btn btn-dark br-3" href="<c:url value="/program/info"/>">프로그램 안내</a>
	<a class="btn btn-outline-dark" href="<c:url value="/program/schedule"/>">프로그램 일정</a>
	<hr>
	
	<c:forEach items="${list}" var="sp" varStatus="status">
		<c:choose>
			<c:when test="${status.index == 0}">
				<c:set var="outline" value="" />
			</c:when>
			<c:otherwise>
				<c:set var="outline" value="outline-" />
			</c:otherwise>
		</c:choose>
		<button id="btn-sp-${status.index}" class="btn btn-${outline }primary"
			data-detail="${sp.sp_detail}" data-num="${status.index}" onclick="showDetail(this)">${sp.sp_name}</button>


	</c:forEach>
	<div id="program-detail">${list[0].sp_detail }</div>
	<br>
	<div id="program-penalty"></div>
		

	<script>
    function showDetail(selectedButton) {
    	
        // 모든 버튼을 찾아서 처리
        var buttons = document.querySelectorAll("button[id^='btn-sp-']");

        buttons.forEach((button) => {
	        if (button === selectedButton) {
	            // 클릭된 버튼에는 btn-primary 추가
	            button.classList.remove("btn-outline-primary");
	            button.classList.add("btn-primary");
	        } else {
	            // 다른 버튼들은 btn-outline-primary로 설정
	            button.classList.remove("btn-primary");
	            button.classList.add("btn-outline-primary");
	        }
        });
        
		// 클릭된 버튼의 data-detail 속성 값을 가져와서 표시
        var detail = selectedButton.getAttribute('data-detail');
        // detail-container에 클릭된 sp_detail을 표시
        document.getElementById("program-detail").innerHTML = detail;
        if(selectedButton.getAttribute('data-num') != 0) {
        	document.getElementById("program-penalty").innerHTML = "노쇼(no show)일 경우 패널티가 있다는 안내";
        }
        else {
        	document.getElementById("program-penalty").innerHTML = "";
        }
    }
</script>
</body>
</html>
