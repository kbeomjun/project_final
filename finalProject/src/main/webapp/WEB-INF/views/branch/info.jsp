<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4dc87d628f2e532b0812b9e9aae7b2fa&libraries=services,clusterer,drawing"></script>

<style>
.customoverlay {
	position: relative;
	bottom: 72px;
	left: 2px;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	float: left;
}

.customoverlay:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.customoverlay a {
	display: block;
	text-decoration: none;
	color: #000;
	text-align: center;
	border-radius: 6px;
	font-size: 14px;
	font-weight: bold;
	overflow: hidden;
	background: #d95050;
	background: #d95050
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.customoverlay .title {
	display: block;
	text-align: center;
	background: #fff;
	margin-right: 35px;
	padding: 5px 8px;
	font-size: 14px;
	font-weight: bold;
}

.customoverlay:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: -12px;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.btn-branch {
	width: 120px; /* 원하는 고정 너비 설정 */
	text-align: center; /* 버튼 내 텍스트를 가운데 정렬 */
}

.branch-navbar {
	position: relative;
	float: left;
	width: 16.66%;
	float: left;
	padding-left: 40px;
	
}

.branch-detail-container {
	position: relative;
	float: left;
	width: 83.34%;
	padding-left: 40px;
	padding-bottom: 100px;
    border-left: 1px solid #ddd;
    box-sizing: border-box;
}

.branch-tab {
	position: relative;
    height: 60px;
    margin: 0px;
    border-bottom: 1px solid #555;
    background: #eee;
}

.branch-detail-container .branch-detail .branch-tab ul li a {
    display: block;
    height: 60px;
    line-height: 60px;
    font-size: 17px;
    color: #333;
    text-align: center;
    padding: 0;
}

.branch-detail-container .branch-detail .branch-tab ul li a.active {
    color: #ed1b24;
    border-bottom: 1px solid #ed1b24;
}

.branch-detail-container .branch-detail .branch-tab ul li {
    float: left;
    width: 25%;
}
</style>
</head>
<body>
	<div class="branch-navbar">
	<ul>
		<c:if test="${select eq null}">
			<c:set var="active" value="active" />
		</c:if>
		<li>
		<a class="btn btn-outline-secondary btn-branch mb-1 ${active}" href=<c:url value="/branch/info"/>>전지점보기</a>
		</li>
		<c:forEach items="${br_list}" var="br">
		<c:choose>
			<c:when test="${br.br_name eq select}">
				<c:set var="active" value="active" />
			</c:when>
			<c:otherwise>
				<c:set var="active" value="" />
			</c:otherwise>
		</c:choose>
		<li>
		<a class="btn btn-outline-secondary btn-branch mb-1 ${active}" href=<c:url value="/branch/detail/${br.br_name}/1"/>>${br.br_name}</a></li>
		</c:forEach>
	</ul>
	</div>
	<div class="branch-detail-container">
		<c:choose>
		<c:when test="${select ne null}">
		<h3>${branch.br_name}</h3>
		<hr>
		<div class="branch-detail">
			<div class="branch-tab">
				<ul>
					<li><a class="btn ${opt_num == 1 ? 'active' : ''}" href="<c:url value="/branch/detail/${branch.br_name}/1"/>">지점정보</a></li>
					<li><a class="btn ${opt_num == 2 ? 'active' : ''}" href="<c:url value="/branch/detail/${branch.br_name}/2"/>">시설안내</a></li>
					<li><a class="btn ${opt_num == 3 ? 'active' : ''}" href="<c:url value="/branch/detail/${branch.br_name}/3"/>">직원소개</a></li>
					<li><a class="btn ${opt_num == 4 ? 'active' : ''}" href="<c:url value="/branch/detail/${branch.br_name}/4"/>">지점위치</a></li>
				</ul>
			</div>
			<div class="branch-content">
				<c:choose>
				<c:when test="${opt_num eq 1}"></c:when>
				<c:when test="${opt_num eq 2}">
					<div class="swiper-container">
						<div class="swiper-wrapper" id="swiper-wrapper">
							<div class="swiper-slide"></div>
							<div class="swiper-slide"></div>
							<div class="swiper-slide"></div>
						</div>
					<div class="swiper-button-next">&gt;</div>
					<div class="swiper-button-prev">&lt;</div>
					<div class="swiper-pagination"></div>
					</div>
				</c:when>
				<c:when test="${opt_num eq 3}"></c:when>
				<c:when test="${opt_num eq 4}">
					<div class="mt-5" id="map" style="width: 600px; background-color: lightgray; height: 400px; margin: 0 auto; /* 수평으로 가운데 정렬 */"></div>
				</c:when>
				</c:choose>
			</div>
		</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
		</c:choose>
	</div>


	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
		level : 4
	// 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('서울 강남구 테헤란로 156', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	    if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			var imageSrc = '<c:url value="/resources/image/icon/sample_fitness_icon.svg"/>', // 마커이미지의 주소입니다    
			imageSize = new kakao.maps.Size(45, 45), // 마커이미지의 크기입니다
			imageOption = {
				offset : new kakao.maps.Point(22, 60)
			}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption), 
				markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x); // 마커가 표시될 위치입니다
					
			// 결과값으로 받은 위치를 마커로 표시합니다
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				map: map,
				position : coords,
				image : markerImage
			// 마커이미지 설정 
			});

			var content = '<div class="customoverlay">'
						+	'<a href="https://map.kakao.com/link/map/'
						+	'KH Fitness 역삼점'
						+	',' + '33.450701' + ',' + '126.570667"'
						+	' target="_blank">'
						+ 	'<span class="title">'
						+	'KH Fitness 역삼점'
						+	'</span></a></div>';


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
</body>
</html>
