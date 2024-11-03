<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이용 약관</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 150px; /* 헤더와의 간격을 150px로 설정 */
            padding-bottom: 50px; /* 푸터와의 간격 */
        }
        h1 {
            margin-bottom: 30px; /* h1과 그 아래 요소 사이에 30px의 여백을 추가 */
        }
        h3 {
            margin-top: 20px; /* h3 태그 위에 20px의 여백을 추가 */
            margin-bottom: 15px; /* h3 태그 아래에 15px의 여백을 추가 */
        }
        .term-box {
            height: 200px; /* 약관 박스 높이 */
            overflow-y: auto; /* 스크롤 가능 */
            border: 1px solid #ced4da; /* 테두리 */
            border-radius: 0.25rem; /* 테두리 둥글기 */
            background-color: #f8f9fa; /* 배경색 */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">이용 약관</h1>

        <!-- 소제목과 내용 -->
        <h3>이용 약관 1</h3>
        <div class="term-box p-3 mb-4">
            <p>여기에 이용 약관 1의 내용을 넣습니다...</p>
        </div>
        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" id="agreeTerms1" onclick="checkAllSelected()">
            <label class="form-check-label" for="agreeTerms1">이용 약관 1에 동의합니다.</label>
        </div>

        <!-- 소제목과 내용 -->
        <h3>이용 약관 2</h3>
        <div class="term-box p-3 mb-4">
            <p>여기에 이용 약관 2의 내용을 넣습니다...</p>
        </div>
        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" id="agreeTerms2" onclick="checkAllSelected()">
            <label class="form-check-label" for="agreeTerms2">이용 약관 2에 동의합니다.</label>
        </div>

        <!-- 소제목과 내용 -->
        <h3>이용 약관 3</h3>
        <div class="term-box p-3 mb-4">
            <p>여기에 이용 약관 3의 내용을 넣습니다...</p>
        </div>
        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" id="agreeTerms3" onclick="checkAllSelected()">
            <label class="form-check-label" for="agreeTerms3">이용 약관 3에 동의합니다.</label>
        </div>

        <!-- 모두 동의 체크박스를 다음 버튼 위에 배치 -->
        <form action="<c:url value='/signup'/>" method="get" onsubmit="return validateForm();">
            <div class="d-flex justify-content-end mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="agreeAll" onclick="toggleAllCheckboxes(this)">
                    <label class="form-check-label" for="agreeAll">모두 동의합니다.</label>
                </div>
            </div>
            
            <!-- 다음 버튼을 오른쪽 끝에 배치 -->
            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-success mt-3">다음</button>
            </div>
        </form>
    </div>

    <script>
        // 모두 동의 체크박스를 클릭했을 때
        function toggleAllCheckboxes(checkbox) {
            const checked = checkbox.checked;
            document.getElementById('agreeTerms1').checked = checked;
            document.getElementById('agreeTerms2').checked = checked;
            document.getElementById('agreeTerms3').checked = checked;
        }

        // 개별 체크박스를 클릭했을 때 모두 동의 체크 여부 확인
        function checkAllSelected() {
            const allChecked = document.getElementById('agreeTerms1').checked &&
                               document.getElementById('agreeTerms2').checked &&
                               document.getElementById('agreeTerms3').checked;
            document.getElementById('agreeAll').checked = allChecked;
        }

        // 모든 약관 동의 검증
        function validateForm() {
            const agreeTerms1 = document.getElementById('agreeTerms1').checked;
            const agreeTerms2 = document.getElementById('agreeTerms2').checked;
            const agreeTerms3 = document.getElementById('agreeTerms3').checked;

            if (!agreeTerms1 || !agreeTerms2 || !agreeTerms3) {
                let message = '모든 약관에 동의해야 회원가입을 진행할 수 있습니다.';
                
                if (!agreeTerms1) {
                    message += '\n- 이용 약관 1에 동의하지 않았습니다.';
                }
                if (!agreeTerms2) {
                    message += '\n- 이용 약관 2에 동의하지 않았습니다.';
                }
                if (!agreeTerms3) {
                    message += '\n- 이용 약관 3에 동의하지 않았습니다.';
                }
                
                alert(message);
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
