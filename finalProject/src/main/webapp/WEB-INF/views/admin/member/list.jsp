<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>회원 목록</title>
	<style type="text/css">
    	#thead th{text-align: center;}
    	#tbody td{text-align: center;}
    	.dt-layout-end, .dt-search{margin: 0; width: 100%;}
    	.dt-input{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px; width: 100%;}
    </style>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">회원 목록</h2>
					<table class="table text-center" id="table">
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
					        			<c:if test="${me.me_kakaoUserId == null && me.me_naverUserId == null}">-</c:if>
					        			<c:if test="${me.me_kakaoUserId != null}">카카오</c:if>
					        			<c:if test="${me.me_naverUserId != null}">네이버</c:if>
					        		</td>
					        		<td>
					        			<c:if test="${me.me_authority == 'USER'}">사용중</c:if>
					        			<c:if test="${me.me_authority == 'REMOVED'}">탈퇴</c:if>
					        		</td>									
									<td>
										<a href="<c:url value="/admin/member/detail/${me.me_id}"/>">조회</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${memberList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="9">등록된 회원이 없습니다.</th>
								</tr>
							</c:if>
						</tbody>
					</table>
					
					<div class="text-right mb-3">
						<a href="<c:url value="/terms"/>" class="btn btn-outline-success btn-sm">회원등록</a>
					</div>
	                
	            </div>
	        </main>
	    </div>
	</div>	
	
	<script type="text/javascript">
		// 데이터테이블
		$('#table').DataTable({
			language: {
		        search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
			scrollY: 200,
		    paging: true,
		    pageLength: 5,
		    lengthChange: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [8], orderable: false },
		        { targets: [0, 1, 2, 3, 4, 5, 6, 7, 8], className: "align-content-center"}
		    ]
		});
	</script>
	
</body>
</html>
