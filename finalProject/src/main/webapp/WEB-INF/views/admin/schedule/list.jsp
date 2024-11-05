<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<c:if test="${not empty msg}">
			    <script type="text/javascript">
			        alert("${msg}");
			    </script>
			</c:if>
			
			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${br_name} 스케줄 목록</h2>
					</div>		
					
					<!-- 탭 버튼 -->
			    	<div class="sub_hd_wrap">
			    		<ul class="tab_list">
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-present _active" data-name="present">현재예약현황</button></li>
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-past" data-name="past">이전예약내역</button></li>
				    	</ul>
				    </div>
		
					<!-- 스케줄 목록 -->
					<div class="table_wrap">
						<div class="box box-present">
							<table class="table table_center table-present" id="table">
								<thead id="thead">
									<tr>
										<th>프로그램명</th>
										<th>트레이너명</th>
										<th>[예약인원 / 총인원]</th>
										<th>프로그램 날짜</th>
										<th>프로그램 시간</th>
										<th>예약회원보기</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${presentList}" var="list">
										<tr>
											<td>${list.bp_sp_name}</td>
											<td>${list.em_name}</td>
											<td>${list.bs_current} / ${list.bp_total}</td>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="yyyy-MM-dd"/>
											</td>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
											</td>
											<td>
												<a href="<c:url value="/admin/schedule/member/${list.bs_num}"/>" class="btn btn_blue">조회</a>
											</td>
											<td>
												<a href="<c:url value="/admin/schedule/update/${list.bs_num}"/>" class="btn btn_yellow">수정</a>
											</td>
											<td>	
												<a href="<c:url value="/admin/schedule/delete/${list.bs_num}"/>" onclick="return confirm('삭제하시겠습니까?');"  class="btn btn_red">삭제</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
					    <div class="box box-past" style="display: none;">
							<table class="table table_center table-past">
								<thead id="thead">
									<tr>
										<th>프로그램명</th>
										<th>트레이너명</th>
										<th>[예약인원 / 총인원]</th>
										<th>프로그램 날짜</th>
										<th>프로그램 시간</th>
										<th>예약회원보기</th>
									</tr>					
								</thead>
								<tbody id="tbody">
									<c:forEach items="${pastList}" var="list">
										<tr>
											<td>${list.bp_sp_name}</td>
											<td>${list.em_name}</td>
											<td>${list.bs_current} / ${list.bp_total}</td>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="yyyy-MM-dd"/>
											</td>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
											</td>
											<td>
												<a href="<c:url value="/admin/schedule/member/${list.bs_num}"/>" class="btn btn_blue">조회</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>		
					</div>
					
					<!-- 스케줄 등록 버튼 -->
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<div class="btn_link_black">
								<a href="<c:url value="/admin/schedule/regist"/>" class="btn btn_black js-btn-insert">
									<span>일정 추가<i class="ic_link_share"></i></span>
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
				var table = $('.table-present').DataTable({
					language: {
						search: "",
				        searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: "",
				        lengthMenu: ""
				    },
				    pageLength: 10,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 3, "asc" ]],
				    columnDefs: [
				        { targets: [5, 6, 7], orderable: false }
				    ]
				});
				
				$('.btn-menu').click(function(){
					var name = $(this).data("name");
					
					$('.btn-menu').removeClass("_active");
					$('.btn-'+name).addClass("_active");
					
					$('.box').css("display", "none");
					$('.box-'+name).css("display", "block");
					
					table.destroy();
					if(name == 'present'){
						table = $('.table-'+name).DataTable({
							language: {
								search: "",
						        searchPlaceholder: "검색",
						        zeroRecords: "",
						        emptyTable: "",
						        lengthMenu: ""
						    },
						    pageLength: 10,
						    info: false,
						    stateSave: true,
						    stateDuration: 300,
						    order: [[ 3, "asc" ]],
						    columnDefs: [
						        { targets: [5, 6, 7], orderable: false }
						    ]					
						});
					}else{
						table = $('.table-'+name).DataTable({
							language: {
								search: "",
						        searchPlaceholder: "검색",
						        zeroRecords: "",
						        emptyTable: "",
						        lengthMenu: ""
						    },
						    pageLength: 10,
						    info: false,
						    stateSave: true,
						    stateDuration: 300,
						    order: [[ 3, "desc" ]],
						    columnDefs: [
						        { targets: [5], orderable: false }
						    ]					
						});
					}
				});
			</script>