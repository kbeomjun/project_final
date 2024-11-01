<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <style>
        .error {
            margin-top: 10px;
            font-size: 0.9em;
            color: red;
        }
        .form-control {
            color: black;
        }
        .form-control.error-border {
            border-color: red;
        }
        body {
            background-color: #f0f0f0;
            padding: 100px 20px;
        }
        h1 {
            margin-top: 60px;
            text-align: center;
        }
        .card {
            margin: auto;
            width: 90%;
            max-width: 600px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .address-group input {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>회원가입</h1>
    <div class="card">
        <form action="<c:url value='/signup'/>" method="post" id="form" onsubmit="return onSubmitForm()">
            <div class="form-group">
                <label for="name">이름:</label>
                <input type="text" class="form-control" id="name" name="me_name">
            </div>
            <div class="form-group">
                <label for="id">아이디:</label>
                <input type="text" class="form-control" id="id" name="me_id">
            </div>
            <div class="form-group">
                <label for="pw">비밀번호:</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="pw" name="me_pw">
                    <span class="input-group-text" id="togglePassword1" style="cursor: pointer;">
                        <img id="eyeIcon1" src="<c:url value='/resources/image/icons/eye.svg'/>" alt="Show Password" style="width: 20px; height: 20px;" />
                    </span>
                </div>
            </div>
            <div class="form-group">
                <label for="pw2">비밀번호 확인:</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="pw2" name="me_pw2">
                    <span class="input-group-text" id="togglePassword2" style="cursor: pointer;">
                        <img id="eyeIcon2" src="<c:url value='/resources/image/icons/eye.svg'/>" alt="Show Password" style="width: 20px; height: 20px;" />
                    </span>
                </div>
            </div>
            <div class="form-group">
                <label for="email">이메일:</label>
                <div style="display: flex; align-items: center;">
                    <input type="text" class="form-control" id="me_emailId" name="me_emailId" placeholder="이메일 아이디" style="flex: 6; margin-right: 10px;">
                    <span style="margin-right: 10px;">@</span>
                    <select class="form-control" id="me_emailDomain" name="me_emailDomain" style="flex: 4; margin-right: 10px;">
                        <option value="">선택</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="google.com">google.com</option>
                        <option value="yahoo.com">yahoo.com</option>
                        <option value="custom">직접 입력</option>
                    </select>
                    <input type="text" class="form-control" id="me_customEmailDomain" name="me_customEmailDomain" placeholder="도메인 직접 입력" style="display: none; flex: 4;">
                </div>
                <p id="check-email" class="error" style="margin-bottom: 10px;"></p>
            </div>
            <div class="form-group">
                <label for="gender" style="display: block; margin-bottom: 8px;">성별:</label>
                <div style="display: flex; align-items: center; gap: 20px;">
                    <div>
                        <input type="radio" id="male" name="me_gender" value="남자">
                        <label for="male">남성</label>
                    </div>
                    <div>
                        <input type="radio" id="female" name="me_gender" value="여자">
                        <label for="female">여성</label>
                    </div>
                </div>
            </div>
            <div class="form-group address-group">
                <label for="br_address">주소:</label>
                <div style="display: flex; align-items: center;">
                    <input type="text" class="form-control" id="me_postcode" name="me_postcode" placeholder="우편번호" style="width: 150px; margin-right: 10px;" readonly/>
                    <input class="btn btn-outline-dark" type="button" onclick="addressPostcode()" value="우편번호 찾기"/>
                </div>
                <input type="text" class="form-control" id="me_address" name="me_address" placeholder="주소" readonly/>
                <input type="text" class="form-control" id="me_detailAddress" name="me_detailAddress" placeholder="상세주소"/>
                <input type="text" class="form-control" id="me_extraAddress" name="me_extraAddress" placeholder="참고항목" readonly/>
            </div>
            <div class="form-group" id="phoneGroup">
                <label for="phone">전화번호:</label>
                <div style="display: flex; align-items: center; justify-content: space-between;">
                    <select class="form-control phone-select" id="phone1" name="phone1">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    <span>-</span>
                    <input type="tel" class="form-control phone-input" id="phone2" name="phone2" maxlength="4" placeholder="0000">
                    <span>-</span>
                    <input type="tel" class="form-control phone-input" id="phone3" name="phone3" maxlength="4" placeholder="0000">
                </div>
                <input type="hidden" id="me_phone" name="me_phone">
            </div>
            <div class="form-group birth-group">
                <label for="birth">생년월일:</label>
                <input type="date" class="form-control" id="birth" name="me_birth"
                    max="<%= java.time.LocalDate.now().minusYears(12) %>" min="<%= java.time.LocalDate.now().minusYears(100) %>">
            </div>
            <button type="submit" class="btn btn-outline-success col-12">회원가입</button>
        </form>
        <c:if test="${not empty errorMessage}">
            <div class="error" style="margin-bottom: 10px;">${errorMessage}</div>
        </c:if>
    </div>
</body>

<script type="text/javascript">
    function togglePassword(inputId, iconId) {
        var passwordField = document.getElementById(inputId);
        var eyeIcon = document.getElementById(iconId);
        
        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            eyeIcon.src = "<c:url value='/resources/image/icons/eye-slash.svg'/>"; // 닫힌 눈 아이콘
            eyeIcon.alt = "Hide Password";
        } else {
            passwordField.type = 'password';
            eyeIcon.src = "<c:url value='/resources/image/icons/eye.svg'/>"; // 열린 눈 아이콘
            eyeIcon.alt = "Show Password";
        }
    }

    // 비밀번호 토글 버튼 이벤트 리스너 추가
    document.getElementById('togglePassword1').addEventListener('click', function() {
        togglePassword('pw', 'eyeIcon1');
    });

    document.getElementById('togglePassword2').addEventListener('click', function() {
        togglePassword('pw2', 'eyeIcon2');
    });
</script>

<script type="text/javascript">
    document.getElementById("me_emailDomain").addEventListener("change", function() {
        var emailDomain = this.value;
        var customEmailField = document.getElementById("me_customEmailDomain");

        // "직접 입력" 선택 시 표시, 그 외에는 숨기기
        if (emailDomain === "custom") {
            customEmailField.style.display = "block";
            customEmailField.setAttribute("required", "true");
        } else {
            customEmailField.style.display = "none";
            customEmailField.removeAttribute("required");
        }
    });
</script>

<script type="text/javascript">
    var flag = false;
    
    $('#form').validate({
    	groups: {
            phoneGroup: "phone2 phone3"
        },
        rules: {
        	me_name :{
        		required : true
        	},        	
            me_id: {
                required: true,
                regex: /^\w{4,10}$/
            },
            me_pw: {
                required: true,
                regex: /^[a-zA-Z0-9!@#$]{4,15}$/
            },
            me_pw2: {
            	required: true,
                equalTo: "#pw"
            },
            me_emailId: {
                required: true
            },
            me_customEmailDomain: {
                required: function () {
                    return $('#me_emailDomain').val() === "custom";
                }
            },
            me_gender: {
                required: true
            },
            me_detailAddress: {
                required: true
            },
            phone2: {
                required: true,
                minlength: 4,
                maxlength: 4
            },
            phone3: {
                required: true,
                minlength: 4,
                maxlength: 4
            },
            me_birth: {
                required: true
            }
        },
        messages: {
            me_name: {
                required: '필수 항목입니다.'
            },
            me_id: {
                required: '필수 항목입니다.',
                regex: '아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.'
            },
            me_pw: {
                required: '필수 항목입니다.',
                regex: '비밀번호는 영어, 숫자, 특수문자(!@#$)만 가능하며, 4~15자이어야 합니다.'
            },
            me_pw2: {
                required: '필수 항목입니다.',
                equalTo: '비밀번호와 일치하지 않습니다.'
            },
            me_emailId: {
                required: '이메일을 입력해주세요.',
                email: '이메일 형식이 아닙니다.'
            },
            me_customEmailDomain: {
                required: '도메인을 직접 입력하세요.'
            },
            me_gender: {
                required: '성별을 선택해주세요.'
            },
            me_detailAddress: {
                required: '상세주소를 입력해주세요.'
            },
            phone2: {
                required: '전화번호를 입력해주세요.',
                minlength: '정확한 전화번호를 입력하여야 합니다.',
                maxlength: '정확한 전화번호를 입력하여야 합니다.'
            },
            phone3: {
                required: '전화번호를 입력해주세요.',
                minlength: '정확한 전화번호를 입력하여야 합니다.',
                maxlength: '정확한 전화번호를 입력하여야 합니다.'
            },
            me_birth: {
                required: '생년월일을 선택해주세요.'
            }
        },
        errorPlacement: function (error, element) {
            if (element.attr("name") === "phone2" || element.attr("name") === "phone3") {
                error.appendTo("#phoneGroup"); // phoneGroup 영역에 한 번만 에러 메시지 출력
            } else if (element.attr("name") === "me_emailId" || element.attr("name") === "me_emailDomain" || element.attr("name") === "me_customEmailDomain") {
                error.appendTo("#check-email"); // emailGroup 영역에 한 번만 에러 메시지 출력
            } else {
                error.appendTo(element.closest('.form-group'));
            }
        }
    });

    // "직접 입력" 선택 시 직접 입력란 표시/숨김
    $('#me_emailDomain').change(function () {
        if ($(this).val() === "custom") {
            $('#me_customEmailDomain').show().attr("required", true);
        } else {
            $('#me_customEmailDomain').hide().val("").removeAttr("required");
            $('#form').validate().element('#me_customEmailDomain'); // 기존의 에러 메시지 제거
        }
    });

    $.validator.addMethod('regex', function (value, element, regex) {
        var re = new RegExp(regex);
        return this.optional(element) || re.test(value);
    	}, "정규표현식을 확인하세요.");
</script>

<script type="text/javascript">
    // 아이디 중복 확인
    $("#id").keyup(function() {
        var id = $(this).val();
        var result = checkId(id);
        displayCheckId(result);
    });

    function checkId(id) {
        var regex = /^\w{4,10}$/;
        if (!regex.test(id)) {
            return -1;
        }
        var res = 0;
        $.ajax({
            async: false,
            url: '<c:url value="/check/id"/>',
            type: 'get',
            data: {
                id: id
            },
            success: function(data) {
                res = data ? 1 : 0;
            },
            error: function(jqXHR, textStatus, errorThrown) {
            }
        });
        return res;
    }

    function displayCheckId(result) {
        $('.form-group .error').not('#genderError').remove();

        if (result == 1) {
            var str = `<label id="check-id" class="id-ok error" style="color: green;">사용 가능한 아이디입니다.</label>`;
            $('#id').after(str);
        } else if (result == 0) {
            var str = `<label id="check-id" class="error" style="margin-bottom: 10px; color: red;">이미 사용중인 아이디입니다.</label>`;
            $('#id').after(str);
        }
    }
</script>

<script type="text/javascript">
    var debounceTimer; // 디바운스 타이머 변수

    // 이메일 입력란에서 입력할 때마다 중복 확인
    $("#me_emailId, #me_emailDomain, #me_customEmailDomain").on("input", function() {
        clearTimeout(debounceTimer); // 이전 타이머 제거

        debounceTimer = setTimeout(function() {
            var emailId = $("#me_emailId").val();
            var emailDomain = $("#me_emailDomain").val() === "custom" ? $("#me_customEmailDomain").val() : $("#me_emailDomain").val();
            
            // 이메일 입력란이 비어있으면 중복 체크하지 않고 종료
            if (!emailId || !emailDomain) {
                $('#check-email').remove(); // 기존의 중복 체크 메시지 제거
                return;
            }

            // 이메일 중복 체크
            var email = emailId + "@" + emailDomain;
            var result = checkEmail(email);
            displayCheckEmail(result);
        }, 500); // 500ms 후에 중복 체크 실행
    });

    function checkEmail(email) {
        var res = 0;
        $.ajax({
            async: false,
            url: '<c:url value="/check/email"/>',
            type: 'get',
            data: {
                email: email
            },
            success: function(data) {
                res = data ? 1 : 0;
            },
            error: function(jqXHR, textStatus, errorThrown) {
            }
        });
        return res;
    }

    function displayCheckEmail(result) {
        // 기존 에러 메시지 제거
        $('#check-email').remove();

        // 에러 메시지 생성
        var message;
        if (result == 1) {
            message = `<label id="check-email" class="email-ok error" style="color: green;">사용 가능한 이메일입니다.</label>`;
        } else if (result == 0) {
            message = `<label id="check-email" class="error" style="margin-bottom: 10px; color: red;">이미 사용중인 이메일입니다.</label>`;
        }
        
        // 이메일 입력란 아래에 에러 메시지 추가
        $('#me_emailId').closest('.form-group').append(message);
    }
</script>

<script type="text/javascript">
    function setPhoneNumber() {
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;

        // 전화번호 필드의 값 설정
        var fullPhoneNumber = phone1 + phone2 + phone3;
        document.getElementById('me_phone').value = fullPhoneNumber;
    }

    function combineEmail() {
        const emailId = document.getElementById("me_emailId").value;
        const emailDomain = document.getElementById("me_emailDomain").value === 'custom' ? 
                            document.getElementById("me_customEmailDomain").value : 
                            document.getElementById("me_emailDomain").value;
        
        // 이메일 필드 설정
        const emailField = document.createElement("input");
        emailField.setAttribute("type", "hidden");
        emailField.setAttribute("name", "me_email");
        emailField.setAttribute("value", emailId + "@" + emailDomain);
        document.getElementById("form").appendChild(emailField);
    }

    function onSubmitForm() {
        setPhoneNumber();  // 전화번호 설정
        combineEmail();    // 이메일 설정
        return true;       // 폼 제출 허용
    }
</script>

<script>
    function addressPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var postcode = data.zonecode;
                var address = data.roadAddress || data.jibunAddress;

                var extraAddress = ''; 
                if (data.bname !== '' && data.buildingName !== '') {
                    extraAddress = data.bname + ', ' + data.buildingName;
                } else if (data.bname !== '') {
                    extraAddress = data.bname;
                } else if (data.buildingName !== '') {
                    extraAddress = data.buildingName;
                }

                document.getElementById('me_postcode').value = postcode;
                document.getElementById('me_address').value = address;
                document.getElementById('me_extraAddress').value = extraAddress;

                document.getElementById('me_detailAddress').focus();
            }
        }).open();
    }
</script>

<script type="text/javascript">
    var isFormSubmitted = false;

    document.getElementById("form").addEventListener("submit", function() {
        isFormSubmitted = true;
    });

    // 페이지 이탈 시 경고창 표시
    window.addEventListener("beforeunload", function (event) {
        if (isFormSubmitted) return;        
        event.preventDefault();
        event.returnValue = ''; // 기본 경고 메시지 표시
    });

    // 마이페이지 클릭 시 경고창 해제
    document.querySelector(".gnb__link[href*='/mypage']").addEventListener("click", function() {
        window.removeEventListener("beforeunload", showBeforeUnloadWarning);
    });
</script>

</html>
