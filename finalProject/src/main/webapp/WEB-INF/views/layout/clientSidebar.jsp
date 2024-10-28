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
				        var isReviewMenu = currentPath.substring(secondSlashIndex+1, thirdSlashIndex);
				        
				        $('.sidebar-sticky .nav-link').each(function() {
				            var href = $(this).attr('href');
				            
				            if(isReviewMenu == 'review'){
				            	$('#reviewMenu').addClass('active');
				            	return;
				            }
				            
			               	if(href === currentPath){
			            		$(this).addClass('active');				            		
			            	} else{
				                $(this).removeClass('active');
			            	}
			               	
				        });
				    });
				</script>
				
				<!-- sidebar.jsp -->
				<div class="sidebar-sticky">
					<h4 class="sidebar-heading mt-3">고객센터 메뉴</h4>
					<ul class="nav flex-column">
						<li class="nav-item">
							<a id="reviewMenu" class="nav-link" href="<c:url value='/client/review/list'/>">리뷰게시판</a>
						</li>
						<li class="nav-item">
							<a id="faqMenu" class="nav-link" href="<c:url value='/client/inquiry/faq'/>">자주묻는질문</a>
						</li>            
						<li class="nav-item">
							<a id="inquiryMenu" class="nav-link" href="<c:url value='/client/inquiry/insert'/>">1:1문의</a>
						</li>
					</ul>
				</div>
