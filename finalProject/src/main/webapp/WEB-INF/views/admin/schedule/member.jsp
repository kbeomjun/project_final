<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
		        <!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
			
	        	<!-- 오른쪽 컨텐츠 영역 -->
	        	<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">예약회원 목록</h2>
					</div>
					
					<!-- 예약회원 목록 -->
					<div class="table_wrap">
						<table class="table table_center" id="table">
							<thead id="thead">
								<tr>
									<th>회원명</th>
									<th>전화번호</th>
									<th>생년월일</th>
									<th>성별</th>
									<th>노쇼경고횟수</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<c:forEach items="${memberList}" var="list">
									<tr>
										<td>${list.me_name}</td>
										<td>${list.me_phone}</td>
										<td>
											<fmt:formatDate value="${list.me_birth}" pattern="yyyy년 MM월 dd일"/> 
										</td>
										<td>${list.me_gender}</td>
										<td>${list.me_noshow}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>					

					<div class="btn_wrap">
						<div class="btn_left_wrap">
							<a href="<c:url value="/admin/schedule/list"/>" class="btn btn_cancel">목록</a>
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
				        emptyTable: ""
				    },
				    createdRow: function(row, data, dataIndex) {
				        if (data[4] == 5) {
				        	$('td', row).css('color', 'red');
				        }
				    },
				    paging: false,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 0, "asc" ]]
				});
			</script>
