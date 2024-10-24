<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
<style type="text/css">
	.error{color:red; margin-bottom: 10px;}
	.form-group{margin: 0;}
	.form-control, .address-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
	.address-input{margin-bottom: 10px;}
	.sns-accounts {
    display: flex;
    gap: 15px; /* 요소 간의 간격 */
    align-items: center; /* 수직 정렬 */
}

.sns-account {
    display: flex;
    align-items: center; /* 각 아이콘과 버튼의 수직 정렬 */
}
.btn-sns-unlink {
    width: 40px;
    height: 30px;
    border: 1px solid #bcbfc6;
    color: gray;
    background-color: #fafbf6;
    background-image: linear-gradient(to bottom, #fff, #f1f1f1);
    border-radius: 4px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 0;
    line-height: 29px; /* 텍스트가 중앙에 오도록 설정 */
    font-size: 12px; /* 텍스트 크기 조정 */
}

.btn-sns-unlink:hover {
    background-color: #f5f6f2;
    background-image: linear-gradient(to bottom, #fefefe, #f2f2f2);
    border-color: #a8b1b8;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    color: #555;
}

.btn-sns-unlink:active {
    background-color: #e8e9e5;
    background-image: linear-gradient(to bottom, #f0f0f0, #e2e3de);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
    border-color: #9ca3ab;
    transform: translateY(1px);
}
</style>
</head>
<body>
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>개인정보수정</h2>
	                
					<form action="<c:url value='/mypage/info/update'/>" method="post" id="form">
				        <div class="form-group">
				            <label for="me_id">아이디:</label>
				            <input type="text" class="form-control" name="me_id" value="${member.me_id}" readonly>
				        </div>		
			        	<c:if test="${member.me_naverUserId ne null || member.me_kakaoUserId ne null}">
					        <div class="form-group sns">
							    <label for="me_social">연동된 SNS:</label>
							    <div class="sns-accounts">
							    	<c:if test="${member.me_naverUserId ne null}">
								        <div class="sns-account">
											<img src="<c:url value='/resources/image/naver/logo_naver.png'/>" class="naver-icon" width="30"/>
								            <a class="btn btn-sns-unlink ml-1" data-type="NAVER">
								                <span>해제</span>
								            </a>
								        </div>
							    	</c:if>
							    	<c:if test="${member.me_kakaoUserId ne null}">
								        <div class="sns-account">
								            <img src="<c:url value='/resources/image/kakao/kakaotalk_sharing_btn_small.png'/>" class="kakao-icon" width="30"/>
								            <a class="btn btn-sns-unlink ml-1" data-type="KAKAO">
								                <span>해제</span>
								            </a>
								        </div>
							        </c:if>
							    </div>
							</div>
						</c:if>
						<div class="form-group">
							<label for="me_email">이메일:</label>
							<input type="email" class="form-control" id="me_email" name="me_email" value="${member.me_email}">
							<div id="emailCheckResult" class="error"></div>
						</div>
						<div class="error error-email"></div>
						<div class="form-group">
							<label for="me_name">이름:</label>
							<input type="text" class="form-control" id="me_name" name="me_name" value="${member.me_name}">
						</div>
						<div class="error error-name"></div>
						<div class="form-group">
							<label for="me_phone">전화번호:</label>
							<input type="text" class="form-control" id="me_phone" name="me_phone" value="${member.me_phone}">
						</div>
						<div class="error error-phone"></div>
						<div class="form-group">
							<label for="me_gender" style="margin-right: 10px;">성별:</label>
							<div class="form-check-inline">
				  				<label class="form-check-label" for="radio1">
				    				<input type="radio" class="form-check-input" id="radio1" name="me_gender" value="남자" <c:if test='${member.me_gender == "남자"}'>checked</c:if>>남
				  				</label>
							</div>
							<div class="form-check-inline">
				  				<label class="form-check-label" for="radio2">
				   			 		<input type="radio" class="form-check-input" id="radio2" name="me_gender" value="여자" <c:if test='${member.me_gender == "여자"}'>checked</c:if>>여
				  				</label>
							</div>	
						</div>
						<div class="error error-gender"></div>
						<div class="form-group">
							<label for="me_birth" style="margin-right: 10px;">생년월일:</label>
							<input type="date" id="me_birth" name="birth" value="<fmt:formatDate value='${member.me_birth}' pattern='yyyy-MM-dd'/>">
						</div>
						<div class="form-group">
							<label for="me_address">주소:</label> <br/>
							<input type="text" class="address-input" id="me_postcode" name="me_postcode" placeholder="우편번호" style="width:130px;" value="${member.me_postcode}">
							<input class="btn btn-outline-dark" onclick="addressPostcode()" value="우편번호 찾기" style="width:130px; margin-bottom:5px;"> <br/>
							<input type="text" class="address-input" id="me_address" name="me_address" placeholder="주소" style="width:100%;" value="${member.me_address}"> <br/>
							<input type="text" class="address-input" id="me_detailAddress" name="me_detailAddress" placeholder="상세주소" style="width:60%; margin-bottom: 0;" value="${member.me_detailAddress}">
							<input type="text" class="address-input" id="me_extraAddress" name="me_extraAddress" placeholder="참고항목" style="width:39.36%; margin-bottom: 0;" value="${member.me_extraAddress}">
						</div>
						<div class="error error-address"></div>			
						<div class="form-group">
							<label for="me_noshow">노쇼경고횟수:</label>
							<input type="text" class="form-control" id="me_noshow" value="${member.me_noshow}" readonly>
						</div>
						<c:if test="${member.me_noshow >= 5}">
							<div class="form-group">
								<label for="me_cancel">노쇼제한시간:</label>
								<input type="text" class="form-control" id="me_cancel" value="<fmt:formatDate value='${member.me_cancel}' pattern='yyyy/MM/dd HH:mm:ss' />" readonly>
							</div>
						</c:if>
			
			
						<div class="text-right mb-3">
							<button type="submit" class="btn btn-outline-warning mt-3">개인정보 수정</button>
						</div>
					</form>	                
	                
	            </div>
	        </main>
	    </div>
	</div>

	<script type="text/javascript">
		let emailCheckPassed = true;
		
		//이메일 중복 체크
	    $('#me_email').on('keyup', function() {
	        var email = $(this).val();
	        var id = '${member.me_id}';
	        let regexEmail = /^\w{4,13}@\w{4,8}\.[a-z]{2,3}$/;
	        
	        // 이메일이 비어있는 경우 체크하지 않음
	        if (email == '') {
	            $('#emailCheckResult').html('');
	            emailCheckPassed = false;
	            return;
	        }
	        
	        // 이메일 형식 체크
	        if (!regexEmail.test(email)) {
	            $('#emailCheckResult').html('<span style="color: red;">이메일 형식이 올바르지 않습니다.</span>');
	            emailCheckPassed = false;
	            return;
	        } else {
	            $('#emailCheckResult').html('<span style="color: green;">올바른 이메일 형식입니다. 중복 확인 중...</span>');
			
		        $.ajax({
		        	async : true,
		        	url : '<c:url value="/mypage/checkEmail"/>', 
		        	type : 'post', 
		        	data : {
		        		id : id,
		        		email : email
		        		},
		        	dataType : "json",
		        	success : function (data){
		                if (data) {
		                    $('#emailCheckResult').html('<span style="color: red;">이미 사용 중인 이메일입니다.</span>');
		                    emailCheckPassed = false;
		                } else {
		                    $('#emailCheckResult').html('<span style="color: green;">사용 가능한 이메일입니다.</span>');
		                    emailCheckPassed = true;
		                }
		        	}, 
		        	error : function(jqXHR, textStatus, errorThrown){
						console.log(jqXHR);
		        	}
		        });
	        }
	    });
		
		$('#me_phone').on('input', function () {
		    // 입력값에서 숫자만 남기고 모두 제거
		    let inputVal = $(this).val().replace(/[^0-9]/g, '');
		    $(this).val(inputVal);
		});
	</script>

   <script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		let msgEmailCheck = `<span>이메일 중복 확인을 해주세요.</span>`;
		let msgRegexPhone = `<span>올바른 전화번호 형식을 입력하세요.</span>`;
		let regexPhone = /^01[016789]\d{3,4}\d{4}$/;
		
		$('#me_email').keyup(function(){
			$('.error-email').children().remove();
			
			if($('#me_email').val() == ''){
				$('.error-email').append(msgRequired);
			}else{
				$('.error-email').children().remove();	
			}
		});
		
		$('#me_name').keyup(function(){
			$('.error-name').children().remove();
			
			if($('#me_name').val() == ''){
				$('.error-name').append(msgRequired);
			}else{
				$('.error-name').children().remove();	
			}
		});
		
		$('#me_phone').keyup(function(){
			$('.error-phone').children().remove();
			
			if($('#me_phone').val() == ''){
				$('.error-phone').append(msgRequired);
			}else{
				if(!regexPhone.test($('#me_phone').val())){
					$('.error-phone').append(msgRegexPhone);
				}else{
					$('.error-phone').children().remove();	
				}
			}
		});
		
		$('#me_detailAddress').keyup(function(){
			$('.error-address').children().remove();
			
			if($('#me_address').val() == '' || $('#me_detailAddress').val() == ''){
				$('.error-address').append(msgRequired);
			}else{
				$('.error-address').children().remove();	
			}
		});
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
		    if (!emailCheckPassed) {
				$('.error-email').append(msgEmailCheck);
				$('#me_email').focus();
		        flag = false;
		    }
		    
			if($('#me_name').val() == ''){
				$('.error-name').append(msgRequired);
				$('#me_name').focus();
				flag = false;
			}
			
			if($('#me_phone').val() == ''){
				$('.error-phone').append(msgRequired);
				$('#me_phone').focus();
				flag = false;
			} else if(!regexPhone.test($('#me_phone').val())){
				$('.error-phone').append(msgRegexPhone);
				$('#me_phone').focus();
				flag = false;
			}
			
			if($('input[name=me_gender]:checked').val() == null){
				$('.error-gender').append(msgRequired);
				$('#me_gender').focus();
				flag = false;
			}
			
			if($('#me_address').val() == '' || $('#me_detailAddress').val() == ''){
				$('.error-address').append(msgRequired);
				$('#me_detailAddress').focus();
				flag = false;
			}
			
			return flag;
		});
    </script>
    
    <script type="text/javascript">
    	// 주소 api
	    function addressPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("me_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("me_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('me_postcode').value = data.zonecode;
	                document.getElementById("me_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("me_detailAddress").focus();
	            }
	        }).open();
	    }
    </script>
	<script>
    $(document).ready(function() {
        $('.btn-sns-unlink').on('click', function(event) {
            event.preventDefault();
            
            var socialType = $(this).data('type');
            
            $.ajax({
                url: '<c:url value="/mypage/unlinkSNS"/>', // 서버의 URL을 여기에 지정
                type: 'POST',
                data: {
                    socialType: socialType
                },
                success: function(response) {
                    if (response) {
                        alert('SNS 계정이 성공적으로 해제되었습니다.');
                        $('.btn-sns-unlink[data-type="' + socialType + '"]').closest('.sns-account').remove();
                     	// 연동된 계정이 없으면 전체 섹션 숨기기
                        if ($('.sns-account').length === 0) {
                            $('.form-group.sns').remove();
                        }
                    } else {
                        alert('SNS 계정 해제에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('SNS 계정 해제 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>
</body>
</html>
