<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/program/info.css"/>">
<style type="text/css">



</style>
</head>
<body>
	<section class="sub_banner sub_banner_03"></section>
	<!-- <h1>프로그램 안내</h1> -->
	<div class="navbar">
		<a class="btn selected br-3" href="<c:url value="/program/info"/>">프로그램 안내</a> 
		<a class="btn " href="<c:url value="/program/schedule"/>">프로그램 일정</a>
	</div>
	
	<section class="sub_content">
		<!-- lnb -->
		<section class="lnb_wrap">
		<div id="program-button-group" class="lnb-sidebar">
			<c:forEach items="${list}" var="sp" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<c:set var="notSelected" value="btn-wide" />
					</c:when>
					<c:otherwise>
						<c:set var="notSelected" value="bg_white" />
					</c:otherwise>
				</c:choose>
				<div class="btn_wrap">
				<div class="btn_link_black ${notSelected }">
					<button id="btn-sp-${status.index}" class="btn btn_black js-btn-insert"
						data-detail="${sp.sp_detail}" data-num="${status.index}"
						data-name="${sp.sp_name}" onclick="showDetail(this)">
						<span>${sp.sp_name}<i class="ic_link_share"></i></span>
					</button>
					<div class="btn_black_top_line"></div>
					<div class="btn_black_right_line"></div>
					<div class="btn_black_bottom_line"></div>
					<div class="btn_black_left_line"></div>
				</div>
				</div>
			</c:forEach>
		</div>
		</section>
		<section class="sub_content_group"> 
		
		<!-- Main Content -->
		<div class="main-content">
			<div id="program-image" class="mb-3">
				<div class="swiper-container">
					<div class="swiper-wrapper" id="swiper-wrapper">
						<div class="swiper-slide"></div>
						<div class="swiper-slide"></div>
						<div class="swiper-slide"></div>
					</div>
					<div class="swiper-button-next">&gt;</div>
					<div class="swiper-button-prev">&lt;</div>
					<div class="swiper-pagination"></div>
					<div class="content-text">
						<h2 id="program-name"></h2>
						<div id="program-detail"></div>
					</div>
				</div>
			</div>
		</div>
	<!-- 		<div id="program-penalty"></div> -->
	</section>
</section>
	<script>
	const mySwiper = new Swiper('.swiper-container', {
		  	// 옵션 설정
			effect : 'fade', 
			fadeEffect: { 
			crossFade: true 
			},
			loop: true,
			slidesPerView: 1,
			watchOverflow: true,
			spaceBetween: 1500,
			observer: true,  
			observeParents: true,
			navigation: {
			    nextEl: '.swiper-button-next',
			    prevEl: '.swiper-button-prev',
		  	}		  	
		});
	
	// 이미지가 1개일 경우 Next, Prev 버튼 숨기기
	mySwiper.on('slideChange', function () {
		
	    const totalSlides = mySwiper.slides.length; // 전체 슬라이드 수

	    if (totalSlides === 1) {
	        document.querySelector('.swiper-button-next').style.display = 'none'; // Next 버튼 숨기기
	        document.querySelector('.swiper-button-prev').style.display = 'none'; // Prev 버튼 숨기기
	    } else {
	        document.querySelector('.swiper-button-next').style.display = 'flex'; // Next 버튼 보이기
	        document.querySelector('.swiper-button-prev').style.display = 'flex'; // Prev 버튼 보이기
	    }
	    
	});
	
	// 커스텀 페이지네이션 버튼 클릭 시 첫 번째 슬라이드로 이동
	document.querySelector('.swiper-pagination').addEventListener('click', function () {
	    if (mySwiper.isEnd) {
	        mySwiper.slideTo(0); // 마지막 슬라이드에서 첫 번째 슬라이드로 이동
	    }
	});
	
    // 페이지가 로드될 때 첫 번째 버튼의 세부 정보를 표시
    window.onload = function() {
        var firstButton = document.querySelector("button[id^='btn-sp-']");
        if (firstButton) {
            showDetail(firstButton); // 첫 번째 버튼 클릭
        }
        
        // 페이지가 로드되면 저장된 스크롤 위치로 이동
        const scrollPosition = localStorage.getItem("scrollPosition");
        if (scrollPosition) {
            window.scrollTo(0, scrollPosition);
        }
        
     	// 페이드 인 효과 활성화
        document.body.classList.add("fade-in");
    };
    
 	// 스크롤할 때마다 현재 위치를 저장
    window.onscroll = function() {
        localStorage.setItem("scrollPosition", window.scrollY);
    };
	
    function showDetail(selectedButton) {
    	
        // 모든 버튼을 찾아서 처리
        var buttons = document.querySelectorAll("button[id^='btn-sp-']");

        buttons.forEach((button) => {
	        if (button === selectedButton) {
	            // 다른 버튼들은 bg_white로 설정
	        	button.parentElement.classList.remove("bg_white");
	        	button.parentElement.classList.add("btn-wide");
	        } else {
	        	button.parentElement.classList.remove("btn-wide");
	        	button.parentElement.classList.add("bg_white");
	        }
        });
        var programName = selectedButton.getAttribute('data-name');
        
        // 프로그램 이름으로 저장된 이미지들을 가져와서 하나씩 출력        
        getProgramImageNameList(programName, function(imageNameList) {
            if (imageNameList) {
            	document.getElementById("swiper-wrapper").innerHTML = '';
                // List<String>에서 값을 하나씩 꺼내서 사용
                imageNameList.forEach(function(imageName) {
                    // 여기에서 각 이미지 이름에 대한 추가 작업을 할 수 있습니다.
                    var imgSrc = '<c:url value="/uploads' + imageName + '" />';
                    // console.log('imgSrc2 : '+imgSrc); // 각 이미지 이름을 출력               			
                    document.getElementById("swiper-wrapper").innerHTML += 
                    	'<div class="swiper-slide"><img src="' + imgSrc + '" style="width:800px; height:600px"><br></div>';
                });
            } else {
                console.log("Error fetching image names");
            }
            
            // 슬라이더를 업데이트합니다.
            mySwiper.update(); // 슬라이더 업데이트
        });
        
		// 클릭된 버튼의 data-detail 속성 값을 가져와서 표시
        var detail = selectedButton.getAttribute('data-detail');
        var name = selectedButton.getAttribute('data-name');
        // detail-container에 클릭된 sp_detail을 표시
        document.getElementById("program-name").innerHTML = name;
        document.getElementById("program-detail").innerHTML = detail;
/*         if(selectedButton.getAttribute('data-num') != 0) {
        	document.getElementById("program-penalty").innerHTML = "노쇼(no show)일 경우 패널티가 있다는 안내";
        }
        else {
        	document.getElementById("program-penalty").innerHTML = "";
        } */
    }
    
	function getProgramImageNameList(programName, callback) {
		$.ajax({
	        async : true,
	        url : '<c:url value="/program/getImageName"/>',
	        type : 'get',
	        data : { pr_name : programName }, 
	        dataType : 'json',
	        success : function(data) {
	        	 if (data && Array.isArray(data)) {
	                 callback(data); // 콜백으로 결과 전달
	             }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            console.log(jqXHR);
	            callback(null); // 에러 발생 시 null 전달
	        }
	    });
	}
</script>
</body>
</html>
