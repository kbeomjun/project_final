<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>리뷰게시글 등록</title>
</head>
<body>

	<main class="sub_container" id="skipnav_target">
		<section class="sub_banner sub_banner_04"></section>
		<section class="sub_content">
		
	        <!-- 왼쪽 사이드바 -->
	        <%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
		
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <section class="sub_content_group">
	        	<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
				<form action="<c:url value="/client/review/insert"/>" method="post" id="form">
					<table class="table">
						<colgroup>
							<col style="width: 20%;">
							<col style="width: 80%;">
						</colgroup>
						
						<tbody>
							<tr>
								<th scope="row">
									<label for="rp_pa_num" class="_asterisk">리뷰에 작성할 결제내역</label>
								</th>
								<td>
									<div class="form-group">
										<select name="rp_pa_num" id="rp_pa_num" class="custom-select form-control">
											<option value="">선택</option>
											<c:forEach items="${paymentList}" var="pa">
												<c:set var="formattedDate">
													<fmt:formatDate value="${pa.pa_date}" pattern="yy/MM/dd" />
												</c:set>
												<option value="${pa.pa_num}">${pa.pt_type}(${formattedDate})</option>												
											</c:forEach>
										</select>
									</div>
									<div class="error error-payment"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_br_name" class="_asterisk">지점명</label>
								</th>
								<td>
									<div class="form-group">
										<select name="rp_br_name" id="rp_br_name" class="custom-select form-control">
											<option value="">선택</option>
											<c:forEach items="${branchList}" var="br">
												<option value="${br.br_name}">${br.br_name}</option>
											</c:forEach>												
										</select>
									</div>
									<div class="error error-brName"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_title" class="_asterisk">제목</label>
								</th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control" id="rp_title" name="rp_title" placeholder="제목을 입력하세요.">
									</div>
									<div class="error error-title"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_content" class="_asterisk">내용</label>
								</th>
								<td>
									<div class="form-group">
										<textarea class="form-control" id="rp_content" name="rp_content" placeholder="내용을 입력하세요. (5000자 이내)" maxlength="5000"></textarea>
									</div>
									<div class="error error-content"></div>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<button type="submit" class="btn btn_insert">등록</button>
							<a href="<c:url value="/client/review/list"/>" class="btn btn_cancel">취소</a>
						</div>
					</div>					
					
				</form>    	
		
	        </section>
	        
		</section>
	</main>

    <script type="text/javascript">
    	// 필수항목 체크
		let msgRequired = `<span>필수항목입니다.</span>`;
		
		
		$('#rp_title').keyup(function(){
			$('.error-title').children().remove();
			
			if($('#rp_title').val() == ''){
				$('.error-title').append(msgRequired);
			}else{
				$('.error-title').children().remove();	
			}
		});
		
	    $('#rp_content').on('summernote.change', function() {
	        $('.error-content').children().remove();
	        
	        if ($('#rp_content').summernote('isEmpty')) {
	            $('.error-content').append(msgRequired);
	        } else {
	            $('.error-content').children().remove();
	        }
	    });
		
		
		$('#form').submit(function(){
			$('.error').children().remove();
			let flag = true;
			
			if($('#rp_pa_num').val() == ''){
				$('.error-payment').append(msgRequired);
				flag = false;
			}
			
			if($('#rp_br_name').val() == ''){
				$('.error-brName').append(msgRequired);
				flag = false;
			}
			
			if($('#rp_title').val() == ''){
				$('.error-title').append(msgRequired);
				$('#rp_title').focus();
				flag = false;
			}
			
	        if ($('#rp_content').summernote('isEmpty')) {
	            $('.error-content').append(msgRequired);
	            $('#rp_content').focus();
	            flag = false;
	        }
			
			return flag;
		});
    </script>
    
	<script>
		$('#rp_content').summernote({
			placeholder: '내용을 작성하세요.',
			tabsize: 2,
			height: 350
		});
    </script>
</body>
</html>
