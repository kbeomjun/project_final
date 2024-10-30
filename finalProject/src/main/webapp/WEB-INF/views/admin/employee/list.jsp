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
						<h2 class="sub_title">${br_name} 직원 목록</h2>
					</div>
					
					<!-- 직원 목록 -->
					<table class="table table_center" id="table">
						<thead id="thead">
							<tr>
								<th>직원번호</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>입사일</th>
								<th>직책</th>
								<th>상세</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${employeeList}" var="em">
								<tr>
									<td>${em.em_num}</td>
									<td>${em.em_name}</td>
									<td>${em.em_phone}</td>
									<td>${em.em_email}</td>
									<td>
										<fmt:formatDate value="${em.em_join}" pattern="yyyy.MM.dd"/>
									</td>
									<td>${em.em_position}</td>
									<td>
										<a href="<c:url value="/admin/employee/detail/${em.em_num}"/>" class="btn btn_blue">조회</a>
									</td>							
								</tr>
							</c:forEach>
						</tbody>
					</table>
							
					<!-- 직원 등록 버튼 -->
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<div class="btn_link_black">
								<a href="<c:url value="/admin/employee/insert"/>" class="btn btn_black js-btn-insert">
									<span>직원등록<i class="ic_link_share"></i></span>
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
				    	{ targets: [6], orderable: false }
				    ]
				});
			</script>

</body>
</html>
