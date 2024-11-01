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
				<h2 class="sub_title">재고 관리</h2>
			</div>
			
			<div class="sub_hd_wrap">
	    		<ul class="tab_list">
			    	<li class="tab_item">
			    		<button type="button" class="tab_link btn-menu btn-menu btn-record _active" data-name="record">내역</button>
		    		</li>
			    	<li class="tab_item">
			    		<button type="button" class="tab_link btn-menu btn-menu btn-img" data-name="img">현황</button>
		    		</li>
		    	</ul>
		    </div>
		
	    	<div class="table_wrap box box-record">
		    	<table class="table table_center" id="table">
			    	<thead id="thead">
			      		<tr>
			        		<th>내역번호</th>
			        		<th>기록날짜</th>
			        		<th>기구명</th>
			        		<th>제조일</th>
			        		<th>수량</th>
			        		<th>상태</th>
			      		</tr>
			    	</thead>
			    	<tbody id="tbody">
			    	
			    	</tbody>
				</table>
	    	</div>
	    	
	    	<div class="box box-img" style="display: none;">
		    	<div class="search_bar ml-0">
		            <input type="text" class="form-control" id="search" name="search" placeholder="검색">
		            <div class="search_btn"></div>
		        </div>
		        
		    	<ul class="img-container equipment_warp">
			    	
				</ul>
	    	</div>

	    	<div class="btn_wrap">
				<div class="btn_right_wrap">
					<div class="btn_link_black">
						<button type="button" class="btn btn_black js-btn-insert" data-toggle="modal" data-target="#myModal">
							<span>입고<i class="ic_link_share"></i></span>
						</button>
						<div class="btn_black_top_line"></div>
						<div class="btn_black_right_line"></div>
						<div class="btn_black_bottom_line"></div>
						<div class="btn_black_left_line"></div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="myModal">
		    	<div class="modal-dialog modal-dialog-centered">
		    		<div class="modal-content">
			        	<div class="modal-header">
			          		<h4 class="modal-title">입고</h4>
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
											<th scope="row">
												<label for="be_se_name">기구명</label>
											</th>
											<td>
												<div class="form-group">
													<select name="be_se_name" class="custom-select form-control">

													</select>
												</div>
												<div class="error error-name"></div>
											</td>
										</tr>
										<tr>
											<th scope="col"><label for="be_amount">수량</label></th>
							                <td>
							                	<div>
													<input type="text" class="form-control" id="be_amount" name="be_amount">
												</div>
												<div class="error error-amount"></div>
							                </td>
							            </tr>
									</tbody>
								</table>
							</div>
						</div>
			        	<div class="modal-footer">
			        		<button class="btn btn_black btn-insert">입고</button>
			          		<a href="#" class="btn btn_red btn-close" data-dismiss="modal">취소</a>
			        	</div>
		    		</div>
		    	</div>
	  		</div>
    	</section>
	</section>
	
	<script type="text/javascript">
		// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		let msgNum = `<span>정상적인 숫자가 아닙니다.</span>`;
		let regexNum = /^[0-9]{1,}$/;

		$('#be_amount').keyup(function(){
			$('.error-amount').children().remove();
			
			if($('#be_amount').val() == ''){
				$('.error-amount').append(msgRequired);
			}else if(!regexNum.test($('#be_amount').val())){
				$('.error-amount').append(msgNum);
			}else if($('#be_amount').val() == '0'){
				$('.error-amount').append(msgNum);
			}else{
				$('.error-amount').children().remove();	
			}
		});
		
		$(document).on('click', '.btn-insert', function(){
			let flag = true;
			
			$('.error').children().remove();
			if($('#be_amount').val() == ''){
				$('.error-amount').append(msgRequired);
				$('#be_amount').focus();
				flag = false;
			}else if(!regexNum.test($('#be_amount').val())){
				$('.error-amount').append(msgNum);
				$('#be_amount').focus();
				flag = false;
			}else if($('#be_amount').val() == '0'){
				$('.error-amount').append(msgNum);
				$('#be_amount').focus();
				flag = false;
			}
			
			if(flag){
				var be_se_name = $("select[name=be_se_name]").val();
				var be_amount = $("#be_amount").val();
				
				$.ajax({
					async : true,
					url : '<c:url value="/hq/stock/insert"/>', 
					type : 'post', 
					data : {be_se_name : be_se_name, be_amount : be_amount}, 
					dataType : "json",
					success : function (data){
						let msg = data.msg;
						if(!msg == ""){
							alert(msg);
						}
						displayList(search);
						$('#myModal').modal("hide");
						$('#be_amount').val("");
					},
					error : function(jqXHR, textStatus, errorThrown){
						console.log(jqXHR);
					}
				});
			}
		});
	</script>
	
	<script type="text/javascript">
		var search = "";

		$(document).ready(function(){
			displayList(search);
		});
		
		$('#search').keyup(function(){
	    	search = $('#search').val();
	    	displayList(search);
	    });
		
		function displayList(search){
			$.ajax({
				async : true,
				url : '<c:url value="/hq/stock/list/items"/>', 
				type : 'get', 
				data : {search : search}, 
				dataType : "json",
				success : function (data){
					let stList = data.stList;
					let str = ``;
					for(var st of stList){
						str += `
							<li class="equipment_item">
								<div class="equipment_img_wrap">
					        		<img class="equipment_img" src="<c:url value="/uploads\${st.be_se_fi_name}"/>" />
					        	</div>
						    	<div class="equipment_info_wrap">
									<p class="img-text mx-auto">\${st.be_se_name}(수량 : \${st.be_se_total})</p>
								</div>
					    	</li>
						`;
					}
					$('.img-container').html(str);
					
					let seList = data.seList;
					str = ``;
					for(var se of seList){
						str += `
							<option value="\${se.se_name}">\${se.se_name}</option>
						`;
					}
					$('.custom-select').html(str);
					
					restartTable();
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
				}
			});
		}
		
		$('.btn-close').click(function(){
    		$('.error').children().remove();
    		$('#be_amount').val("");
    	});
	</script>
	
	<script type="text/javascript">
		// 데이터테이블
		var table = $('#table').DataTable({
			language: {
				search: "",
		        searchPlaceholder: "검색",
		        zeroRecords: "",
		        emptyTable: ""
		    },
		    createdRow: function(row, data, dataIndex) {
		        if (data.be_amount < 0) {
		        	$('td', row).eq(4).css('color', 'red');
		        } else if (data.be_amount > 0) {
		        	$('td', row).eq(4).css('color', 'green');
		        }
		    },
		    scrollY: 400,
		    stateSave: true,
		    stateDuration: 300,
		    paging: false,
		    info: false,
		    order: [[ 0, "desc" ]],
		    ajax:{
	        	url:'<c:url value="/hq/stock/list"/>',
	        	type:"post",
	        	dataSrc :"data"
	        },
	        columns:[
	        	{data:"be_num"},
	        	{data:"be_recordStr"},
	        	{data:"be_se_name"},
	        	{data:"be_birthStr"},
	        	{data:"be_amount"},
	        	{data:"be_type"}
	        ]
		});
		
		function restartTable(){
			table.destroy();
			table = $('#table').DataTable({
				language: {
					search: "",
			        searchPlaceholder: "검색",
			        zeroRecords: "",
			        emptyTable: ""
			    },
			    createdRow: function(row, data, dataIndex) {
			    	if (data.be_amount < 0) {
			        	$('td', row).eq(4).css('color', 'red');
			        } else if (data.be_amount > 0) {
			        	$('td', row).eq(4).css('color', 'green');
			        }
			    },
			    scrollY: 400,
			    stateSave: true,
			    stateDuration: 300,
			    paging: false,
			    info: false,
			    order: [[ 0, "desc" ]],
			    ajax:{
		        	url:'<c:url value="/hq/stock/list"/>',
		        	type:"post",
		        	dataSrc :"data"
		        },
		        columns:[
		        	{data:"be_num"},
		        	{data:"be_recordStr"},
		        	{data:"be_se_name"},
		        	{data:"be_birthStr"},
		        	{data:"be_amount"},
		        	{data:"be_type"}
		        ]
			});
		}
	
		$(document).on('click', '.btn-menu', function(){
			var name = $(this).data("name");
			
			$('.btn-menu').removeClass("_active");
			$('.btn-'+name).addClass("_active");
			$('.box').css("display", "none");
			$('.box-'+name).css("display", "block");
			
			if(name == 'record'){
				restartTable();
				$('#search').val("");
				search = "";
				$(document).ready(function(){
					displayList(search);
				});
			}
		});
	</script>
</body>