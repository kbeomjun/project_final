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
                        <form action="<c:url value='/login'/>" method="post" id="loginfrom">
                            <div class="mb-3">
                                <label for="id" class="form-label">아이디</label> 
                                <input type="text" class="form-control" id="id" name="me_id" required />
                            </div>
                            <div class="mb-3 position-relative">
                                <label for="pw" class="form-label">비밀번호</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="pw" name="me_pw" required />
                                    <span class="input-group-text" id="togglePassword" style="cursor: pointer;">
                                        <img id="eyeIcon" src="<c:url value='/resources/image/icons/eye.svg'/>" alt="Show Password" style="width: 20px; height: 20px;" />
                                    </span>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                                <div class="form-check mb-2">
                                    <input type="checkbox" class="form-check-input" id="autologin" name="autologin" value="true" />
                                    <label class="form-check-label" for="autologin">자동 로그인</label>
                                </div>
                                <div class="d-flex gap-2 mb-2">
                                    <a href="<c:url value='/find/id' />" class="text-decoration-none">아이디 찾기</a>
                                    <a href="<c:url value='/find/pw' />" class="text-decoration-none">비밀번호 찾기</a>
                                </div>
                            </div>
    
                            <!-- 로그인 버튼 -->
                            <button type="submit" class="btn btn-success w-100 mb-3">로그인</button>
    
                            <!-- 소셜 로그인 버튼들 -->
                            <div class="d-flex justify-content-between gap-2">
                                <a href="#" class="d-flex align-items-center justify-content-center border rounded"
                                   style="width: 48%; height: 45px;" onclick="loginWithKakao()">
                                    <img alt="카카오로그인"
                                         src="<c:url value='/resources/image/kakao/kakao_login_medium_narrow.png'/>" 
                                         style="max-height: 100%;" />
                                </a>
                                <a href="${naverApiUrl}" class="d-flex align-items-center justify-content-center border rounded"
                                   style="width: 48%; height: 45px;">
                                    <img alt="네이버로그인" 
                                         src="<c:url value='/resources/image/naver/small_g_in.png'/>" 
                                         style="max-height: 100%;" />
                                </a>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center">
                        <a href="<c:url value='/terms'/>" class="text-decoration-none">회원가입</a>
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

    // 비밀번호 보이기/숨기기
    document.getElementById('togglePassword').addEventListener('click', function() {
        var passwordField = document.getElementById('pw');
        var eyeIcon = document.getElementById('eyeIcon');
        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            eyeIcon.src = "<c:url value='/resources/image/icons/eye-slash.svg'/>"; // 닫힌 눈 아이콘
            eyeIcon.alt = "Hide Password";
        } else {
            passwordField.type = 'password';
            eyeIcon.src = "<c:url value='/resources/image/icons/eye.svg'/>"; // 열린 눈 아이콘
            eyeIcon.alt = "Show Password";
        }
    });
</script>
</body>
</html>
