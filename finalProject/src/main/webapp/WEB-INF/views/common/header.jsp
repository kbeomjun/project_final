<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<!-- skip nav -->
		<div class="skip_nav">
			<a href="#skipnav_target">본문 영역 바로가기</a>
		</div>
		<!-- skip nav -->
		
		<!-- main header -->
		<header class="main_header">
			<div class="logo_wrap">
				<h1><a href="#" class="logo" title="Fitness Logo"><span class="blind">Fitness Logo</span></a></h1>
			</div>
			<nav class="gnb_wrap">
				<ul class="gnb">
					<li class="gnb__item"><a href="#" class="gnb__link">지점 조회</a></li>
					<li class="gnb__item"><a href="#" class="gnb__link">회원권</a></li>
					<li class="gnb__item"><a href="#" class="gnb__link">프로그램</a></li>
					<li class="gnb__item"><a href="#" class="gnb__link">고객센터</a></li>
					<li class="gnb__item"><a href="#" class="gnb__link">지점관리</a></li>
					<li class="gnb__item"><a href="#" class="gnb__link">본사관리</a></li>
					<li class="gnb__item"><a href="#" class="gnb__link">로그인</a></li>
				</ul>
				<div class="gnb_side">
					<a href="#" class="gnb_side__link js-gnb_side__link">
						<span>정보</span>
						<i class="ic_gnb_side_menu">
							<svg width="50" height="40" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
								<rect x="5" y="18" width="40" height="2" fill="white"/>
								<rect x="5" y="30" width="40" height="2" fill="white"/>
							</svg>
						</i>
					</a>
					<!-- gnb side -->
					<div class="gnb_side_wrap">
						<a href="javascript:void(0)" class="btn_x js-btn_x">
							<span>닫기</span>
							<svg width="25" height="25" viewBox="0 0 23 23" style="enable-background:new 0 0 23 23;" xml:space="preserve">
							<polygon points="22.5,21.7 12.7,11.9 12.2,11.4 12.2,11.4 12.2,11.4 12.7,10.9 22.5,1.2 21.8,0.5 11.5,10.8 1.2,0.5 
								0.5,1.2 10.3,10.9 10.8,11.4 10.8,11.4 10.8,11.4 10.3,11.9 0.4,21.7 1.1,22.4 11.5,12.1 21.8,22.4 "></polygon>
							</svg>
						</a>
						<div class="gnb_side__info_wrap">
							<div class="gnb_side__info">
								<div>
									<a href="#">
										<img width="134" height="101" src="https://powerlift.qodeinteractive.com/wp-content/uploads/2019/07/logo-side-area.png" class="image wp-image-2173  attachment-full size-full" alt="" style="max-width: 100%; height: auto;" loading="eager">
									</a>
								</div>
								<div class="textbox">
									<p>Lorem ipsum dolor sit amet, consectetur<br>
									adipiscing elit. Pellentesque vitae nunc ut<br>
									dolor sagittis euismod eget sit amet erat.<br>
									Mauris porta. Lorem ipsum dolor.</p>
								</div>
								<div class="textbox">
									<h3 class="gnb_side__title">Working hours</h3>
									<p>Monday - Friday:<br>07:00 - 21:00</p>
									<p>Saturday:<br>07:00 - 16:00</p>
									<p>Sunday Closed</p>
								</div>
								<div class="textbox mt-auto">
									<h3 class="gnb_side__title">Our socials</h3>
									<div>
										<a href="#" class="gnb_side__sns" title="인스타그램">
											<svg width="25" height="25" viewBox="0 0 400 400" fill="none" xmlns="http://www.w3.org/2000/svg" class="gnb_side__sns_defualt">
												<path fill-rule="evenodd" clip-rule="evenodd" d="M96.857 22.4856C77.1299 22.4856 58.2103 30.3202 44.2584 44.2667C30.3065 58.2133 22.4646 77.1299 22.457 96.857V295.257C22.457 314.989 30.2956 333.913 44.2483 347.866C58.201 361.818 77.1249 369.657 96.857 369.657H295.257C314.984 369.649 333.901 361.808 347.847 347.856C361.794 333.904 369.628 314.984 369.628 295.257V96.857C369.621 77.1348 361.783 58.2226 347.837 44.2768C333.891 30.3311 314.979 22.4932 295.257 22.4856H96.857ZM316.657 96.9713C316.657 102.655 314.399 108.105 310.381 112.124C306.362 116.142 300.912 118.4 295.228 118.4C289.545 118.4 284.095 116.142 280.076 112.124C276.058 108.105 273.8 102.655 273.8 96.9713C273.8 91.2881 276.058 85.8377 280.076 81.819C284.095 77.8004 289.545 75.5427 295.228 75.5427C300.912 75.5427 306.362 77.8004 310.381 81.819C314.399 85.8377 316.657 91.2881 316.657 96.9713ZM196.086 136.628C180.324 136.628 165.208 142.89 154.063 154.035C142.918 165.18 136.657 180.296 136.657 196.057C136.657 211.818 142.918 226.934 154.063 238.079C165.208 249.224 180.324 255.486 196.086 255.486C211.847 255.486 226.963 249.224 238.108 238.079C249.253 226.934 255.514 211.818 255.514 196.057C255.514 180.296 249.253 165.18 238.108 154.035C226.963 142.89 211.847 136.628 196.086 136.628ZM108.057 196.057C108.057 172.718 117.328 150.335 133.832 133.832C150.335 117.328 172.718 108.057 196.057 108.057C219.396 108.057 241.779 117.328 258.282 133.832C274.786 150.335 284.057 172.718 284.057 196.057C284.057 219.396 274.786 241.779 258.282 258.282C241.779 274.786 219.396 284.057 196.057 284.057C172.718 284.057 150.335 274.786 133.832 258.282C117.328 241.779 108.057 219.396 108.057 196.057Z" fill="white"/>
											</svg>
										</a>
										<a href="#" class="gnb_side__sns" title="페이스북">
											<svg width="25" height="25" viewBox="0 0 400 400" fill="none" xmlns="http://www.w3.org/2000/svg" class="gnb_side__sns_defualt">
												<path d="M222.583 366.667V214.617H273.617L281.267 155.367H222.6V117.533C222.6 100.367 227.35 88.6834 251.95 88.6834L283.333 88.6667V35.6667C268.149 34.0518 252.887 33.2728 237.617 33.3334C192.367 33.3334 161.4 60.95 161.4 111.667V155.367H110.233V214.617H161.4V366.667H222.583Z" fill="white"/>
											</svg>
										</a>
										<a href="#" class="gnb_side__sns" title="트위터">
											<svg width="25" height="25" viewBox="0 0 400 400" fill="none" xmlns="http://www.w3.org/2000/svg" class="gnb_side__sns_defualt">
												<path d="M341.25 130.083C341.417 133.167 341.417 136.25 341.417 139.167C341.372 158.141 338.605 177.011 333.2 195.2C321.791 237.118 296.745 274.043 262.016 300.143C227.287 326.243 184.854 340.032 141.417 339.333C103.184 339.376 65.7547 328.368 33.6333 307.633C39.2008 308.325 44.8064 308.665 50.4166 308.65C82.0576 308.679 112.787 298.053 137.65 278.483C123.004 278.216 108.808 273.383 97.0415 264.658C85.2753 255.934 76.5266 243.753 72.0166 229.817C76.3778 230.567 80.7918 230.968 85.2166 231.017C91.529 231.049 97.814 230.185 103.883 228.45C88.8456 225.468 75.2027 217.632 65.0498 206.145C54.897 194.659 48.7958 180.157 47.6833 164.867C47.4055 163.109 47.2939 161.329 47.35 159.55V158.7C57.1231 164.112 68.0497 167.107 79.2166 167.433C69.5929 161.028 61.7052 152.34 56.258 142.143C50.8108 131.947 47.9737 120.56 48 109C48.0099 96.5538 51.261 84.3246 57.4333 73.5167C75.0856 95.2662 97.1202 113.055 122.103 125.724C147.086 138.393 174.456 145.66 202.433 147.05C198.904 131.974 200.449 116.154 206.83 102.046C213.211 87.9376 224.07 76.33 237.722 69.0244C251.374 61.7187 267.056 59.1234 282.334 61.6414C297.611 64.1593 311.631 71.6497 322.217 82.95C338.001 79.8512 353.134 74.0553 366.95 65.8167C367.541 77.7485 365.549 89.6674 361.111 100.759C356.673 111.85 349.909 121.853 341.25 130.083Z" fill="white"/>
											</svg>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- gnb side -->
				</div>
			</nav>
		</header>