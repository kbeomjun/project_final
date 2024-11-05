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
    		<div class="text_small text-right mb10"><span class="color_red"></span>아래 항목들은필수 기재 항목 입니다.</div>
    		<form action="<c:url value='/signup'/>" method="post" id="form" onsubmit="return onSubmitForm()">
				<table class="table">
					<colgroup>
						<col style="width: 20%;">
						<col style="width: 80%;">
					</colgroup>
					
					<tbody>
						<tr>
							<th scope="row">
								<label for="name" class="form-label">이름</label>
							</th>
							<td>
								<div class="form-group">
                            		<input type="text" class="form-control" id="name" name="user_name" placeholder="이름을 입력하세요" style="width: 450px; margin-right: 10px;">
                            	</div>
                        	</td>
                        </tr>
                        <tr>
							<th scope="row">
								<label for="email" class="form-label">이메일</label>
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
	
	        // 서버로 아이디 찾기 요청
	        $.ajax({
	            async: true, // 비동기 방식으로 요청 (기본값)
	            url: '<c:url value="/find/id"/>', // 아이디 찾기 URL로 POST 요청 전송
	            type: 'post',
	            data: { me_name: name, me_email: email }, // 서버로 전송할 데이터 (이름과 이메일)
	            dataType: 'json', // 서버로부터의 응답 형식 지정 (JSON)
	            success: function (data) {
	                console.log("서버 응답 데이터: ", data); // 서버 응답 데이터 콘솔에 출력
	                $('.modal-container').remove(); // 로딩 모달 제거
	                
	                if (data && data.success) {
	                    // 서버가 응답한 결과가 성공일 경우
	                    console.log("아이디 찾기 성공"); // 성공 로그 출력
	                    alert("아이디가 전송됐습니다."); // 성공 알림창
	                } else {
	                    // 서버가 응답한 결과가 실패일 경우
	                    console.log("아이디 찾기 실패: 잘못된 이름 또는 이메일"); // 실패 로그 출력
	                    alert("잘못된 이름 또는 이메일입니다.");
	                }
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                console.error("AJAX 요청 실패: ", textStatus, errorThrown); // 에러 메시지 콘솔에 출력
	                $('.modal-container').remove(); // 로딩 모달 제거
	                alert("아이디 찾기에 실패했습니다."); // 사용자에게 실패 메시지 표시
	            }
	        });
	    });
	
	    // 로그인 페이지로 이동 버튼 클릭 이벤트
	    $('.btn-go-login').click(function () {
	        window.location.href = '<c:url value="/login"/>'; // 로그인 페이지로 이동
	    });
	});
</script>
</html>
