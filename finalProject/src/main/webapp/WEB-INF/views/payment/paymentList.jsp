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
		<section class="sub_banner sub_banner_02"></section>
			<section class="sub_content">
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">회원권 결제</h2>
						<p class="sub_title__txt">※ PT 이용권은 지정된 기간 내에 사용하지 않으면 소멸됩니다.</p>
						<p class="sub_title__txt">※ 회원권 결제는 로그인 후 이용 가능 합니다.</p>
					</div>
					<div class="table_wrap">
						<table class="table">
							<caption class="blind">회원권의 이용권 종류와 기간, 횟수, 가격이 있는 테이블</caption>
							<colgroup>
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">이용권 종류</th>
									<th scope="col">기간(개월)</th>
									<th scope="col">횟수(회)</th>
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
						<div class="btn_wrap">
							<div class="btn_right_wrap">
								<div class="btn_link_black">
									<a href="<c:url value="/payment/paymentInsert" />" class="btn btn_black js-btn-insert">
										<span>회원권 결제<i class="ic_link_share"></i></span>
									</a>
									<div class="btn_black_top_line"></div>
									<div class="btn_black_right_line"></div>
									<div class="btn_black_bottom_line"></div>
									<div class="btn_black_left_line"></div>
								</div>
								<c:if test="${hasMembership}">
									<div class="btn_link_black bg_white">
										<a href="<c:url value="/payment/paymentInsertPT" />" class="btn btn_black js-btn-insert">
											<span>PT 결제<i class="ic_link_share"></i></span>
										</a>
										<div class="btn_black_top_line"></div>
										<div class="btn_black_right_line"></div>
										<div class="btn_black_bottom_line"></div>
										<div class="btn_black_left_line"></div>
									</div>
								</c:if>	
							</div>
						</div>
					</div>
				</section>
			</section>
	
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