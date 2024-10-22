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
							</div>
							<div class="d-flex justify-content-between">
							    <a id="kakao-login-btn" href="javascript:loginWithKakao()" class="kakao-login-btn btn">카카오 로그인</a>
							    <a href="/kakaoRegister" class="kakao-register-btn btn">카카오 회원가입</a>
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
    });

    function loginWithKakao() {
        Kakao.Auth.authorize({ 
        redirectUri: '${redirectUri}' 
        }); // 등록한 리다이렉트uri 입력
        
    }
    
</script>
</body>

<script>
/* 삭제 예정.
  // 카카오 SDK 초기화
  Kakao.init('9c8609073560662bd995a54cb43bbe28'); // 발급받은 실제 JavaScript 앱 키를 사용
  console.log(Kakao.isInitialized()); // 초기화 여부 확인 (true/false 출력)

  // 카카오 로그인 함수 정의
  function loginWithKakao() {
    Kakao.Auth.login({
      success: function (authObj) {
        // access_token을 저장
        Kakao.Auth.setAccessToken(authObj.access_token);
        // 회원 정보 가져오는 함수 호출
        getInfo();
      },
      fail: function (err) {
        console.error(err); // 로그인 실패 시 에러 출력
      }
    });
  }

  // 카카오 사용자 정보 가져오기
  function getInfo() {
    Kakao.API.request({
      url: '/v2/user/me',
      success: function (res) {
        var id = res.id; // 카카오 계정 ID
        var email = res.kakao_account.email; // 카카오 계정 이메일
        var sns = "kakao"; // SNS 타입을 지정
        
        // 가입 여부 확인
        if (!checkMember(sns, id)) {
          // 회원이 아니면 가입 여부를 묻고 처리
          if (confirm("회원이 아닙니다. 가입하시겠습니까?")) {
            // SNS 계정으로 회원 가입
            signupSns(sns, id, email);
          } else {
            return;
          }
        }
        // 로그인 진행
        snsLogin(sns, id);
        // 로그인 성공 후 메인 페이지로 이동
        location.href = '/';
      },
      fail: function (error) {
        alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요. ' + JSON.stringify(error));
      }
    });
  }

  //가입 여부 확인을 위한 AJAX
  function checkMember(sns, id) {
    var res;
    $.ajax({
      async: false,
      url: `/sns/${sns}/check/id`,  // 이 부분에서 sns 값이 제대로 설정되어 있는지 확인
      type: 'post',
      data: { id: id },  // 전송할 데이터
      success: function (data) {
        res = data;  // 성공 시 데이터 반환
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error(jqXHR, textStatus, errorThrown);  // 에러 처리
      }
    });
    return res;
  }

  // SNS 계정으로 회원 가입을 위한 AJAX
  function signupSns(sns, id, email) {
    $.ajax({
      async: false,
      url: `/sns/${sns}/signup`,
      type: 'post',
      data: { id: id, email: email },
      success: function (data) {
        console.log("가입 성공");
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error(jqXHR, textStatus, errorThrown);
      }
    });
  }

  // SNS 로그인 진행을 위한 AJAX
  function snsLogin(sns, id) {
    $.ajax({
      async: false,
      url: `/sns/${sns}/login`,
      type: 'post',
      data: { id: id },
      success: function (data) {
        if (data) {
          alert("로그인 되었습니다.");
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error(jqXHR, textStatus, errorThrown);
      }
    });
  } */
</script>
</html>
