<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>

    <!-- Bootstrap CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style type="text/css">
        .modal-container {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1050;
        }

        .modal-email {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .modal-email .spinner-border {
            width: 3rem;
            height: 3rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg">
                    <div class="card-header bg-success text-white text-center">
                        <h2>비밀번호 찾기</h2>
                    </div>
                    <div class="card-body box-find-pw">
                        <div class="form-group mb-3">
                            <label for="id" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="id" name="me_id" placeholder="아이디를 입력하세요">
                        </div>
                        <div class="form-group mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" name="me_email" placeholder="이메일을 입력하세요">
                        </div>
                        <div class="form-group mb-3">
                            <label for="phone" class="form-label">전화번호</label>
                            <input type="text" class="form-control" id="phone" name="me_phone" placeholder="전화번호를 입력하세요">
                        </div>
                        <button type="button" class="btn btn-outline-success w-100 btn-find-pw mb-3">비밀번호 찾기</button>
                        <button type="button" class="btn btn-outline-success w-100 btn-go-login">로그인 페이지로</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.btn-find-pw').click(function () {
                var id = $('#id').val();
                var email = $('#email').val();
                var phone = $('#phone').val();

                if (id === '' || email === '' || phone === '') {
                    alert('아이디, 이메일, 전화번호를 모두 입력하세요.');
                    return;
                }

                // 로딩 모달 표시
                var str = `
                    <div class="modal-container">
                        <div class="modal-email">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-3">이메일 전송 중입니다. 잠시만 기다려주세요.</p>
                        </div>
                    </div>
                `;
                $('body').append(str);

                var res = false;
                setTimeout(() => {
                    $.ajax({
                        async: false,
                        url: '<c:url value="/find/pw"/>',
                        type: 'post',
                        data: { id: id, email: email, phone: phone },
                        success: function (data) {
                            res = data;
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.error(jqXHR, textStatus, errorThrown);
                        }
                    });

                    $('.modal-container').remove();
                    if (res) {
                        alert("비밀번호가 전송됐습니다.");
                    } else {
                        alert("비밀번호 찾기에 실패했습니다.");
                    }
                }, 100);
            });

            // 로그인 페이지로 이동 버튼 클릭 이벤트
            $('.btn-go-login').click(function () {
                window.location.href = '<c:url value="/login"/>';
            });
        });
    </script>
</body>
</html>
