<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>운동기구 재고 변동내역</title>
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
					<h2 class="mt-3 mb-3">${br_name} 재고 변동내역</h2>
					<table class="table text-center" id="table">
						<thead id="thead">
							<tr>
								<th>운동기구명</th>
								<th>제조년월일</th>
								<th>수량</th>
								<th>기록날짜</th>
								<th>기록유형</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${equipmentChange}" var="change">
								<tr>
									<td>${change.be_se_name}</td>
									<td>
										<fmt:formatDate value="${change.be_birth}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${change.be_amount}</td>
									<td>
										<fmt:formatDate value="${change.be_record}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${change.be_type}</td>
								</tr>
							</c:forEach>
							<c:if test="${equipmentChange.size() eq 0}">
								<tr>
									<th class="text-center" colspan="5">변동내역이 없습니다.</th>							
								</tr>
							</c:if>
						</tbody>
					</table>
	                
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
		        emptyTable: "",
		        lengthMenu: ""
		    },
		    createdRow: function(row, data, dataIndex) {
		        if (data[2] < 0) {
		        	$('td', row).eq(2).css('color', 'red');
		        }
		        if (data[2] > 0) {
		        	$('td', row).eq(2).css('color', 'green');
		        }
		    },
			scrollY: 500,
		    pageLength: 10,
		    info: false,
		    stateSave: true,
		    stateDuration: 300,
		    order: [[ 3, "desc" ]],
		    columnDefs: [
		        { targets: [0, 1, 2, 3, 4], className: "align-content-center"}
		    ]
		});
	</script>

</body>
</html>
