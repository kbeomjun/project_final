<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>

	<main class="sub_container" id="skipnav_target">
		<section class="sub_banner sub_banner_07"></section>
		<section class="sub_content">
		
			<!-- 왼쪽 사이드바 -->
			<%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
			
			<!-- 오른쪽 컨텐츠 영역 -->
			<section class="sub_content_group">
				
				<div class="table_wrap">
				
					<table class="table">
						<colgroup>
							<col style="width: 20%;">
							<col style="width: 80%;">
						</colgroup>
						
						<tbody>
							<tr>
								<th scope="row">
									<label for="rp_title">제목</label>
								</th>
								<td>
									<div class="form-group">${review.rp_title}</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_br_name">지점명</label>
								</th>
								<td>
									<div class="form-group">${review.rp_br_name}</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="pa_me_id">작성자</label>
								</th>
								<td>
									<div class="form-group">${review.pa_me_id}</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_date">작성일</label>
								</th>
								<td>
									<div class="form-group">
										<fmt:formatDate value="${review.rp_date}" pattern="yyyy-MM-dd" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_view">조회수</label>
								</th>
								<td>
									<div class="form-group">${review.rp_view}</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_content">내용</label>
								</th>
								<td>
									<div class="form-group">${review.rp_content}</div>
								</td>
							</tr>																											
						</tbody>
										
					</table>
					
					<div class="d-flex justify-content-between">
						<a href="<c:url value="/mypage/review/list"/>" class="btn btn-outline-info">목록</a>
						
						<div>
							<c:if test="${review.pa_me_id eq me_id }">
								<a href="<c:url value="/mypage/review/update/${review.rp_num}"/>" class="btn btn_insert ml-2">수정</a>
								<a href="<c:url value="/mypage/review/delete/${review.rp_num}"/>" class="btn btn_cancel ml-2" 
											onclick="return confirm('삭제하면 해당 결제내역의 리뷰 게시글은 다시 작성할 수 없습니다. 삭제하시겠습니까?');">삭제</a>
							</c:if>
						</div>
					</div>					
					
				</div>
			</section>
			
		</section>
	</main>

</body>
</html>
