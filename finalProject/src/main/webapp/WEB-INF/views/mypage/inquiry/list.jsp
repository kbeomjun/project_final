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
					<div class="sub_title_wrap">
						<h2 class="sub_title">나의 문의내역</h2>
					</div>
					
					<div class="table_wrap">
						<table class="table table_center" id="table">
							<thead id="thead">
								<tr>
									<th>문의유형</th>
									<th>지점</th>
									<th>제목</th>
									<th>문의날짜</th>
									<th>문의상태</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<c:forEach items="${inquiryList}" var="list">
									<tr>
										<td>${list.mi_it_name}</td>
										<td>${list.mi_br_name}</td>
										<td>
											<a href="<c:url value="/mypage/inquiry/detail/${list.mi_num}"/>">${list.mi_title}</a>
										</td>
										<td>
											<fmt:formatDate value="${list.mi_date}" pattern="yyyy-MM-dd"/>
										</td>
										<td>${list.mi_state}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>				
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
				    createdRow: function(row, data, dataIndex) {
				        if (data[4] == "답변완료") {
				        	$('td', row).eq(4).css('color', 'red');
				        }
				        if (data[4] == "답변대기") {
				        	$('td', row).eq(4).css('color', 'blue');
				        }
				    },
				    pageLength: 10,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 3, "desc" ]]
				});
			</script>	
