<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<!-- Bootstrap CSS 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .body {
            padding-top: 150px; /* 헤더와의 간격 */
            padding-bottom: 150px; /* 푸터와의 간격 */
        }
        .card {
            margin-top: 100px; /* 카드의 위쪽 여백 */
        }
    </style>
</head>
<body class="bg-light">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<!-- Card를 사용하여 로그인 폼을 감쌈 -->
				<div class="card shadow-lg">
					<div class="card-header bg-success text-white text-center">
						<h2>로그인</h2>
					</div>
					<div class="card-body">
						<form action="<c:url value='/login'/>" method="post" id="loginfrom">
							<div class="mb-3">
								<label for="id" class="form-label">아이디</label>
								<input type="text" class="form-control" id="id" name="me_id" required/>
							</div>
							<div class="mb-3">
								<label for="pw" class="form-label">비밀번호</label>
								<input type="password" class="form-control" id="pw" name="me_pw" required/>
							</div>
							<div class="mb-3 form-check">
								<input type="checkbox" class="form-check-input" id="autologin" name="autologin" value="true"/>
								<label class="form-check-label" for="autologin">자동 로그인</label>
							</div>
							<button type="submit" class="btn btn-success w-100">로그인</button>
						</form>
					</div>
					<div class="card-footer text-center">
						<a href="<c:url value='/terms'/>" class="text-decoration-none">회원가입</a>
					</div>
					



<!-- kakao button -->
<div class="col-lg-12 text-center mt-3">
    <a href=#>
    	<img alt="카카오로그인" src="<c:url value='/resources/image/kakao/kakao_login_medium_narrow.png'/>" onclick="loginWithKakao()">
    </a>
</div>

<!-- 카카오 로그인 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
<script type="text/javascript">
    $(document).ready(function(){
        Kakao.init('${kakaoApiKey}');
        Kakao.isInitialized();
    });

    function loginWithKakao() {
        Kakao.Auth.authorize({ 
        redirectUri: '${redirectUri}' 
        }); // 등록한 리다이렉트uri 입력
        
    }
    
</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>