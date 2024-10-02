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
            color: red;
        }
        .form-control {
            color: black;
        }
        body {
            background-color: #f0f0f0;
            padding: 100px 20px; /* 상하 100px, 좌우 20px 간격 */
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
        .age-group {
            display: flex;
            align-items: center;
        }
        #age {
            width: 80px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h1>회원가입</h1>
    <div class="card">
        <form action="<c:url value='/signup'/>" method="post" id="form" onsubmit="return validateForm()">
        	<div class="form-group">
                <label for="name">이름:</label>
                <input type="text" class="form-control" id="name" name="me_name" required>
                <div id="nameError" class="error" style="display: none;">필수 입력 사항입니다</div>
            </div>
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
            </div>
            <div class="form-group">
                <label for="gender">성별:</label>
                <select class="form-control" id="gender" name="me_gender">
                    <option value="">선택없음</option>
                    <option value="남자">남성</option>
                    <option value="여자">여성</option>
                </select>
            </div>
            <div class="form-group">
			    <label for="br_address">주소:</label>
			    <div style="display: flex; align-items: center;">
			        <input type="text" class="form-control" id="me_postcode" name="me_postcode" placeholder="우편번호" style="width: 150px; margin-right: 10px;" required/>
			        <input class="btn btn-outline-dark" type="button" onclick="addressPostcode()" value="우편번호 찾기"/>
			    </div>
			    <br/>
			    <input type="text" class="form-control" id="me_address" name="me_address" placeholder="주소" required/>
			    <br/>
			    <input type="text" class="form-control" id="me_detailAddress" name="me_detailAddress" placeholder="상세주소" required/>
			    <br/>
			    <input type="text" class="form-control" id="me_extraAddress" name="me_extraAddress" placeholder="참고항목"/>
			</div>
            <div class="form-group" id="phoneGroup">
                <label for="phone">전화번호:</label>
                <div style="display: flex; align-items: center;">
                    <input type="tel" class="form-control" id="phone1" maxlength="3" placeholder="000" required>
                    <span>-</span>
                    <input type="tel" class="form-control" id="phone2" maxlength="4" placeholder="0000" required>
                    <span>-</span>
                    <input type="tel" class="form-control" id="phone3" maxlength="4" placeholder="0000" required>
                </div>
                <input type="hidden" id="me_phone" name="me_phone">
                <div id="phoneError" class="error" style="display: none;">전화번호를 모두 입력해주세요.</div>
            </div>
	        <div class="form-group birth-group">
			    <label for="birth">생년월일:</label>
			    <input type="date" class="form-control" id="birth" name="me_birth" required>
			</div>
            <button type="submit" class="btn btn-outline-success col-12">회원가입</button>
        </form>
        <!-- 에러 메시지 표시 부분 -->
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>
    </div>
</body>
	<script type="text/javascript">
	var flag = false;
	
	$('#form').validate({
		rules : {
			me_id : {
				required : true,
				regex : /^\w{4,10}$/
			},
			me_pw : {
				required : true,
				regex : /^[a-zA-Z0-9!@#$]{4,15}$/
			},
			me_pw2 : {
				equalTo : pw
			},
			me_email : {
				required : true,
				email : true
			}
		},
		messages : {
			me_name : {
				required : '필수 항목입니다.'
			},
			me_id : {
				required : '필수 항목입니다.',
				regex : '아이디는 영어, 숫자만 가능하며, 4~10자이어야 합니다.'
			},
			me_pw : {
				required : '필수 항목입니다.',
				regex : '아이디는 영어, 숫자, 특수문자(!@#$)만 가능하며, 4~15자이어야 합니다.'
			},
			me_pw2 : {
				equalTo : '비번과 일치하지 않습니다.'
			},
			me_email : {
				required : '필수 항목입니다.',
				email : '이메일 형식이 아닙니다'
			}
		},
		submitHandler : function(){
			var id = $("#id").val();
			var res = checkId(id);
			if(res == 0){
				displayCheckId(res);
				alert('이미 사용 중인 아이디입니다.');
				return false;
			}
			return true;
		}
	});
	$.validator.addMethod('regex', function(value, element, regex){
		var re = new RegExp(regex);
		return this.optional(element) || re.test(value);
	}, "정규표현식을 확인하세요.");
	
	</script>
	<script type="text/javascript">
		//아이디 중복 확인
		$("#id").keyup(function(){
			//입력된 아이디 값을 가져옴
			var id = $(this).val();
			//아이디를 서버에 전달해서 사용 가능한지 확인
			var result = checkId(id);
			displayCheckId(result);
		});
		/**
		@return 1이면 사용 가능, 0이면 사용 불가능, -1이면 전송하지 않음
		*/
		function checkId(id){
			//정규표현식 확인
			var regex = /^\w{6,13}$/;
			if(!regex.test(id)){
				return -1;
			}
			var res = 0;
			//맞으면 서버에 확인 요청
			$.ajax({
				async : false,
				url : '<c:url value="/check/id"/>', 
				type : 'get', 
				data : {
					id : id
				}, 
				success : function (data){
					res = data? 1 : 0;
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
			return res;
		}
		function displayCheckId(result){
			$('#check-id').remove();
			
			if(result == 1){
				var str = `<label id="check-id" class="id-ok error">사용 가능한 아이디입니다.</label>`;
				$('#id').after(str);
			}else if(result == 0){
				var str = `<label id="check-id" class="error">이미 사용중인 아이디입니다.</label>`;
				$('#id').after(str);
			}
		}
	</script>
	<script type="text/javascript">
    // 전화번호를 하나의 필드로 결합하여 전송
    document.getElementById('form').onsubmit = function() {
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;
        
        // 전화번호 조합
        var fullPhoneNumber = phone1 + phone2 + phone3;
        document.getElementById('me_phone').value = fullPhoneNumber; // 결합된 전화번호를 hidden input에 설정

        // 추가 유효성 검사 (필요할 경우)
        if (!phone1 || !phone2 || !phone3) {
            document.getElementById('phoneError').style.display = 'block';
            return false; // 폼 제출 방지
        } else {
            document.getElementById('phoneError').style.display = 'none';
        }

        return true; // 유효성 검사가 통과하면 제출
    };
	</script>
	
  <!-- <script type="text/javascript">
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
	</script>  -->
	<script>
    function addressPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 우편번호와 주소 데이터를 가져옵니다.
                var postcode = data.zonecode; // 우편번호
                var address = data.roadAddress || data.jibunAddress; // 도로명 주소나 지번 주소

                // 참고항목 (extraAddress) 처리
                var extraAddress = ''; 
                if (data.bname !== '' && data.buildingName !== '') {
                    extraAddress = data.bname + ', ' + data.buildingName;
                } else if (data.bname !== '') {
                    extraAddress = data.bname;
                } else if (data.buildingName !== '') {
                    extraAddress = data.buildingName;
                }

                // 우편번호와 주소를 각각의 input 필드에 자동으로 채웁니다.
                document.getElementById('me_postcode').value = postcode;
                document.getElementById('me_address').value = address;
                document.getElementById('me_extraAddress').value = extraAddress;

                // 상세주소 입력란으로 포커스 이동
                document.getElementById('me_detailAddress').focus();
            }
        }).open();
    }
	</script>
</html>
