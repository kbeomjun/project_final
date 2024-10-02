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
		<div>
			<p>※PT이용권은 기간 이내에 사용하지 않으시면 소진 됩니다.</p>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">이용권 종류</th>
					<th scope="col">유형</th>
					<th scope="col">기간(일)</th>
					<th scope="col">횟수</th>
					<th scope="col">가격</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${paymentList}" var="ptList">
					<tr>
						<td>${ptList.pt_type}</td>
						<td>${ptList.pt_date}</td>
						<td>${ptList.pt_count}</td>
						<td>${ptList.pt_price}원</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div>
			<a href="<c:url value="/membership/membershipInsert" />" class="btn btn-primary">결제</a>
		</div>
</body>
</html>