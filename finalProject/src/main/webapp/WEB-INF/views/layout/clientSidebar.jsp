<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style type="text/css">
	/* 하위 메뉴 숨김 처리 (기본적으로 display: none) */
	.submenu {
	    margin-left: 15px;
	}
	
	/* 하위 메뉴 항목 스타일 */
	.submenu .nav-link {
	    color: black;
	    text-decoration: none;
	    padding: 5px 10px;
	    display: flex;
	    align-items: center;
	}
	
	.submenu .nav-link::before {
	    content: "▶"; /* 화살표 추가 */
	    margin-right: 10px;
	    font-size: 12px;
	}	
	
	.submenu .nav-link:hover {
	    background-color: #f1f1f1;
	}
</style>
</head>
<body>
	<!-- sidebar.jsp -->
    <div class="sidebar-sticky">
        <h4 class="sidebar-heading mt-3">고객센터 메뉴</h4>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/client/review/list'/>">리뷰게시판</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/client/inquiry/faq'/>">자주묻는질문</a>
            </li>            
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/client/inquiry/insert'/>">1:1문의</a>
            </li>
            <c:if test="${user ne null && user.me_authority eq 'USER'}">
                <li class="nav-item">
                    <a class="nav-link" href="#" id="mypageToggle">마이페이지</a>
                    <ul id="mypageMenu" class="submenu" style="display: none;">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/schedule/${user.me_id}'/>">프로그램 일정</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/membership/${user.me_id}'/>">회원권</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/review/list/${user.me_id}'/>">나의 작성글</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/inquiry/list/${user.me_id}'/>">문의내역</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/pwcheck/${user.me_id}'/>">개인정보수정</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/pwchange/${user.me_id}'/>">비밀번호 변경</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/client/mypage/unregister/${user.me_id}'/>">회원탈퇴</a>
                        </li>
                    </ul>
                </li>
            </c:if>
        </ul>
    </div>
	
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            const toggle = document.getElementById('mypageToggle');
            const submenu = document.getElementById('mypageMenu');

            // 현재 URL이 마이페이지와 관련된지 확인
            const currentPath = window.location.pathname;

            // 마이페이지 관련 경로
            const myPagePaths = [
                '/client/mypage/schedule/',
                '/client/mypage/membership/',
                '/client/mypage/review/',
                '/client/mypage/inquiry/',
                '/client/mypage/pwcheck/',
                '/client/mypage/info/',
                '/client/mypage/pwchange/',
                '/client/mypage/unregister/'
            ];

            // 마이페이지 경로라면 서브메뉴를 자동으로 펼침
            if (myPagePaths.some(path => currentPath.includes(path))) {
                submenu.style.display = 'block';
            }

            // 마이페이지 메뉴 토글 클릭 이벤트
            toggle.addEventListener('click', function (event) {
                event.preventDefault(); // 페이지 이동 방지
                if (submenu.style.display === 'none') {
                    submenu.style.display = 'block'; // 메뉴 보이기
                } else {
                    submenu.style.display = 'none'; // 메뉴 숨기기
                }
            });
        });
    </script>
	
</body>
</html>
