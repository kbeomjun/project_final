<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
			<link rel="stylesheet" href="<c:url value='/resources/css/faq.css' />">
		
		    <script>
		        $(document).ready(function () {
		            $('.faq-question').click(function () {
		                $(this).next(".faq-answer").slideToggle("fast");
		                $(this).find(".faq-icon").toggleClass('icon-active');
		            });
		        });
		    </script>
		
			<section class="sub_banner sub_banner_04"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					
					<div class="sub_title_wrap">
						<h2 class="sub_title">자주 묻는 질문</h2>
					</div>
					
					<div class="sub_hd_wrap">
						<form action="<c:url value='/client/inquiry/faq'/>" method="get">
							<ul class="tab_list">
								<li class="tab_item"><button type="submit" name="category" value="all" class="tab_link <c:if test='${category eq "all"}'>_active</c:if>">전체</button></li>
								<c:forEach items="${typeList}" var="tl">
									<li class="tab_item"><button type="submit" name="category" value="${tl.it_name}" class="tab_link <c:if test='${category eq tl.it_name}'>_active</c:if>">${tl.it_name}</button></li>
								</c:forEach>
							</ul>
						</form>
					
						<form action="<c:url value='/client/inquiry/faq'/>" method="get">
							<input type="hidden" name="category" value="${category}">
							<div class="search_bar_wrap">
								<select class="form-control custom-select" name="type">
									<option value="all" <c:if test="${pm.cri.type eq 'all'}">selected</c:if>>전체</option>
									<option value="title" <c:if test="${pm.cri.type eq 'title'}">selected</c:if>>제목</option>
									<option value="content" <c:if test="${pm.cri.type eq 'content'}">selected</c:if>>내용</option>
								</select>
								<div class="search_bar">
									<input type="text" class="form-control" placeholder="검색어" name="search" value="${pm.cri.search}">
									<button type="submit" class="btn search_btn"></button>
								</div>
							</div>
						</form>
					</div>
		                
					<div class="faqList">
				        <c:forEach items="${faqList}" var="faq">
				            <div class="faq-item">
				                <div class="faq-question">
				                    <span class="faq-title-label">[${faq.mi_it_name}]</span>
				                    <h3 class="faq-title">${faq.mi_title}</h3>
				                    <span class="faq-icon"></span>
				                </div>
				                <div class="faq-answer">
				                    <p>${faq.mi_content}</p>
				                </div>
				            </div>
				        </c:forEach>
						<c:if test="${empty faqList}">
							<div class="noList">
								<p>등록된 답변이 없습니다.</p>
							</div>
						</c:if>
			        
					    <c:if test="${pm.totalCount ne 0}">
							<ul class="pagination justify-content-center">
								<c:if test="${pm.prev}">
									<c:url var="url" value="/client/inquiry/faq">
										<c:param name="page" value="${pm.startPage - 1}"/>
										<c:param name="type" value="${pm.cri.type}"/>
										<c:param name="search" value="${pm.cri.search}"/>
									</c:url>
									<li class="page-item">
										<a class="page-link" href="${url}">이전</a>
									</li>
								</c:if>
								<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
									<c:url var="url" value="/client/inquiry/faq">
										<c:param name="page" value="${i}"/>
										<c:param name="type" value="${pm.cri.type}"/>
										<c:param name="search" value="${pm.cri.search}"/>
									</c:url>
									<c:choose>
										<c:when test="${pm.cri.page eq i}">
											<c:set var="active" value="active"/>
										</c:when>
										<c:otherwise>
											<c:set var="active" value=""/>
										</c:otherwise>
									</c:choose>
									<li class="page-item ${active}">
										<a class="page-link" href="${url}">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${pm.next}">
									<c:url var="url" value="/client/inquiry/faq">
										<c:param name="page" value="${pm.endPage + 1}"/>
										<c:param name="type" value="${pm.cri.type}"/>
										<c:param name="search" value="${pm.cri.search}"/>
									</c:url>
									<li class="page-item">
										<a class="page-link" href="${url}">다음</a>
									</li>
								</c:if>
							</ul>
						</c:if>
					</div>
						
				</section>
				
			</section>
