<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/css/calendar.css"/>">
</head>
<body>
							
	<!-- <h1>프로그램 일정</h1> -->
	<a class="btn btn-outline-dark br-3"
		href="<c:url value="/program/info"/>">프로그램 안내</a>
	<a class="btn btn-dark" href="<c:url value="/program/schedule"/>">프로그램
		일정</a>
	
	<hr>
	<div class="mb-2">
		<label>지점 조회</label>
			<a class="btn btn-<c:if test="${br_name ne 'null'}">outline-</c:if>info"
				href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/null/${pr_name != null ? pr_name : 'null'}"/>"> 전체 </a>
		<c:forEach items="${branch_list}" var="br" varStatus="status">
			<c:choose>
				<c:when test="${br.br_name == br_name}">
					<c:set var="outline" value="" />
				</c:when>
				<c:otherwise>
					<c:set var="outline" value="outline-" />
				</c:otherwise>
			</c:choose>
			<c:if test="${br.br_name ne '본사'}">
			<a class="btn btn-${outline}info"
				href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br.br_name}/${pr_name != null ? pr_name : 'null'}"/>">
				${br.br_name } </a>
			</c:if>
		</c:forEach>
	</div>
	<div>
		<fmt:formatDate value="${nowDate}" pattern="yyyy-MM-dd" var="today" />
		<fmt:formatDate value="${nowDate}" pattern="dd" var="todayDate" />
		<fmt:formatDate value="${nowDate}" pattern="MM" var="todayMonth" />
		<fmt:formatDate value="${nowDate}" pattern="yyyy" var="todayYear" />
		<label>프로그램 조회</label> <a class="btn btn-<c:if test="${pr_name ne 'null'}">outline-</c:if>info"
			href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/null"/>"> 전체 </a>
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
			<a class="btn btn-${outline}info"
				href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${cal.day}/${br_name != null ? br_name : 'null'}/${pr.sp_name}"/>">
				${pr.sp_name } </a>
			</c:if>
		</c:forEach>
	</div>
	<div class="d-flex account-book-container">
		<div class="calendar-wrapper">
			<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
				<span>
					<c:if test="${ cal.year ne todayYear || ((cal.month+1) ne todayMonth)}">
						<a class="btn btn-outline-dark" href="<c:url value="/program/schedule/${cal.year}/${cal.month-1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}"/>">이전달</a>
					</c:if>
				</span> 
				<span class="fw-bold fs-3">${cal.year}년 ${cal.month+1}월</span> 
				<span>
					<a class="btn btn-outline-dark"
					href="<c:url value="/program/schedule/${cal.year}/${cal.month+1}/${todayDate }/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}"/>">다음달</a>
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
								</c:if> 
								<c:if test="${(j > cal.startBlankCnt) && (j <= cal.startBlankCnt + cal.lastDate)}">
									<c:set var="url" value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${pr_name != null ? pr_name : 'null'}" />
									
									<c:choose>
										<c:when test="${cal.year > todayYear}">
											<c:set var="disabled" value=""/>
										</c:when>
										<c:when test="${(cal.month+1) > todayMonth}">
											<c:set var="disabled" value=""/>
										</c:when>
										<c:when test="${((cal.month+1) eq todayMonth) && ((j - cal.startBlankCnt) >= todayDate)}">
											<c:set var="disabled" value=""/>
										</c:when>
										<c:otherwise>
											<c:set var="disabled" value="disabled"/>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${j % 7 == 0 }">
											<a href="<c:url value="${url}"/>" class="btn ${disabled}">
												<span class="text-primary mb-3 ${cls}">${j - cal.startBlankCnt }</span>
											</a><br>
										</c:when>
										<c:when test="${j % 7 == 1 }">
											<a
												href="<c:url value="${url}"/>" class="btn ${disabled}">
												<span class="text-danger mb-3 ${cls}">${j - cal.startBlankCnt }
											</span>
											</a><br>
										</c:when>
										<c:otherwise>
											<a
												href="<c:url value="${url}"/>" class="btn ${disabled}">
												<span class="mb-3 ${cls}"> ${j - cal.startBlankCnt } </span>
											</a><br>
										</c:otherwise>
									</c:choose>
									<c:set var="sp_name_distinct" value="PT" />
									<c:forEach items="${ps_list}" var="ps" varStatus="status" >
										<fmt:formatDate value='${ps.bs_start}' pattern='dd' var="ps_day"/>
										<c:if test="${(j - cal.startBlankCnt) eq ps_day}">
											<c:if test="${fn:contains(sp_name_distinct, ps.bp_sp_name) == false}">
									            <a class="btn btn-success program-button ${disabled}"  href="<c:url value="/program/schedule/${cal.year}/${cal.month}/${j - cal.startBlankCnt}/${br_name != null ? br_name : 'null'}/${ps.bp_sp_name}"/>">
									            <span>${ps.bp_sp_name}</span>
									            </a>
									            <c:set var="sp_name_distinct" value="${sp_name_distinct},${ps.bp_sp_name}" />
									        </c:if>
										</c:if>
									</c:forEach>
								</c:if>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>

			</table>
		</div>
		<div class="list-wrapper ml-5" >
			<div class="mb-2" style="position: relative; display: flex; justify-content: center; align-items: center;">
			    <h3 style="position: absolute; left: 50%; transform: translateX(-50%); white-space: nowrap;">&lt;${searchDate}&gt; 프로그램</h3>
			</div>
			<div style="text-align: right;">
			    <c:if test="${user eq null}">
			        <a href="<c:url value='/login'/>" class="btn btn-dark mr-3 mt-3">로그인</a>
			    </c:if>
			</div>
			<div class="overflow-auto mt-3 mb-3" style="max-height: 70vh;">
				<table class="table table-striped">
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
							<fmt:formatDate value='${ps.bs_start}' pattern='dd' var="ps_day"/>
							<c:if test="${ps.bp_sp_name ne 'PT' && cal.day eq ps_day}">
								<tr>
									<td>${ps.bp_sp_name }</td>
									<td>${fn:replace(ps.bp_br_name, '점', '')}</td>
									<td>${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})</td>
									<td>
									    <fmt:formatDate value="${ps.bs_start}" pattern="HH:mm" />
									    <br/>~<fmt:formatDate value="${ps.bs_end}" pattern="HH:mm" />
									</td>
									<td>${ps.bs_current} / ${ps.bp_total }</td>
									<td>
										<c:set var="currentTime" value="<%= new java.util.Date() %>" />
										
										<c:choose>
										<c:when test="${ps.bs_current ne ps.bp_total && currentTime.before(ps.bs_start)}">
										<!-- 정원 초과가 아니고 현재 시간보다 이전 프로그램이 아니라면 예약 가능 -->
											<form action="<c:url value="/program/reservation" />" method="post">
												<input type="hidden" name="bs_num" value="${ps.bs_num}">
												<button class="btn btn-outline-primary btn-program-reservation1" 
												data-program="${ps.bp_sp_name}/${ps.bp_br_name}/${ps.em_name}(${fn:substring(ps.em_gender, 0, 1)})/<fmt:formatDate value="${ps.bs_start}" pattern="HH:mm"/>~<fmt:formatDate value="${ps.bs_end}" pattern="HH:mm" />"
												data-num="${ps.bs_num}" type="submit" >예약</button>
											</form>
										</c:when>
										<c:otherwise>
											<span class="btn btn-program-reservation2">마감</span>
										</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:if>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script>
	
	$('.btn-program-reservation1').click(function(e) {
		const button = $(this);  // 현재 클릭된 버튼 객체
	    const program = button.data('program'); 
		const bs_num = button.data('num');
		
 		if(${user == null}) {
			if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
					location.href = "<c:url value="/member/login"/>";
			}
			return;
		}
		var id = ${user.me_id};
		var noshow = ${user.me_noshow};
		
 		
 
		if (confirm(program
				+ '으로 예약하시겠습니까?\n'
				+ '노쇼 누적시 예약이 제한될 수 있습니다.\n('
				+ id + '님의 누적 노쇼: '
				+ noshow + '번)'))
		{
				var isDuplicated = checkReservation(bs_num);
				console.log(isDuplicated);
				if(isDuplicated){
					
					alert('이미 예약한 프로그램입니다.');
					e.preventDefault();
				}
				else {
					return;
				}
		}
		else {
			e.preventDefault();
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



