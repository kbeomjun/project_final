<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
				<!-- sidebar.jsp -->
				<div class="sidebar-sticky">
					<h4 class="sidebar-heading mt-3">고객센터 메뉴</h4>
					<ul class="nav flex-column">
						<li class="nav-item">
							<a class="nav-link" href="<c:url value='/client/review/list'/>">리뷰게시판</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<c:url value='/client/inquiry/faq'/>">자주묻는질문</a>
						</li>            
						<li class="nav-item">
							<a class="nav-link" href="<c:url value='/client/inquiry/insert'/>">1:1문의</a>
						</li>
					</ul>
				</div>
