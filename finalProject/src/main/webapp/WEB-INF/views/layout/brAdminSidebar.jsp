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
				    }
				</style>
				
				<script>
				    $(document).ready(function() {
				        // 드롭다운 메뉴 상태를 세션에 저장하여 유지
				        $('.dropdown-toggle').click(function() {
				            const submenu = $(this).next('.submenu');
				
				            // 모든 드롭다운 메뉴를 닫음
				            $('.submenu').slideUp("fast");
				
				            // 클릭한 메뉴만 토글
				            submenu.stop(true, true).slideToggle("fast");
				
				            // 클릭된 메뉴 ID를 세션에 저장하여 페이지 이동 후에도 유지
				            const menuId = $(this).attr('id');
				            sessionStorage.setItem('activeMenu', submenu.is(':visible') ? menuId : '');
				        });
				
				        // 기타 메뉴 클릭 시 모든 드롭다운 메뉴 닫기
				        $('.static-link').click(function() {
				            $('.submenu').slideUp("fast");
				            sessionStorage.removeItem('activeMenu'); // 세션의 메뉴 상태 초기화
				        });
				        
				        // 페이지 로딩 시 세션에 저장된 메뉴 상태 유지
				        const activeMenuId = sessionStorage.getItem('activeMenu');
				        if (activeMenuId) {
				            $('#' + activeMenuId).next('.submenu').show();
				        }
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
				                    <a class="nav-link" href="<c:url value='/admin/program/list'/>">프로그램 관리</a>
				                </li>
				                <li class="nav-item">
				                    <a class="nav-link" href="<c:url value='/admin/schedule/list'/>">일정 관리</a>
				                </li>
				            </ul>
				        </li>
				        
				        <!-- 운동기구 관리 드롭다운 -->
				        <li class="nav-item">
				            <a id="equipmentMenu" class="nav-link dropdown-toggle">운동기구</a>
				            <ul class="nav flex-column submenu">
				                <li class="nav-item">
				                    <a class="nav-link" href="<c:url value='/admin/order/list'/>">발주목록</a>
				                </li>
				                <li class="nav-item">
				                    <a class="nav-link" href="<c:url value='/admin/equipment/list'/>">보유목록</a>
				                </li>
				            </ul>
				        </li>
				
				        <!-- 지점 메뉴 -->
				        <li class="nav-item">
				        	<a id="branchMenu" class="nav-link dropdown-toggle">지점</a>
				        	<ul class="nav flex-column submenu">
						        <li class="nav-item">
						            <a class="nav-link" href="<c:url value='/admin/employee/list'/>">직원관리</a>
						        </li>
						        <li class="nav-item">
						            <a class="nav-link" href="<c:url value='/admin/branch/detail'/>">지점 상세</a>
						        </li>
				        	</ul>
				        </li>
				        
				        <!-- 기타 메뉴 -->
				        <li class="nav-item">
				            <a class="nav-link static-link" href="<c:url value='/admin/member/list'/>">회원관리</a>
				        </li>
				        <li class="nav-item">
				            <a class="nav-link static-link" href="<c:url value='/admin/inquiry/list'/>">문의내역</a>
				        </li>
				    </ul>
				</div>
