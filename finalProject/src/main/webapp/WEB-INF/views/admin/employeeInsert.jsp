<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
<style>
    .error { color: red; margin-bottom: 10px; }
    .form-group { margin-bottom: 15px; }
</style>
</head>
<body>
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">마이페이지 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/schedule/${me_id}"/>">프로그램 일정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/membership/${me_id}"/>">회원권</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/review/list/${me_id}"/>">나의 작성글</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/inquiry/list/${me_id}"/>">문의내역</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwcheck/${me_id}"/>">개인정보수정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/client/mypage/pwchange/${me_id}"/>">비밀번호 변경</a>
	                    </li>
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2 class="mb-3">비밀번호 변경</h2>
					<form action="<c:url value='/client/mypage/pwchange/update'/>" method="post" onsubmit="return validatePassword()">
					    <input type="hidden" name="me_id" value="${me_id}">
					
					    <div class="form-group">
					        <label for="current_pw">현재 비밀번호:</label>
					        <input type="password" id="current_pw" name="current_pw" class="form-control" placeholder="현재 비밀번호를 입력하세요" required>
					        <span class="error" id="current_pw_error"></span>
					    </div>
					
					    <div class="form-group">
					        <label for="new_pw">새 비밀번호:</label>
					        <input type="password" id="new_pw" name="new_pw" class="form-control" placeholder="새 비밀번호를 입력하세요" required>
					        <span class="error" id="new_pw_error"></span>
					    </div>
					
					    <div class="form-group">
					        <label for="confirm_pw">새 비밀번호 확인:</label>
					        <input type="password" id="confirm_pw" name="confirm_pw" class="form-control" placeholder="새 비밀번호를 다시 입력하세요" required>
					        <span class="error" id="confirm_pw_error"></span>
					    </div>
					
					    <button type="submit" class="btn btn-primary">변경</button>
					</form>
					
	            </div>
	        </main>
	    </div>
	</div>
	
    <script>
        const pwRegex = /^[a-zA-Z0-9!@#$]{4,15}$/;

        function validatePasswordField(inputId, errorId, customMessage) {
            const inputValue = document.getElementById(inputId).value;
            if (!pwRegex.test(inputValue)) {
                document.getElementById(errorId).innerText = customMessage;
                return false;
            } else {
                document.getElementById(errorId).innerText = "";
                return true;
            }
        }

        function validatePassword() {
            const currentPw = document.getElementById("current_pw").value;
            const newPw = document.getElementById("new_pw").value;
            const confirmPw = document.getElementById("confirm_pw").value;

            // 새 비밀번호와 새 비밀번호 확인이 일치하는지 체크
            if (newPw !== confirmPw) {
                document.getElementById("confirm_pw_error").innerText = "새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.";
                return false;
            } else {
                document.getElementById("confirm_pw_error").innerText = "";
            }

            // 비밀번호가 현재 비밀번호와 같은지 체크
            if (currentPw === newPw) {
                document.getElementById("new_pw_error").innerText = "현재 비밀번호와 새 비밀번호는 같을 수 없습니다.";
                return false;
            } else {
                document.getElementById("new_pw_error").innerText = "";
            }

            // 모든 비밀번호 필드 정규식 체크
            const currentPwValid = validatePasswordField("current_pw", "current_pw_error", "비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.");
            const newPwValid = validatePasswordField("new_pw", "new_pw_error", "비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.");
            const confirmPwValid = validatePasswordField("confirm_pw", "confirm_pw_error", "비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.");

            return currentPwValid && newPwValid && confirmPwValid;
        }

        // keyup 이벤트 추가 (실시간 검증)
        document.getElementById("new_pw").addEventListener("keyup", function() {
            validatePasswordField("new_pw", "new_pw_error", "비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.");
        });

        document.getElementById("confirm_pw").addEventListener("keyup", function() {
            const newPw = document.getElementById("new_pw").value;
            const confirmPw = document.getElementById("confirm_pw").value;

            if (newPw !== confirmPw) {
                document.getElementById("confirm_pw_error").innerText = "새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.";
            } else {
                validatePasswordField("confirm_pw", "confirm_pw_error", "비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.");
            }
        });

        document.getElementById("current_pw").addEventListener("keyup", function() {
            validatePasswordField("current_pw", "current_pw_error", "비밀번호는 4자에서 15자의 영문자, 숫자, 특수문자(!@#$)만 사용할 수 있습니다.");
        });
    </script>
</body>
</html>
