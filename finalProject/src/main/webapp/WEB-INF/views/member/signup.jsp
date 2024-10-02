<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
    .error {
        color: red; /* 에러 메시지를 빨간색으로 설정 */
    }
    .form-control {
        color: black; /* 입력창 글자를 검정색으로 설정 */
    }
</style>
</head>
<body>
    <h1>회원가입</h1>
    <form action="/signup" method="post" id="form">
        <div class="form-group">
            <label for="id">아이디:</label>
            <input type="text" class="form-control" id="id" name="me_id" required>
            <div id="check-id"></div>
        </div>
        <div class="form-group">
            <label for="pw">비밀번호:</label>
            <input type="password" class="form-control" id="pw" name="me_pw" required>
        </div>
        <div class="form-group">
            <label for="pw2">비밀번호 확인:</label>
            <input type="password" class="form-control" id="pw2" name="me_pw2" required>
        </div>
        <div class="form-group">
            <label for="email">이메일:</label>
            <input type="email" class="form-control" id="email" name="me_email" required>
        </div>
        <div class="form-group">
            <label for="gender">성별:</label>
            <select class="form-control" id="gender" name="me_gender">
                <option value="">선택하세요</option>
                <option value="M">남성</option>
                <option value="F">여성</option>
                <option value="O">기타</option>
            </select>
        </div>
        <div class="form-group" id="phoneGroup">
            <label for="phone">전화번호:</label>
            <div style="display: flex; align-items: center;">
                <input type="tel" class="form-control" id="phone1" maxlength="3" pattern="[0-9]{3}" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateFullPhone();" style="width: 80px; margin-right: 5px;">
                <span>-</span>
                <input type="tel" class="form-control" id="phone2" maxlength="4" pattern="[0-9]{4}" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateFullPhone();" style="width: 80px; margin-right: 5px;">
                <span>-</span>
                <input type="tel" class="form-control" id="phone3" maxlength="4" pattern="[0-9]{4}" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateFullPhone();" style="width: 80px;">
            </div>
            <small>형식: 000-0000-0000</small>
            <div id="phoneError" class="error" style="display: none;">전화번호를 모두 입력해주세요.</div>
            <input type="hidden" id="me_phone" name="me_phone">
        </div>
        <div class="form-group">
            <label for="age">나이:</label>
            <input type="text" class="form-control" id="age" name="me_age" min="1" max="120">
        </div>
        <button type="submit" class="btn btn-outline-success col-12">회원가입</button>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
    <script type="text/javascript">
        function updateFullPhone() {
            var phone1 = document.getElementById('phone1').value;
            var phone2 = document.getElementById('phone2').value;
            var phone3 = document.getElementById('phone3').value;

            // 전체 전화번호를 조합하여 숨겨진 필드에 저장
            var fullPhone = phone1 + (phone1 && phone2 ? '-' : '') + phone2 + (phone2 && phone3 ? '-' : '') + phone3;

            // 숨겨진 필드에 설정
            document.getElementById('me_phone').value = fullPhone;

            // 전화번호 입력란이 모두 채워지지 않은 경우 에러 메시지 표시
            if (phone1 === '' || phone2 === '' || phone3 === '') {
                document.getElementById('phoneError').style.display = 'block';
            } else {
                document.getElementById('phoneError').style.display = 'none';
            }
        }

        // jQuery Validate의 커스텀 regex 메소드 추가
        $.validator.addMethod("regex", function(value, element, regexpr) {          
            return regexpr.test(value);
        }, "형식에 맞지 않습니다.");

        $(document).ready(function() {
            $.extend($.validator.messages, {
                required: "필수 항목입니다.",
                email: "유효한 이메일 주소를 입력하세요.",
                number: "숫자만 입력 가능합니다.",
                equalTo: "비밀번호가 일치하지 않습니다."
            });
            
            $('#form').validate({
                rules: {
                    me_id: {
                        required: true,
                        regex: /^\w{4,10}$/  // 아이디: 4~10자
                    },
                    me_pw: {
                        required: true,
                        regex: /^[a-zA-Z0-9!@#$]{6,15}$/  // 비밀번호: 6~15자
                    },
                    me_pw2: {
                        equalTo: "#pw"  // 비밀번호 확인: 비밀번호와 동일한지 검사
                    },
                    me_email: {
                        required: true,
                        email: true  // 이메일 형식 검사
                    },
                    me_phone: {
                        required: true
                    },
                    me_age: {
                        required: true,
                        digits: true,  // 나이: 숫자만 허용
                        min: 1,
                        max: 120  // 나이 제한
                    }
                },
                messages: {
                    me_id: {
                        required: '필수 항목입니다.',
                        regex: '아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.' // 통합된 메시지
                    },
                    me_pw: {
                        required: '필수 항목입니다.',
                        regex: '비밀번호는 영어, 숫자, 특수문자(!@#$)만 가능하며, 6~15자이어야 합니다.'
                    },
                    me_pw2: {
                        required: '필수 항목입니다.',
                        equalTo: '비밀번호와 일치하지 않습니다.'
                    },
                    me_email: {
                        required: '필수 항목입니다.',
                        email: '이메일 형식이 아닙니다.'
                    },
                    me_phone: {
                        required: '필수 항목입니다.'
                    },
                    me_age: {
                        required: '필수 항목입니다.',
                        digits: '숫자만 입력 가능합니다.',
                        min: '유효한 나이를 입력하세요.',
                        max: '유효한 나이를 입력하세요.'
                    }
                },
                submitHandler: function(form) {
                    var id = $("#id").val();
                    if (id.length < 4) {
                        displayCheckId('아이디는 최소 4자 이상이어야 합니다.'); // 4자 미만일 경우
                        return false; // 제출 방지
                    }
                    $.ajax({
                        url: '/checkid',
                        type: 'get',
                        data: { id: id },
                        success: function(data) {
                            if (data) {
                                displayCheckId('사용할 수 없는 아이디입니다.'); // 중복된 아이디
                            } else {
                                displayCheckId('사용 가능한 아이디입니다.'); // 사용 가능한 아이디
                                form.submit(); // 사용 가능한 아이디, 제출
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            displayCheckId('아이디 확인 중 오류가 발생했습니다.'); // 오류 발생 시
                        }
                    });
                    return false; // 기본 제출 방지
                }
            });

            // 아이디 중복 확인
            $("#id").keyup(function() {
                var id = $(this).val();
                checkId(id);
            });

            function checkId(id) {
                var regex = /^\w{4,10}$/;
                if (!regex.test(id)) {
                    displayCheckId('아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.'); // 유효하지 않은 경우
                    return;
                }

                // 비동기 아이디 체크 로직
                $.ajax({
                    url: '/checkid',
                    type: 'get',
                    data: { id: id },
                    success: function(data) {
                        if (data) {
                            displayCheckId('사용할 수 없는 아이디입니다.'); // 중복된 아이디
                        } else {
                            displayCheckId('사용 가능한 아이디입니다.'); // 사용 가능한 아이디
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        displayCheckId('아이디 확인 중 오류가 발생했습니다.'); // 오류 발생 시
                    }
                });
            }

            function displayCheckId(message) {
                // 이전 메시지를 지우고 새로운 메시지만 표시
                $("#check-id").html('<span class="error">' + message + '</span>');
            }
        });
    </script>
</body>
</html>
