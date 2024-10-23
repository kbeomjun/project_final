<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<!-- skip nav -->
		<div class="skip_nav">
			<a href="#skipnav_target">본문 영역 바로가기</a>
		</div>
		<!-- skip nav -->
		
		<!-- main header -->
		<header class="main_header">
			<div class="logo_wrap">
				<h1><a href="<c:url value="/" />" class="logo logo-light" title="Fitness Logo"><span class="blind">Fitness Logo</span></a></h1>
			</div>
			<nav class="gnb_wrap">
				<ul class="gnb">
					<li class="gnb__item"><a href="<c:url value="/branch/info" />" class="gnb__link">지점 조회</a></li>
					<li class="gnb__item"><a href="<c:url value="/payment/paymentList" />" class="gnb__link">회원권</a></li>
					<li class="gnb__item"><a href="<c:url value="/program/info"/>" class="gnb__link">프로그램</a></li>
					<li class="gnb__item"><a href="<c:url value="/client/review/list" />" class="gnb__link">고객센터</a></li>
					<li class="gnb__item"><a href="<c:url value="/admin/program/list"/>" class="gnb__link">지점관리</a></li>
					<li class="gnb__item"><a href="<c:url value="/hq/branch/list"/>" class="gnb__link">본사관리</a></li>
					<c:choose>
						<c:when test="${not empty sessionScope.user}">
							<li class="gnb__item"><a href="<c:url value='/logout'/>" class="gnb__link">로그아웃</a></li>
						</c:when>
						<c:otherwise>
							<li class="gnb__item"><a href="<c:url value='/login'/>" class="gnb__link">로그인</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
				<div class="gnb_side">
					<a href="javascript:void(0)" class="gnb_side__link js-gnb_side__link">
						<span>정보</span>
						<i class="ic_gnb_side_menu">
							<svg width="50" height="40" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
								<rect x="5" y="18" width="40" height="2" fill="white"/>
								<rect x="5" y="30" width="40" height="2" fill="white"/>
							</svg>
						</i>
					</a>
					<!-- gnb side -->
					<div class="gnb_side_wrap">
						<a href="javascript:void(0)" class="btn_x js-btn_x">
							<span>닫기</span>
							<svg width="25" height="25" viewBox="0 0 23 23" style="enable-background:new 0 0 23 23;" xml:space="preserve">
							<polygon points="22.5,21.7 12.7,11.9 12.2,11.4 12.2,11.4 12.2,11.4 12.7,10.9 22.5,1.2 21.8,0.5 11.5,10.8 1.2,0.5 
								0.5,1.2 10.3,10.9 10.8,11.4 10.8,11.4 10.8,11.4 10.3,11.9 0.4,21.7 1.1,22.4 11.5,12.1 21.8,22.4 "></polygon>
							</svg>
						</a>
						<div class="gnb_side__info_wrap">
							<div class="gnb_side__info">
								<div>
									<a href="<c:url value="/" />" class="gnb_side__logo" title="Fitness Logo"><span class="blind">Fitness Logo</span></a>
								</div>
								<div class="textbox">
									<p>Lorem ipsum dolor sit amet, consectetur<br>
									adipiscing elit. Pellentesque vitae nunc ut<br>
									dolor sagittis euismod eget sit amet erat.<br>
									Mauris porta. Lorem ipsum dolor.</p>
								</div>
								<div class="textbox">
									<h3 class="gnb_side__title">Working hours</h3>
									<p>Monday - Friday:<br>07:00 - 21:00</p>
									<p>Saturday:<br>07:00 - 16:00</p>
									<p>Sunday Closed</p>
								</div>
								<div class="textbox mt-auto">
									<h3 class="gnb_side__title">Our socials</h3>
									<div>
										<a href="#" class="gnb_side__sns sns_instagram" title="인스타그램"></a>
										<a href="#" class="gnb_side__sns sns_facebook" title="페이스북"></a>
										<a href="#" class="gnb_side__sns sns_twitter" title="트위터">	</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- gnb side -->
				</div>
			</nav>
		</header>