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
				<h2 class="sub_title">프로그램 관리</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			        		<th>프로그램</th>
			        		<th>유형</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${spList}" var="sp">
			    			<tr>
				        		<td>${sp.sp_name}</td>
				        		<td>${sp.sp_type}</td>
				        		<td>
				        			<a href="<c:url value="/hq/program/detail/${sp.sp_name}"/>" class="btn btn_green">조회</a>
				        		</td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<a href="<c:url value="/hq/program/insert"/>" class="btn btn_black js-btn-insert">
							<span>등록<i class="ic_link_share"></i></span>
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
		        emptyTable: ""
		    },
		    scrollY: 500,
		    stateSave: true,
		    stateDuration: 300,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [2], orderable: false }
		    ]
		});
	</script>
</body>