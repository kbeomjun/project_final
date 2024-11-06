<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/program/schedule.css"/>">

<style type="text/css">

</style>
</head>
<body>
	<section class="sub_banner sub_banner_03"></section>
	<!-- <h1>프로그램 일정</h1> -->
	<nav class="tabList_wrap">
		<ul class="tabList">
		<li class="tabList_item">
			<a class="tabList_link" href="<c:url value="/program/info"/>">프로그램 안내</a>
		</li>
		<li class="tabList_item">
			<a class="tabList_link _active" href="<c:url value="/program/schedule"/>">프로그램 일정</a>
		</li>
		</ul>
	</nav>

	<section class="sub_content">

		<!-- lnb -->
		<section class="lnb_wrap">
			<!-- <div class="main-container"> -->
				<div class="lnb-container mb-2">
					<div class="btn_wrap">
						<div class="btn_link_black 
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
								href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/null/${pr_name != null ? pr_name : 'null'}/false/null"/>">
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
										href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br.br_name}/${pr_name != null ? pr_name : 'null'}/false/null"/>">
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
			<!-- </div> -->

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
							href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/null/false/null"/>">
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
								href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/${pr.sp_name}/false/null"/>">
								${pr.sp_name } </a></li>
						</c:if>
					</c:forEach>
					</ul>
				</div>
				<div class="calendar-wrapper">
					<div class="p-3 d-flex justify-content-between">
						<span> 
							<c:if test="${ cal.year ne todayYear || ((cal.month+1) ne todayMonth)}">
								<a class="btn tab_link" style="border-radius: 10px;"
									href="<c:url value="/program/schedule/${cal.year}/${cal.month-1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/false/null"/>">이전달</a>
							</c:if>
						</span> 
						<span class="fs-5" style="font-size: 1.5rem; font-weight: 600;">${cal.year}년
							${cal.month+1}월
						</span>
						<span> <a class="btn tab_link" style="border-radius: 10px;"
							href="<c:url value="/program/schedule/${cal.year}/${cal.month+1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/false/null"/>">다음달</a>
						</span>
					</div>

					<table class="table text-center table-bordered calendar">
						<tr class="text-center fs-5 tr-h">
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
												value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/true/null" />

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
													<a href="<c:url value="${url}"/>" class="btn p-0 ${disabled} ml-3 ">
														<span class="text-primary ${cls} day-item"><fmt:formatNumber value="${j - cal.startBlankCnt}" pattern="00" /></span>
													</a>
													<br>
												</c:when>
												<c:when test="${j % 7 == 1 }">
													<a href="<c:url value="${url}"/>" class="btn p-0 ${disabled} ml-3">
														<span class="text-danger ${cls} day-item"><fmt:formatNumber value="${j - cal.startBlankCnt}" pattern="00" /></span>
													</a>
													<br>
												</c:when>
												<c:otherwise>
													<a href="<c:url value="${url}"/>" class="btn p-0 ${disabled} ml-3">
														<span class="${cls} day-item"><fmt:formatNumber value="${j - cal.startBlankCnt}" pattern="00" /></span>
													</a>
													<br>
												</c:otherwise>
											</c:choose>
											<c:set var="sp_name_distinct" value="PT" />
											<div style="text-align: center; margin-top: 5px;">
											<c:forEach items="${ps_list}" var="ps" varStatus="status">
											    <fmt:formatDate value='${ps.bs_start}' pattern='dd' var="ps_day" />
											    
											    <c:if test="${(j - cal.startBlankCnt) eq ps_day}">
											    	<c:choose>
													    <c:when test="${not empty programColorMap[ps.bp_sp_name]}">
													        <c:set var="colorClass" value="${programColorMap[ps.bp_sp_name]}" />
													    </c:when>
													    <c:otherwise>
													        <c:set var="colorClass" value="btn_group_color_20" /> <!-- 기본 색상 -->
													    </c:otherwise>
													</c:choose>
											
											        <c:if test="${fn:contains(sp_name_distinct, ps.bp_sp_name) == false}">
											        
											            <a class="btn ${colorClass} program-button ${disabled}"
											                href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}/true/${ps.bp_sp_name}"/>">
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
		<div class="modal-dialog" role="document" style=" top: 20%; ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="tableModalLabel">프로그램 목록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
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
						<c:set var="hasData" value="false" />
						<tbody>
							<c:forEach items="${ps_list}" var="ps" varStatus="status">
								<fmt:formatDate value='${ps.bs_start}' pattern='dd'
									var="ps_day" />
								<c:if test="${ps.bp_sp_name ne 'PT' && cal.day eq ps_day}">
								<c:set var="hasData" value="true" />
								<c:choose>
								    <c:when test="${selectedProgram eq 'null'}">
								        <!-- selectedProgram이 null일 때 모든 프로그램 표시 -->
								        <c:set var="showRow" value="true" />
								    </c:when>
								    <c:otherwise>
								        <!-- selectedProgram이 null이 아닐 때, 일치하는 프로그램만 표시 -->
								        <c:set var="showRow" value="${selectedProgram eq ps.bp_sp_name}" />
								    </c:otherwise>
								</c:choose>
								
								<c:if test="${showRow}">
								    <tr>
								        <td>${ps.bp_sp_name}</td>
								        <td>${fn:replace(ps.bp_br_name, '점', '')}</td>
								        <td>
								            <a class="btn btn-view-details" data-bs-num="${ps.bs_num}">
								                <span style="color: #007bff">${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})</span>
								            </a>
								        </td>
								        <td>
								            <fmt:formatDate value="${ps.bs_start}" pattern="HH:mm" />
								            <br />~<fmt:formatDate value="${ps.bs_end}" pattern="HH:mm" />
								        </td>
								        <td>${ps.bs_current}/${ps.bp_total}</td>
								        <td>
								            <c:set var="currentTime" value="<%=new java.util.Date()%>" />
								            <c:choose>
								                <c:when test="${ps.bs_current ne ps.bp_total && currentTime.before(ps.bs_start)}">
								                    <form action="<c:url value='/program/reservation' />" method="post">
								                        <input type="hidden" name="bs_num" value="${ps.bs_num}">
								                        <button class="btn btn_green btn-program-reservation1"
								                                data-program="${ps.bp_sp_name}/${ps.bp_br_name}/${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})/<fmt:formatDate value='${ps.bs_start}' pattern='HH:mm'/>~<fmt:formatDate value='${ps.bs_end}' pattern='HH:mm' />"
								                                data-num="${ps.bs_num}" type="button">예약</button>
								                    </form>
								                </c:when>
								                <c:otherwise>
								                    <span class="btn btn_ btn-program-reservation2 disabled">마감</span>
								                </c:otherwise>
								            </c:choose>
								        </td>
								    </tr>
								</c:if>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</div>
	<div id="employeeModal" class="modal employee-modal"
		style="display: none;">
		<div class="modal-content" style=" top: 22%;">
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
        var hasData = ${hasData};
        
        if (showModal && hasData) {
            $('#tableModal').modal('show');
        }
        
        var $lnb = $('.lnb_wrap'); // 사이드바 선택
        var offsetTop = $lnb.offset().top; // 사이드바의 초기 위치
        var sidebarHeight = $lnb.outerHeight(); // 사이드바의 높이
        var triggerPoint = 885; 
        /* var triggerPoint = offsetTop + (sidebarHeight / 3); // 사이드바 절반 높이 지점 */
        
        $(window).scroll(function() {
            var scrollTop = $(this).scrollTop(); // 현재 스크롤 위치

            if (scrollTop > offsetTop && scrollTop < triggerPoint) {
                // 스크롤이 사이드바의 상단을 넘어가고 절반 지점보다 아래일 때
                $lnb.css({
                    position: 'fixed',
                    top: '10px' // 페이지 상단에서의 위치
                });
                $('.sub_content_group').css('margin-left', '308px'); // 사이드바 너비 + 여백
            } else if (scrollTop >= triggerPoint) {
                // 스크롤이 사이드바의 절반 지점을 넘어갔을 때
                $lnb.css({
                    position: 'relative',
                    top: '300px' // 절반 지점에서 더 내려가지 않도록 조정
                });
                $('.sub_content_group').css('margin-left', '20px'); // 사이드바 너비 + 여백
            } else {
                // 스크롤이 사이드바의 원래 위치보다 위에 있을 때
                $lnb.css({
                    position: 'relative',
                    top: '0'
                });
                $('.sub_content_group').css('margin-left', '20px'); // 원래 여백으로 복원
            }
        });
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
    if (tds.length === 0) {
        console.error("No td elements found in .calendar table.");
        return; // td 요소가 없으면 함수 종료
    }
    
    let maxHeight = 0;

    // 각 td의 높이 중 가장 큰 값 찾기
    tds.forEach(td => {
        maxHeight = Math.max(maxHeight, td.offsetHeight);
    });

    // 모든 td에 최대 높이 적용
    tds.forEach(td => {
        td.style.height = (maxHeight > 140) ? maxHeight + "px" : "140px";
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
                         	<div class="col-md-6 mb-4">
	                        <div class="card" style="width: 100%; border: none;">
	                            <img class="card-img-top"
	                                 src="\${data.em_fi_name ? uploadUrl+ data.em_fi_name : 'https://www.w3schools.com/bootstrap4/img_avatar1.png'}"
	                                 alt="\${data.em_name}" 
	                                 style="width: 360px; height: 450px; object-fit: cover;">
	                        </div>
	                        </div>
	                        <div class="col-md-6 mb-4" style="padding: 0;">
	                        <div class="card ml-3" style="width: 80%;border: none;">
	                            <div class="card-body" style="padding: 0.5rem 1.25rem;">
	                                <h4 class="card-title">\${data.em_name}</h4>
	                                <p class="card-text">\${data.em_position}</p><br>
	                                <div class="scrollable-text">\${data.em_detail}</div>
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
<script>
    // DOMContentLoaded 이벤트로 페이지가 로드된 후 실행
    document.addEventListener('DOMContentLoaded', function() {
        // bg-highlight 클래스를 가진 span을 찾기
        const highlightedSpan = document.querySelector('.calendar span.selected');

        // 조건이 만족하는 경우 해당 td의 배경색을 변경
        if (highlightedSpan) {
            const highlightedTd = highlightedSpan.closest('td'); // 해당 span의 부모 td 선택
            highlightedTd.style.borderTop = 'none';
            highlightedTd.classList.add('bg-highlight'); // highlighted 클래스 추가
        }
    });
</script>

</body>

</html>



