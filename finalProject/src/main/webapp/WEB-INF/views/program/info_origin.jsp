<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<!-- JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- Swiper -->
<link rel="stylesheet" href="<c:url value="/resources/css/swiper.css"/>">
<style>
#program-image {
	text-align: center;
}
</style>
</head>
<body>
	<!-- <h1>프로그램 안내</h1> -->
	<a class="btn btn-dark br-3" href="<c:url value="/program/info"/>">프로그램
		안내</a>
	<a class="btn btn-outline-dark"
		href="<c:url value="/program/schedule"/>">프로그램 일정</a>
	<div id="program-button-group" class="mt-3">
		<c:forEach items="${list}" var="sp" varStatus="status">
			<c:choose>
				<c:when test="${status.index == 0}">
					<c:set var="outline" value="" />
				</c:when>
				<c:otherwise>
					<c:set var="outline" value="outline-" />
				</c:otherwise>
			</c:choose>
			<button id="btn-sp-${status.index}"
				class="btn btn-${outline }primary" data-detail="${sp.sp_detail}"
				data-num="${status.index}" data-name="${sp.sp_name}"
				onclick="showDetail(this)">${sp.sp_name}</button>
		</c:forEach>
	</div>
	<hr>
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
		</div>
	</div>
	<div id="program-detail"></div>
	<br>
	<div id="program-penalty"></div>

	<script>
	const mySwiper = new Swiper('.swiper-container', {
		  	// 옵션 설정
			effect : 'fade',
			loop: true,
			slidesPerView: 1,
			watchOverflow: true,
			spaceBetween: 1500,
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
    };
	
    function showDetail(selectedButton) {
    	
        // 모든 버튼을 찾아서 처리
        var buttons = document.querySelectorAll("button[id^='btn-sp-']");

        buttons.forEach((button) => {
	        if (button === selectedButton) {
	            // 클릭된 버튼에는 btn-primary 추가
	            button.classList.remove("btn-outline-primary");
	            button.classList.add("btn-primary");
	        } else {
	            // 다른 버튼들은 btn-outline-primary로 설정
	            button.classList.remove("btn-primary");
	            button.classList.add("btn-outline-primary");
	        }
        });
        var programName = selectedButton.getAttribute('data-name');
        
        // 프로그램 이름으로 저장된 이미지들을 가져와서 하나씩 출력        
        getProgramImageNameList(programName, function(imageNameList) {
        	console.log(imageNameList);
            if (imageNameList) {
            	document.getElementById("swiper-wrapper").innerHTML = '';
                // List<String>에서 값을 하나씩 꺼내서 사용
                imageNameList.forEach(function(imageName) {
                    // 여기에서 각 이미지 이름에 대한 추가 작업을 할 수 있습니다.
                    var imgSrc = '<c:url value="/uploads' + imageName + '" />';
                    console.log('imgSrc2 : '+imgSrc); // 각 이미지 이름을 출력               			
                    document.getElementById("swiper-wrapper").innerHTML += 
                    	'<div class="swiper-slide"><img src="' + imgSrc + '" style="width:80%; height:80%"><br></div>';
                });
            } else {
                console.log("Error fetching image names");
            }
            
            // 슬라이더를 업데이트합니다.
            mySwiper.update(); // 슬라이더 업데이트
        });
        
		// 클릭된 버튼의 data-detail 속성 값을 가져와서 표시
        var detail = selectedButton.getAttribute('data-detail');
        // detail-container에 클릭된 sp_detail을 표시
        document.getElementById("program-detail").innerHTML = detail;
        if(selectedButton.getAttribute('data-num') != 0) {
        	document.getElementById("program-penalty").innerHTML = "노쇼(no show)일 경우 패널티가 있다는 안내";
        }
        else {
        	document.getElementById("program-penalty").innerHTML = "";
        }
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
