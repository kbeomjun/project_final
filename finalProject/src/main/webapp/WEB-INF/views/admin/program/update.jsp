<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로그램 수정</title>
<style type="text/css">
	.error{color : red;}
</style>
</head>
<body>

	<div class="container-fluid">
	    <div class="row">
	        <!-- 왼쪽 사이드바 -->
	        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>	
	        </nav>
	
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
	            <div class="pt-3 pb-2 mb-3">
					<h2 class="mt-3 mb-3">${branchProgram.bp_sp_name} 프로그램 수정</h2>
					<form action="<c:url value="/admin/program/update"/>" method="post" id="form">
						<input type="hidden" name="bp_num" value="${branchProgram.bp_num}">
						<div class="form-group">
							<label>프로그램:</label>
							<input class="form-control" name="bp_sp_name" value="${branchProgram.bp_sp_name}" readonly/>
						</div>
						<div class="form-group">
							<label>트레이너:</label>
							<input class="form-control" value="${branchProgram.em_name}" readonly/>
						</div>
						<div class="form-group">
							<label>총 인원수:</label>
							<input class="form-control" name="bp_total" value="${branchProgram.bp_total}" placeholder="숫자를 입력하세요."/>
						</div>
						<div class="d-flex justify-content-between">
							<a href="<c:url value="/admin/program/list"/>" class="btn btn-outline-danger">취소</a>
							<div class="text-right">
								<button type="submit" class="btn btn-outline-warning">수정</button>
							</div>
						</div>
					</form>
	                
	            </div>
	        </main>
	    </div>
	</div>

	<script type="text/javascript">
		$('#form').validate({
			rules : {
				bp_total : {
					required : true,
					digits : true,
					min : 1,
					max : 30
				}
			},
			messages : {
				bp_total : {
					required : '필수 항목입니다.',
					digits : '숫자로만 입력하세요.',
					min : '1 이상으로 입력하세요.',
					max : '30 이하로 입력하세요.'
				}
			},
			submitHandler : function(form){
				form.submit();
			}
			});
		$.validator.addMethod('regex', function(value, element, regex){
			var re = new RegExp(regex);
			return this.optional(element) || re.test(value);
		}, "정규표현식을 확인하세요.");		
	</script>	
</body>
</html>
