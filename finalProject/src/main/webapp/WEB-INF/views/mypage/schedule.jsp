<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<c:if test="${not empty msg}">
			    <script type="text/javascript">
			        alert("${msg}");
			    </script>
			</c:if>
			
			<section class="sub_banner sub_banner_07"></section>
			<section class="sub_content">
			
		        <!-- 왼쪽 사이드바 -->
		           <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
			
		        <!-- 오른쪽 컨텐츠 영역 -->
		        <section class="sub_content_group">
		        
					<div class="sub_title_wrap">
						<h2 class="sub_title">내 예약내역</h2>
					</div> 
		        
			    	<div class="sub_hd_wrap">
			    		<ul class="tab_list">
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-present _active" data-name="present">현재예약현황</button></li>
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-past" data-name="past">이전예약내역</button></li>
				    	</ul>
				    </div>
				    
				    <div class="table_wrap">
					    <div class="box box-present">
							<table class="table table_center table-present">
								<thead id="thead">
									<tr>
										<th>연도</th>
										<th>지점명</th>
										<th>프로그램명</th>
										<th>트레이너명</th>
										<th>[예약인원 / 총인원]</th>
										<th>프로그램 예정 시간</th>
										<th>신청 날짜</th>
										<th>예약취소</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${presentList}" var="list">
										<tr>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="yyyy"/>
											</td>
											<td>${list.bp_br_name}</td>
											<td>${list.bp_sp_name}</td>
											<td>${list.em_name}</td>
											<td>${list.bs_current} / ${list.bp_total}</td>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="MM/dd HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
											</td>
											<td>
												<fmt:formatDate value="${list.pr_date}" pattern="MM/dd HH:mm"/>
											</td>
											<td>
												<a href="<c:url value="/mypage/schedule/cancel/${list.pr_num}/${list.bs_num}"/>" 
																class="btn btn_red"
																onclick="return confirm('취소하시겠습니까?');">취소</a>
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
										<th>연도</th>
										<th>지점명</th>
										<th>프로그램명</th>
										<th>트레이너명</th>
										<th>[예약인원 / 총인원]</th>
										<th>프로그램 예정 시간</th>
										<th>신청 날짜</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${pastList}" var="list">
										<tr>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="yyyy"/>
											</td>
											<td>${list.bp_br_name}</td>
											<td>${list.bp_sp_name}</td>
											<td>${list.em_name}</td>
											<td>${list.bs_current} / ${list.bp_total}</td>
											<td>
												<fmt:formatDate value="${list.bs_start}" pattern="MM/dd HH"/>-<fmt:formatDate value="${list.bs_end}" pattern="HH시"/>
											</td>
											<td>
												<fmt:formatDate value="${list.pr_date}" pattern="MM/dd HH:mm"/>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
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
				    order: [[ 5, "asc" ]],
				    columnDefs: [
				        { targets: [7], orderable: false }
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
						    order: [[ 5, "asc" ]],
						    columnDefs: [
						        { targets: [7], orderable: false }
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
						    order: [[ 5, "desc" ]]
						});
					}
				});
			</script>
