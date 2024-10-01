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
        body {
            background-color: #f0f0f0; /* 밝은 회색 배경 색 */
            padding-top: 100px; /* 헤더와의 간격 */
            padding-bottom: 100px; /* 푸터와의 간격 */
            padding-left: 20px; /* 좌측 여백 */
            padding-right: 20px; /* 우측 여백 */
        }
        h1 {
            margin-top: 60px; /* h1의 상단 여백을 추가하여 헤더와 간격을 유지 */
            text-align: center; /* h1을 가운데 정렬 */
        }
        .card {
            margin: auto; /* 카드 중앙 정렬 */
            width: 90%; /* 카드 너비 */
            max-width: 600px; /* 카드 최대 너비를 증가 */
            padding: 20px; /* 카드 내부 여백 추가 */
            border-radius: 10px; /* 카드 모서리 둥글게 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 카드 그림자 추가 */
            background-color: white; /* 카드 배경 색을 흰색으로 설정 */
        }
        .form-group {
            margin-bottom: 20px; /* 입력창 간격 추가 */
        }
        .age-group {
            display: flex; /* flexbox를 사용하여 나이 태그와 입력창을 나란히 배치 */
            align-items: center; /* 세로 정렬 */
        }
        #age {
            width: 80px; /* 나이 입력칸을 좁게 설정 */
            margin-left: 10px; /* 태그와 입력창 간격 조정 */
        }
    </style>
</head>
<body>
    <h1>회원가입</h1>
    <div class="card">
        <form action="<c:url value='/signup'/>" method="post" id="form" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="id">아이디:</label>
                <input type="text" class="form-control" id="id" name="me_id" required>
                <div id="idError" class="error" style="display: none;">필수 입력 사항입니다</div>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호:</label>
                <input type="password" class="form-control" id="pw" name="me_pw" required>
                <div id="pwError" class="error" style="display: none;">필수 입력 사항입니다</div>
            </div>
            <div class="form-group">
                <label for="pw2">비밀번호 확인:</label>
                <input type="password" class="form-control" id="pw2" name="me_pw2" required>
                <div id="pw2Error" class="error" style="display: none;">필수 입력 사항입니다</div>
            </div>
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" class="form-control" id="email" name="me_email" required>
                <div id="emailError" class="error" style="display: none;">필수 입력 사항입니다</div>
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
            <div class="form-group">
                <label for="address">주소:</label>
                <input type="text" class="form-control" id="address" name="me_address" required>
                <div id="addressError" class="error" style="display: none;">필수 입력 사항입니다</div>
            </div>
            <div class="form-group" id="phoneGroup">
                <label for="phone">전화번호:</label>
                <div style="display: flex; align-items: center;">
                    <input type="tel" class="form-control" id="phone1" maxlength="3" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateFullPhone();" style="width: 80px; margin-right: 5px;">
                    <span>-</span>
                    <input type="tel" class="form-control" id="phone2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateFullPhone();" style="width: 80px; margin-right: 5px;">
                    <span>-</span>
                    <input type="tel" class="form-control" id="phone3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, ''); updateFullPhone();" style="width: 80px;">
                </div>
                <small>형식: 000-0000-0000</small>
                <div id="phoneError" class="error" style="display: none;">전화번호를 모두 입력해주세요.</div>
                <input type="hidden" id="me_phone" name="me_phone">
            </div>
            <div class="form-group age-group">
                <label for="age">나이:</label>
                <input type="text" class="form-control" id="age" name="me_age" min="1" max="120">
            </div>
            <button type="submit" class="btn btn-outline-success col-12">회원가입</button>
        </form>
        <!-- 에러 메시지 표시 부분 -->
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    </script>
</body>
</html>
