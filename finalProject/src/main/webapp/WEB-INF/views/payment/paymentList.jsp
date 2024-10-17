<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>회원권 리스트</title>
</head>
<body>
	<!-- main container -->
	<!-- <main class="sub_container" id="skipnav_target"> -->
		<h2 class="mb10">회원권</h2>
		<ul class="mb10">
			<li>※ PT 이용권은 지정된 기간 내에 사용하지 않으면 소멸됩니다.</li>
			<li>※ 회원권 결제는 로그인 후 이용 가능 합니다.</li>
		</ul>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">이용권 종류</th>
					<th scope="col">기간(일)</th>
					<th scope="col">횟수</th>
					<th scope="col">가격</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${membershipList}" var="ptList">
		            <tr>
		                <td>${ptList.pt_name}</td>
		                <td>${ptList.pt_date}</td>
		                <td>${ptList.pt_count}</td>
		                <td>${ptList.formattedPrice}원</td> <!-- 포맷된 가격 사용 -->
		            </tr>
		        </c:forEach>
			</tbody>
		</table>
		<div class="text-right">
			<a href="<c:url value="/payment/paymentInsert" />" class="btn btn-primary js-btn-insert">회원권 결제</a>
			<c:if test="${hasMembership}">
			    <a href="<c:url value="/payment/paymentInsertPT" />" class="btn btn-info js-btn-insert">PT 결제</a>
			</c:if>
		</div>
	
		<script type="text/javascript">
			$('.js-btn-insert').click(function(e){
				if('${user.me_id}' != ''){
					return;
				}
				e.preventDefault();
				if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하겠습니까?')){
					location.href = "<c:url value="/login"/>"
				}
			});
		</script>
</body>
</html>