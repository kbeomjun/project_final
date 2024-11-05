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
		<main class="sub_container clearfix" id="skipnav_target"> 
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
		

		$(function() {
		    // 현재 URL을 가져옴
		    var url = window.location.pathname;

		    // 현재 URL을 콘솔에 출력
		    //console.log("현재 URL:", url);

		    // '/fitness/' 다음의 첫 번째 '/'까지 포함된 공통 경로를 가져오기
		    var firstSlashIndex = url.indexOf('/', 1); // 첫 번째 슬래시의 인덱스 (0은 '/'에 해당하므로 1부터 시작)
		    var secondSlashIndex = url.indexOf('/', firstSlashIndex + 1); // 두 번째 슬래시의 인덱스
		    var commonPath = url.substring(0, secondSlashIndex + 1); // '/fitness/'와 그 다음의 슬래시까지 포함
		    //console.log("공통 경로:", commonPath); // 공통 경로 출력

		    // 주소가 같으면 또는 하위 경로에 포함되면 메뉴에 _active
		    $(".gnb__item").find(".gnb__link").each(function() {
		        var href = $(this).attr("href");
		        
		        // console.log("현재 href:", href); // 현재 href 출력

		        // href에서 '/'로 시작하는지 확인
		        if (href.startsWith('/')) {
		            // href의 공통 경로를 가져오기
		            var hrefFirstSlashIndex = href.indexOf('/', 1); // href에서 첫 번째 슬래시의 인덱스
		            var hrefSecondSlashIndex = href.indexOf('/', hrefFirstSlashIndex + 1); // href에서 두 번째 슬래시의 인덱스
		            var hrefCommonPath = href.substring(0, hrefSecondSlashIndex + 1); // href의 공통 경로 가져오기
		            //console.log("href 공통 경로:", hrefCommonPath); // href의 공통 경로 출력

		            // 공통 경로가 일치하는지 비교
		            //console.log("비교:", commonPath, "=== ", hrefCommonPath); // 비교할 값 출력

		            // href가 '#'이 아니고, commonPath가 hrefCommonPath와 일치할 경우
		            if (href !== '#' && commonPath === hrefCommonPath) {
		                $(this).addClass("_active");
		            }
		        } else {
		            // href가 '/'로 시작하지 않으면 공통 경로 비교 (예: '#' 등)
		            //console.log("href가 유효하지 않음:", href);
		        }
		    });
		});
		$(document).ready(function() {
			// 현재 경로에서 '/fitness/admin/', '/fitness/hq/' 포함된 경우에만 컨텐츠 태그로 이동.
		    const currentPath = window.location.pathname;

		    if (/\/fitness\/(admin|hq)\//.test(currentPath)) {
		      $('html, body').animate({
		        scrollTop: $('.sub_content').offset().top
		      }, 200); // 부드럽게 이동
		    }
		});
	</script>
</body>
</html>
