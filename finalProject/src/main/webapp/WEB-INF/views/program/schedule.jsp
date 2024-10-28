<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/css/calendar.css"/>">


<style type="text/css">
.sidebar {
	width: 200px;
	padding: 20px;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.sidebar a {
	width: 100%;
	padding: 15px;
	margin-bottom: 10px;
	border: none;
	background: #fff;
	text-align: left;
	cursor: pointer;
	font-size: 16px;
	border: 1px solid #ccc;
	transition: background 0.3s;
	text-align: center;
	letter-spacing: 10px;
}

.sidebar a:hover {
	background: #ddd;
}

.main-container {
	display: flex;
	align-items: flex-start;
}

.selected {
	color: #fff !important;
	background: #000 !important;
	position: relative;
	box-shadow: 4px 4px 0px 0px rgba(0, 0, 0, 0.5); /* 오른쪽과 아래쪽에 그림자 효과 */
}

.sidebar .selected {
	width: 115%;
	transition: width 0.5s ease; /* 너비 변화 애니메이션 */
}

.main-container {
	display: flex;
	align-items: flex-start;
}

.navbar {
	display: flex;
	justify-content: center;
	/* background: #eee; */
	padding: 10px 0;
}

.navbar a {
	margin: 0 15px;
	text-decoration: none;
	color: #333;
	font-weight: bold;
}

.sub_navbar {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
}
</style>
</head>
<body>
	<section class="sub_banner sub_banner_03"></section>
	<!-- <h1>프로그램 일정</h1> -->
	<div class="navbar mb-3">
		<a class="btn br-3"
			href="<c:url value="/program/info"/>">프로그램 안내</a>
		<a class="btn selected" href="<c:url value="/program/schedule"/>">프로그램
			일정</a>
	</div>

	<section class="sub_content">
		
		<!-- lnb -->
		<section class="lnb_wrap">
		<div class="main-container">
			<div class="mb-2">
			<div class="btn_wrap">
				<div class="btn_link_black <c:if test="${br_name ne 'null' && br_name != null}">bg_white</c:if>">
					<a class="btn btn_black js-btn-insert"
						href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/null/${pr_name != null ? pr_name : 'null'}/false"/>">
						<span>전체<i class="ic_link_share"></i></span> 
					</a>
					<div class="btn_black_top_line"></div>
					<div class="btn_black_right_line"></div>
					<div class="btn_black_bottom_line"></div>
					<div class="btn_black_left_line"></div>
				</div>
			</div>	
			<c:forEach items="${branch_list}" var="br" varStatus="status">
			<c:if test="${br.br_name ne '본사'}">
			<c:choose>
				<c:when test="${br.br_name == br_name}">
					<c:set var="unSelected" value="" />
				</c:when>
				<c:otherwise>
					<c:set var="unSelected" value="bg_white" />
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btn_link_black ${unSelected}">
					<a
						class="btn btn_black js-btn-insert"
						href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br.br_name}/${pr_name != null ? pr_name : 'null'}/false"/>">
						<span>${br.br_name }<i class="ic_link_share"></i></span>
					</a>
					<div class="btn_black_top_line"></div>
					<div class="btn_black_right_line"></div>
					<div class="btn_black_bottom_line"></div>
					<div class="btn_black_left_line"></div>
				</div>
			</div>
			</c:if>
			</c:forEach>
			</div>
		</div>
		
	</section>

		<!-- 오른쪽 컨텐츠 영역 -->
	<section class="sub_content_group"> 
		
	
		<fmt:formatDate value="${nowDate}" pattern="yyyy-MM-dd" var="today" />
		<fmt:formatDate value="${nowDate}" pattern="dd" var="todayDate" />
		<fmt:formatDate value="${nowDate}" pattern="MM" var="todayMonth" />
		<fmt:formatDate value="${nowDate}" pattern="yyyy" var="todayYear" />
		<div class="account-book-container">
			<div class="sub_navbar">
	
	
				<a class="btn btn-<c:if test="${pr_name ne 'null'}">outline-</c:if>info ml-2"
					href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/null/false"/>">
					전체 
				</a>
				<c:forEach items="${program_list}" var="pr" varStatus="status">
					<c:if test="${pr.sp_name ne 'PT'}">
						<c:choose>
							<c:when test="${pr.sp_name == pr_name}">
								<c:set var="outline" value="" />
							</c:when>
							<c:otherwise>
								<c:set var="outline" value="outline-" />
							</c:otherwise>
						</c:choose>
						<a class="btn btn-${outline}info ml-2"
							href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/${pr.sp_name}/false"/>">
							${pr.sp_name } </a>
					</c:if>
				</c:forEach>
			</div>
			<div class="calendar-wrapper ml-3">
				<span class="fw-bold fs-5 ml-3" style="font-size: 1.5rem;">${cal.year}년 ${cal.month+1}월</span>
				<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
					<span> <c:if
							test="${ cal.year ne todayYear || ((cal.month+1) ne todayMonth)}">
							<a class="btn btn-outline-dark"
								href="<c:url value="/program/schedule/${cal.year}/${cal.month-1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/false"/>">이전달</a>
						</c:if>
					</span>  <span>
						<a class="btn btn-outline-dark"
						href="<c:url value="/program/schedule/${cal.year}/${cal.month+1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/false"/>">다음달</a>
					</span>
				</div>

				<table class="table text-center table-bordered calendar">
					<tr class="table-light text-center fs-5 tr-h">
						<th class="text-danger">일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th class="text-primary">토</th>
					</tr>

					<c:forEach begin="1" end="${cal.tdCnt}" step="7" var="i">
						<tr>
							<c:forEach begin="${i }" end="${i + 6}" step="1" var="j">
								<td><c:if test="${selected ne null }">
										<c:choose>
											<c:when
												test="${selected.dayOfMonth == (j - cal.startBlankCnt)}">
												<c:set var="cls" value="selected" />
											</c:when>
											<c:otherwise>
												<c:set var="cls" value="" />
											</c:otherwise>
										</c:choose>
									</c:if> <c:if
										test="${(j > cal.startBlankCnt) && (j <= cal.startBlankCnt + cal.lastDate)}">
										<c:set var="url"
											value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/true" />

										<c:choose>
											<c:when test="${cal.year > todayYear}">
												<c:set var="disabled" value="" />
											</c:when>
											<c:when test="${(cal.month+1) > todayMonth}">
												<c:set var="disabled" value="" />
											</c:when>
											<c:when
												test="${((cal.month+1) eq todayMonth) && ((j - cal.startBlankCnt) >= todayDate)}">
												<c:set var="disabled" value="" />
											</c:when>
											<c:otherwise>
												<c:set var="disabled" value="disabled" />
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${j % 7 == 0 }">
												<a href="<c:url value="${url}"/>" class="btn ${disabled}">
													<span class="text-primary mb-3 ${cls}">${j - cal.startBlankCnt }</span>
												</a>
												<br>
											</c:when>
											<c:when test="${j % 7 == 1 }">
												<a href="<c:url value="${url}"/>" class="btn ${disabled}">
													<span class="text-danger mb-3 ${cls}">${j - cal.startBlankCnt }
												</span>
												</a>
												<br>
											</c:when>
											<c:otherwise>
												<a href="<c:url value="${url}"/>" class="btn ${disabled}">
													<span class="mb-3 ${cls}"> ${j - cal.startBlankCnt }
												</span>
												</a>
												<br>
											</c:otherwise>
										</c:choose>
										<c:set var="sp_name_distinct" value="PT" />
										<c:forEach items="${ps_list}" var="ps" varStatus="status">
											<fmt:formatDate value='${ps.bs_start}' pattern='dd'
												var="ps_day" />
											<c:if test="${(j - cal.startBlankCnt) eq ps_day}">
												<c:if
													test="${fn:contains(sp_name_distinct, ps.bp_sp_name) == false}">
													<a class="btn btn-success program-button ${disabled}"
														href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${ps.bp_sp_name}/true"/>">
														<span>${ps.bp_sp_name}</span>
													</a>
													<c:set var="sp_name_distinct"
														value="${sp_name_distinct},${ps.bp_sp_name}" />
												</c:if>
											</c:if>
										</c:forEach>
									</c:if></td>
							</c:forEach>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
	</div>
	</section></section>
	<!-- Modal -->
	<div class="modal fade" id="tableModal" tabindex="-1" role="dialog"
		aria-labelledby="tableModalLabel" aria-hidden="true" data-bs-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="tableModalLabel">프로그램 목록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="overflow-auto mt-3 mb-3" style="max-height: 70vh;">
						<table class="table table-striped" id="modalTable">
							<thead>
								<tr>
									<th>프로그램</th>
									<th>지점</th>
									<th>강사</th>
									<th>시간</th>
									<th>인원</th>
									<th>예약</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ps_list}" var="ps" varStatus="status">
									<fmt:formatDate value='${ps.bs_start}' pattern='dd'
										var="ps_day" />
									<c:if test="${ps.bp_sp_name ne 'PT' && cal.day eq ps_day}">
										<tr>
											<td>${ps.bp_sp_name }</td>
											<td>${fn:replace(ps.bp_br_name, '점', '')}</td>
											<td>${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})</td>
											<td><fmt:formatDate value="${ps.bs_start}"
													pattern="HH:mm" /> <br />~<fmt:formatDate
													value="${ps.bs_end}" pattern="HH:mm" /></td>
											<td>${ps.bs_current}/${ps.bp_total }</td>
											<td><c:set var="currentTime"
													value="<%=new java.util.Date()%>" /> <c:choose>
													<c:when
														test="${ps.bs_current ne ps.bp_total && currentTime.before(ps.bs_start)}">
														<!-- 정원 초과가 아니고 현재 시간보다 이전 프로그램이 아니라면 예약 가능 -->
														<form action="<c:url value="/program/reservation" />"
															method="post">
															<input type="hidden" name="bs_num" value="${ps.bs_num}">
															<button
																class="btn btn-outline-primary btn-program-reservation1"
																data-program="${ps.bp_sp_name}/${ps.bp_br_name}/${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})/<fmt:formatDate value="${ps.bs_start}" pattern="HH:mm"/>~<fmt:formatDate value="${ps.bs_end}" pattern="HH:mm" />"
																data-num="${ps.bs_num}" type="button">예약</button>
														</form>
													</c:when>
													<c:otherwise>
														<span class="btn btn-program-reservation2">마감</span>
													</c:otherwise>
												</c:choose></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function() {
        // showModal 값이 true일 때만 모달 실행
        var showModal = ${showModal}; // JSTL 변수를 JavaScript로 사용

        if (showModal) {
            $('#tableModal').modal('show');
        }
    });
	</script>
	<script>
	
	$(document).on('click', '.btn-program-reservation1', function(e) {
		e.preventDefault(); // 기본 이벤트 방지
		
	    const button = $(this);  // 현재 클릭된 버튼 객체
	    const program = button.data('program'); 
	    const bs_num = button.data('num');
		
 		if(${user == null}) {
			if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
					location.href = "<c:url value="/login"/>";
			}
			return;
		}
 		
		var id = "${user.me_id}";
		var noshow = "${user.me_noshow}";
		
 
	    if (confirm(program + '으로 예약하시겠습니까?\n' + 
                '노쇼 누적시 예약이 제한될 수 있습니다.\n(' + 
                id + '님의 누적 노쇼: ' + noshow + '번)')) {
        
        var isDuplicated = checkReservation(bs_num);
        if (isDuplicated) {
            alert('이미 예약한 프로그램입니다.');
        } else {
            // 폼 제출
            $(this).closest('form').submit(); // 해당 버튼의 부모 폼 제출
        }
    }
	});
	
	function checkReservation(bs_num) {
		
		var isDuplicated = false;
		
		$.ajax({
	        async : false,
	        url : '<c:url value="/program/checkReservation"/>',
	        type : 'get',
	        data : { bs_num: bs_num }, 
	        dataType : 'json',
	        success : function(data) {
	        	isDuplicated = data.checkReservation;
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            console.log(jqXHR);
	        }
	    });
		
		return isDuplicated;
	}
		
</script>

	<script type="text/javascript">
	// 모든 링크에 대해 클릭 이벤트 추가
    const links = document.querySelectorAll('a');

    links.forEach(link => {
        link.addEventListener('click', function(event) {
            // 클릭한 요소가 disabled 클래스를 가지고 있는지 확인
            if (this.classList.contains('disabled')) {
                event.preventDefault(); 
                alert('기한이 지난 프로그램입니다.'); // 사용자 알림
            }
        });
    });
</script>

</body>

</html>



