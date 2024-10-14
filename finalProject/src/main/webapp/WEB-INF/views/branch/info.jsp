<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<!-- CSS -->
<link rel="stylesheet"
	href="<c:url value="/resources/css/swiper-bundle.min_branch.css"/>">
<!-- JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- Swiper -->
<link rel="stylesheet" href="<c:url value="/resources/css/swiper.css"/>">

<!-- branch 관련 css -->
<link rel="stylesheet" href="<c:url value="/resources/css/branch.css"/>">

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4dc87d628f2e532b0812b9e9aae7b2fa&libraries=services,clusterer,drawing"></script>
<style type="text/css">
.swiper-slide {
  position: relative;
  z-index: 1;
  background-color: #fff;
}

#scrollToTopBtn {
    position: fixed;
    bottom: 20px;
    right: 20px; 
    width: 80px;
    height: 80px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    z-index: 1000;
    text-align: center;
    line-height: 50px;
}


</style>

</head>
<body>
	<div class="branch-navbar" >
		<ul>
			<c:if test="${select eq null}">
				<c:set var="active" value="active" />
			</c:if>
			<li><a
				class="btn btn-outline-secondary btn-branch mb-1 ${active}"
				href=<c:url value="/branch/info"/>>전지점보기</a></li>
			<c:forEach items="${br_list}" var="br">
				<c:if test="${br.br_name ne '본점'}">
				<c:choose>
					<c:when test="${br.br_name eq select}">
						<c:set var="active" value="active" />
					</c:when>
					<c:otherwise>
						<c:set var="active" value="" />
					</c:otherwise>
				</c:choose>
				<li><a
					class="btn btn-outline-secondary btn-branch mb-1 ${active}"
					href=<c:url value="/branch/detail/${br.br_name}/1"/>>${br.br_name}</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<div class="branch-detail-container" >
		<c:choose>
			<c:when test="${select ne null}">
				<h3>${branch.br_name}</h3>
				<hr>
				<div class="branch-detail mb-5">
					<div class="branch-tab">
						<ul>
							<li><a class="btn" href="#branch">지점정보</a></li>
							<li><a class="btn" href="#employee">직원소개</a></li>
							<li><a class="btn" href="#mapinfo">지점위치</a></li>
						</ul>
					</div>
				</div>
				<div class="branch-content" id="branch">
					<h3>지점정보</h3>
					<div class="content-box mb-5 mt-5"
						style="text-align: center; display: flex; flex-wrap: wrap; align-items: center;">
						<div class="swiper-container mr-5">
							<c:if test="${branch_image_list.size() ne 0 }">
								<div class="swiper-wrapper" id="swiper-wrapper">
									<c:forEach items="${branch_image_list}" var="image">
										<div class="swiper-slide">
											<img src="<c:url value="/uploads${image.bf_name}" />"
												style="width: 600px; height: 400px;"><br>
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next">&gt;</div>
								<div class="swiper-button-prev">&lt;</div>
								<div class="swiper-pagination"></div>
							</c:if>
						</div>
						<div class="jumbotron" style="margin: 45px 0; padding: 32px;">
							<strong class="title"
								style="padding-top: 50px; font-size: 28px; background-size: 50px;">KH
								피트니스 ${branch.br_name }</strong>
							<p class="address">${branch.br_address},
								${branch.br_detailAddress} ${branch.br_extraAddress}</p>
							<hr>
							<div>${branch.br_detail}</div>
							<!-- 									<dl>
										<dt>평일</dt>
										<dd>06:00 ~ 23:00</dd>
										<dt>토요일</dt>
										<dd>09:00 ~ 18:00</dd>
										<dt>일요일/공휴일</dt>
										<dd>09:00 ~ 18:00</dd>
										<dt>정기휴일</dt>
										<dd>매월 첫째, 셋째 일요일</dd>
									</dl> -->
							<br> <span class="phone" style="font-size: 16px;"> <c:choose>
									<c:when test="${fn:length(branch.br_phone) == 10}">
										☎ ${fn:substring(branch.br_phone, 0, 2)}-${fn:substring(branch.br_phone, 2, 6)}-${fn:substring(branch.br_phone, 6, 10)}
									</c:when>
									<c:when test="${fn:length(branch.br_phone) == 9}">
										☎ ${fn:substring(branch.br_phone, 0, 2)}-${fn:substring(branch.br_phone, 2, 5)}-${fn:substring(branch.br_phone, 5, 9)}
									</c:when>
								</c:choose>
							</span>
						</div>
					</div>
					<div class="em-container mb-5 mt-5" id="employee">
						<h3>직원소개</h3>
					<div class="mt-5" style="text-align: center; display: flex; justify-content: center; gap: 20px; flex-wrap: wrap;">
						<c:if test="${em_list.size() ne 0 }">
							<c:forEach items="${em_list}" var="em">
								<div class="card" style="width: 200px">
									<img class="card-img-top"
										src=<c:url value="/uploads${em.em_fi_name}" />
										alt=" ${em.em_fi_name}"
										style="width: 100%; height: 250px; object-fit: cover;">
									<div class="card-body">
										<h4 class="card-title">${em.em_name}(${fn:substring(em.em_gender, 0, 1)})</h4>
										<p class="card-text">${em.em_position}</p>
										<!-- <a href="#" class="btn btn-primary">뭘 둘까나~</a> -->
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div></div>
					<div class="branch-map-container mt-5" id="mapinfo">
						<h3>지점위치</h3>
						<div class="mt-5" id="map" data-address="${branch.br_address}"
							data-name="${branch.br_name }"
							style="width: 800px; background-color: lightgray; height: 600px; margin: 0 auto;">
						</div>
					</div>

				</div>
			</c:when>
			<c:otherwise>
				<h3>전지점보기</h3>
				<hr>
				<div class="mt-5" id="map-total" style="width: 800px; background-color: lightgray; height: 600px; margin: 0 auto;"></div>
			</c:otherwise>
		</c:choose>
		<button id="scrollToTopBtn" style="display: none;">맨 위로</button>
	</div>
<c:if test="${select eq null}">
	<script type="text/javascript">
		var mapContainer = document.getElementById('map-total'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.4991855041824, 127.032787264974), // 지도의 중심좌표
	        level: 6 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	// 주소로 좌표를 검색하고 마커를 표시하는 함수
	function setMarkerByAddress(branch) {
	    var geocoder = new kakao.maps.services.Geocoder();
	    geocoder.addressSearch(branch.address, function(result, status) {
	        // 정상적으로 검색이 완료됐으면 
	        if (status === kakao.maps.services.Status.OK) {
	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 좌표
	            var imageSize = new kakao.maps.Size(38, 38); // 마커이미지의 크기
	            var imageOption = {offset: new kakao.maps.Point(22, 60)}; // 마커 이미지 옵션
	            var imageSrc = '<c:url value="/resources/image/icon/sample_fitness_icon.svg"/>'; // 마커이미지 주소

	            // 마커 이미지 생성
	            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

	            // 마커 생성
	            var marker = new kakao.maps.Marker({
	                map: map, // 마커를 표시할 지도
	                position: coords, // 마커를 표시할 위치
	                title: branch.title, // 마커의 타이틀
	                image: markerImage // 마커 이미지 설정
	            });

					
			 	content = '<div class="customoverlay">'
		 		content += '<a href="<c:url value="/branch/detail/'+ branch.title +'/1" />"'
			 	if(branch.title == '본점'){
				 	content += 'onclick="return false;"'
			 	}
		 		content += '>'
			 	content += '<span class="title">'
		 		content += branch.title
	 			content += '</span></a></div>';
	 			
				// 커스텀 오버레이를 생성합니다
				var customOverlay = new kakao.maps.CustomOverlay(
						{
							map : map,
							position : coords,
							content : content,
							yAnchor : 1,
							xAnchor : 0.55
						});
				
				// 커스텀 오버레이 지도에 표시
	            customOverlay.setMap(map);
				
	        } else {
	            console.error('주소를 찾을 수 없습니다: ' + branch.address);
	        }
	    });
	}
	
	// 서버에서 전달된 br_list를 자바스크립트 배열로 변환
	var branchList = [
	    <c:forEach var="branch" items="${br_list}" varStatus="status">
	        {
	            title: '${branch.br_name}', // 지점명
	            address: '${branch.br_address}'        // 지점 주소
	        }<c:if test="${!status.last}">,</c:if>
	        </c:forEach>
	];

	// 모든 branch에 대해 좌표를 검색하고 마커를 설정
	for (var i = 0; i < branchList.length; i++) {
	    setMarkerByAddress(branchList[i]);
	}
	
	// 지도의 중심을 마커 위치로 설정
    map.setCenter(coords);
	</script>
</c:if>

	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		
		mapOption = {
			center : new kakao.maps.LatLng(37.4991855041824, 127.032787264974), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};

		var address = mapContainer.getAttribute('data-address'); 
		var brName = mapContainer.getAttribute('data-name'); 
		
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(address,function(result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				var imageSrc = '<c:url value="/resources/image/icon/sample_fitness_icon.svg"/>', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(45, 45), // 마커이미지의 크기입니다
				imageOption = {
					offset : new kakao.maps.Point(22, 60)
				}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

				// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
				var markerImage = new kakao.maps.MarkerImage(
						imageSrc, imageSize, imageOption), markerPosition = new kakao.maps.LatLng(
						result[0].y, result[0].x); // 마커가 표시될 위치입니다

				// 결과값으로 받은 위치를 마커로 표시합니다
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : coords,
					image : markerImage
				// 마커이미지 설정 
				});

				var content = '<div class="customoverlay">'
						+ '<a href="https://map.kakao.com/link/map/'
						+	'KH Fitness ' + brName
						+	',' + result[0].y + ',' + result[0].x + '"'
						+	' target="_blank">'
						+ '<span class="title">'
						+ 'KH Fitness ' + brName
						+ '</span></a></div>';

				// 커스텀 오버레이를 생성합니다
				var customOverlay = new kakao.maps.CustomOverlay(
						{
							map : map,
							position : coords,
							content : content,
							yAnchor : 1
						});

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);
	</script>

	<script type="text/javascript">
	window.onload = function() {
		
		const mySwiper = new Swiper('.swiper-container', {
			  	// 옵션 설정
				effect : 'fade',
				loop: true,
				slidesPerView: 1,
				watchOverflow: true,
				spaceBetween: 10,
				navigation: {
				    nextEl: '.swiper-button-next',
				    prevEl: '.swiper-button-prev',
			  	},
			  	pagination: {
			  	    el: '.swiper-pagination',
			  	    type: 'bullets',
		  			clickable: true
		  	  	}
			  	
			});
		
		// 이미지가 1개일 경우 Next, Prev 버튼 숨기기
		const totalSlides = mySwiper.slides.length; // 전체 슬라이드 수

	    if (totalSlides === 1) {
	        document.querySelector('.swiper-button-next').style.display = 'none'; // Next 버튼 숨기기
	        document.querySelector('.swiper-button-prev').style.display = 'none'; // Prev 버튼 숨기기
	    } else {
	        document.querySelector('.swiper-button-next').style.display = 'flex'; // Next 버튼 보이기
	        document.querySelector('.swiper-button-prev').style.display = 'flex'; // Prev 버튼 보이기
	    }
		
		// Swiper 슬라이드를 업데이트
	    mySwiper.update();
	}	

	
	/* // 커스텀 페이지네이션 버튼 클릭 시 첫 번째 슬라이드로 이동
	document.querySelector('.swiper-pagination').addEventListener('click',
	
		function () { if (mySwiper.isEnd) { mySwiper.slideTo(0); // 마지막 슬라이드에서
		첫 번째 슬라이드로 이동 } }); */
</script>
<script type="text/javascript">

	// tab 클릭 시 아래로 이동하도록.
	document.querySelectorAll('.branch-tab a').forEach(anchor => {
	    anchor.addEventListener('click', function(e) {
	        e.preventDefault();
	        const target = document.querySelector(this.getAttribute('href'));
	        const offset = 0; // 원하는 오프셋 값
	        window.scrollTo({
	            top: target.offsetTop - offset,
	            behavior: 'smooth'
	        });
	    });
	});

	// 스크롤 이벤트 리스너 등록
	window.addEventListener('scroll', function() {
	    const scrollToTopBtn = document.getElementById('scrollToTopBtn');
	    // 스크롤 위치가 300px 이상일 때 버튼 표시
	    if (window.scrollY > 300) {
	        scrollToTopBtn.style.display = 'block';
	    } else {
	        scrollToTopBtn.style.display = 'none';
	    }
	});
	
	// "맨 위로 가기" 버튼 클릭 시 부드럽게 스크롤
	document.getElementById('scrollToTopBtn').addEventListener('click', function() {
	    window.scrollTo({
	        top: 0,
	        behavior: 'smooth'
	    });
	});
</script>

</body>
</html>
