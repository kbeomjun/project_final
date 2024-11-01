<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/program/schedule.css"/>">

<style type="text/css">
.employee-modal .modal-content {
	width: 800px; /* 고정 너비를 500px로 설정 */
	margin: auto; /* 중앙 정렬 */
	border-radius: 8px; /* 모서리 둥글게 하기 (선택 사항) */
	padding: 20px; /* 여백 추가 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 (선택 사항) */
}

.employee-modal .close {
	cursor: pointer;
	font-size: 3rem;
	padding: 0;
}
.modal-dialog .close {
	padding: 2rem 2rem 0 0;
	margin: -2rem -1rem -1rem auto;
	font-size: 3rem;
}

.employee-modal .modal-header,
.modal-dialog .modal-header {
    border-bottom: none;
}

.calendar,
.calendar td {
border : none;
}
.calendar {
    border-collapse: separate;
    border-spacing: 15px;
    table-layout: fixed; /* 고정 레이아웃 설정 */
}

.calendar th {
border : none !important;
}

.calendar td {
border-top : solid 1px;
}

.calendar span {
	font-weight: 500 !important;
}
</style>
</head>
<body>
	<section class="sub_banner sub_banner_03"></section>
	<!-- <h1>프로그램 일정</h1> -->
	<div class="navbar">
		<a class="btn br-3" href="<c:url value="/program/info"/>">프로그램 안내</a>
		<a class="btn btn-selected" href="<c:url value="/program/schedule"/>">프로그램
			일정</a>
	</div>

	<section class="sub_content">

		<!-- lnb -->
		<section class="lnb_wrap">
			<div class="main-container">
				<div class="mb-2">
					<div class="btn_wrap">
						<div
							class="btn_link_black 
				<c:choose>
					<c:when test="${br_name ne 'null' && br_name != null}">
					bg_white
					</c:when>
					<c:otherwise>
					btn-wide
					</c:otherwise>
				</c:choose>
				">
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
									<c:set var="unSelected" value="btn-wide" />
								</c:when>
								<c:otherwise>
									<c:set var="unSelected" value="bg_white" />
								</c:otherwise>
							</c:choose>
							<div class="btn_wrap">
								<div class="btn_link_black ${unSelected}">
									<a class="btn btn_black js-btn-insert"
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
					<ul class="tab_list">
						<li class="tab_item">
						<a
							class="btn tab_link <c:if test="${pr_name eq 'null'}">_active</c:if>"
							href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/null/false"/>">
							전체 </a></li>
						
					<c:forEach items="${program_list}" var="pr" varStatus="status">
						<c:if test="${pr.sp_name ne 'PT'}">
							<!-- 여기에 각 색상을 순서대로 클래스로 set하고 a 태그 클래스에 추가 -->
							<c:choose>
								<c:when test="${pr.sp_name == pr_name}">
									<c:set var="_btn_seleceted" value="_active" />
								</c:when>
								<c:otherwise>
									<c:set var="_btn_seleceted" value="" />
								</c:otherwise>
							</c:choose>
							<li class="tab_item">
							<a class="btn tab_link ${_btn_seleceted}"
								href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/${pr.sp_name}/false"/>">
								${pr.sp_name } </a></li>
						</c:if>
					</c:forEach>
					</ul>
				</div>
				<div class="calendar-wrapper">
					<span class="fs-5 ml-3" style="font-size: 1.5rem; font-weight: 600;">${cal.year}년
						${cal.month+1}월</span>
					<div class="p-3 d-flex justify-content-between">
						<span> <c:if
								test="${ cal.year ne todayYear || ((cal.month+1) ne todayMonth)}">
								<a class="btn tab_link" style="border-radius: 10px;"
									href="<c:url value="/program/schedule/${cal.year}/${cal.month-1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/false"/>">이전달</a>
							</c:if>
						</span> <span> <a class="btn tab_link" style="border-radius: 10px;"
							href="<c:url value="/program/schedule/${cal.year}/${cal.month+1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/false"/>">다음달</a>
						</span>
					</div>

					<table class="table text-center table-bordered calendar">
						<tr class="table-light text-center fs-5 tr-h">
							<th class="text-danger">일요일</th>
							<th>월요일</th>
							<th>화요일</th>
							<th>수요일</th>
							<th>목요일</th>
							<th>금요일</th>
							<th class="text-primary">토요일</th>
						</tr>

						<c:forEach begin="1" end="${cal.tdCnt}" step="7" var="i">
							<tr>
								<c:forEach begin="${i }" end="${i + 6}" step="1" var="j">
									<c:choose>
										<c:when test="${j % 7 == 0 }">
										<td class="text-primary">
										</c:when>
										<c:when test="${j % 7 == 1 }">
										<td class="text-danger">
										</c:when>
										<c:otherwise>
										<td>
										</c:otherwise>
									</c:choose>
									<c:if test="${selected ne null }">
											<c:choose>
												<c:when
													test="${selected.dayOfMonth == (j - cal.startBlankCnt)}">
													<c:set var="cls" value="selected" />
												</c:when>
												<c:otherwise>
													<c:set var="cls" value="" />
												</c:otherwise>
											</c:choose>
										</c:if> 
										<c:if test="${(j > cal.startBlankCnt) && (j <= cal.startBlankCnt + cal.lastDate)}">
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
														<span class="text-primary mb-3 ${cls}"><fmt:formatNumber value="${j - cal.startBlankCnt}" pattern="00" /></span>
													</a>
													<br>
												</c:when>
												<c:when test="${j % 7 == 1 }">
													<a href="<c:url value="${url}"/>" class="btn ${disabled}">
														<span class="text-danger mb-3 ${cls}"><fmt:formatNumber value="${j - cal.startBlankCnt}" pattern="00" /></span>
													</a>
													<br>
												</c:when>
												<c:otherwise>
													<a href="<c:url value="${url}"/>" class="btn ${disabled}">
														<span class="mb-3 ${cls}"><fmt:formatNumber value="${j - cal.startBlankCnt}" pattern="00" /></span>
													</a>
													<br>
												</c:otherwise>
											</c:choose>
											<c:set var="sp_name_distinct" value="PT" />
											<div style="text-align: center;">
											<c:forEach items="${ps_list}" var="ps" varStatus="status">
											    <fmt:formatDate value='${ps.bs_start}' pattern='dd' var="ps_day" />
											    
											    <c:if test="${(j - cal.startBlankCnt) eq ps_day}">
											    	
											    	<c:set var="colorClass" value="" />

											        <c:choose>
											            <c:when test="${ps.bp_sp_name eq '필라테스'}">
											                <c:set var="colorClass" value="btn_group_color_1" />
											            </c:when>
											            <c:when test="${ps.bp_sp_name eq '요가'}">
											                <c:set var="colorClass" value="btn_group_color_2" />
											            </c:when>
											            <c:when test="${ps.bp_sp_name eq '스피닝'}">
											                <c:set var="colorClass" value="btn_group_color_3" />
											            </c:when>
											            <c:when test="${ps.bp_sp_name eq '크로스핏'}">
											                <c:set var="colorClass" value="btn_group_color_4" />
											            </c:when>
											            <c:otherwise>
											                <c:set var="colorClass" value="btn_group_color_10" /> 
											            </c:otherwise>
											        </c:choose>
											
											        <c:if test="${fn:contains(sp_name_distinct, ps.bp_sp_name) == false}">
											        
											            <a class="btn ${colorClass} program-button ${disabled}"
											                href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${ps.bp_sp_name}/true"/>">
											                <span>${ps.bp_sp_name}</span>
											            </a>
											            <c:set var="sp_name_distinct" value="${sp_name_distinct},${ps.bp_sp_name}" />
											        </c:if>
											    </c:if>
											</c:forEach>
											</div>
										</c:if></td>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</section>
	</section>
	<!-- Modal -->
	<div class="modal fade" id="tableModal" tabindex="-1" role="dialog"
		aria-labelledby="tableModalLabel" aria-hidden="true"
		data-bs-backdrop="static">
		<div class="modal-dialog" role="document" style="max-width: 800px;">
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
											<td><a class="btn btn-view-details"
												data-bs-num="${ps.bs_num}"> <span style="color: #007bff">${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})</span>
											</a></td>
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
																class="btn btn_green btn-program-reservation1"
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
	<div id="employeeModal" class="modal employee-modal"
		style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="close">&times;</span>
				<!-- x 버튼 -->
			</div>
			<div id="modalBody"></div>
			<!-- 여기에 동적 컨텐츠를 삽입 -->
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
 		
 		if(${user.me_authority != 'USER'}) {
 			alert('관리자는 예약이 불가능 합니다.');
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
<script type="text/javascript">
// 페이지가 로드될 때 첫 번째 버튼의 세부 정보를 표시
window.onload = function() {
    
    // 페이지가 로드되면 저장된 스크롤 위치로 이동
    const scrollPosition = localStorage.getItem("scrollPosition");
    if (scrollPosition) {
        window.scrollTo(0, scrollPosition);
    }
    
    // 페이드 인 효과 활성화
    document.body.classList.add("fade-in");
    
    // 모든 td 요소의 최대 높이를 구해 같은 높이로 설정
   	const tds = document.querySelectorAll(".calendar td");
    let maxHeight = 0;

    // 각 td의 높이 중 가장 큰 값 찾기
    tds.forEach(td => {
        maxHeight = Math.max(maxHeight, td.offsetHeight);
    });

    // 모든 td에 최대 높이 적용
    tds.forEach(td => {
        td.style.height = maxHeight + "px";
    });
    
};

	// 스크롤할 때마다 현재 위치를 저장
window.onscroll = function() {
    localStorage.setItem("scrollPosition", window.scrollY);
};
</script>
	<script>
document.addEventListener("DOMContentLoaded", function() {
    const modal = document.getElementById("employeeModal");
    const modalBody = document.getElementById("modalBody");
    const closeBtn = modal.querySelector(".close");

    // 버튼 클릭 이벤트
    document.querySelectorAll(".btn-view-details").forEach(button => {
        button.addEventListener("click", function() {
        	
        	const bsNum = $(this).data('bs-num'); // data-bs-num 값 가져오기 (소문자 사용)
        	const uploadUrl = '<c:url value="/uploads" />';
        	
            $.ajax({
                async: false,
                url: '<c:url value="/program/getEmployeeInfo"/>',
                type: 'get',
                data: { bs_num: bsNum }, 
                dataType: 'json',
                success: function(data) {
                	 if (data) {
                         // employee 정보 출력
                         console.log('직원 정보:', data);
                         // 여기에 모달에 데이터를 넣는 코드 추가
                         $('#modalBody').html(`
                        	<div class="row">
                         	<div class="col-md-6 mb-4" style="padding: 0;">
	                        <div class="card" style="width: 100%; border: none;">
	                            <img class="card-img-top"
	                                 src="\${data.em_fi_name ? uploadUrl+ data.em_fi_name : 'https://www.w3schools.com/bootstrap4/img_avatar1.png'}"
	                                 alt="\${data.em_name}" 
	                                 style="width: 100%; height: 350px; object-fit: cover;">
	                        </div>
	                        </div>
	                        <div class="col-md-6 mb-4" style="padding: 0;">
	                        <div class="card" style="width: 100%; border: none;">
	                            <div class="card-body" style="padding: 0.5rem 1.25rem;">
	                                <h4 class="card-title">\${data.em_name}</h4>
	                                <p class="card-text">\${data.em_position}</p><br>
	                                <p class="card-text">\${data.em_detail}</p>
	                            </div>
	                        </div>
	                        </div>
	                    `);
	                    $('#employeeModal').show(); // 모달 표시
                     } else {
                         alert('직원 정보를 찾을 수 없습니다.');
                     }
                 },
                 error: function(jqXHR, textStatus, errorThrown) {
                     console.error('오류 발생:', jqXHR);
                     alert('직원 정보를 가져오는 데 실패했습니다.');
                 }
            });
        });
    });

    // 모달 닫기 이벤트
    closeBtn.addEventListener("click", function() {
        modal.style.display = "none";
    });

    window.addEventListener("click", function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
});
</script>

</body>

</html>



