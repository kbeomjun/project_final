<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<body>
	<section class="sub_banner sub_banner_06"></section>
	<section class="sub_content">
        <!-- 왼쪽 사이드바 -->
        <%@ include file="/WEB-INF/views/layout/hqSidebar.jsp" %>

        <!-- 오른쪽 컨텐츠 영역 -->
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">회원 조회</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			        		<th>이름</th>
			        		<th>생년월일</th>
			        		<th>성별</th>
			        		<th>전화번호</th>
			        		<th>계정</th>
			        		<th>이메일</th>
			        		<th>SNS</th>
			        		<th>상태</th>
			        		<th>탈퇴기한</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		<c:forEach items="${meList}" var="me">
			    			<tr>
				        		<td>${me.me_name}</td>
				        		<td>
				        			<c:if test="${me.me_birth != null}">
				        				<fmt:formatDate value="${me.me_birth}" pattern="yyyy.MM.dd"/>
			        				</c:if>
				        			<c:if test="${me.me_birth == null}">
				        				-
			        				</c:if>
			        			</td>
				        		<td>
				        			<c:if test="${me.me_gender != null}">
				        				${me.me_gender}
			        				</c:if>
				        			<c:if test="${me.me_gender == null}">
				        				-
			        				</c:if>
			        			</td>
				        		<td>
				        			<c:if test="${me.me_phone != null}">
				        				${me.me_phone}
			        				</c:if>
				        			<c:if test="${me.me_phone == null}">
				        				-
			        				</c:if>
			        			</td>
				        		<td>${me.me_id}</td>
				        		<td>${me.me_email}</td>
				        		<td>
				        			<c:if test="${me.me_kakaoUserId == null && me.me_naverUserId == null}">-</c:if>
				        			<c:if test="${me.me_kakaoUserId != null}">카카오</c:if>
				        			<c:if test="${me.me_kakaoUserId != null && me.me_naverUserId != null}">/</c:if>
				        			<c:if test="${me.me_naverUserId != null}">네이버</c:if>
				        		</td>
				        		<td>
				        			<c:if test="${me.me_authority == 'USER'}">사용중</c:if>
				        			<c:if test="${me.me_authority == 'REMOVED'}">탈퇴</c:if>
				        		</td>
				        		<td>
				        			<c:if test="${me.me_authority == 'USER'}">
				        				-
			        				</c:if>
				        			<c:if test="${me.me_authority == 'REMOVED'}">
				        				<fmt:formatDate value="${me.me_dataPeriod}" pattern="yyyy.MM.dd"/>
				        			</c:if>
				        		</td>
				        		<td>
				        			<c:if test="${!me.me_canDelete}">
					        			<button type="button" class="btn btn_blue btn-detail" data-toggle="modal" data-target="#myModal" data-id="${me.me_id}">조회</button>
				        			</c:if>
				        			<c:if test="${me.me_canDelete}">
					        			<a href="<c:url value="/hq/member/delete/${me.me_id}"/>" class="btn btn_red btn-delete">삭제</a>
				        			</c:if>
				        		</td>
				      		</tr>
			    		</c:forEach>
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="modal fade" id="myModal">
		    	<div class="modal-dialog modal-dialog-centered">
		    		<div class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">조회</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
							<div class="table_wrap">
								<table class="table">
									<colgroup>
										<col style="width: 20%;">
										<col style="width: 80%;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label>이름</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_name"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label>생년월일</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_birth"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label>전화번호</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_phone"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label>주소</label></th>
											<td>
												<div>
													<div class="form-group" id="me_address"></div>
												</div>
												<div class="error"></div>
											</td>
										</tr>
										<tr>
											<th scope="col"><label>아이디</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_id"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label>이메일</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_email"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label>경고횟수</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_noshow"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
							            <tr>
											<th scope="col"><label>정지기한</label></th>
							                <td>
							                	<div>
													<div class="form-group" id="me_cancel"></div>
												</div>
												<div class="error"></div>
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</div>
		    	</div>
	  		</div>
    	</section>
	</section>

	<script type="text/javascript">
		$('.btn-detail').click(function(){
			var me_id = $(this).data("id"); 
			
			$.ajax({
				async : true,
				url : '<c:url value="/hq/member/detail"/>', 
				type : 'get', 
				data : {me_id : me_id}, 
				dataType : "json",
				success : function (data){
					let me = data.me;
					var me_birth = (new Date(me.me_birth)).toLocaleDateString('ko-KR', {
						year: 'numeric',
						month: '2-digit',
						day: '2-digit',
						})
						.replace(/\./g, '')
						.replace(/\s/g, '.')
					var me_cancel = "";
					if(me.me_cancel != null){
						me_cancel = (new Date(me.me_cancel)).toLocaleDateString('ko-KR', {
							year: 'numeric',
							month: '2-digit',
							day: '2-digit',
							})
							.replace(/\./g, '')
							.replace(/\s/g, '.')	
					}
					var fullAddress = "(" + me.me_postcode + ") " + me.me_address + me.me_extraAddress + " " + me.me_detailAddress;
					console.log(fullAddress);
					
					$('#me_name').text(me.me_name);
					$('#me_birth').text(me_birth);
					$('#me_phone').text(me.me_phone);
					$('#me_address').text(fullAddress);
					$('#me_id').text(me.me_id);
					$('#me_email').text(me.me_email);
					$('#me_noshow').text(me.me_noshow);
					$('#me_cancel').text(me_cancel);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		});
		
		$('.btn-delete').click(function(e){
			if(!confirm("정말 삭제하시겠습니까?\n삭제하면 복구할 수 없습니다.")){
				e.preventDefault();
			}
		});
	</script>
	
	<script type="text/javascript">
		// 데이터테이블
		$('#table').DataTable({
			language: {
		        search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
		    scrollY: 400,
		    stateSave: true,
		    stateDuration: 300,
		    paging: false,
		    info: false,
		    order: [[ 0, "asc" ]],
		    columnDefs: [
		        { targets: [9], orderable: false }
		    ]
		});
	</script>
</body>