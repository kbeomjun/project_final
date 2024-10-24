<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<style>
.button_kakao,
.button_naver {
	position: relative;
    display: flex; /* 플렉스 박스 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: center; /* 수평 중앙 정렬 */
    font-weight: 500;
    margin: 16px auto 0;
    width: 100%;
    height: 50px;
    /* background-color: #00c400; */
    border-radius: 8px;
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 여백 */
    font-size: 16px; /* 폰트 크기 */
    font-weight: bold; /* 폰트 두껍게 */
    cursor: pointer; /* 커서 모양 변경 */
    transition: background-color 0.3s ease; /* 배경색 변화 애니메이션 */
}

.button_kakao {
    background-color: #FEE500; /* 카카오톡 주황색 */
    color: #3A1D0D; /* 카카오톡 텍스트 색상 */
}

.button_naver {
    background-color: #03C75A; /* 네이버 녹색 */
    color: #FFFFFF; /* 텍스트 흰색 */
}

/* 버튼 호버 효과 */
.button_kakao:hover {
    background-color: #FFD500; /* 밝은 주황색 */
    color: #3A1D0D; /* 텍스트 색상 유지 */
}

.button_kakao:active {
    background-color: #FFC700; /* 클릭 시 더 어두운 주황색 */
}

/* 아이콘 스타일 */
.kakao-icon,
.naver-icon {
    width: 30px; /* 아이콘 크기 조정 */
    height: 30px; /* 아이콘 크기 조정 */
    margin-right: 10px; /* 텍스트와 아이콘 간의 간격 */
}
.text_name {
	color: #00c400;
}
.box__border {
	border: 1px solid #e0e0e0;
    padding: 30px 20px;
    margin-top: 30px;
    background: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    border-radius: 8px;
    width: 100%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    color: #222;
    font-size: 18px;
    font-weight: 800;
    line-height: 24px;
}
.box__alert-message{
	position: relative;
    text-align: center;
    min-height: 600px;
    max-width: 400px;
    padding: 106px 0;
    margin: 0 auto;
    text-align: left;
}
.text__certify-title {
	font-family: 'Gmarket sans', sans-serif;
    font-size: 22px;
    line-height: 30px;
    color: #222;
    font-weight: 500;
    text-align: center;
}
</style>
</head>
<body>
<div class="box__alert-message">
	<h3 class="text__certify-title">이미 가입된 아이디가 있어요.
	<br>
	<span class="text_name">${socialType}</span>
	 계정을 연결해 주세요.
	</h3>
	<div class="box__border">
	${user.me_id}
	</div>
	<form action="<c:url value="/sso/match"/>" method ="post">
		<input type="hidden" name="social_type" value="${socialType}"> 
        <input type="hidden" name="me_id" value="${user.me_id}" />
		<c:choose>
			<c:when test="${ socialType eq 'KAKAO'}">
				<input type="hidden" name="me_kakaoUserId" value="${user.me_kakaoUserId}" />
				<button type="submit" id="btnMatchingSubmit" class="button_kakao">
					<img src="<c:url value='/resources/image/kakao/kakaotalk_sharing_btn_small.png'/>" class="kakao-icon" />
						카카오 계정 연결하기
				</button>
			</c:when>
			<c:when test="${ socialType eq 'NAVER'}">
				<input type="hidden" name="me_naverUserId" value="${user.me_naverUserId}" />
				<button type="submit" id="btnMatchingSubmit" class="button_naver">
					<img src="<c:url value='/resources/image/naver/logo_naver.png'/>" class="naver-icon" />
					네이버 계정 연결하기
				</button>
			</c:when>
		</c:choose>
		<input type="hidden" name="me_gender" value="${user.me_gender}" /> 
		<input type="hidden" name="me_phone" value="${user.me_phone}" /> 
		<input type="hidden" name="me_name" value="${user.me_name}" />
		
		
	</form>
</div>

</body>
</html>
