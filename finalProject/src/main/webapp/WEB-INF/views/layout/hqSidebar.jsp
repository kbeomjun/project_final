<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<!-- sidebar.jsp -->
	<nav class="lnb_wrap">
		<ul class="lnb">
        	<li class="lnb-item">
          		<a class="lnb__link active" href="<c:url value="/hq/branch/list"/>">지점 관리</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/employee/list"/>">직원 관리</a>
      	 		</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/equipment/list"/>">운동기구 관리</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/stock/list"/>">재고 관리</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/order/list"/>">발주 내역</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/paymentType/list"/>">회원권 관리</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/member/list"/>">회원 조회</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/FAQ/list"/>">FAQ 관리</a>
        	</li>
        	<li class="lnb-item">
          		<a class="lnb__link" href="<c:url value="/hq/refund/list"/>">환불 처리</a>
        	</li>
      	</ul>
	</nav>
    
    <script>
    	$(document).ready(function(){
		    var currentPath = window.location.pathname;
		    
		    var firstSlashIndex = currentPath.indexOf('/', 1);
		    var secondSlashIndex = currentPath.indexOf('/', firstSlashIndex + 1);
		    var thirdSlashIndex = currentPath.indexOf('/', secondSlashIndex + 1);
		    var commonPath = currentPath.substring(0, thirdSlashIndex + 1);
		    
		    $(".lnb-item").find(".lnb__link").each(function() {
		        var href = $(this).attr("href");
		        
		        if (href.startsWith(commonPath)) {
	                $(this).addClass("_active");
		        }else{
		        	$(this).removeClass("_active");
		        }
		    });
    	});
	</script>