<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

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
										<label for="mi_it_name">문의유형</label>
									</th>
									<td>
										<div class="form-group">${inquiry.mi_it_name}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="mi_br_name">지점명</label>
									</th>
									<td>
										<div class="form-group">${inquiry.mi_br_name}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="mi_date">문의날짜</label>
									</th>
									<td>
										<div class="form-group">
											<fmt:formatDate value="${inquiry.mi_date}" pattern="yyyy-MM-dd" />
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="mi_title">제목</label>
									</th>
									<td>
										<div class="form-group">${inquiry.mi_title}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="mi_content">내용</label>
									</th>
									<td>
										<div class="form-group">${inquiry.mi_content}</div>
									</td>
								</tr>
							</tbody>
						</table>
						
						<table class="table">
							<colgroup>
								<col style="width: 20%;">
								<col style="width: 80%;">
							</colgroup>
							
							<tbody>
								<tr>
									<th scope="row">
										<label for="mi_answer">답변</label>
									</th>
									<td>
									    <c:choose>
									        <c:when test="${inquiry.mi_answer != null}">
									            <div class="form-group">${inquiry.mi_answer}</div>
									        </c:when>
									        <c:otherwise>
									            <div class="form-group">
									                <p class="text-muted">아직 답변이 등록되지 않았습니다.</p>
									            </div>
									        </c:otherwise>
									    </c:choose>
									</td>
								</tr>
							</tbody>							
						</table>						
		                   
						<div class="btn_wrap">
							<div class="btn_left_wrap">
								<a href="<c:url value="/mypage/inquiry/list"/>" class="btn btn_cancel">목록</a>
							</div>
						</div>
							
					</div>
				</section>
				
			</section>