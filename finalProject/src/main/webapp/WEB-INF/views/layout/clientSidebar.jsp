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
				        var isReviewMenu = currentPath.substring(secondSlashIndex+1, thirdSlashIndex);
				        
				        $('.lnb_wrap .lnb__link').each(function() {
				            var href = $(this).attr('href');
				            
				            if(isReviewMenu == 'review'){
				            	$('#reviewMenu').addClass('_active');
				            	return;
				            }
				            
			               	if(href === currentPath){
			            		$(this).addClass('_active');				            		
			            	} else{
				                $(this).removeClass('_active');
			            	}
			               	
				        });
				    });
				</script>
				
				<!-- sidebar.jsp -->
				<section class="lnb_wrap">
					<ul class="lnb">
						<li class="lnb__item">
							<a id="reviewMenu" class="lnb__link" href="<c:url value='/client/review/list'/>">리뷰게시판</a>
						</li>
						<li class="lnb__item">
							<a id="faqMenu" class="lnb__link" href="<c:url value='/client/inquiry/faq'/>">자주묻는질문</a>
						</li>
						<li class="lnb__item">
							<a id="inquiryMenu" class="lnb__link" href="<c:url value='/client/inquiry/insert'/>">1:1문의</a>
						</li>
					</ul>
				</section>
