<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>본사관리페이지</title>
	<style type="text/css">
    	.img-box{width:33.33%; height:200px; box-sizing: border-box; position: relative; margin:20px 0; display: none;}
    	.img-name{border: 1px solid gray;}
    	.img-text{margin-bottom: 0; padding: 5px;}
    	.error{color:red; margin-bottom: 10px;}
    	.form-group{margin: 0;}
    	.form-control{border: 1px solid gray; border-radius: 5px; height: 38px; padding: 6px 12px;}
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
			    	<button type="button" class="btn btn-outline-info" data-name="img">현황</button>
			    	<button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#myModal">입고</button>
			    </div>
		    	<div class="mt-3 box record-box">
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
				<div class="img-container d-flex flex-wrap">
					<c:forEach items="${stList}" var="st">
						<div class="card box img-box" style="width:250px; cursor:pointer">
				        	<img class="card-img-top" style="width:100%; height:100%" src="<c:url value="/uploads${st.be_se_fi_name}"/>"></img>
					    	<div class="img-name d-flex align-content-center">
					      		<p class="img-text mx-auto">${st.be_se_name}(수량 : ${st.be_se_total})</p>
					    	</div>
						</div>
					</c:forEach>
				</div>
				<div class="modal fade" id="myModal">
			    	<div class="modal-dialog modal-dialog-centered">
			      		<div class="modal-content">
				        	<div class="modal-header">
				          		<h4 class="modal-title">입고</h4>
				          		<button type="button" class="close" data-dismiss="modal">&times;</button>
				        	</div>
				        	<div class="modal-body">
				          		<form action="<c:url value="/hq/stock/insert"/>" method="post" id="form">
					          		<div class="form-group">
										<label for="be_se_name">기구명:</label>
										<select name="be_se_name" class="custom-select mb-3 form-control">
											<c:forEach items="${seList}" var="se">
												<option value="${se.se_name}">${se.se_name}</option>
											</c:forEach>
									    </select>
									</div>
									<div class="form-group">
										<label for="be_amount">수량:</label>
										<select name="be_amount" class="custom-select mb-3 form-control">
											<c:forEach begin="1" end="30" var="i">
												<option value="${i}">${i}</option>
											</c:forEach>
									    </select>
									</div>
									<button class="btn btn-outline-info col-12">재고 추가</button>
				          		</form>
				        	</div>
				        	<div class="modal-footer">
				          		<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				        	</div>
			      		</div>
			    	</div>
		  		</div>
	    	</div>
	  	</div>
	</div>
	
	<script type="text/javascript">
		$('.btn-outline-info').click(function(){
			var name = $(this).data("name");
			
			$('.btn-outline-info').removeClass("active");
			$(this).addClass("active");
			
			$('.box').css("display", "none");
			$('.'+name+'-box').css("display", "block");
		});
	</script>
</body>
</html>