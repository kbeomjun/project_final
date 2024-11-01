<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
        <div class="login_wrap">
            <div class="login_content">
                <div class="login_left_wrap">
                    <div class="login_banner">
                        <h2 class="login_logo"><span class="blind">KF</span></h2>
                        <p class="login_logo_text">KH Fitness For<br>Front-Back-end Developers</p>
                    </div>
                </div>
                <!-- 오른쪽 로그인 폼 세션 -->
                <div class="login_right_wrap" id="skipnav_target">
                	<div class="login_prev_wrap">
						<a href="" class="login_prev">Return Home</a>
					</div>
                    <div class="login_group">
                        <div class="login">
                            <form action="<c:url value='/login'/>" method="post" id="loginfrom">
                                <h1 class="login_title">Welcome back to the<br>KH Fitness</h1>
                                <div class="login_form_group">
                                    <label for="id" class="login_label">아이디</label>
                                    <input type="text" class="login_input" id="id" name="me_id" placeholder="아이디를 입력하세요" required/>
                                </div>
                                <div class="login_form_group">
                                    <label for="pw" class="login_label">비밀번호</label>
                                    <input type="password" class="login_input" id="pw" name="me_pw" placeholder="비밀번호를 입력하세요" required/>
                                </div>
                                <!-- SNS 로그인 버튼 -->
                                <div class="sns_login_wrap">
                                    <a href="#" class="sns_login naver__login">
                                        <span>Log in with Naver</span>
                                    </a>
                                    <a href="#" class="sns_login kakao__login">
                                        <span onclick="loginWithKakao()">Log in with Kakao</span>
                                    </a>
                                </div>
                                <!-- 자동 로그인 체크박스 및 아이디/비밀번호 찾기 -->
                                <div class="login_auto_find_wrap">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="autologin" name="autologin" value="true">
                                        <label class="form-check-label" for="autologin">자동 로그인</label>
                                    </div>
                                    <div class="login_find_wrap">
                                        <p>아이디 또는 비밀번호를 잃어버리셨나요?</p>
                                        <div>
                                            <a href="<c:url value='/find/id' />" class="find_link find_id">아이디 찾기</a>
                                            <span>or</span>
                                            <a href="<c:url value='/find/pw' />" class="find_link find_pw">비밀번호 찾기</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- 로그인 버튼 -->
                                <button type="submit" class="btn btn_login">로그인</button>
                            </form>
                        </div>
                        <!-- 회원가입 링크 -->
                        <div class="singup_wrap">
                            <span>No Account yet?</span>
                            <a href="<c:url value='/terms'/>" class="singup_link">SIGN UP</a>
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

<!-- 비밀번호 보이기/숨기기 -->
<script type="text/javascript">
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

