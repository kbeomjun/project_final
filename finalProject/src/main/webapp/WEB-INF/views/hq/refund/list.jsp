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
				<h2 class="sub_title">환불 처리</h2>
			</div>
		
	    	<div class="table_wrap">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			      			<th>결제번호</th>
			        		<th>회원계정</th>
			        		<th>이메일</th>
			        		<th>결제날짜</th>
			        		<th>금액(원)</th>
			        		<th>회원권유형</th>
			        		<th>시작일</th>
			        		<th>마감일</th>
			        		<th></th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    		
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="modal fade" id="myModal">
		    	<div class="modal-dialog modal-dialog-centered">
		    		<div class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">환불</h4>
			          		<button type="button" class="close btn-close" data-dismiss="modal">&times;</button>
			        	</div>
			        	<div class="modal-body">
							<div class="table_wrap">
								<table class="table">
									<colgroup>
										<col style="width: auto;">
									</colgroup>
									<tbody>
							            <tr>
											<th scope="col"><label for="re_price">금액</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="re_price" name="re_price">
												</div>
												<div class="error error-price"></div>
							                </td>
							            </tr>
										<tr>
											<th scope="row">
												<label for="re_reason">사유</label>
											</th>
											<td>
												<div class="form-group">
													<select id="re_reason" name="re_reason" class="custom-select form-control" style="width: 100%;">
														<option value="" selected>선택</option>
														<option value="중도 해지">중도 해지</option>
														<option value="시작전 계약 취소">시작전 계약 취소</option>
														<option value="PT트레이너 불만">PT트레이너 불만</option>
														<option value="서비스 불만">서비스 불만</option>
													</select>
												</div>
												<input type="hidden" id="re_pa_num" name="re_pa_num">
												<div class="error error-reason"></div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			        		<button class="btn btn_black btn-refund">환불</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</div>
		    	</div>
	  		</div>
    	</section>
	</section>
	
	<script type="text/javascript">
		// 필수항목 체크
		let msgPrice = `<span>결제금액을 초과합니다.</span>`;
		let msgRequired = `<span>필수항목입니다.</span>`;
		let msgNum = `<span>정상적인 숫자가 아닙니다.</span>`;
		let regexNum = /^[0-9]{1,}$/;
		
		$(document).on("keyup", "#re_price", function(){
			$('.error').children().remove();
			if($('#re_price').val() == ''){
				$('.error-price').append(msgRequired);
			}else if(!regexNum.test($('#re_price').val())){
				$('.error-price').append(msgNum);
			}else if($('#re_price').val() == '0'){
				$('.error-price').append(msgNum);
			}else if($('#re_price').val() > price || $('#re_price').val().length > price.length){
				$('.error-price').append(msgPrice);
			}else{
				$('.error-price').children().remove();	
			}
		});
		$('select[name=re_reason]').change(function(){
			$('.error-reason').children().remove();
			if($("select[name=re_reason]").val() == ''){
				$('.error-reason').append(msgRequired);
			}else{
				$('.error-reason').children().remove();
			}
		});
		
		$(document).on("click", ".btn-refund", function(){
			let flag = true;
			
			$('.error').children().remove();
			if($('#re_price').val() == ''){
				$('.error-price').append(msgRequired);
				$('#re_price').focus();
				flag = false;
			}else if(!regexNum.test($('#re_price').val())){
				$('.error-price').append(msgNum);
				$('#re_price').focus();
				flag = false;
			}else if($('#re_price').val() == '0'){
				$('.error-price').append(msgNum);
				$('#re_price').focus();
				flag = false;
			}else if($('#re_price').val() > price || $('#re_price').val().length > price.length){
				$('.error-price').append(msgPrice);
				$('#re_price').focus();
				flag = false;
			}
			if($("select[name=re_reason]").val() == ''){
				$('.error-reason').append(msgRequired);
				flag = false;
			}
			
			if(flag){
				if(confirm("정말 환불처리 하시겠습니까?\n환불처리 후 복구할 수 없습니다.")){
					var re_price = $("#re_price").val();
					var re_reason = $("select[name=re_reason] option:selected").val();
					var re_pa_num = $('#re_pa_num').val();
					$.ajax({
						async : true,
						url : '<c:url value="/hq/refund/insert"/>', 
						type : 'get', 
						data : {re_price : re_price, re_reason : re_reason, re_pa_num : re_pa_num}, 
						dataType : "json",
						success : function (data){
							var msg = data.msg;
							if(msg != ""){
								alert(msg);
							}
							$('#myModal').modal("hide");
							$('#re_price').val("");
							$("select[name=re_reason]").val("").prop("selected", true);
							
							table.destroy();
							table = $('#table').DataTable({
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
							    order: [[ 0, "desc" ]],
							    ajax:{
						        	url:'<c:url value="/hq/refund/list"/>',
						        	type:"post",
						        	dataSrc :"data"
						        },
						        columns:[
						        	{data:"pa_num"},
						        	{data:"pa_me_id"},
						        	{data:"pa_me_email"},
						        	{data:"pa_dateStr"},
						        	{data:"pa_formattedPrice"},
						        	{data:"pa_pt_name"},
						        	{data:"pa_startStr"},
						        	{data:"pa_endStr"},
						        	{data : "",
							    		render: function(data,type,row){
							    			return '<button type="button" class="btn btn_red btn-refund-modal" data-toggle="modal" data-target="#myModal" data-price="'+row.pa_price+'" data-num="'+row.pa_num+'">환불</button>';
							    		}
							    	}
						        ],
						        columnDefs: [
							        { targets: [0, 1, 2, 4, 5, 6, 8], orderable: false }
							    ]
							});
						},
						error : function(jqXHR, textStatus, errorThrown){
							console.log(jqXHR);
						}
					});
				}
			}
		});
	</script>
	
	<script type="text/javascript">
		// 데이터테이블
		var price = "";
		var pa_num = "";
		var table = $('#table').DataTable({
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
		    order: [[ 0, "desc" ]],
		    ajax:{
	        	url:'<c:url value="/hq/refund/list"/>',
	        	type:"post",
	        	dataSrc :"data"
	        },
	        columns:[
	        	{data:"pa_num"},
	        	{data:"pa_me_id"},
	        	{data:"pa_me_email"},
	        	{data:"pa_dateStr"},
	        	{data:"pa_formattedPrice"},
	        	{data:"pa_pt_name"},
	        	{data:"pa_startStr"},
	        	{data:"pa_endStr"},
	        	{data : "",
		    		render: function(data,type,row){
		    			return '<button type="button" class="btn btn_red btn-refund-modal" data-toggle="modal" data-target="#myModal" data-price="'+row.pa_price+'" data-num="'+row.pa_num+'">환불</button>';
		    		}
		    	}
	        ],
	        columnDefs: [
		        { targets: [0, 1, 2, 4, 5, 6, 8], orderable: false }
		    ]
		});

		$(document).on("click", ".btn-refund-modal", function(){
			price = $(this).data("price");
			pa_num = $(this).data("num");
			$('#re_pa_num').val(pa_num);
		});
		
		$('.btn-close').click(function(){
			$('.error').children().remove();
			$('#re_price').val("");
			$('#re_pa_num').val("");
			$("select[name=re_reason]").val("").prop("selected", true);
		});
	</script>
</body>