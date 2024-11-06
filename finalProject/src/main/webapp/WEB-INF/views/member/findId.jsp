<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>아이디 찾기</title>

<body>
	<section class="sub_content">
	    <section class="sub_content_group">
	    	<div class="sub_title_wrap">
				<h2 class="sub_title">아이디 찾기</h2>
				<p class="sub_title__txt">아이디를 잊어버리셨나요?</p>
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
								<label for="name" class="_asterisk">이름</label>
							</th>
							<td>
								<div class="form-group">
                            		<input type="text" class="form-control" id="name" name="user_name" placeholder="이름을 입력하세요" style="width: 450px; margin-right: 10px;">
                            	</div>
                        	</td>
                        </tr>
                        <tr>
							<th scope="row">
								<label for="email" class="_asterisk">이메일</label>
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
							    <button type="button" class="btn btn-dark btn-find-id">아이디 찾기</button>
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
        // 아이디 찾기 버튼 클릭 이벤트
        $('.btn-find-id').click(function () {
            var name = $('#name').val();
            var email = $('#email').val();
    
            // 이름과 이메일 입력값이 비어있는지 확인
            if (name === '' || email === '') {
                alert('이름과 이메일을 모두 입력하세요.');
                return;
            }

            // 서버로 아이디 찾기 요청
            $.ajax({
                async: true,
                url: '<c:url value="/find/id"/>',
                type: 'post',
                data: { me_name: name, me_email: email },
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: 'json',
                success: function (data) {
                    $('.modal-container').remove(); // 로딩 모달 제거
                    
                    if (data && data.success && data.username) {
                        // 아이디 찾기 성공 시 팝업 창 표시
                        var userId = data.username;
                        console.log("받은 아이디: ", userId); // 받은 아이디를 확인하기 위한 로그
                        
                        // 팝업 생성
                        var popupContainer = document.createElement("div");
                        popupContainer.className = "popup-container";

                        var popupContent = document.createElement("div");
                        popupContent.className = "popup-content";

                        var popupText = document.createElement("p");
                        popupText.style.fontSize = "18px";
                        popupText.innerHTML = "회원님 아이디는 <strong>" + userId + "</strong>입니다.";

                        var closeButton = document.createElement("button");
                        closeButton.className = "popup-close-btn";
                        closeButton.innerText = "닫기";
                        closeButton.onclick = function () {
                            document.body.removeChild(popupContainer);
                        };

                        popupContent.appendChild(popupText);
                        popupContent.appendChild(closeButton);
                        popupContainer.appendChild(popupContent);
                        document.body.appendChild(popupContainer);
                        
                    } else {
                        console.log("아이디 찾기 실패: 잘못된 이름 또는 이메일");
                        alert("잘못된 이름 또는 이메일입니다.");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $('.modal-container').remove(); // 로딩 모달 제거
                    console.error("AJAX 요청 실패: ", textStatus, errorThrown);
                    alert("아이디 찾기에 실패했습니다.");
                }
            });
        });
    
        // 로그인 페이지로 이동 버튼 클릭 이벤트
        $('.btn-go-login').click(function () {
            window.location.href = '<c:url value="/login"/>';
        });
    });
</script>

</html>
