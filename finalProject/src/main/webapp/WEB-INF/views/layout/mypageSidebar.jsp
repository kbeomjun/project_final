<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
				
				<script>
				    $(document).ready(function() {
				        // 현재 URL 경로 가져오기
				        var currentPath = window.location.pathname;
				        
				        var firstSlashIndex = currentPath.indexOf('/', 1);
				        var secondSlashIndex = currentPath.indexOf('/', firstSlashIndex + 1);
				        var thirdSlashIndex = currentPath.indexOf('/', secondSlashIndex + 1);
				        var fourthSlashIndex = currentPath.indexOf('/', thirdSlashIndex + 1);
				        
				        // 경로를 세그먼트로 분리
				        var secondPath = thirdSlashIndex === -1 ? currentPath.substring(secondSlashIndex + 1) : currentPath.substring(secondSlashIndex + 1, thirdSlashIndex);
				        var thirdPath = thirdSlashIndex !== -1 && fourthSlashIndex !== -1 ? currentPath.substring(thirdSlashIndex + 1, fourthSlashIndex) : null;
	
				        // 메뉴 활성화 함수
						function activateMenu(menuId) {
						    $('#' + menuId).addClass('_active');
						}
	
				        // 조건에 따라 메뉴 및 서브 메뉴 활성화 설정
				        if (secondPath === 'review') {
				            // 리뷰 메뉴 조건
				            if (thirdPath === 'insert') {
				                activateMenu('membershipMenu');
				            } else {
				                activateMenu('reviewMenu');
				            }
				        } else if (secondPath === 'inquiry') {
				            // 문의 내역 메뉴 조건
				            activateMenu('inquiryMenu');
				        } else if (secondPath === 'info') {
				            // 정보 변경 메뉴 조건
				            activateMenu('infoChangeMenu');
				        } else {
				            // 일반적인 href가 currentPath와 일치하는 경우 활성화
				            $('.lnb_wrap .lnb__link').each(function() {
				                var href = $(this).attr('href');
				                if (href === currentPath) {
				                    $(this).addClass('_active');
				                }
				            });
				        }
				    });
				</script>				
				
				<!-- sidebar.jsp -->
				<nav class="lnb_wrap">
					<ul class="lnb">
						<li class="lnb-item">
							<a id="membershipMenu" class="lnb__link" href="<c:url value='/mypage/membership'/>">결제 내역</a>
						</li>
						<li class="lnb-item">
							<a id="scheduleMenu" class="lnb__link" href="<c:url value='/mypage/schedule'/>">프로그램 일정</a>
						</li>
						<li class="lnb-item">
							<a id="reviewMenu" class="lnb__link" href="<c:url value='/mypage/review/list'/>">나의 작성글</a>
						</li>
						<li class="lnb-item">
							<a id="inquiryMenu" class="lnb__link" href="<c:url value='/mypage/inquiry/list'/>">문의내역</a>
						</li>
						<li class="lnb-item">
							<a id="infoChangeMenu" class="lnb__link" href="<c:url value='/mypage/pwcheck'/>">개인정보수정</a>
						</li>
						<li class="lnb-item">
							<a id="pwChangeMenu" class="lnb__link" href="<c:url value='/mypage/pwchange'/>">비밀번호 변경</a>
						</li>
						<li class="lnb-item">
							<a id="unregistMenu" class="lnb__link" href="<c:url value='/mypage/unregister'/>">회원탈퇴</a>
						</li>						
					</ul>
				</nav>