<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value="/resources/css/sso/match.css"/>">

<div class="login_wrap">
	<div class="login_content">
		<div class="login_left_wrap">
			<div class="login_banner">
				<h2 class="login_logo">
					<span class="blind">KF</span>
				</h2>
				<p class="login_logo_text">
					KH Fitness For<br>Front-Back-end Developers
				</p>
			</div>
		</div>
		<!-- 오른쪽 로그인 폼 세션 -->
		<div class="login_right_wrap" id="skipnav_target">
			<div class="login_prev_wrap">
				<a href="<c:url value='/'/>" class="login_prev">Return Home</a>
			</div>
			<div class="login_group">
				<div class="box__alert-message">
					<h3 class="text__certify-title">
						이미 가입된 아이디가 있어요. <br>
						<c:choose>
							<c:when test="${ socialType eq 'KAKAO'}">
								<c:set var="text_color" value="color_kakao" />
							</c:when>
							<c:otherwise>
								<c:set var="text_color" value="color_naver" />
							</c:otherwise>
						</c:choose>
						<span class="${text_color }">${socialType}</span> 계정을 연결해 주세요.
					</h3>
					<div class="box__border">${user.me_id}</div>
					<form action="<c:url value="/sso/match"/>" method="post">
						<input type="hidden" name="social_type" value="${socialType}">
						<input type="hidden" name="me_id" value="${user.me_id}" />
						<c:choose>
							<c:when test="${ socialType eq 'KAKAO'}">
								<input type="hidden" name="me_kakaoUserId"
									value="${user.me_kakaoUserId}" />
								<button type="submit" id="btnMatchingSubmit"
									class="button_kakao">
									<img
										src="<c:url value='/resources/image/kakao/kakaotalk_sharing_btn_small.png'/>"
										class="kakao-icon" /> 카카오 계정 연결하기
								</button>
							</c:when>
							<c:when test="${ socialType eq 'NAVER'}">
								<input type="hidden" name="me_naverUserId"
									value="${user.me_naverUserId}" />
								<button type="submit" id="btnMatchingSubmit"
									class="button_naver">
									<img
										src="<c:url value='/resources/image/naver/logo_naver.png'/>"
										class="naver-icon" /> 네이버 계정 연결하기
								</button>
							</c:when>
						</c:choose>
						<input type="hidden" name="me_gender" value="${user.me_gender}" />
						<input type="hidden" name="me_phone" value="${user.me_phone}" />
						<input type="hidden" name="me_name" value="${user.me_name}" />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

