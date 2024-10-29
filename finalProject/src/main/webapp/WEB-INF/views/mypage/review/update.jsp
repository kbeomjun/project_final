<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>

	<main class="sub_container" id="skipnav_target">
		<section class="sub_banner sub_banner_04"></section>
		<section class="sub_content">
		
	        <!-- 왼쪽 사이드바 -->
	        <%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
		
	        <!-- 오른쪽 컨텐츠 영역 -->
	        <section class="sub_content_group">
	        	<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
				<form action="<c:url value="/mypage/review/update"/>" method="post" id="form">
					<input type="hidden" name="rp_num" value="${review.rp_num}">
					<input type="hidden" name="me_id" value="${me_id}">
					<table class="table">
						<colgroup>
							<col style="width: 20%;">
							<col style="width: 80%;">
						</colgroup>
						
						<tbody>
							<tr>
								<th scope="row">
									<label for="rp_br_name" class="_asterisk">지점명</label>
								</th>
								<td>
									<div class="form-group">
										<select name="rp_br_name" id="rp_br_name" class="custom-select form-control">
											<c:forEach items="${branchList}" var="br">
												<option value="${br.br_name}" <c:if test="${br.br_name eq review.rp_br_name}">selected</c:if>>${br.br_name}</option>
											</c:forEach>												
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rp_title" class="_asterisk">제목</label>
								</th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control" id="rp_title" name="rp_title" placeholder="제목을 입력하세요." value="${review.rp_title}">
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
										<textarea class="form-control" id="rp_content" name="rp_content" placeholder="내용을 입력하세요. (5000자 이내)" maxlength="5000">${review.rp_content}</textarea>
									</div>
									<div class="error error-content"></div>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<button type="submit" class="btn btn_insert">수정</button>
							<a href="<c:url value="/mypage/review/detail/${review.rp_num}"/>" class="btn btn_cancel">취소</a>
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
