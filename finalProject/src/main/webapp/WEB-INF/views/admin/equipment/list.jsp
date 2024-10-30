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
						<h2 class="sub_title">${br_name} 운동기구 목록</h2>
					</div>

					<!-- 탭 버튼 -->
			    	<div class="sub_hd_wrap">
			    		<ul class="tab_list">
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-all _active" data-name="all">내역</button></li>
					    	<li class="tab_item"><button type="button" class="tab_link btn-menu btn-equipment" data-name="equipment">현황</button></li>
				    	</ul>
				    </div>					
					
					<!-- 운동기구 목록 -->
					<div class="table_wrap">
						<div class="box box-all">
							<table class="table table_center table-all" id="table">
								<thead id="thead">
									<tr>
										<th>운동기구명</th>
										<th>제조년월일</th>
										<th>수량</th>
										<th>기록날짜</th>
										<th>기록유형</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${equipmentChange}" var="change">
										<tr>
											<td>${change.be_se_name}</td>
											<td>
												<fmt:formatDate value="${change.be_birth}" pattern="yyyy-MM-dd"/>
											</td>
											<td>${change.be_amount}</td>
											<td>
												<fmt:formatDate value="${change.be_record}" pattern="yyyy-MM-dd"/>
											</td>
											<td>${change.be_type}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
					    <div class="box box-equipment" style="display: none;">
							<table class="table table_center table-equipment">
								<thead id="thead">
									<tr>
										<th>운동기구명</th>
										<th>총 갯수</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${equipmentList}" var="list">
										<tr>
											<td>${list.be_se_name}</td>
											<td>${list.be_se_total}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>		
					</div>
										
				</section>				
			</section>

			<script type="text/javascript">
				var table = $('.table-all').DataTable({
					language: {
				        search: "",
				        searchPlaceholder: "검색",
				        zeroRecords: "",
				        emptyTable: "",
				        lengthMenu: ""
				    },
				    createdRow: function(row, data, dataIndex) {
				        if (data[2] < 0) {
				        	$('td', row).eq(2).css('color', 'red');
				        }
				        if (data[2] > 0) {
				        	$('td', row).eq(2).css('color', 'green');
				        }
				    },
				    pageLength: 10,
				    info: false,
				    stateSave: true,
				    stateDuration: 300,
				    order: [[ 3, "desc" ]]
				});
				
				$('.btn-menu').click(function(){
					var name = $(this).data("name");
					
					$('.btn-menu').removeClass("_active");
					$('.btn-'+name).addClass("_active");
					
					$('.box').css("display", "none");
					$('.box-'+name).css("display", "block");
					
					table.destroy();
					if(name == 'all'){
						table = $('.table-'+name).DataTable({
							language: {
						        search: "",
						        searchPlaceholder: "검색",
						        zeroRecords: "",
						        emptyTable: "",
						        lengthMenu: ""
						    },
						    createdRow: function(row, data, dataIndex) {
						        if (data[2] < 0) {
						        	$('td', row).eq(2).css('color', 'red');
						        }
						        if (data[2] > 0) {
						        	$('td', row).eq(2).css('color', 'green');
						        }
						    },
						    pageLength: 10,
						    info: false,
						    stateSave: true,
						    stateDuration: 300,
						    order: [[ 3, "desc" ]]	
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
						    order: [[ 0, "asc" ]]		
						});
					}
				});
			</script>