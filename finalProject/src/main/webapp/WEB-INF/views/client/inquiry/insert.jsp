<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

		   	<section class="sub_banner sub_banner_04"></section>
			<section class="sub_content">
		
		        <!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/clientSidebar.jsp" %>
		        
		        
		        <!-- 오른쪽 컨텐츠영역 -->
				<section class="sub_content_group">
				
					<div class="sub_title_wrap">
						<h2 class="sub_title">1:1 문의</h2>
						<p class="sub_title__txt">
							<c:choose>
									<c:when test="${user ne null}">
										<span>답변은 마이페이지에서 확인하실 수 있습니다.</span>
									</c:when>
									<c:when test="${user eq null}">
										<span>답변은 이메일을 통해 받아보실 수 있습니다. </span>
									</c:when>
							</c:choose>	
						</p>
					</div>
					
					<div class="table_wrap">
						<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
						<form action="<c:url value="/client/inquiry/insert"/>" method="post" id="form">
							<table class="table">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 80%;">
								</colgroup>
								
								<tbody>
									<tr>
										<th scope="row">
											<label for="mi_it_name" class="_asterisk">문의 분류</label>
										</th>
										<td>
											<div class="form-group">
												<select name="mi_it_name" id="mi_it_name" class="custom-select form-control">
													<option value="">선택</option>
													<c:forEach items="${inquiryTypeList}" var="it">
														<option value="${it.it_name}">${it.it_name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="error error-typeName"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="mi_br_name" class="_asterisk">지점명</label>
										</th>
										<td>
											<div class="form-group">
												<select name="mi_br_name" id="mi_br_name" class="custom-select form-control">
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
											<label for="mi_email" class="_asterisk">이메일</label>
										</th>
										<td>
											<div class="form-inline">
												<c:choose>
													<c:when test="${user ne null}">
														<div class="form-group">
															${user.me_email}
														</div>				
														<input type="hidden" name="mi_email" value="${user.me_email}">									
													</c:when>
													<c:when test="${user eq null}">
														<input type="text" class="form-control w_email" id="mi_emailId" name="mi_emailId" placeholder="이메일 아이디">
														<span class="email_at">@</span>
														<select class="form-control custom-select" id="mi_emailDomain" name="mi_emailDomain">
															<option value="">선택</option>
															<option value="naver.com">naver.com</option>
									                        <option value="daum.net">daum.net</option>
									                        <option value="google.com">google.com</option>
									                        <option value="yahoo.com">yahoo.com</option>
									                        <option value="custom">직접 입력</option>
														</select>
														<input type="text" class="form-control w_email2" id="mi_customEmailDomain" name="mi_customEmailDomain" placeholder="직접 입력" style="display: none;">
													</c:when>
												</c:choose>
											</div>
											<div style="display: flex;">
												<div class="error error-emailId" style="flex: 367;"></div>
												<div class="error error-emailDomain" style="flex: 194;"></div>
												<div class="error error-customEmailDomain" style="flex: 378;"></div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="mi_title" class="_asterisk">제목</label>
										</th>
										<td>
											<div class="form-group">
												<input type="text" class="form-control" id="mi_title" name="mi_title" placeholder="제목을 입력하세요.">
											</div>
											<div class="error error-title"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="mi_content" class="_asterisk">내용</label>
										</th>
										<td>
											<div class="form-group">
												<textarea class="form-control" id="mi_content" name="mi_content" placeholder="내용을 입력하세요. (5000자 이내)" maxlength="5000"></textarea>
											</div>
											<div class="error error-content"></div>
										</td>
									</tr>
								</tbody>
							</table>
							
							<div class="form-group">
								<div class="privacy_consent_wrap">
									<div>
										<input type="checkbox" id="privacyConsent" name="privacyConsent">
										<label for="privacyConsent" class="privacy_consent_title">개인정보 수집·이용 동의 (필수)</label>
									</div>
									<p class="privacy_consent_text">문의하신 내용에 대한 원인 파악 및 원활한 상담을 위하여 이메일을 수집합니다. 수집된 개인정보는 3년간 보관 후 파기됩니다.</p>
								</div>
							</div>	
							
							<div class="btn_wrap">
								<div class="btn_right_wrap">
									<div class="btn_link_black">
										<button type="submit" class="btn btn_black js-btn-insert">
											<span>문의하기<i class="ic_link_share"></i></span>
										</button>
										<div class="btn_black_top_line"></div>
										<div class="btn_black_right_line"></div>
										<div class="btn_black_bottom_line"></div>
										<div class="btn_black_left_line"></div>
									</div>
								</div>
							</div>						
							
						</form>
					</div>
					
				</section>
		           
			</section>
			
			<script type="text/javascript">
				// 필수항목 체크
				let msgRequired = `<span>필수항목입니다.</span>`;
				let msgEmailId = `<span>아이디가 올바르지 않습니다.</span>`;
				let msgEmailDomain = `<span>도메인이 올바르지 않습니다.</span>`;
				let regexEmailId = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/;
				let regexEmailDomain = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
				const authority = '${user.me_authority}';
				
				
				$('#mi_title').keyup(function(){
					$('.error-title').children().remove();
					
					if($('#mi_title').val() == ''){
						$('.error-title').append(msgRequired);
					}else{
						$('.error-title').children().remove();	
					}
				});
				
				$('#mi_content').keyup(function(){
					$('.error-content').children().remove();
					
					if($('#mi_content').val() == ''){
						$('.error-content').append(msgRequired);
					}else{
						$('.error-content').children().remove();	
					}
				});
			    
				
				$('#mi_emailId').keyup(function(){
					$('.error-emailId').children().remove();
					
					if($('#mi_emailId').val() == ''){
						$('.error-emailId').append(msgRequired);
					}else{
						if(!regexEmailId.test($('#mi_emailId').val())){
							$('.error-emailId').append(msgEmailId);
						}else{
							$('.error-emailId').children().remove();	
						}
					}
				});
				
				$('#form').submit(function(){
					$('.error').children().remove();
					let flag = true;
					
					if(authority == 'BRADMIN' || authority == 'HQADMIN'){
						alert('관리자는 문의를 등록할 수 없습니다.');
						return false;
					}
					
					if($('#mi_it_name').val() == ''){
						$('.error-typeName').append(msgRequired);
						flag = false;
					}
					
					if($('#mi_br_name').val() == ''){
						$('.error-brName').append(msgRequired);
						flag = false;
					}
					
					if($('#mi_title').val() == ''){
						$('.error-title').append(msgRequired);
						$('#mi_title').focus();
						flag = false;
					}
					
					if($('#mi_content').val() == ''){
						$('.error-content').append(msgRequired);
						$('#mi_content').focus();
						flag = false;
					}
					
					if($('#mi_emailId').val() == ''){
						$('.error-emailId').append(msgRequired);
						$('#mi_emailId').focus();
						flag = false;
					} else if(!regexEmailId.test($('#mi_emailId').val())){
						$('.error-emailId').append(msgEmailId);
						$('#mi_emailId').focus();
						flag = false;
					}
					
					if($('#mi_emailDomain').val() == ''){
						$('.error-emailDomain').append(msgRequired);
						flag = false;
					}
					
					if($('#mi_emailDomain').val() == 'custom'){
						if($('#mi_customEmailDomain').val() == ''){
							$('.error-customEmailDomain').append(msgRequired);
							$('#mi_customEmailDomain').focus();
							flag = false;
						} else if(!regexEmailDomain.test($('#mi_customEmailDomain').val())){
							$('.error-customEmailDomain').append(msgEmailDomain);
							$('#mi_customEmailDomain').focus();
							flag = false;
						}			
					}
					
				    if (!$('#privacyConsent').is(':checked')) {
				        alert('개인정보 수집 및 이용에 동의해 주세요.');
				        flag = false;
				    }			
					
				    if (flag) {
				        combineEmail();
				    } else {
				        event.preventDefault();
				    }
					
					return flag;
				});
				
				// 이메일 도메인 선택 변경 시 처리
				document.getElementById('mi_emailDomain').addEventListener('change', function() {
					$('.error-emailDomain').children().remove();
					$('.error-customEmailDomain').children().remove();
					var customDomainInput = document.getElementById('mi_customEmailDomain');
					if (this.value === 'custom') {
						customDomainInput.style.display = 'block';
						customDomainInput.required = true;
		          
						$('#mi_customEmailDomain').off('keyup').on('keyup', function(){
							$('.error-customEmailDomain').children().remove();
		
							if($('#mi_customEmailDomain').val() == ''){
								$('.error-customEmailDomain').append(msgRequired);
							}else{
								if(!regexEmailDomain.test($('#mi_customEmailDomain').val())){
									$('.error-customEmailDomain').append(msgEmailDomain);
								}else{
									$('.error-customEmailDomain').children().remove();	
								}
							}
						});               
					} else {
						customDomainInput.style.display = 'none';
						customDomainInput.value = '';
						customDomainInput.required = false;
						$('#mi_customEmailDomain').off('keyup');               
					}
				});
		
				// 폼 제출 시 이메일을 하나의 필드로 결합하여 숨겨진 필드에 저장
				function combineEmail() {
					const emailId = document.getElementById("mi_emailId").value;
					const emailDomain = document.getElementById("mi_emailDomain").value === 'custom' ? 
					                    document.getElementById("mi_customEmailDomain").value : 
					                    document.getElementById("mi_emailDomain").value;
					console.log(document.getElementById("mi_emailDomain").value === 'custom')                    
					const emailField = document.createElement("input");
					emailField.setAttribute("type", "hidden");
					emailField.setAttribute("name", "mi_email");
					emailField.setAttribute("value", emailId + "@" + emailDomain);
					document.getElementById("form").appendChild(emailField);
				}
		
		    </script>