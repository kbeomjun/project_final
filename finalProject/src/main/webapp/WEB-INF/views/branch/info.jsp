<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<!-- CSS -->
<link rel="stylesheet"
	href="<c:url value="/resources/css/swiper-bundle.min_branch.css"/>">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- branch 관련 css -->
<link rel="stylesheet" href="<c:url value="/resources/css/branch.css"/>">

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4dc87d628f2e532b0812b9e9aae7b2fa&libraries=services,clusterer,drawing"></script>

<!--  fancy box css -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/fancybox.css"/>" />
<script src="<c:url value="/resources/js/fancybox.umd.js"/>"></script>

<style type="text/css">
.scrollable-text {
	max-height: 260px;
    overflow-y: auto;
    overflow-x: hidden;
    padding: 10px;
}
</style>
</head>
<body>
	<section class="sub_banner sub_banner_01"></section>
	<section class="sub_content">
		<!-- lnb -->
		<section class="lnb_wrap">
			<ul class="lnb">
				<c:if test="${select eq null}">
					<c:set var="active" value="_active" />
				</c:if>
				<li class="lnb__item"><a class="lnb__link ${active}"
					href=<c:url value="/branch/info"/>>전지점보기</a></li>
				<c:forEach items="${br_list}" var="br">
					<c:if test="${br.br_name ne '본사'}">
						<c:choose>
							<c:when test="${br.br_name eq select}">
								<c:set var="active" value="_active" />
							</c:when>
							<c:otherwise>
								<c:set var="active" value="" />
							</c:otherwise>
						</c:choose>
						<li class="lnb__item"><a class="lnb__link ${active}"
							href=<c:url value="/branch/detail/${br.br_name}/1"/>>${br.br_name}</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</section>

		<section class="sub_content_group">
			<c:choose>
				<c:when test="${select ne null}">
					<div class="table_wrap">
						<div class="sub_title_wrap">
							<h2 class="sub_title">지점위치</h2>
						</div>
						<div class="branch-info-wrap">
							<div class="branch-map-container" id="mapinfo">
								<div id="map" data-address="${branch.br_address}"
									data-name="${branch.br_name }"
									style="float: left; background-color: lightgray; margin: 0 auto;position: relative;">
					    			<button class="btn-sg btn-dark btn-map" id="original-location-btn" >처음 위치</button>
								</div>
							</div>
							<div class="branch-content-container">
								<strong class="title"
									style="font-size: 28px; background-size: 50px;">KH
									피트니스 ${branch.br_name }</strong>
								<p class="address">${branch.br_address},
									${branch.br_detailAddress} ${branch.br_extraAddress}</p>
								<hr style="border: 0; height: 1px; background: #000;">
								<div>${branch.br_detail}</div>
								<br> <span class="phone" style="font-size: 16px;">
									<c:choose>
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
						<div class="branch-content mt-5" id="branch">
							<div class="sub_title_wrap">
								<h2 class="sub_title">지점정보</h2>
							</div>
							<div class="branch-image-container mb-5 mt-5">
								<c:forEach items="${branch_image_list}" var="image">
									<a href="<c:url value="/uploads${image.bf_name}" />"
										data-fancybox="gallery"> <img
										src="<c:url value="/uploads${image.bf_name}" />"><br>
										<!-- style="width: 600px; height: 400px;" -->
									</a>
								</c:forEach>
							</div>
						</div>
						<div class="em-container mb-5 mt-5" id="employee">
							<div class="sub_title_wrap">
								<h2 class="sub_title">직원소개</h2>
							</div>
							<div class="container">
								<div class="row">
									<c:if test="${em_list.size() ne 0 }">
										<c:forEach items="${em_list}" var="em">
											<div class="col-md-3 mb-4" style="padding: 0;">
												<div class="card" style="width: 100%; border: none;">
													<img class="card-img-top"
														src="<c:url value='/uploads${em.em_fi_name}' />"
														alt="${em.em_fi_name}"
														onerror="this.onerror=null; this.src='https://www.w3schools.com/bootstrap4/img_avatar1.png';"
														style="width: 100%; height: 350px; object-fit: cover;">
												</div>
											</div>
											<div class="col-md-3 mb-4" style="padding: 0;">
												<div class="card" style="width: 100%; border: none;">
													<div class="card-body" style="padding: 0.5rem 1.25rem;">
														<h4 class="card-title">${em.em_name} <%-- (${fn:substring(em.em_gender, 0, 1)}) --%></h4>
														<p class="card-text">${em.em_position}</p><br>
														<div class=" scrollable-text">${em.em_detail }</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="table_wrap">
						<div class="sub_title_wrap" style="margin-bottom: 40px;">
							<h2 class="sub_title">전지점보기</h2>
						</div>
						<div class="mt-5" id="map-total" style="width: 800px; background-color: lightgray; height: 600px; margin: 0 auto; position: relative;">
						    <button class="btn-sg btn-dark btn-map" id="original-location-btn" >원래 위치로</button>
						</div>
					</div>
				</c:otherwise>
			</c:choose>

		</section>
	</section>




	<!-- <button id="scrollToTopBtn" style="display: none;">맨 위로</button> -->

	<script type="text/javascript">
/**
 * AbstractOverlay를 상속받을 객체를 선언합니다.
 */
function TooltipMarker(position, tooltipText) {
    this.position = position;
    var node = this.node = document.createElement('div');
    node.className = 'node';

    var tooltip = document.createElement('div');
    tooltip.className = 'tooltip',

    tooltip.appendChild(document.createTextNode(tooltipText));
    node.appendChild(tooltip);
    
    // 툴팁 엘리먼트에 마우스 인터렉션에 따라 보임/숨김 기능을 하도록 이벤트를 등록합니다.
    node.onmouseover = function() {
        tooltip.style.display = 'block';
    };
    node.onmouseout = function() {
        tooltip.style.display = 'none';
    };
}

// AbstractOverlay 상속. 프로토타입 체인을 연결합니다.
TooltipMarker.prototype = new kakao.maps.AbstractOverlay;

// AbstractOverlay의 필수 구현 메소드.
// setMap(map)을 호출했을 경우에 수행됩니다.
// AbstractOverlay의 getPanels() 메소드로 MapPanel 객체를 가져오고
// 거기에서 오버레이 레이어를 얻어 생성자에서 만든 엘리먼트를 자식 노드로 넣어줍니다.
TooltipMarker.prototype.onAdd = function() {
    var panel = this.getPanels().overlayLayer;
    panel.appendChild(this.node);
};

// AbstractOverlay의 필수 구현 메소드.
// setMap(null)을 호출했을 경우에 수행됩니다.
// 생성자에서 만든 엘리먼트를 오버레이 레이어에서 제거합니다.
TooltipMarker.prototype.onRemove = function() {
    this.node.parentNode.removeChild(this.node);
};

// AbstractOverlay의 필수 구현 메소드.
// 지도의 속성 값들이 변화할 때마다 호출됩니다. (zoom, center, mapType)
// 엘리먼트의 위치를 재조정 해 주어야 합니다.
TooltipMarker.prototype.draw = function() {
    // 화면 좌표와 지도의 좌표를 매핑시켜주는 projection객체
    var projection = this.getProjection();
    
    // overlayLayer는 지도와 함께 움직이는 layer이므로
    // 지도 내부의 위치를 반영해주는 pointFromCoords를 사용합니다.
    var point = projection.pointFromCoords(this.position);

    // 내부 엘리먼트의 크기를 얻어서
    var width = this.node.offsetWidth;
    var height = this.node.offsetHeight;

    // 해당 위치의 정중앙에 위치하도록 top, left를 지정합니다.
    this.node.style.left = (point.x - width/2) + "px";
    this.node.style.top = (point.y - height/2) + "px";
};

// 좌표를 반환하는 메소드
TooltipMarker.prototype.getPosition = function() {
    return this.position;
};

/**
 * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
 * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
 */
function MarkerTracker(map, target) {
    // 클리핑을 위한 outcode
    var OUTCODE = {
        INSIDE: 0, // 0b0000
        TOP: 8, //0b1000
        RIGHT: 2, // 0b0010
        BOTTOM: 4, // 0b0100
        LEFT: 1 // 0b0001
    };
    
    // viewport 영역을 구하기 위한 buffer값
    // target의 크기가 60x60 이므로 
    // 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
    var BOUNDS_BUFFER = 20;
    
    // 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
    // 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
    // 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
    // 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
    var CLIP_BUFFER = 36;

    // trakcer 엘리먼트
    var tracker = document.createElement('div');
    tracker.className = 'tracker';

    // 내부 아이콘
    var icon = document.createElement('div');
    icon.className = 'icon';

    // 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
    var balloon = document.createElement('div');
    balloon.className = 'balloon';

    tracker.appendChild(balloon);
    tracker.appendChild(icon);

    map.getNode().appendChild(tracker);

    // traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
    tracker.onclick = function() {
        map.setCenter(target.getPosition());
        setVisible(false);
    };

    // target의 위치를 추적하는 함수
    function tracking() {
        var proj = map.getProjection();
        
        // 지도의 영역을 구합니다.
        var bounds = map.getBounds();
        
        // 지도의 영역을 기준으로 확장된 영역을 구합니다.
        var extBounds = extendBounds(bounds, proj);

        // target이 확장된 영역에 속하는지 판단하고
        if (extBounds.contain(target.getPosition())) {
            // 속하면 tracker를 숨깁니다.
            setVisible(false);
        } else {
            // target이 영역 밖에 있으면 계산을 시작합니다.
            

            // 지도 bounds를 기준으로 클리핑할 top, right, bottom, left를 재계산합니다.
            //
            //  +-------------------------+
            //  | Map Bounds              |
            //  |   +-----------------+   |
            //  |   | Clipping Rect   |   |
            //  |   |                 |   |
            //  |   |        *       (A)  |     A
            //  |   |                 |   |
            //  |   |                 |   |
            //  |   +----(B)---------(C)  |
            //  |                         |
            //  +-------------------------+
            //
            //        B
            //
            //                                       C
            // * 은 지도의 중심,
            // A, B, C가 TooltipMarker의 위치,
            // (A), (B), (C)는 각 TooltipMarker에 대응하는 tracker입니다.
            // 지도 중심과 각 TooltipMarker를 연결하는 선분이 있다고 가정할 때,
            // 그 선분과 Clipping Rect와 만나는 지점의 좌표를 구해서
            // tracker의 위치(top, left)값을 지정해주려고 합니다.
            // tracker 자체의 크기가 있기 때문에 원래 지도 영역보다 안쪽의 가상 영역을 그려
            // 클리핑된 지점을 tracker의 위치로 사용합니다.
            // 실제 tracker의 position은 화면 좌표가 될 것이므로 
            // 계산을 위해 좌표 변환 메소드를 사용하여 모두 화면 좌표로 변환시킵니다.
            
            // TooltipMarker의 위치
            var pos = proj.containerPointFromCoords(target.getPosition());
            
            // 지도 중심의 위치
            var center = proj.containerPointFromCoords(map.getCenter());

            // 현재 보이는 지도의 영역의 남서쪽 화면 좌표
            var sw = proj.containerPointFromCoords(bounds.getSouthWest());
            
            // 현재 보이는 지도의 영역의 북동쪽 화면 좌표
            var ne = proj.containerPointFromCoords(bounds.getNorthEast());
            
            // 클리핑할 가상의 내부 영역을 만듭니다.
            var top = ne.y + CLIP_BUFFER;
            var right = ne.x - CLIP_BUFFER;
            var bottom = sw.y - CLIP_BUFFER;
            var left = sw.x + CLIP_BUFFER;

            // 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
            var clipPosition = getClipPosition(top, right, bottom, left, center, pos);
            
            // 클리핑된 좌표를 tracker의 위치로 사용합니다.
            tracker.style.top = clipPosition.y + 'px';
            tracker.style.left = clipPosition.x + 'px';

            // 말풍선의 회전각을 얻습니다.
            var angle = getAngle(center, pos);
            
            // 회전각을 CSS transform을 사용하여 지정합니다.
            // 브라우저 종류에따라 표현되지 않을 수도 있습니다.
            // https://caniuse.com/#feat=transforms2d
            balloon.style.cssText +=
                '-ms-transform: rotate(' + angle + 'deg);' +
                '-webkit-transform: rotate(' + angle + 'deg);' +
                'transform: rotate(' + angle + 'deg);';

            // target이 영역 밖에 있을 경우 tracker를 노출합니다.
            setVisible(true);
        }
    }

    // 상하좌우로 BOUNDS_BUFFER(30px)만큼 bounds를 확장 하는 함수
    //
    //  +-----------------------------+
    //  |              ^              |
    //  |              |              |
    //  |     +-----------------+     |
    //  |     |                 |     |
    //  |     |                 |     |
    //  |  <- |    Map Bounds   | ->  |
    //  |     |                 |     |
    //  |     |                 |     |
    //  |     +-----------------+     |
    //  |              |              |
    //  |              v              |
    //  +-----------------------------+
    //  
    // 여기서는 TooltipMaker가 완전히 안보이게 되는 시점의 영역을 구하기 위해서 사용됩니다.
    // TooltipMarker는 60x60 의 크기를 가지고 있기 때문에 
    // 지도에서 완전히 사라지려면 지도 영역을 상하좌우 30px만큼 더 드래그해야 합니다.
    // 이 함수는 현재 보이는 지도 bounds에서 상하좌우 30px만큼 확장한 bounds를 리턴합니다.
    // 이 확장된 영역은 TooltipMarker가 화면에서 보이는지를 판단하는 영역으로 사용됩니다.
    function extendBounds(bounds, proj) {
        // 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
        // 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
        // 픽셀 단위인 화면 좌표로 변환해야 합니다.
        var sw = proj.pointFromCoords(bounds.getSouthWest());
        var ne = proj.pointFromCoords(bounds.getNorthEast());

        // 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
        sw.x -= BOUNDS_BUFFER;
        sw.y += BOUNDS_BUFFER;

        ne.x += BOUNDS_BUFFER;
        ne.y -= BOUNDS_BUFFER;

        // 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
        // extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
        return new kakao.maps.LatLngBounds(
                        proj.coordsFromPoint(sw),proj.coordsFromPoint(ne));
        
    }


    // Cohen–Sutherland clipping algorithm
    // 자세한 내용은 아래 위키에서...
    // https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
    function getClipPosition(top, right, bottom, left, inner, outer) {
        function calcOutcode(x, y) {
            var outcode = OUTCODE.INSIDE;

            if (x < left) {
                outcode |= OUTCODE.LEFT;
            } else if (x > right) {
                outcode |= OUTCODE.RIGHT;
            }

            if (y < top) {
                outcode |= OUTCODE.TOP;
            } else if (y > bottom) {
                outcode |= OUTCODE.BOTTOM;
            }

            return outcode;
        }

        var ix = inner.x;
        var iy = inner.y;
        var ox = outer.x;
        var oy = outer.y;

        var code = calcOutcode(ox, oy);

        while(true) {
            if (!code) {
                break;
            }

            if (code & OUTCODE.TOP) {
                ox = ox + (ix - ox) / (iy - oy) * (top - oy);
                oy = top;
            } else if (code & OUTCODE.RIGHT) {
                oy = oy + (iy - oy) / (ix - ox) * (right - ox);        
                ox = right;
            } else if (code & OUTCODE.BOTTOM) {
                ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
                oy = bottom;
            } else if (code & OUTCODE.LEFT) {
                oy = oy + (iy - oy) / (ix - ox) * (left - ox);     
                ox = left;
            }

            code = calcOutcode(ox, oy);
        }

        return {x: ox, y: oy};
    }

    // 말풍선의 회전각을 구하기 위한 함수
    // 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
    function getAngle(center, target) {
        var dx = target.x - center.x;
        var dy = center.y - target.y ;
        var deg = Math.atan2( dy , dx ) * 180 / Math.PI; 

        return ((-deg + 360) % 360 | 0) + 90;
    }
    
    // tracker의 보임/숨김을 지정하는 함수
    function setVisible(visible) {
        tracker.style.display = visible ? 'block' : 'none';
    }
    
    // Map 객체의 'zoom_start' 이벤트 핸들러
    function hideTracker() {
        setVisible(false);
    }
    
    // target의 추적을 실행합니다.
    this.run = function() {
        kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.addListener(map, 'zoom_changed', tracking);
        kakao.maps.event.addListener(map, 'center_changed', tracking);
        tracking();
    };
    
    // target의 추적을 중지합니다.
    this.stop = function() {
        kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
        kakao.maps.event.removeListener(map, 'center_changed', tracking);
        setVisible(false);
    };
}

</script>


	<script type="text/javascript">

	//주소를 입력해서 좌표를 얻어오는 함수
	function getCoordinates(address) {
		var geocoder = new kakao.maps.services.Geocoder();
	    return new Promise((resolve, reject) => {
	        geocoder.addressSearch(address, function(result, status) {
	            // 정상적으로 검색이 완료되면
	            if (status === kakao.maps.services.Status.OK) {
	                // 검색된 좌표값을 resolve로 반환
	                resolve({ lat: result[0].y, lng: result[0].x });
	            } else {
	                // 검색 실패 시 reject로 에러 메시지 반환
	                reject('주소 검색에 실패했습니다.');
	            }
	        });
	    });
	}
</script>
	<c:choose>
		<c:when test="${select eq null}">
			<script type="text/javascript">

	<c:forEach var="branch" items="${br_list}">
		<c:if test="${branch.br_name == '본사'}">
		    var address = '${branch.br_address}';
		</c:if>
	</c:forEach>
	
	// 예시: 특정 주소로 좌표를 얻어와서 사용하기
	getCoordinates(address).then(coord => {
	    // console.log('위도:', coord.lat, '경도:', coord.lng);
	
		var mapContainer = document.getElementById('map-total'), // 지도를 표시할 div  
	    mapOption = { 
	        level: 3, // 지도의 확대 레벨
	        center: new kakao.maps.LatLng(coord.lat, coord.lng), // 지도의 중심좌표 (본사)
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 원래 위치 좌표 저장
	    var originalPosition = new kakao.maps.LatLng(coord.lat, coord.lng);
		
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
		            var imageSize = new kakao.maps.Size(40, 40); // 마커이미지의 크기
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
				 	if(branch.title == '본사'){
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
					
		        	// MarkerTracker를 생성합니다.
		            var markerTracker = new MarkerTracker(map, marker);
		            
		        	// marker의 추적을 시작합니다.
		            markerTracker.run()
					
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
		
		// 원래 위치 버튼 클릭 이벤트
	    document.getElementById('original-location-btn').addEventListener('click', function() {
	        map.setCenter(originalPosition); // 원래 위치로 지도 중심 설정
	        map.setLevel(3); // 필요한 경우 줌 레벨도 설정
	    });
	
	}).catch(error => {
	    console.error('오류:', error);
	});
	
/* 	// 지도의 중심을 '본사' 위치로 설정
    map.setCenter(mapOption.center); */
	</script>
	</c:when>
	<c:otherwise>
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		
		mapOption = {
			center : new kakao.maps.LatLng(37.4991855041824, 127.032787264974), // 지도의 중심좌표
			level : 3
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
				imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
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
				
				// MarkerTracker를 생성합니다.
	            var markerTracker = new MarkerTracker(map, marker);
	            
	        	// marker의 추적을 시작합니다.
	            markerTracker.run()
			}
			
			// 원래 위치 버튼 클릭 이벤트
		    document.getElementById('original-location-btn').addEventListener('click', function() {
		        map.setCenter(coords); // 원래 위치로 지도 중심 설정
		        map.setLevel(3); // 필요한 경우 줌 레벨도 설정
		    });
		});
	
		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);
	</script>
		</c:otherwise>
	</c:choose>
	<!-- swiper 기능 제거 -->
	<!-- 	<script type="text/javascript">
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
</script> -->

	<script type="text/javascript">

<!-- 기능 제거 예정 (상단 navbar)-->		
/* 	// tab 클릭 시 아래로 이동하도록.
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
	}); */

/* 	// 스크롤 이벤트 리스너 등록
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
	}); */
</script>
	<script type="text/javascript">
Fancybox.bind('[data-fancybox="gallery"]', {
	  // Your custom options
	 	
	});
</script>
</body>
</html>
