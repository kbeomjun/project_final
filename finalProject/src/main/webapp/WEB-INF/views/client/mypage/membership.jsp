<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
<style>
    .info-box {
        border: 1px solid #ccc;
        padding: 15px;
        margin: 10px;
        border-radius: 5px;
        width: 45%;
        display: flex;
        flex-direction: column;
    }

    .info-box h5 {
        margin-bottom: 10px;
    }

    .info-box .content {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .info-container {
        display: flex;
        justify-content: space-between;
        align-items: stretch;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
	            <div class="sidebar-sticky">
	                <h4 class="sidebar-heading mt-3">마이페이지 메뉴</h4>
	                <ul class="nav flex-column">
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/schedule/${me_id}"/>">프로그램 일정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link active" href="<c:url value="/client/mypage/membership/${me_id}"/>">회원권</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/review/list/${me_id}"/>">나의 작성글</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/inquiry/list/${me_id}"/>">문의내역</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwcheck/${me_id}"/>">개인정보수정</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" href="<c:url value="/client/mypage/pwchange/${me_id}"/>">비밀번호 변경</a>
	                    </li>
	                </ul>
	            </div>
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
	                <h2>나의 결제내역</h2>
	                
	                <div class="info-container">
	                    <!-- 현재 이용권 정보 박스 -->
	                    <div class="info-box">
	                        <h5>헬스장 이용권</h5>
	                        <div class="content">
		                        <c:if test="${not empty currentMembership}">
		                            <p>기간 : <fmt:formatDate value="${currentMembership.pa_start}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${currentMembership.pa_end}" pattern="yyyy-MM-dd"/></p>
		                        </c:if>
		                        <c:if test="${empty currentMembership}">
		                            <p>현재 이용 중인 회원권이 없습니다.</p>
		                        </c:if>
	                        </div>
	                    </div>

	                    <!-- 진행 중인 PT 정보 박스 -->
	                    <div class="info-box">
	                        <h5>진행 중인 PT</h5>
	                        <div class="content">
		                        <c:if test="${not empty currentPT}">
		                        	<p>기간 : <fmt:formatDate value="${currentPT.pa_start}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${currentPT.pa_end}" pattern="yyyy-MM-dd"/></p>
		                            <p>PT 잔여 횟수: [${currentPT.remain_count} / ${currentPT.total_count}]</p>
		                        </c:if>
		                        <c:if test="${empty currentPT}">
		                            <p>현재 진행 중인 PT가 없습니다.</p>
		                        </c:if>
	                        </div>
	                    </div>
	                </div>
	                
					<table class="table text-center">
						<thead>
							<tr>
								<th>결제유형</th>
								<th>결제날짜</th>
								<th>결제금액</th>
								<th>시작날짜</th>
								<th>마감날짜</th>
								<th>리뷰확인</th>
								<th>결제상태</th>
								<th>환불내역</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${paymentList}" var="list">
								<tr>
									<td>${list.pt_type}</td>
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
												<a href="<c:url value="/client/mypage/review/insert/${list.pa_num}/${pm.cri.page}"/>">작성하기</a>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${list.pa_state}</td>
									<td>
										<c:if test="${list.pa_state eq '환불완료'}">
											<a href="javascript:void(0);" onclick="loadRefundDetail(${list.pa_num})">환불내역확인</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${paymentList.size() eq 0}">
								<tr>
									<th class="text-center" colspan="8">결제 내역이 없습니다.</th>							
								</tr>
							</c:if>
						</tbody>
					</table>
					
					<c:if test="${pm.totalCount ne 0}">
						<ul class="pagination justify-content-center">
							<c:if test="${pm.prev}">
								<c:url var="url" value="/client/mypage/membership/${me_id}">
									<c:param name="page" value="${pm.startPage - 1}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
								<c:url var="url" value="/client/mypage/membership/${me_id}">
									<c:param name="page" value="${i}"/>
								</c:url>
								<c:choose>
									<c:when test="${pm.cri.page eq i}">
										<c:set var="active" value="active"/>
									</c:when>
									<c:otherwise>
										<c:set var="active" value=""/>
									</c:otherwise>
								</c:choose>
								<li class="page-item ${active}">
									<a class="page-link" href="${url}">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${pm.next}">
								<c:url var="url" value="/client/mypage/membership/${me_id}">
									<c:param name="page" value="${pm.endPage + 1}"/>
								</c:url>
								<li class="page-item">
									<a class="page-link" href="${url}">다음</a>
								</li>
							</c:if>
						</ul>
					</c:if>
					
					<div id="refundDetail" class="mt-3"></div>
					
	            </div>
	        </main>
	    </div>
	</div>
	
	<script type="text/javascript">
	    function loadRefundDetail(pa_num) {
	        $.ajax({
	        	async: true,
	            url: '<c:url value="/client/mypage/refundDetail"/>',  // 환불 내역을 가져올 URL
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

	        // refundDetail div에 HTML 추가
	        $('#refundDetail').html(html);
	    }

	</script>
	
</body>
</html>
