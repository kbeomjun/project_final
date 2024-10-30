<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<!-- sidebar.jsp -->
	<nav class="lnb_wrap">
	    <ul class="lnb">
	        <li class="lnb-item">
	            <a id="branchMenu" class="lnb__link dropdown">지점</a>
	            <ul class="nav_two">
	                <li class="nav_two__item">
	                    <a id="branchSubMenu" class="nav_two__link" href="<c:url value='/hq/branch/list'/>">지점 관리</a>
	                </li>
	                <li class="nav_two__item">
	                    <a id="employeeSubMenu" class="nav_two__link" href="<c:url value='/hq/employee/list'/>">직원 관리</a>
	                </li>
	            </ul>
	        </li>
	        
	        <li class="lnb-item">
	            <a id="fitnessMenu" class="lnb__link dropdown">헬스장</a>
	            <ul class="nav_two">
	                <li class="nav_two__item">
	                    <a id="equipmentSubMenu" class="nav_two__link" href="<c:url value='/hq/equipment/list'/>">운동기구 관리</a>
	                </li>
	                <li class="nav_two__item">
	                    <a id="paymentTypeSubMenu" class="nav_two__link" href="<c:url value='/hq/paymentType/list'/>">회원권 관리</a>
	                </li>
	                <li class="nav_two__item">
	                    <a id="programSubMenu" class="nav_two__link" href="<c:url value='/hq/program/list'/>">프로그램 관리</a>
	                </li>
	            </ul>
	        </li>
	
	        <li class="lnb-item">
	        	<a id="stockMenu" class="lnb__link dropdown">재고</a>
	        	<ul class="nav_two">
			        <li class="nav_two__item">
			            <a id="stockSubMenu" class="nav_two__link" href="<c:url value='/hq/stock/list'/>">재고 관리</a>
			        </li>
			        <li class="nav_two__item">
			            <a id="orderSubMenu" class="nav_two__link" href="<c:url value='/hq/order/list'/>">발주 내역</a>
			        </li>
	        	</ul>
	        </li>
	        
	        <li class="lnb-item">
	        	<a id="memberMenu" class="lnb__link dropdown">회원</a>
	        	<ul class="nav_two">
			        <li class="nav_two__item">
			            <a id="memberSubMenu" class="nav_two__link" href="<c:url value='/hq/member/list'/>">회원 조회</a>
			        </li>
			        <li class="nav_two__item">
			            <a id="inquirySubMenu" class="nav_two__link" href="<c:url value='/hq/inquiry/list'/>">문의 내역</a>
			        </li>
			        <li class="nav_two__item">
			            <a id="FAQSubMenu" class="nav_two__link" href="<c:url value='/hq/FAQ/list'/>">FAQ 관리</a>
			        </li>
			        <li class="nav_two__item">
			            <a id="refundSubMenu" class="nav_two__link" href="<c:url value='/hq/refund/list'/>">환불 처리</a>
			        </li>
	        	</ul>
	        </li>
	    </ul>
	</nav>
    
    <script>
    	$(document).ready(function(){
    		var currentPath = window.location.pathname;
	        var pathSegments = currentPath.split('/');
	        var secondPath = pathSegments[3];
		    
		    var sub = '';
		    if (secondPath === 'branch' || secondPath === 'employee') {
		        activateMenu('branchMenu', secondPath === 'branch' ? 'branchSubMenu' : 'employeeSubMenu');
		    } else if (secondPath === 'equipment' || secondPath === 'paymentType' || secondPath === 'program') {
		    	if(secondPath === 'equipment'){
		    		sub = 'equipmentSubMenu';
	    		}else if(secondPath === 'paymentType'){
	    			sub = 'paymentTypeSubMenu';
	    		}else if(secondPath === 'program'){
	    			sub = 'programSubMenu';
	    		}
		    	
		        activateMenu('fitnessMenu', sub);
		    } else if (secondPath === 'stock' || secondPath === 'order') {
		        activateMenu('stockMenu', secondPath === 'stock' ? 'stockSubMenu' : 'orderSubMenu');
		    } else if (secondPath === 'member' || secondPath === 'inquiry' || secondPath === 'FAQ' || secondPath === 'refund') {
		    	if(secondPath === 'member'){
		    		sub = 'memberSubMenu';
	    		}else if(secondPath === 'inquiry'){
	    			sub = 'inquirySubMenu';
	    		}else if(secondPath === 'FAQ'){
	    			sub = 'FAQSubMenu';
	    		}else if(secondPath === 'refund'){
	    			sub = 'refundSubMenu';
	    		}
		    	
		        activateMenu('memberMenu', sub);
		    }
		    function activateMenu(mainMenuId, subMenuId) {
	            $('#' + mainMenuId).next('.nav_two').show();
	            $('#' + mainMenuId).addClass('_active');
	            if (subMenuId) {
	                $('#' + subMenuId).addClass('_active');
	            }
	        }
	    
		    $('.dropdown').click(function() {
	            const submenu = $(this).next('.nav_two');
	            if (submenu.is(':visible')) {
	                submenu.slideUp("fast");
	            } else {
	                $('.nav_two').slideUp("fast");
	                submenu.stop(true, true).slideToggle("fast");
	            }
	        });
    	});
	</script>