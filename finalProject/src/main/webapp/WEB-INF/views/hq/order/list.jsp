<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<body>
	<section class="sub_banner sub_banner_06"></section>
	<section class="sub_content">
        <!-- 왼쪽 사이드바 -->
        <%@ include file="/WEB-INF/views/layout/hqSidebar.jsp" %>

        <!-- 오른쪽 컨텐츠 영역 -->
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">발주 내역</h2>
			</div>
			
			<div class="sub_hd_wrap">
	    		<ul class="tab_list">
			    	<li class="tab_item">
			    		<button type="button" class="tab_link btn-menu btn-menu btn-wait _active" data-name="wait">대기</button>
		    		</li>
			    	<li class="tab_item">
			    		<button type="button" class="tab_link btn-menu btn-menu btn-done" data-name="done">완료</button>
		    		</li>
		    	</ul>
		    </div>
			
			<div class="table_wrap box box-wait">
		    	<table class="table table_center table-wait">
			    	<thead id="thead">
			      		<tr>
			        		<th>내역번호</th>
			        		<th>지점</th>
			        		<th>신청날짜</th>
			        		<th>기구명</th>
			        		<th>수량</th>
			        		<th>상태</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${boWaitList}" var="bo">
			    			<tr>
				        		<td>${bo.bo_num}</td>
				        		<td>${bo.bo_br_name}</td>
				        		<td>
				        			<fmt:formatDate value="${bo.bo_date}" pattern="yyyy.MM.dd hh:mm:ss"/>
			        			</td>
				        		<td>${bo.bo_se_name}</td>
				        		<td>${bo.bo_amount}</td>
				        		<td>${bo.bo_state}</td>
				        		<td>
				        			<a href="<c:url value="/hq/order/accept/${bo.bo_num}"/>" class="btn btn_green">승인</a>
				        			<a href="<c:url value="/hq/order/deny/${bo.bo_num}"/>" class="btn btn_red">거부</a>
				        		</td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="table_wrap box box-done" style="display: none;">
		    	<table class="table table_center table-done">
			    	<thead id="thead">
			      		<tr>
			        		<th>내역번호</th>
			        		<th>지점</th>
			        		<th>신청날짜</th>
			        		<th>기구명</th>
			        		<th>수량</th>
			        		<th>상태</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${boDoneList}" var="bo">
			    			<tr>
				        		<td>${bo.bo_num}</td>
				        		<td>${bo.bo_br_name}</td>
				        		<td>
				        			<fmt:formatDate value="${bo.bo_date}" pattern="yyyy.MM.dd hh:mm:ss"/>
			        			</td>
				        		<td>${bo.bo_se_name}</td>
				        		<td>${bo.bo_amount}</td>
				        		<td>${bo.bo_state}</td>
				        		<td></td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
    	</section>
	</section>

	<script type="text/javascript">
		// 데이터테이블
		var table = $('.table-wait').DataTable({
			language: {
				search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
		    scrollY: 500,
		    stateSave: true,
		    stateDuration: 300,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [5, 6], orderable: false }
		    ]
		});
		
		$('.btn-menu').click(function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("_active");
			$('.btn-'+name).addClass("_active");
			
			$('.box').css("display", "none");
			$('.box-'+name).css("display", "block");
			
			table.destroy();
			if(name == 'wait'){
				table = $('.table-'+name).DataTable({
					language: {
						search: "",
				        searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: ""
				    },
				    scrollY: 500,
				    stateSave: true,
				    stateDuration: 300,
				    paging: false,
				    info: false,
				    order: [[ 0, "asc" ]],
				    columnDefs: [
				        { targets: [5, 6], orderable: false }
				    ]
				});
			}else{
				table = $('.table-'+name).DataTable({
					language: {
						search: "",
				        searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: ""
				    },
				    scrollY: 500,
				    stateSave: true,
				    stateDuration: 300,
				    paging: false,
				    info: false,
				    order: [[ 0, "desc" ]],
				    columnDefs: [
				        { targets: [5, 6], orderable: false }
				    ]
				});
			}
		});
	</script>
</body>