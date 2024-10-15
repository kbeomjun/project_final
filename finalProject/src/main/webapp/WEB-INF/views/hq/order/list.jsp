<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
</head>
<body>
	<div class="container" style="margin-top:30px">
	  	<div class="row">
	    	<div class="col-sm-2">
		    	<ul class="nav nav-pills flex-column">
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/branch/list"/>">지점 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/employee/list"/>">직원 관리</a>
	       	 		</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/equipment/list"/>">운동기구 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/stock/list"/>">재고 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/order/list"/>">발주 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/paymentType/list"/>">회원권 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/member/list"/>">회원 조회</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
		    	<div>
			    	<button type="button" class="btn btn-outline-info btn-menu btn-wait active" data-name="wait">대기</button>
			    	<button type="button" class="btn btn-outline-info btn-menu btn-done" data-name="done">완료</button>
			    </div>
			    <hr>
		    	<div class="mt-3 box box-wait">
		    		<table class="table table-hover table-wait">
				    	<thead>
				      		<tr>
				        		<th class="text-center">내역번호</th>
				        		<th class="text-center">지점</th>
				        		<th class="text-center">신청날짜</th>
				        		<th class="text-center">기구명</th>
				        		<th class="text-center">수량</th>
				        		<th class="text-center">상태</th>
				        		<th class="text-center"></th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${boWaitList}" var="bo">
				    			<tr>
					        		<td class="align-content-center text-left">${bo.bo_num}</td>
					        		<td class="align-content-center text-left">${bo.bo_br_name}</td>
					        		<td class="align-content-center text-left">
					        			<fmt:formatDate value="${bo.bo_date}" pattern="yyyy.MM.dd hh:mm:ss"/>
				        			</td>
					        		<td class="align-content-center text-left">${bo.bo_se_name}</td>
					        		<td class="align-content-center text-left">${bo.bo_amount}</td>
					        		<td class="align-content-center text-left">${bo.bo_state}</td>
					        		<td class="align-content-center text-left">
					        			<a href="<c:url value="/hq/order/accept/${bo.bo_num}"/>" class="btn btn-outline-success">승인</a>
					        			<a href="<c:url value="/hq/order/deny/${bo.bo_num}"/>" class="btn btn-outline-danger">거부</a>
					        		</td>
					      		</tr>
				    		</c:forEach>
				    		<c:if test="${boWaitList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="7">발주대기 내역이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
				</div>
				<div class="mt-3 box box-done" style="display: none;">
		    		<table class="table table-hover table-done">
				    	<thead>
				      		<tr>
				        		<th class="text-center">내역번호</th>
				        		<th class="text-center">지점</th>
				        		<th class="text-center">신청날짜</th>
				        		<th class="text-center">기구명</th>
				        		<th class="text-center">수량</th>
				        		<th class="text-center">상태</th>
				        		<th class="text-center"></th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${boDoneList}" var="bo">
				    			<tr>
					        		<td class="align-content-center text-left">${bo.bo_num}</td>
					        		<td class="align-content-center text-left">${bo.bo_br_name}</td>
					        		<td class="align-content-center text-left">
					        			<fmt:formatDate value="${bo.bo_date}" pattern="yyyy.MM.dd hh:mm:ss"/>
				        			</td>
					        		<td class="align-content-center text-left">${bo.bo_se_name}</td>
					        		<td class="align-content-center text-left">${bo.bo_amount}</td>
					        		<td class="align-content-center text-left">${bo.bo_state}</td>
					        		<td class="align-content-center text-left">
					        		
					        		</td>
					      		</tr>
				    		</c:forEach>
				    		<c:if test="${boDoneList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="7">발주완료 내역이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
				</div>
	    	</div>
	  	</div>
	</div>
	
	<script type="text/javascript">
		var table = $('.table-wait').DataTable({
			language: {
		        search: "검색:",
		        zeroRecords: ""
		    },
			scrollY: 600,
		    paging: false,
		    info: false,
		    columnDefs: [
		        {
		        	targets: [5, 6], 
		        	orderable: false
	        	}
		    ]
		});
		
		$('.btn-menu').click(function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("active");
			$('.btn-'+name).addClass("active");
			
			$('.box').css("display", "none");
			$('.box-'+name).css("display", "block");
			
			table.destroy();
			table = $('.table-'+name).DataTable({
				language: {
			        search: "검색:",
			        zeroRecords: ""
			    },
				scrollY: 600,
			    paging: false,
			    info: false,
			    columnDefs: [
			        {
			        	targets: [5, 6], 
			        	orderable: false
		        	}
			    ]
			});
		});
	</script>
</body>
</html>