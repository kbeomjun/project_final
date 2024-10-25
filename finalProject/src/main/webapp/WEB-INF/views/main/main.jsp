<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>main</title>
</head>
<body>
	<!-- main container -->
	<!-- <main class="main_container" id="skipnav_target"> -->
		<div class="main_banner_wrap">
			<div class="main_banner">
				<div class="swiper main-swiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="<c:url value='/resources' />/image/main/main1.jpg" class="main_banner__img" />
						</div>
						<div class="swiper-slide">
							<img src="<c:url value='/resources' />/image/main/main2.jpg" class="main_banner__img" />
						</div>
						<div class="swiper-slide">
							<img src="<c:url value='/resources' />/image/main/main3.jpg" class="main_banner__img" />
						</div>
					</div>
					<div class="progress-box">
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
						<div class="swiper-pagination"></div>
						<div class="autoplay-progress">
							<svg viewBox="0 0 100 10">
								<line x1="0" y1="0" x2="100" y2="0">
							</svg>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- </main> -->
	<!-- main container -->
</body>
</html>
