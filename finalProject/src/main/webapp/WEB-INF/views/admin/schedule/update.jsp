<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
		        <!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
			
		        <!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">스케줄 수정</h2>
						<p class="sub_title__txt">* 이전에 등록한 프로그램과 일정이 겹치면 등록이 불가능합니다.</p>
					</div>	
					
					<div class="table_wrap">
						<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
						<form action="<c:url value="/admin/schedule/update"/>" method="post" id="form">
							<input type="hidden" name="br_name" value="${schedule.bp_br_name}">
							<input type="hidden" name="bs_bp_num" value="${schedule.bs_bp_num}">
							<input type="hidden" name="bs_num" value="${schedule.bs_num}">
							<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="bp_sp_name" class="_asterisk">프로그램</label>
										</th>
										<td>
											<div class="form-group">${schedule.bp_sp_name}(${schedule.em_name}, ${schedule.bp_total}인)</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="bs_start">현재일정</label>
										</th>
										<td>
											<div class="form-group">
												<fmt:formatDate value="${schedule.bs_start}" pattern="MM월dd일"/> <fmt:formatDate value="${schedule.bs_start}" pattern="HH"/>-<fmt:formatDate value="${schedule.bs_end}" pattern="HH시"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="mi_content" class="_asterisk">수정날짜</label>
										</th>
										<td>
											<div class="form-group">
												<input type="date" class="form-control custom-calender" id="currentDate" name="date" value="<fmt:formatDate value='${schedule.bs_start}' pattern='yyyy-MM-dd'/>" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="startTime" class="_asterisk">수정시작시간</label>
										</th>
										<td>
											<div class="form-group">
												<input type="time" class="form-control custom-calender" id="startTime" name="startTime" step="3600" value="<fmt:formatDate value='${schedule.bs_start}' pattern='HH:mm'/>" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="endTime" class="_asterisk">수정마감시간</label>
										</th>
										<td>
											<div class="form-group">
												<input type="time" class="form-control custom-calender" id="endTime" name="endTime" step="3600" value="<fmt:formatDate value='${schedule.bs_end}' pattern='HH:mm'/>" />
											</div>
										</td>
									</tr>																											
								</tbody>
							</table>
							
							<div class="btn_wrap">
								<div class="btn_right_wrap">
									<button type="submit" class="btn btn_insert">수정</button>
									<a href="<c:url value="/admin/schedule/list"/>" class="btn btn_cancel">취소</a>
								</div>
							</div>														
						</form>
					</div>
				</section>
				
			</section>
			
			<script>
				// 현재 날짜 계산
				var today = new Date();
				var lastDay = new Date();
				lastDay.setDate(today.getDate() + 30); // 현재 날짜에서 30일 더함
		
				// 오늘 날짜 포맷팅 (YYYY-MM-DD)
				var formattedToday = today.toISOString().substring(0, 10);
				var formattedLastDay = lastDay.toISOString().substring(0, 10);
		
			    var currentDateField = document.getElementById('currentDate');
			    var startTimeField = document.getElementById('startTime');
			    var endTimeField = document.getElementById('endTime');
		
			    // 만약 input 값이 없으면 기본값 설정
			    if (!currentDateField.value) {
			        currentDateField.value = formattedToday;
			        currentDateField.min = formattedToday;
			        currentDateField.max = formattedLastDay;
			    }
				
			    // 시간 필드에 시작 시간 및 마감 시간 설정 (분 단위 00 고정)
			    if (!startTimeField.value) {
			        startTimeField.value = "09:00";
			        startTimeField.min = "09:00";
			        startTimeField.max = "19:00";
			    }
		
			    if (!endTimeField.value) {
			        endTimeField.value = "10:00";
			        endTimeField.min = "10:00";
			        endTimeField.max = "20:00";
			    }
				
				// 시간 선택 시, 분을 항상 00으로 설정
				startTimeField.addEventListener('input', function() {
					var time = this.value.split(":");
					this.value = time[0] + ":00"; // 분을 00으로 고정
				});
		
				endTimeField.addEventListener('input', function() {
					var time = this.value.split(":");
					this.value = time[0] + ":00"; // 분을 00으로 고정
				});		
			</script>			