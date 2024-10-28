<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		<div class="login_wrap">
			<div class="">
				<!-- Card를 사용하여 로그인 폼을 감쌈 -->
				<div class="">
					<div class="">
						<h2>로그인</h2>
					</div>
					<div class="card-body">
						<form action="<c:url value='/login'/>" method="post"
							id="loginfrom">
							<div class="mb-3">
								<label for="id" class="form-label">아이디</label> <input
									type="text" class="form-control" id="id" name="me_id" required />
							</div>
							<div class="mb-3">
								<label for="pw" class="form-label">비밀번호</label> <input
									type="password" class="form-control" id="pw" name="me_pw"
									required />
							</div>
							<div class="d-flex justify-content-between align-items-center mb-3">
							    <div class="form-check">
							        <input type="checkbox" class="form-check-input" id="autologin" name="autologin" value="true"/>
							        <label class="form-check-label" for="autologin">자동 로그인</label>
							    </div>
							    <div>
							        <a href="<c:url value='/find/id' />" class="text-decoration-none me-3">아이디 찾기</a>
							        <a href="<c:url value='/find/pw' />" class="text-decoration-none">비밀번호 찾기</a>
							    </div>
							    <button type="submit" class="btn btn-success w-100">로그인</button>
							</div>
						</form>
					</div>
					<div class="card-footer text-center">
						<a href="<c:url value='/terms'/>" class="text-decoration-none">회원가입</a>
					</div>

					<!-- kakao button -->
					<div class="col-lg-12 text-center mt-3">
						<a href=#> <img alt="카카오로그인"
							src="<c:url value='/resources/image/kakao/kakao_login_medium_narrow.png'/>"
							onclick="loginWithKakao()">
						</a>
						<a href="${naverApiUrl }"><img alt="네이버로그인" width ="180" height="45" src="<c:url value='/resources/image/naver/small_g_in.png'/>"/></a>
					</div>

				</div>
			</div>
		</div>
