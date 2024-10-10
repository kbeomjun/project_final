<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
    	.img-box{width:33.33%; height:200px; box-sizing: border-box; position: relative; margin:20px 0;}
    	.img-name{border: 1px solid gray;}
    	.img-text{margin-bottom: 0; padding: 5px;}
    	.btn-update-img{position:absolute; top:5px; right:5px; line-height: 16px; width: 42px; height: 38px; border-radius: 50%; padding: 9px 6px 6px;}
		.box-stock{visibility: hidden;}
	</style>
</head>
<body>
	<div class="container" style="margin-top:30px">
	  	<div class="row">
	    	<div class="col-sm-2">
		    	<ul class="nav nav-pills flex-column">
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/branch/list"/>">지점 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/employee/list"/>">직원 관리</a>
	       	 		</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/equipment/list"/>">운동기구 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link active" href="<c:url value="/hq/stock/list"/>">재고 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/order/list"/>">발주 내역</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/payment/list"/>">회원권 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/program/list"/>">프로그램 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/member/list"/>">회원 관리</a>
		        	</li>
		        	<li class="nav-item">
		          		<a class="nav-link" href="<c:url value="/hq/inquiry/list"/>">문의 내역</a>
		        	</li>
		      	</ul>
		      	<hr class="d-sm-none">
	    	</div>
		    <div class="col-sm-10">
			    <div>
			    	<button type="button" class="btn btn-outline-info active" data-name="record">내역</button>
			    	<button type="button" class="btn btn-outline-info" data-name="stock">현황</button>
			    </div>
		    	<div class="mt-3 box box-record">
		    		<table class="table table-hover">
				    	<thead>
				      		<tr>
				        		<th>내역번호</th>
				        		<th>기록날짜</th>
				        		<th>기구명</th>
				        		<th>제조일</th>
				        		<th>수량</th>
				        		<th>상태</th>
				      		</tr>
				    	</thead>
				    	<tbody>
				    		<c:forEach items="${beList}" var="be">
						      	<tr>
						        	<td>
								        ${be.be_num}
							        </td>
							        <td>
										<fmt:formatDate value="${be.be_record}" pattern="yyyy.MM.dd hh:mm:ss"/>				        	
						        	</td>
							        <td>
							        	${be.be_se_name}
						        	</td>
						        	<td>
						        		<fmt:formatDate value="${be.be_birth}" pattern="yyyy.MM.dd"/>
						        	</td>
						        	<td>
						        		${be.be_amount}
						        	</td>
						        	<td>
						        		${be.be_type}
						        	</td>
						      	</tr>
				    		</c:forEach>
				    		<c:if test="${beList.size() == 0}">
				    			<tr>
					        		<th class="text-center" colspan="5">재고내역이 없습니다.</th>
					      		</tr>
				    		</c:if>
				    	</tbody>
					</table>
				</div>
				<div class="img-container d-flex flex-wrap box box-stock">
					<c:forEach items="${stList}" var="st">
						<div class="card img-box" style="width:250px; cursor:pointer">
				        	<img class="card-img-top" style="width:100%; height:100%" src="<c:url value="/uploads${st.be_se_fi_name}"/>">
					        	<a href="#" class="btn btn-outline-warning btn-update-img">
									<i class="fi fi-br-edit"></i>
								</a>
							</img>
					    	<div class="img-name d-flex align-content-center">
					      		<p class="img-text mx-auto">${st.be_se_name}(수량 : ${st.be_se_total})</p>
					    	</div>
						</div>
					</c:forEach>
				</div>
	    	</div>
	  	</div>
	</div>
	
	<script type="text/javascript">
		$('.btn-outline-info').click(function(){
			var name = $(this).data("name");
			
			$('.btn-outline-info').removeClass("active");
			$(this).addClass("active");
			
			if(name == "record"){
				$('.box-record').css("display", "block");
				$('.box-stock').css("visibility", "hidden");
			}else{
				$('.box-record').css("display", "none");
				$('.box-stock').css("visibility", "visible");
			}
		});
	</script>
</body>
</html>