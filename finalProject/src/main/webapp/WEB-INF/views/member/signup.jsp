<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>회원가입</title>

<div class="login_prev_wrap">
	<a href="<c:url value='/'/>" class="login_prev">Return Home</a>
</div>

<section class="sub_content">
    <section class="sub_content_group">
    	<div class="sub_title_wrap">
			<h2 class="sub_title">회원가입</h2>
			<p class="sub_title__txt"/>
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
									 <input type="text" class="form-control" id="name" name="me_name" style="width: 250px; margin-right: 10px;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="id" class="_asterisk">아이디</label>
							</th>
							<td>
								<div class="form-group">
									 <input type="text" class="form-control" id="id" name="me_id" style="width: 250px; margin-right: 10px;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="pw" class="_asterisk">비밀번호</label>
							</th>
							<td>
								 <div class="form-group">
				                    <input type="password" class="form-control" id="pw" name="me_pw" style="width: 250px; margin-right: 10px;">
				                </div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="pw2" class="_asterisk">비밀번호 확인</label>
							</th>
							<td>
								<div class="form-group">
				                    <input type="password" class="form-control" id="pw2" name="me_pw2" style="width: 250px; margin-right: 10px;">
				                </div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="email" class="_asterisk">이메일</label>
							</th>
							<td>
								<div class="form-group">
									 <div style="display: flex; align-items: center;">
					                    <input type="text" class="form-control" id="me_emailId" name="me_emailId" placeholder="이메일 아이디" style="width: 250px; margin-right: 10px;">
					                    <span style="margin-right: 10px;">@</span>
					                    <select class="form-control" id="me_emailDomain" name="me_emailDomain" style="width: 300px; margin-right: 10px;">
					                        <option value="">선택</option>
					                        <option value="naver.com">naver.com</option>
					                        <option value="daum.net">daum.net</option>
					                        <option value="google.com">google.com</option>
					                        <option value="yahoo.com">yahoo.com</option>
					                        <option value="custom">직접 입력</option>
					                    </select>
					                    <input type="text" class="form-control" id="me_customEmailDomain" name="me_customEmailDomain" placeholder="도메인 직접 입력" style="display: none; flex: 4;">
					                </div>
					                <div id="email-error-container" style="margin-top: 5px; color: red;"></div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								 <label for="gender" style="display: block; margin-bottom: 8px;" class="_asterisk">성별</label>
							</th>
							<td>
								<div class="form-group">
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
					                <div id="gender-error-container" style="margin-top: 5px; color: red;"></div>
								</div>
							</td>
						</tr>
						<tr>
						    <th scope="row">
						        <label for="br_address" class="_asterisk">주소</label>
						    </th>
						    <td>
						        <div class="form-group">
						            <div style="display: flex; align-items: center; margin-bottom: 10px;">
						                <input type="text" class="form-control" id="me_postcode" name="me_postcode" placeholder="우편번호" style="width: 150px; margin-right: 10px;" readonly/>
						                <input class="btn btn-outline-dark" type="button" onclick="addressPostcode()" value="우편번호 찾기"/>
						            </div>
						            <input type="text" class="form-control" id="me_address" name="me_address" placeholder="주소" style="width: 450px; margin-right: 10px; margin-bottom: 10px;" readonly/>
						            <input type="text" class="form-control" id="me_detailAddress" name="me_detailAddress" placeholder="상세주소" style="width: 450px; margin-right: 10px; margin-bottom: 10px;"/>
						            <input type="text" class="form-control" id="me_extraAddress" name="me_extraAddress" placeholder="참고항목" style="width: 450px; margin-right: 10px; margin-bottom: 10px;" readonly/>
						        </div>
						    </td>
						</tr>
						<tr>
							<th scope="row">
								<label for="phone" class="_asterisk">전화번호</label>
							</th>
							<td>
								<div class="form-group">
									 <div style="display: flex; align-items: center; justify-content: flex-start; gap: 5px;">
									    <select class="form-control phone-select" id="phone1" name="phone1" style="width: 80px;">
									        <option value="010">010</option>
									        <option value="011">011</option>
									        <option value="016">016</option>
									        <option value="017">017</option>
									        <option value="018">018</option>
									        <option value="019">019</option>
									    </select>
									    <span style="margin: 0 5px; align-self: center;">-</span>
									    <input type="tel" class="form-control phone-input" id="phone2" name="phone2" maxlength="4" placeholder="0000" style="width: 80px;">
									    <span style="margin: 0 5px; align-self: center;">-</span>
									    <input type="tel" class="form-control phone-input" id="phone3" name="phone3" maxlength="4" placeholder="0000" style="width: 80px;">
									</div>
					                <input type="hidden" id="me_phone" name="me_phone">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="birth" class="_asterisk">생년월일</label>
							</th>
							<td>
								<div class="form-group">
									 <input type="date" class="form-control" id="birth" name="me_birth"
                   					  max="<%= java.time.LocalDate.now().minusYears(12) %>" min="<%= java.time.LocalDate.now().minusYears(100) %>"
                   					  style="width: 150px; margin-right: 10px;">
								</div>								
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_wrap">
					<div class="btn_right_wrap">
						<div class="btn_link_black">
							<button type="submit" class="btn btn_black js-btn-insert">
								<span>회원가입<i class="ic_link_share"></i></span>
							</button>
							<div class="btn_black_top_line"></div>
							<div class="btn_black_right_line"></div>
							<div class="btn_black_bottom_line"></div>
							<div class="btn_black_left_line"></div>
						</div>
					</div>
				</div>
			</form>
    	</div>
            
        <c:if test="${not empty errorMessage}">
            <div class="error" style="margin-bottom: 10px;">${errorMessage}</div>
        </c:if>
    </section>
</section>

<script type="text/javascript">
    document.getElementById("me_emailDomain").addEventListener("change", function() {
        var emailDomain = this.value;
        var customEmailField = document.getElementById("me_customEmailDomain");

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
    $('#form').validate({
        groups: {
            phoneGroup: "phone2 phone3"
        },
        rules: {
            me_name: {
                required: true
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
            me_emailDomain: {
                required: function() {
                    return $('#me_emailId').val() !== "";  // 이메일 아이디가 있을 때 도메인 필수
                }
            },
            me_customEmailDomain: {
                required: function () {
                    return $('#me_emailDomain').val() === "custom" && $('#me_emailId').val() !== ""; // custom 선택 시에만 필수
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
            me_name: { required: '필수 항목입니다.' },
            me_id: { required: '아이디를 입력해주세요.', regex: '아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.' },
            me_pw: { required: '필수 항목입니다.', regex: '비밀번호는 영어, 숫자, 특수문자(!@#$)만 가능하며, 4~15자이어야 합니다.' },
            me_pw2: { required: '필수 항목입니다.', equalTo: '비밀번호와 일치하지 않습니다.' },
            me_emailId: { required: '이메일을 입력해주세요.' },
            me_emailDomain: { required: '이메일 도메인을 선택해주세요.' },
            me_customEmailDomain: { required: '도메인을 직접 입력하세요.' },
            me_gender: { required: '성별을 선택해주세요.' },
            me_detailAddress: { required: '주소를 입력해주세요.' },
            phone2: { required: '전화번호를 입력해주세요.', minlength: '정확한 전화번호를 입력하여야 합니다.', maxlength: '정확한 전화번호를 입력하여야 합니다.' },
            phone3: { required: '전화번호를 입력해주세요.', minlength: '정확한 전화번호를 입력하여야 합니다.', maxlength: '정확한 전화번호를 입력하여야 합니다.' },
            me_birth: { required: '생년월일을 선택해주세요.' }
        },
        errorPlacement: function (error, element) {
            // 이메일 필드 전체 아래에 에러 메시지 표시
            if (element.attr("name") == "me_emailId" || element.attr("name") == "me_emailDomain" || element.attr("name") == "me_customEmailDomain") {
                // 기존 에러 메시지 제거 후 추가
                $("#email-error-container").empty().append(error).css("display", "block");
            }
            // 성별 선택 아래에 에러 메시지 표시
            else if (element.attr("name") == "me_gender") {
                error.appendTo("#gender-error-container").css("display", "block");
            }
            // 상세주소 필드가 포함된 주소 블록의 마지막 필드 아래에 에러 메시지 표시
            else if (element.attr("name") == "me_detailAddress") {
                error.insertAfter("#me_extraAddress");
            }
            // 전화번호 필드 아래에 에러 메시지 표시
            else if (element.attr("name") == "phone2" || element.attr("name") == "phone3") {
                error.insertAfter("#phone3");
            }
            // 그 외 필드는 기본적으로 입력란 바로 아래에 에러 메시지 표시
            else {
                error.insertAfter(element);
            }
        }
    });

    $.validator.addMethod('regex', function(value, element, regex){
        var re = new RegExp(regex);
        return this.optional(element) || re.test(value);
    }, "정규표현식을 확인하세요.");

    $('#me_emailDomain').change(function () {
        if ($(this).val() === "custom") {
            $('#me_customEmailDomain').show().attr("required", true);
        } else {
            $('#me_customEmailDomain').hide().val("").removeAttr("required");
        }
    });
</script>


<script type="text/javascript">
    function onSubmitForm() {
        setPhoneNumber();  // 전화번호만 결합
        return true;
    }

    function setPhoneNumber() {
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;
        document.getElementById('me_phone').value = phone1 + phone2 + phone3;
    }
</script>

<script>
    function addressPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var postcode = data.zonecode;
                var address = data.roadAddress || data.jibunAddress;
                var extraAddress = (data.bname !== '' && data.buildingName !== '') ? (data.bname + ', ' + data.buildingName) : (data.bname || data.buildingName || '');

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

    window.addEventListener("beforeunload", function (event) {
        if (!isFormSubmitted) {
            event.preventDefault();
            event.returnValue = '';
        }
    });

    document.querySelector(".gnb__link[href*='/mypage']").addEventListener("click", function() {
        window.removeEventListener("beforeunload", handleBeforeUnload);
    });
</script>

<script type="text/javascript">
    // 아이디 중복 확인 결과를 화면에 표시하는 함수
    function displayCheckId(result) {
        $('#check-id').remove(); // 기존 메시지 제거

        let str;
        if (result === 1) { // 사용 가능한 아이디인 경우
        } else if (result === 0) { // 이미 사용 중인 아이디인 경우
            str = `<label id="check-id" class="error">이미 사용중인 아이디입니다.</label>`;
        }
        if (str) $('#id').after(str); // 아이디 필드 바로 아래에 표시
    }

    // 이메일 중복 확인 결과를 화면에 표시하는 함수
    function displayCheckEmail(result) {
        $('#check-email').remove(); // 기존 메시지 제거

        let str;
        if (result === 1) { // 사용 가능한 이메일인 경우
        } else if (result === 0) { // 이미 사용 중인 이메일인 경우
            str = `<label id="check-email" class="error">이미 사용중인 이메일입니다.</label>`;
        }
        if (str) $('#email-error-container').append(str); // 이메일 오류 메시지를 #email-error-container에 표시
    }

    // 아이디 입력 감지 및 중복 확인
    $("#id").keyup(function() {
        const id = $(this).val();
        if (id) {
            const result = checkId(id);
            displayCheckId(result);
        } else {
            $('#check-id').remove(); // 값이 비어 있으면 메시지 제거
        }
    });

    function checkId(id) {
        if (!/^\w{4,10}$/.test(id)) return -1; // 정규표현식 확인
        let res = 0;
        $.ajax({
            async: false,
            url: '<c:url value="/check/id"/>',
            type: 'get',
            data: { id: id },
            success: function(data) {
                res = data ? 1 : 0;
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX 요청 실패:", textStatus, errorThrown);
            }
        });
        return res;
    }

    // 이메일 입력 감지 및 중복 확인
    $("#me_emailId, #me_emailDomain, #me_customEmailDomain").on("keyup change", function() {
        const emailId = $("#me_emailId").val();
        const emailDomain = $("#me_emailDomain").val() === 'custom' ? 
                            $("#me_customEmailDomain").val() : 
                            $("#me_emailDomain").val();

        if (emailId && emailDomain) {
            const email = emailId + "@" + emailDomain;
            checkEmail(email); // 이메일이 완성되었을 때 중복 검사 실행
        } else {
            $('#check-email').remove(); // 값이 비어 있으면 메시지 제거
        }
    });

    function checkEmail(email) {
        $.ajax({
            async: true,
            url: '<c:url value="/check/email"/>',
            type: 'get',
            data: { email: email },
            success: function(data) {
                displayCheckEmail(data ? 1 : 0); // 서버에서 true/false 반환
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX 요청 실패:", textStatus, errorThrown);
                alert("중복 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
</script>

</html>
