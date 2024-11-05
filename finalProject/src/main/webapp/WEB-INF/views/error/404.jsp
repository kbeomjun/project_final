<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="errorPage_wrap">
	<div class="errorPage_text_wrap">
		<div class="errorPage_group">
			<small class="errorPage_small">Oops</small>
			<h1 class="errorPage_title">404</h1>
			<p class="errorPage_text">Page not found</p>
			<p class="errorPage_text2">Oops! The page you are looking for does not exist. It might have been moved or deleted.</p>
			<p class="errorPage_text3">접근할 수 없는 페이지입니다.</p>
		</div>
		<div class="btn_link_white">
			<a class="btn btn_white font-montserrat" href="<c:url value='/'/>" class="login_prev">
				<span>Back to home<i class="ic_link_share"></i></span>
			</a>
			<div class="btn_white_top_line"></div>
			<div class="btn_white_right_line"></div>
			<div class="btn_white_bottom_line"></div>
			<div class="btn_white_left_line"></div>
		</div>
	</div>
</div>