<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>비밀번호 찾기</title>

<body>
	<section class="sub_content">
	    <section class="sub_content_group">
	    	<div class="sub_title_wrap">
				<h2 class="sub_title">비밀번호 찾기</h2>
				<p class="sub_title__txt">비밀번호를 잊어버리셨나요?</p>
			</div>
		
			<div class="table-warp">
    		<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
    		<form action="<c:url value='/signup'/>" method="post" id="form" onsubmit="return onSubmitForm()">
				<table class="table">
					<colgroup>
						<col style="width: 20%;">
						<col style="width: 80%;">
					</colgroup>
					
					<tbody>
						<tr>
							<th scope="row">
								<label for="id" class="form-label" class="_asterisk">아이디</label>
							</th>
							<td>
								<div class="form-group">
                            		<input type="text" class="form-control" id="id" name="me_id" placeholder="아이디를 입력하세요" style="width: 450px; margin-right: 10px;">
                            	</div>
                        	</td>
                        </tr>
                        <tr>
							<th scope="row">
								<label for="email" class="form-label" class="_asterisk">이메일</label>
							</th>
							<td>
								<div class="form-group">
                            		 <input type="email" class="form-control" id="email" name="user_email" placeholder="이메일을 입력하세요" style="width: 450px; margin-right: 10px;">
                            	</div>
                        	</td>
                        </tr>
                    </tbody>
                </table>
                <div class="btn_wrap">
					<div class="btn_right_wrap">
						<div class="btn_link_black">
                   	 		<div class="d-flex justify-content-between" style="gap: 10px;">
							    <button type="button" class="btn btn-dark btn-find-pw">비밀번호 찾기</button>
							    <button type="button" class="btn btn-dark btn-go-login">로그인 페이지로</button>
							</div>
                   	 	</div>
                   	 </div>
                 </div>
            </form>
            </div>
        </section>
    </section>          
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $('.btn-find-pw').click(function () {
            var id = $('#id').val();
            var email = $('#email').val();

            if (id === '' || email === '') {
                alert('아이디와 이메일을 모두 입력하세요.');
                return;
            }

            // 로딩 모달 표시
            var str = `
                <div class="modal-container">
                    <div class="modal-email">
                        <div class="spinner-border text-primary" role="status"></div>
                        <p class="mt-2">Loading...</p> <!-- 로딩 아이콘 아래에 텍스트 추가 -->
                        <p class="mt-3">이메일 전송 중입니다. 잠시만 기다려주세요.</p>
                    </div>
                </div>
            `;
            $('body').append(str);

            setTimeout(() => {
                $.ajax({
                    url: '<c:url value="/find/pw"/>',
                    type: 'post',
                    data: { id: id, email: email },
                    success: function (data) {
                        $('.modal-container').remove();
                        if (data === 'not_found') {
                            alert("등록된 사용자가 아닙니다, 아이디 또는 이메일을 확인해주세요");
                        } else if (data === 'error') {
                            alert("오류가 발생했습니다. 다시 시도해 주세요.");
                        } else {
                            alert("임시 비밀번호가 전송됐습니다.");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('.modal-container').remove();
                        if (jqXHR.status === 404) {
                            alert("등록된 사용자가 없습니다.");
                        } else {
                            alert("오류가 발생했습니다. 다시 시도해 주세요.");
                        }
                        console.error(jqXHR, textStatus, errorThrown);
                    }
                });
            }, 100);
        });

        // 로그인 페이지로 이동 버튼 클릭 이벤트
        $('.btn-go-login').click(function () {
            window.location.href = '<c:url value="/login"/>';
        });
    });
</script>
</html>
