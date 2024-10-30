<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<h2 class="sub_title">지점 관리</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			        		<th>지점</th>
			        		<th>지점번호</th>
			        		<th>지점주소</th>
			        		<th>관리자계정</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${brList}" var="br">
					      	<tr>
					        	<td>${br.br_name}</td>
						        <td>${br.br_phone}</td>
						        <td>${br.br_address}(${br.br_detailAddress})</td>
					        	<td>${br.br_admin}</td>
					        	<td>
					        		<a class="btn btn_green" href="<c:url value="/hq/branch/detail/${br.br_name}"/>">조회</a>
					        	</td>
					      	</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<a href="<c:url value="/hq/branch/insert"/>" class="btn btn_black js-btn-insert">
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
		// 테이블 api
		$('#table').DataTable({
			language: {
				search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
			scrollY: 500,
		    paging: false,
		    info: false,
		    stateSave: true,
		    stateDuration: 300,
		    columnDefs: [
		        { targets: [4], orderable: false }
		    ]
		});
	</script>
</body>