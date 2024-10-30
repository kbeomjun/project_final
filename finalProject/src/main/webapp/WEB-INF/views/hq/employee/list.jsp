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
				<h2 class="sub_title">직원 관리</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			        		<th>직원번호</th>
			        		<th>이름</th>
			        		<th>전화번호</th>
			        		<th>이메일</th>
			        		<th>입사일</th>
			        		<th>소속</th>
			        		<th>직책</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${emList}" var="em">
					      	<tr>
					        	<td>${em.em_num}</td>
						        <td>${em.em_name} </td>
						        <td>${em.em_phone}</td>
						        <td>${em.em_email}</td>
						        <td>
						        	<fmt:formatDate value="${em.em_join}" pattern="yyyy.MM.dd"/>
						        </td>
						        <td>${em.em_br_name}</td>
						        <td>${em.em_position}</td>
					        	<td>
					        		<a class="btn btn_green" href="<c:url value="/hq/employee/detail/${em.em_num}"/>">조회</a>
					        		<a class="btn btn_red btn-delete" href="<c:url value="/hq/employee/delete/${em.em_num}"/>">삭제</a>
					        	</td>
					      	</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<a href="<c:url value="/hq/employee/insert"/>" class="btn btn_black js-btn-insert">
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
		$('.btn-delete').click(function(e){
			if(!confirm("정말 삭제하시겠습니까?\n삭제하시면 복구할 수 없습니다.")){
				e.preventDefault();
			}
		});
	</script>

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
		    stateSave: true,
		    stateDuration: 300,
		    paging: false,
		    info: false,
		    columnDefs: [
		        { targets: [7], orderable: false }
		    ]
		});
	</script>
</body>