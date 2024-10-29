<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

				<script>
				    $(document).ready(function() {
				        // 현재 URL 경로를 세그먼트로 나누기
				        var currentPath = window.location.pathname;
				        var pathSegments = currentPath.split('/');
				        var secondPath = pathSegments[3];
	
				        // 메뉴와 서브메뉴를 동적으로 열어주는 함수
				        function activateMenu(mainMenuId, subMenuId) {
				            $('#' + mainMenuId).next('.nav_two').show();
				            $('#' + mainMenuId).addClass('_active');
				            if (subMenuId) {
				                $('#' + subMenuId).addClass('_active');
				            }
				        }
	
				        // 조건에 따라 메뉴 열기 및 active 설정
				        if (secondPath === 'program' || secondPath === 'schedule') {
				            activateMenu('programMenu', secondPath === 'program' ? 'programSubMenu' : 'scheduleSubMenu');
				        } else if (secondPath === 'order' || secondPath === 'equipment') {
				            activateMenu('equipmentMenu', secondPath === 'order' ? 'orderSubMenu' : 'equipmentSubMenu');
				        } else if (secondPath === 'employee' || secondPath === 'branch') {
				            activateMenu('branchMenu', secondPath === 'employee' ? 'employeeSubMenu' : 'detailSubMenu');
				        } else if (secondPath === 'member') {
				            activateMenu('memberMenu');
				        } else if (secondPath === 'inquiry') {
				            activateMenu('inquiryMenu');
				        }
	
				        // 드롭다운 메뉴 클릭 이벤트 핸들러
				        $('.dropdown').click(function() {
				            const submenu = $(this).next('.nav_two');
				            if (submenu.is(':visible')) {
				                submenu.slideUp("fast");
				            } else {
				                $('.nav_two').slideUp("fast");
				                submenu.stop(true, true).slideToggle("fast");
				            }
				        });
	
				        // 기타 메뉴 클릭 시 모든 드롭다운 메뉴 닫기
				        $('.static-link').click(function() {
				            $('.nav_two').slideUp("fast");
				        });
				    });
				</script>
				
				<!-- sidebar.jsp -->
				<nav class="lnb_wrap">
					<ul class="lnb">
						<!-- 프로그램 관리 드롭다운 -->
				        <li class="lnb-item">
				            <a id="programMenu" class="lnb__link dropdown">프로그램</a>
				            <ul class="nav_two">
				                <li class="nav_two__item">
				                    <a id="programSubMenu" class="nav_two__link" href="<c:url value='/admin/program/list'/>">프로그램 관리</a>
				                </li>
				                <li class="nav_two__item">
				                    <a id="scheduleSubMenu" class="nav_two__link" href="<c:url value='/admin/schedule/list'/>">일정 관리</a>
				                </li>
				            </ul>
				        </li>
				        
						<!-- 운동기구 관리 드롭다운 -->
				        <li class="lnb-item">
				            <a id="equipmentMenu" class="lnb__link dropdown">운동기구</a>
				            <ul class="nav_two">
				                <li class="nav_two__item">
				                    <a id="orderSubMenu" class="nav_two__link" href="<c:url value='/admin/order/list'/>">발주목록</a>
				                </li>
				                <li class="nav_two__item">
				                    <a id="equipmentSubMenu" class="nav_two__link" href="<c:url value='/admin/equipment/list'/>">보유목록</a>
				                </li>
				            </ul>
				        </li>
				        
				        <!-- 지점 메뉴 -->
				        <li class="lnb-item">
				            <a id="branchMenu" class="lnb__link dropdown">지점</a>
				            <ul class="nav_two">
				                <li class="nav_two__item">
				                    <a id="employeeSubMenu" class="nav_two__link" href="<c:url value='/admin/employee/list'/>">직원관리</a>
				                </li>
				                <li class="nav_two__item">
				                    <a id="detailSubMenu" class="nav_two__link" href="<c:url value='/admin/branch/detail'/>">지점상세</a>
				                </li>
				            </ul>
				        </li>
				        
				        <!-- 기타 메뉴 -->
				        <li class="lnb-item">
				            <a id="memberMenu" class="lnb__link static-link" href="<c:url value='/admin/member/list'/>">회원관리</a>
				        </li>
				        <li class="lnb-item">
				            <a id="inquiryMenu" class="lnb__link static-link" href="<c:url value='/admin/inquiry/list'/>">문의내역</a>
				        </li>				        				        					
					</ul>
				</nav>
				