<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>
		<section class="sub_banner sub_banner_07"></section>
		<section class="sub_content">
	        <!-- 왼쪽 사이드바 -->
            <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
			<section class="sub_content_group">
				<div class="sub_title_wrap">
					<h2 class="sub_title">결제 내역</h2>
				</div>
                
                <div class="info_container">
					<!-- 현재 이용권 정보 박스 -->
					<div class="info_box info_box_fitness">
						<div class="info_text_box">
							<h5 class="info_content__title">헬스장 이용권</h5>
							<div class="info_content__text">
								<c:if test="${not empty currentMembership}">
	                            	<p>기간 : <fmt:formatDate value="${currentMembership.pa_start}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${currentMembership.pa_end}" pattern="yyyy-MM-dd"/></p>
		                        </c:if>
		                        <c:if test="${empty currentMembership}">
		                            <p>현재 이용 중인 회원권이 없습니다.</p>
		                        </c:if>
							</div>
						</div>
					</div>

					<!-- 진행 중인 PT 정보 박스 -->
					<div class="info_box info_box_fitness_PT">
						<div class="info_text_box">
							<h5 class="info_content__title">PT 이용권</h5>
							<div class="info_content__text">
								<c:if test="${not empty currentPT}">
		                        	<p>기간 : <fmt:formatDate value="${currentPT.pa_start}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${currentPT.pa_end}" pattern="yyyy-MM-dd"/></p>
		                            <p>PT 잔여 횟수 : ${currentPT.remain_count} / ${currentPT.total_count}</p>
		                        </c:if>
		                        <c:if test="${empty currentPT}">
		                            <p>현재 진행 중인 PT가 없습니다.</p>
		                        </c:if>
							</div>
						</div>
					</div>
				</div>
                
				<table class="table table_center" id="table">
					<caption class="blind">결제 내역에 관한 테이블</caption>
					<thead>
						<tr>
							<th scope="col">결제유형</th>
							<th scope="col">결제날짜</th>
							<th scope="col">결제금액</th>
							<th scope="col">시작날짜</th>
							<th scope="col">마감날짜</th>
							<th scope="col">리뷰확인</th>
							<th scope="col">결제상태</th>
							<th scope="col">환불내역</th>
						</tr>
					</thead>
					<tbody id="tbody">
						<c:forEach items="${paymentList}" var="list">
							<tr>
								<td>${list.pt_name}</td>
								<td>
									<fmt:formatDate value="${list.pa_date}" pattern="yyyy-MM-dd"/>
								</td>
								<td>
									<fmt:formatNumber value="${list.pa_price}" type="number" pattern="#,##0"/>
								</td>
								<td>
									<fmt:formatDate value="${list.pa_start}" pattern="yyyy-MM-dd"/>
								</td>
								<td>
									<fmt:formatDate value="${list.pa_end}" pattern="yyyy-MM-dd"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${fn:trim(list.pa_review) eq 'Y'}">작성완료</c:when>
										<c:otherwise>
											<a href="<c:url value="/mypage/review/insert/${list.pa_num}"/>" class="btn btn_green">작성하기</a>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${list.pa_state}</td>
								<td>
									<c:if test="${list.pa_state eq '환불완료'}">
										<a href="javascript:void(0);" onclick="loadRefundDetail(${list.pa_num})" class="btn btn_red">환불내역확인</a>
									</c:if>
									<c:if test="${list.pa_state ne '환불완료'}">
										-
									</c:if>										
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
					
				<div id="refundDetail" class="mt-3"></div>
				
	        </section>
	        
		</section>
	
	<script type="text/javascript">
		// 데이터테이블
		$('#table').DataTable({
			language: {
				search: "",
		        zeroRecords: "",
		        emptyTable: "",
		        lengthMenu: ""
		    },
			//scrollY: 500,
		    pageLength: 10,
		    info: false,
		    stateSave: true,
		    searching: false,
		    stateDuration: 300,
		    order: [[ 1, "desc" ]],
		    columnDefs: [
		    	{ targets: [5, 6, 7], orderable: false },
		        { targets: [0, 1, 2, 3, 4, 5, 6, 7]}
		    ]
		});
	</script>
	
	<script type="text/javascript">
		//환불내역확인 불러오기 ajax
	    function loadRefundDetail(pa_num) {
	        $.ajax({
	        	async: true,
	            url: '<c:url value="/mypage/refundDetail"/>',  // 환불 내역을 가져올 URL
	            type: 'GET',
	            data: { pa_num: pa_num },  // 서버에 전달할 파라미터
	            dataType : "json",
	            success: function(data) {
	                // 환불 내역을 페이지의 특정 영역에 표시
	                renderRefundDetail(data.refund);
	            },
	            error: function(xhr, status, error) {
	            	console.log(jqXHR);
	            }
	        });
	    }
	    
	    function renderRefundDetail(refund) {
	        let html = '<table class="table text-center">';
	        html += '<thead><tr><th>환불날짜</th><th>환불비율</th><th>환불금액</th><th>환불사유</th></tr></thead><tbody>';
	        
	        if (refund) {
	        	// 날짜 포맷을 yyyy-MM-dd로 변경
	            let refundDate = new Date(refund.re_date);
	            let formattedDate = refundDate.getFullYear() + '-' + 
	                                String(refundDate.getMonth() + 1).padStart(2, '0') + '-' + 
	                                String(refundDate.getDate()).padStart(2, '0');
	            html += '<tr>';
	            html += '<td>' + formattedDate + '</td>';
	            html += '<td>' + refund.re_percent + '%</td>';
	            html += '<td>' + refund.re_price.toLocaleString() + '</td>';
	            html += '<td>' + refund.re_reason + '</td>';
	            html += '</tr>';
	        } else {
	            html += '<tr><td colspan="4">환불 내역이 없습니다.</td></tr>';
	        }

	        html += '</tbody></table>';
	        
	        html += '<div class="btn_wrap"><div class="btn_right_wrap"><button type="button" onclick="closeRefundDetail()" class="btn btn_cancel">닫기</button></div>	</div>';

	        // refundDetail div에 HTML 추가
	        $('#refundDetail').html(html);
	        
	    }
	    
	    function closeRefundDetail() {
	        $('#refundDetail').html(''); // 환불 내역 숨기기
	    }

	</script>
	
</body>
</html>
