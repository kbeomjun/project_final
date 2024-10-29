<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .kakao-login-btn, .kakao-register-btn {
		    display: inline-block; /* 인라인 블록으로 설정 */
		    width: 48%; /* 버튼 너비 조절 */
		    text-align: center; /* 텍스트 중앙 정렬 */
		    margin-top: 10px; /* 버튼 간격 띄우기 */
		    background-color: #f7e600; /* 배경색 설정 */
		    color: black; /* 글자색 설정 */
		    border-radius: 5px; /* 테두리 둥글게 */
		    text-decoration: none; /* 링크 밑줄 제거 */
		    padding: 10px 0; /* 일반 로그인 버튼과 크기 맞춤 */
		    transition: background-color 0.3s ease; /* 커서 hover 효과에 부드러운 전환 추가 */
		}
		.kakao-login-btn:hover, .kakao-register-btn:hover {
		    background-color: #f1da00; /* 커서가 있을 때 배경색 변경 */
		    cursor: pointer;
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
	</div>
<!-- 카카오 로그인 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>

<script type="text/javascript">
    $(document).ready(function(){
        Kakao.init('${kakaoApiKey}');
        Kakao.isInitialized();
        
        $('#autologin').change(function() {
        	var isChecked = $(this).is(':checked') ? 1 : 0; 
            
            $.ajax({
                url: '<c:url value="/oauth/autoLogin"/>',
                type: 'POST',
                data: {
                	autoLogin: isChecked
                }
            });
        });
    });

    function loginWithKakao() {
        Kakao.Auth.authorize({ 
        redirectUri: '${kakaoRedirectUri}' 
        }); // 등록한 리다이렉트uri 입력
        
    }
    </script>