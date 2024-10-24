<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<style>
.validation-message {
            font-size: 0.9em;
            color: red;
        }
</style>
</head>
<body>
   
	<div class="container mt-5">
    <h2 class="text-center">${socialType} 계정으로 가입/연동</h2>
    <div class="text-center mt-4">
        <button type="button" class="btn btn-secondary" onclick="showForm('linkForm')">기존 계정 연동</button>
        <button type="button" class="btn btn-secondary" onclick="showForm('signupForm')">간편 가입</button>
    </div>

    <!-- 간편 가입 폼 -->
    <form id="signupForm" action='<c:url value="/sso/join" />' method="post" onsubmit="return validateForm()" class="mt-4" style="display: none;">
        <input type="hidden" name="social_type" value="${socialType}"> 
        <c:choose>
            <c:when test="${ socialType eq 'KAKAO'}">
                <input type="hidden" name="me_kakaoUserId" value="${socialUser.me_kakaoUserId}" />
            </c:when>
            <c:when test="${ socialType eq 'NAVER'}">
                <input type="hidden" name="me_naverUserId" value="${socialUser.me_naverUserId}" />
            </c:when>
        </c:choose>
        <input type="hidden" name="me_gender" value="${socialUser.me_gender}" /> 
        <input type="hidden" name="me_phone" value="${socialUser.me_phone}" /> 
        <input type="hidden" name="me_name" value="${socialUser.me_name}" />
        <input type="hidden" name="me_email" value="${socialUser.me_email}" />

        <div class="form-group">
            <label for="me_id">아이디:</label>
            <input type="text" id="join_me_id" name="me_id" class="form-control" required>
            <div id="idValidationMessage" class="validation-message"></div>
        </div>

        <div class="form-group">
            <label for="me_pw">비밀번호:</label>
            <input type="password" id="join_me_pw" name="me_pw" class="form-control" required>
            <div id="pwValidationMessage" class="validation-message"></div>
        </div>

        <div class="form-group">
            <label for="pw_check">비밀번호 확인:</label>
            <input type="password" id="pw_check" name="pw_check" class="form-control" required>
            <div id="pwCheckValidationMessage" class="validation-message"></div>
        </div>

        <button type="submit" class="btn btn-primary btn-block">가입하기</button>
    </form>

    <!-- 기존 계정 연동 폼 -->
    <form id="linkForm" action='<c:url value="/sso/match/login" />' method="post" class="mt-4" style="display: none;">
        <input type="hidden" name="social_type" value="${socialType}"> 
        <c:choose>
            <c:when test="${ socialType eq 'KAKAO'}">
                <input type="hidden" name="me_kakaoUserId" value="${socialUser.me_kakaoUserId}" />
            </c:when>
            <c:when test="${ socialType eq 'NAVER'}">
                <input type="hidden" name="me_naverUserId" value="${socialUser.me_naverUserId}" />
            </c:when>
        </c:choose>
        <input type="hidden" name="me_gender" value="${socialUser.me_gender}" /> 
        <input type="hidden" name="me_phone" value="${socialUser.me_phone}" /> 
        <input type="hidden" name="me_name" value="${socialUser.me_name}" />
        <input type="hidden" name="me_email" value="${socialUser.me_email}" />

        <div class="form-group">
            <label for="me_id">아이디:</label>
            <input type="text" id="login_me_id" name="me_id" class="form-control" required>
            <div id="idValidationMessage" class="validation-message"></div>
        </div>

        <div class="form-group">
            <label for="me_pw">비밀번호:</label>
            <input type="password" id="login_me_pw" name="me_pw" class="form-control" required>
            <div id="pwValidationMessage" class="validation-message"></div>
        </div>

        <button type="submit" class="btn btn-primary btn-block">로그인하기</button>
    </form>
</div>

<script>
	function showForm(formId) {
	    // 모든 폼 숨기기 및 초기화
	    resetForm('signupForm');
	    resetForm('linkForm');
	
	    // 선택된 폼만 보이기
	    document.getElementById(formId).style.display = 'block';
	}
	
	function resetForm(formId) {
	    // 해당 폼을 숨기고, 폼의 모든 입력 필드를 초기화
	    const form = document.getElementById(formId);
	    form.style.display = 'none';
	    form.reset();
	}
	
    showForm('linkForm');
</script>
	

<script>
const idPattern = /^\w{4,10}$/; // 
const passwordPattern = /^[a-zA-Z0-9!@#$]{8,15}$/;

function validateForm() {
        
    const me_id = document.getElementById("join_me_id").value;
    const me_pw = document.getElementById("join_me_pw").value;
    const pw_check = document.getElementById("pw_check").value;

    // 아이디 검증
    if (!idPattern.test(me_id)) {
        alert("아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.");
        return false; // 검증 실패 시 전송 방지
    }

    // 비밀번호 검증
    if (!passwordPattern.test(me_pw)) {
        alert("비밀번호는 8~15자 길이로, 영어, 숫자, 특수문자(!@#$)만 포함할 수 있습니다.");
        return false; // 검증 실패 시 전송 방지
    }

    // 비밀번호 확인 검증
    if (me_pw !== pw_check) {
        alert("비밀번호가 일치하지 않습니다.");
        return false; // 검증 실패 시 전송 방지
    }
    
    if (!checkIdDuplicate(me_id)) {
        alert("이미 사용중인 아이디입니다.");
        return false;
    }
   
    return true;
}

function checkIdDuplicate(id) {
	 
	var res = 0;
	
	 $.ajax({
         async: false,
         url: '<c:url value="/check/id"/>',
         type: 'get',
         data: {
             id: id
         },
         success: function(data) {
             res=data;
        	 console.log(res);
         },
         error: function(jqXHR, textStatus, errorThrown) {
             // 에러 처리
         }
     });
     return res;
     
}

//아이디 검증 함수
function validateId() {
    const me_id = document.getElementById("join_me_id").value;
    const idValidationMessage = document.getElementById("idValidationMessage");

    if (!idPattern.test(me_id)) {
        idValidationMessage.textContent = "아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.";
    } else {
        idValidationMessage.textContent = ""; // 메시지 초기화
    }
}

// 비밀번호 검증 함수
function validatePassword() {
    const me_pw = document.getElementById("join_me_pw").value;
    const pwValidationMessage = document.getElementById("pwValidationMessage");

    if (!passwordPattern.test(me_pw)) {
        pwValidationMessage.textContent = "비밀번호는 8~15자 길이로, 영어, 숫자, 특수문자(!@#$)만 포함할 수 있습니다.";
    } else {
        pwValidationMessage.textContent = ""; // 메시지 초기화
    }

    // 비밀번호 확인 검증
    validatePasswordCheck();
}

// 비밀번호 확인 검증 함수
function validatePasswordCheck() {
    const me_pw = document.getElementById("join_me_pw").value;
    const pw_check = document.getElementById("pw_check").value;
    const pwCheckValidationMessage = document.getElementById("pwCheckValidationMessage");

    if (me_pw !== pw_check) {
        pwCheckValidationMessage.textContent = "비밀번호가 일치하지 않습니다.";
    } else {
        pwCheckValidationMessage.textContent = ""; // 메시지 초기화
    }
}

// 입력 필드에서 이벤트 리스너 추가
document.getElementById("join_me_id").addEventListener("input", validateId);
document.getElementById("join_me_pw").addEventListener("input", validatePassword);
document.getElementById("pw_check").addEventListener("input", validatePasswordCheck);
</script>
</body>
</html>
