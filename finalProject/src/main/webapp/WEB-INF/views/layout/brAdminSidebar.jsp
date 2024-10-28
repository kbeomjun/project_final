<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

				<style>
				    /* 하위 메뉴 스타일 */
				    .submenu {
				        display: none; /* 처음에 숨김 */
				        padding-left: 15px;
				        margin-top: 5px;
				    }
				    .nav-link {
				        cursor: pointer;
						color: #333;
						text-decoration: none;				        
				    }
					.nav-link.active {
					    font-weight: bold;
					}		
					.submenu .nav-link.active {
					    font-weight: bold;
					}							    
				</style>
				
				<script>
				    $(document).ready(function() {
				        // 현재 URL 경로를 세그먼트로 나누기
				        var currentPath = window.location.pathname;
				        var pathSegments = currentPath.split('/');
				        var secondPath = pathSegments[3];
	
				        // 메뉴와 서브메뉴를 동적으로 열어주는 함수
				        function activateMenu(mainMenuId, subMenuId) {
				            $('#' + mainMenuId).next('.submenu').show();
				            $('#' + mainMenuId).addClass('active');
				            if (subMenuId) {
				                $('#' + subMenuId).addClass('active');
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
				        $('.dropdown-toggle').click(function() {
				            const submenu = $(this).next('.submenu');
				            if (submenu.is(':visible')) {
				                submenu.slideUp("fast");
				            } else {
				                $('.submenu').slideUp("fast");
				                submenu.stop(true, true).slideToggle("fast");
				            }
				        });
	
				        // 기타 메뉴 클릭 시 모든 드롭다운 메뉴 닫기
				        $('.static-link').click(function() {
				            $('.submenu').slideUp("fast");
				        });
				    });
				</script>
				
				<!-- sidebar.jsp -->
				<div class="sidebar-sticky">
				    <h4 class="sidebar-heading mt-3">지점관리자 메뉴</h4>
				    <ul class="nav flex-column">
				        <!-- 프로그램 관리 드롭다운 -->
				        <li class="nav-item">
				            <a id="programMenu" class="nav-link dropdown-toggle">프로그램</a>
				            <ul class="nav flex-column submenu">
				                <li class="nav-item">
				                    <a id="programSubMenu" class="nav-link" href="<c:url value='/admin/program/list'/>">프로그램 관리</a>
				                </li>
				                <li class="nav-item">
				                    <a id="scheduleSubMenu" class="nav-link" href="<c:url value='/admin/schedule/list'/>">일정 관리</a>
				                </li>
				            </ul>
				        </li>
				        
				        <!-- 운동기구 관리 드롭다운 -->
				        <li class="nav-item">
				            <a id="equipmentMenu" class="nav-link dropdown-toggle">운동기구</a>
				            <ul class="nav flex-column submenu">
				                <li class="nav-item">
				                    <a id="orderSubMenu" class="nav-link" href="<c:url value='/admin/order/list'/>">발주목록</a>
				                </li>
				                <li class="nav-item">
				                    <a id="equipmentSubMenu" class="nav-link" href="<c:url value='/admin/equipment/list'/>">보유목록</a>
				                </li>
				            </ul>
				        </li>
				
				        <!-- 지점 메뉴 -->
				        <li class="nav-item">
				        	<a id="branchMenu" class="nav-link dropdown-toggle">지점</a>
				        	<ul class="nav flex-column submenu">
						        <li class="nav-item">
						            <a id="employeeSubMenu" class="nav-link" href="<c:url value='/admin/employee/list'/>">직원관리</a>
						        </li>
						        <li class="nav-item">
						            <a id="detailSubMenu" class="nav-link" href="<c:url value='/admin/branch/detail'/>">지점 상세</a>
						        </li>
				        	</ul>
				        </li>
				        
				        <!-- 기타 메뉴 -->
				        <li class="nav-item">
				            <a id="memberMenu" class="nav-link static-link" href="<c:url value='/admin/member/list'/>">회원관리</a>
				        </li>
				        <li class="nav-item">
				            <a id="inquiryMenu" class="nav-link static-link" href="<c:url value='/admin/inquiry/list'/>">문의내역</a>
				        </li>
				    </ul>
				</div>
