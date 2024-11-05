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
						<a href="<c:url value='/'/>" class="login_prev">Return Home</a>
					</div>
                    <div class="login_group">
                        <div class="login">
                        <c:choose>
                        <c:when test="${socialType eq 'KAKAO'}">
                        	<c:set var="sns" value="kakao__login" />
                        </c:when>
                        <c:otherwise>
                        	<c:set var="sns" value="naver__login" />
                        </c:otherwise>
                        </c:choose>
                        <div class="sns_login_wrap">
                           <button type="button" class="sns_login ${sns}" onclick="showForm('signupForm')">
                               <span onclick="showForm('signupForm')">간편 가입</span>
                           </button>
                           <button type="button" class="sns_login ${sns}" onclick="showForm('linkForm')">
                               <span onclick="showForm('linkForm')">계정 연동</span>
                           </button>
                        </div>
                        <!-- 간편 가입 폼 -->
    					<form id="signupForm" action='<c:url value="/sso/join" />' method="post" onsubmit="return validateForm()" style="display: none;" id="joinfrom">
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
                            <h1 class="login_title">${socialType}<br>간편가입</h1>
                            
                                <div class="login_form_group">
                                	<label for="me_id" class="login_label">아이디</label>
						            <input type="text" id="join_me_id" name="me_id" class="login_input" placeholder="아이디를 입력하세요" required>
						            <div id="idValidationMessage" class="validation-message"></div>
                                </div>
                                
                                <div class="login_form_group">
                                    <div class="password_wrap">
		                                <label for="me_pw" class="login_label">비밀번호</label>
							            <input type="password" id="join_me_pw" name="me_pw" class="login_input" placeholder="비밀번호를 입력하세요" required>
							            <div id="pwValidationMessage" class="validation-message"></div>
						            
                                    </div>
                                </div>
                                <div class="login_form_group">
                                	<div class="password_wrap">
                               		<label for="pw_check" class="login_label">비밀번호 확인</label>
					            	<input type="password" id="pw_check" name="pw_check" class="login_input" placeholder="비밀번호를 입력하세요" required>
					            	<div id="pwCheckValidationMessage" class="validation-message"></div>
					            </div>
                                </div>
                                
                                <!-- 간편 가입 버튼 -->
                                <button type="submit" class="btn btn_login mt-3">간편 가입</button>
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
								<h1 class="login_title">${socialType}<br>연동하기</h1>
						        <div class="login_form_group">
						            <label for="me_id" class="login_label">아이디:</label>
						            <input type="text" id="login_me_id" name="me_id" class="login_input" placeholder="아이디를 입력하세요" required>
						            <div id="idValidationMessage" class="validation-message"></div>
						        </div>
						
						        <div class="login_form_group">
						            <label for="me_pw" class="login_label">비밀번호:</label>
						            <input type="password" id="login_me_pw" name="me_pw"  class="login_input" placeholder="비밀번호를 입력하세요" required>
						            <div id="pwValidationMessage" class="validation-message"></div>
						        </div>
						
						        <button type="submit" class="btn btn_login mt-3">간편연동</button>
						    </form>
                            
                            
                        </div>
                    </div>
                </div>
            </div>
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

