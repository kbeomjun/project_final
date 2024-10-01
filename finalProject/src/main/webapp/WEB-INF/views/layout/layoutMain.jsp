<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <tiles:insertAttribute name="head"/>
    
	<title>
		<c:choose>
			<c:when test="${title ne null}">${title}</c:when>
			<c:otherwise>KH Fitness</c:otherwise>
		</c:choose>
	</title>
	
</head>
<body>
    <tiles:insertAttribute name="header"/>
        <main class="main_container" id="skipnav_target"> 
				<tiles:insertAttribute name="body" />                                                 
	    </main>
    <tiles:insertAttribute name="footer" />
    
    <script>
		$(".js-gnb_side__link").on("click", function(){
			$(".gnb_side_wrap").addClass("_active");
		})
		$(".js-btn_x").on("click", function(){
			$(".gnb_side_wrap").removeClass("_active");
		})

		const progressLine = document.querySelector('.autoplay-progress svg')
		const mainSwiper = new Swiper(".main-swiper", {
			loop: true,
			autoplay: {
				delay: 5000, // 5초
				disableOnInteraction: false,
			},
			// bullet
			// pagination: {
			// 	el: ".main-swiper .swiper-pagination",
			// 	clickable: false,
			// 	type: "custom",
			// 	renderCustom: function (swiper, current, total) {
			// 		return (
			// 			'<span class="current">' + 0 + (current) + '</span>' + '<span class="total">' + 0 + (total) + '</span>'
			// 		);
			// 	}
			// },
			//arrow
			navigation: {
				nextEl: ".main-swiper .swiper-button-next",
				prevEl: ".main-swiper .swiper-button-prev",
			},
			// svg
			on: {
				autoplayTimeLeft(s, time, progress) {
					progressLine.style.setProperty("--progress", 1 - progress)
				}
			}
		});
		

		$(function(){
			var url = window.location.pathname;
			
			// 주소가 같으면 메뉴에 _active
			$(".gnb__item").find(".gnb__link").each(function(){
				$(this).toggleClass("_active", $(this).attr("href") == url);
				console.log($(this).attr("href") == url);
			});
			
			// 메인에서 로고 하얀새으로 변경
			$(".logo").each(function(){
				if($(this).attr("href") == url){
					$(this).addClass("logo-white");
				}
				console.log($(this).attr("href") == url);
			})
			
		});
	</script>
</body>
</html>
