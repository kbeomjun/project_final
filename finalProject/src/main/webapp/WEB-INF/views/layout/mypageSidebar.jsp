<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
				
				<style>
					.nav-link.active {
					    font-weight: bold;
					}			
				</style>			
				
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
						    $('#' + menuId).addClass('active');
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
				            $('.sidebar-sticky .nav-link').each(function() {
				                var href = $(this).attr('href');
				                if (href === currentPath) {
				                    $(this).addClass('active');
				                }
				            });
				        }
				    });
				</script>				
				
				<!-- sidebar.jsp -->
				<div class="sidebar-sticky">
					<h4 class="sidebar-heading mt-3">마이페이지</h4>
					<ul class="nav flex-column">
						<li class="nav-item">
							<a id="membershipMenu" class="nav-link" href="<c:url value='/mypage/membership'/>">회원권</a>
						</li>
						<li class="nav-item">
							<a id="scheduleMenu" class="nav-link" href="<c:url value='/mypage/schedule'/>">프로그램 일정</a>
						</li>
						<li class="nav-item">
							<a id="reviewMenu" class="nav-link" href="<c:url value='/mypage/review/list'/>">나의 작성글</a>
						</li>
						<li class="nav-item">
							<a id="inquiryMenu" class="nav-link" href="<c:url value='/mypage/inquiry/list'/>">문의내역</a>
						</li>
						<li class="nav-item">
							<a id="infoChangeMenu" class="nav-link" href="<c:url value='/mypage/pwcheck'/>">개인정보수정</a>
						</li>
						<li class="nav-item">
							<a id="pwChangeMenu" class="nav-link" href="<c:url value='/mypage/pwchange'/>">비밀번호 변경</a>
						</li>
						<li class="nav-item">
							<a id="unregistMenu" class="nav-link" href="<c:url value='/mypage/unregister'/>">회원탈퇴</a>
						</li>
					</ul>
				</div>
