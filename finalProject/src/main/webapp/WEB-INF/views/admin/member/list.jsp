<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<c:if test="${not empty msg}">
			    <script type="text/javascript">
			        alert("${msg}");
			    </script>
			</c:if>	

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">회원 목록</h2>
					</div>
				
					<!-- 회원 목록 -->
					<table class="table table_center" id="table">
						<thead id="thead">
							<tr>
				        		<th>이름</th>
				        		<th>생년월일</th>
				        		<th>성별</th>
				        		<th>전화번호</th>
				        		<th>계정</th>
				        		<th>이메일</th>
				        		<th>SNS</th>
				        		<th>상태</th>							
								<th>상세</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${memberList}" var="me">
								<tr>
									<td>${me.me_name}</td>
									<td>
										<c:if test="${me.me_birth != null}">
											<fmt:formatDate value="${me.me_birth}" pattern="yyyy.MM.dd"/>
										</c:if>
										<c:if test="${me.me_birth == null}">
											-
										</c:if>
									</td>
									<td>
										<c:if test="${me.me_gender != null}">
											${me.me_gender}
										</c:if>
										<c:if test="${me.me_gender == null}">
											-
										</c:if>									
									</td>
									<td>
										<c:if test="${me.me_phone != null}">
											${me.me_phone}
										</c:if>
										<c:if test="${me.me_phone == null}">
											-
										</c:if>									
									</td>									
									<td>${me.me_id}</td>
									<td>${me.me_email}</td>
					        		<td>
					        			<c:choose>
					        			<c:when test="${me.me_kakaoUserId == null && me.me_naverUserId == null}">-</c:when>
					        			<c:when test="${me.me_kakaoUserId != null && me.me_naverUserId == null}">카카오</c:when>
					        			<c:when test="${me.me_kakaoUserId == null && me.me_naverUserId != null}">네이버</c:when>
					        			<c:otherwise>네이버, 카카오</c:otherwise>
					        			</c:choose>
					        		</td>
					        		<td>
					        			<c:if test="${me.me_authority == 'USER'}">사용중</c:if>
					        			<c:if test="${me.me_authority == 'REMOVED'}">탈퇴</c:if>
					        		</td>									
									<td>
										<a href="<c:url value="/admin/member/detail/${me.me_id}"/>" class="btn btn_blue">조회</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- 회원 등록 버튼 -->
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<div class="btn_link_black">
								<a href="<c:url value="/terms"/>" class="btn btn_black js-btn-insert">
									<span>회원등록<i class="ic_link_share"></i></span>
								</a>
								<div class="btn_black_top_line"></div>
								<div class="btn_black_right_line"></div>
								<div class="btn_black_bottom_line"></div>
								<div class="btn_black_left_line"></div>
							</div>
						</div>
					</div>
									
				</section>
			</section>
	
			<script type="text/javascript">
				// 데이터테이블
				$('#table').DataTable({
					language: {
				        search: "",
				        searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: "",
				        lengthMenu: ""
				    },
				    pageLength: 10,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 0, "asc" ]],
				    columnDefs: [
				        { targets: [8], orderable: false }
				    ]
				});
			</script>