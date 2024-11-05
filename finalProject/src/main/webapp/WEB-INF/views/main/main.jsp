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
	<!-- main container -->
	
	<!-- program banner title -->
	<section class="fitness_banner_wrap">
		<!-- <div class="fitness_vertical_wrap">
			<div class="fitness_vertical">
				<h2 class="fitness_vertical_title">Fitness</h2>
			</div>
		</div> -->
		<div class="fitness_banner_title_wrap">
			<div class="fitness_banner_title_group">
				<h1 class="fitness_banner_title">
					What is functional<br>fitness all about
				</h1>
				<p class="fitness_banner_text">
					Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae
				</p>
			</div>
		</div>
	</section>
	<!-- program banner title -->
	
	<!-- program -->
	<section class="program_wrap">
		<ul class="program_group">
			<li class="program_item">
				<a href="<c:url value="/program/info"/>" class="program__link">
					<h2 class="program__title"><span>Cardio program</span></h2>
					<div class="program__explanation">
						Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quaerat praesentium non aperiam fugit earum rem voluptatibus nam facilis corrupti repudiandae consequuntur, voluptas, mollitia provident ducimus porro nobis vitae quibusdam a iste.
					</div>
					<div class="btn_link_white">
						<button type="button" class="btn btn_white font-montserrat">
							<span>read more<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_white_top_line"></div>
						<div class="btn_white_right_line"></div>
						<div class="btn_white_bottom_line"></div>
						<div class="btn_white_left_line"></div>
					</div>
				</a>
				<div class="program_item_bg program_item_bg_01"></div>
			</li>
			<li class="program_item">
				<a href="<c:url value="/program/info"/>" class="program__link">
					<h2 class="program__title"><span>Pure Strenght</span></h2>
					<div class="program__explanation">
						Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quaerat praesentium non aperiam fugit earum rem voluptatibus nam facilis corrupti repudiandae consequuntur, voluptas, mollitia provident ducimus porro nobis vitae quibusdam a iste.
					</div>
					<div class="btn_link_white">
						<button type="button" class="btn btn_white font-montserrat">
							<span>read more<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_white_top_line"></div>
						<div class="btn_white_right_line"></div>
						<div class="btn_white_bottom_line"></div>
						<div class="btn_white_left_line"></div>
					</div>
				</a>
				<div class="program_item_bg program_item_bg_02"></div>
			</li>
			<li class="program_item">
				<a href="<c:url value="/program/info"/>" class="program__link">
					<h2 class="program__title"><span>True Challenge</span></h2>
					<div class="program__explanation">
						Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quaerat praesentium non aperiam fugit earum rem voluptatibus nam facilis corrupti repudiandae consequuntur, voluptas, mollitia provident ducimus porro nobis vitae quibusdam a iste.
					</div>
					<div class="btn_link_white">
						<button type="button" class="btn btn_white font-montserrat">
							<span>read more<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_white_top_line"></div>
						<div class="btn_white_right_line"></div>
						<div class="btn_white_bottom_line"></div>
						<div class="btn_white_left_line"></div>
					</div>
				</a>
				<div class="program_item_bg program_item_bg_03"></div>
			</li>
			<li class="program_item">
				<a href="<c:url value="/program/info"/>" class="program__link">
					<h2 class="program__title"><span>Power yoga</span></h2>
					<div class="program__explanation">
						Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quaerat praesentium non aperiam fugit earum rem voluptatibus nam facilis corrupti repudiandae consequuntur, voluptas, mollitia provident ducimus porro nobis vitae quibusdam a iste.
					</div>
					<div class="btn_link_white">
						<button type="button" class="btn btn_white font-montserrat">
							<span>read more<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_white_top_line"></div>
						<div class="btn_white_right_line"></div>
						<div class="btn_white_bottom_line"></div>
						<div class="btn_white_left_line"></div>
					</div>
				</a>
				<div class="program_item_bg program_item_bg_04"></div>
			</li>
		</ul>
	</section>
	<!-- program -->
</body>
</html>
