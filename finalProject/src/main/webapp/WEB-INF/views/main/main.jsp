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
	<main class="main_container" id="skipnav_target">
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
						<div class="swiper-button-next">
							<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 39 71" height="56" width="28">
								<polyline points="2,0.7 37.8,35.5 2,70.3 " style="fill:none; stroke:#FFFFFF; stroke-width: 2px; stroke-opacity: 1;"/>
							</svg>
						</div>
						<div class="swiper-button-prev">
							<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 39 71" style="enable-background:new 0 0 39 71" height="56" width="28">
								<polyline points="37.8,70.3 2,35.5 37.8,0.7 " style="fill:none; stroke:#FFFFFF; stroke-width: 2px; stroke-opacity: 1;"/>
							</svg>
						</div>
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
	</main>
	<!-- main container -->
</body>
</html>
