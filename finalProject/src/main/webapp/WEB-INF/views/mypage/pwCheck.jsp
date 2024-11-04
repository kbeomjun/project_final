<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<section class="sub_banner sub_banner_07"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/mypageSidebar.jsp" %>
	
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">비밀번호 확인</h2>
					</div>
					
					<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
					<form action="<c:url value="/mypage/pwcheck"/>" method="post" id="form">
						<input type="hidden" name="me_id" value="${user.me_id}">
						<table class="table">
							<colgroup>
								<col style="width: 20%;">
								<col style="width: 80%;">
							</colgroup>
							
							<tbody>
								<tr>
									<th scope="row">
										<label for="me_pw" class="_asterisk">비밀번호</label>
									</th>
									<td>
										<div class="form-group">
											<input type="password" class="form-control" id="me_pw" name="me_pw" placeholder="비밀번호를 입력하세요">
										</div>
										<div class="error error-pw"></div>
									</td>
								</tr>						
							</tbody>
						</table>
						
						<div class="btn_wrap">
							<div class="btn_left_wrap">
								<div class="account_wrap">
									<a href="javascript:void(0)" class="btn btn_naver">
										<span onclick="redirectToSocial('NAVER')">naver 계정으로 계속하기</span>
									</a>
									<a href="javascript:void(0)" class="btn btn_kakao">
										<span onclick="redirectToSocial('KAKAO')">kakao 계정으로 계속하기</span>
									</a>
								</div>
								<!-- <a href="javascript:void(0);" class="btn mt-3 btn-naver" onclick="redirectToSocial('NAVER')">naver 계정으로 계속하기</a>
								<a href="javascript:void(0);" class="btn mt-3 btn-kakao ml-3" onclick="redirectToSocial('KAKAO')">kakao 계정으로 계속하기</a> -->
							</div>						
							<div class="btn_right_wrap">
								<button type="submit" class="btn btn_insert">확인</button>
							</div>
						</div>
					</form>
					
				</section>
			
			</section>
	
			<!-- 카카오 로그인 -->
			<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
			<script type="text/javascript">
			    $(document).ready(function(){
			        Kakao.init('${kakaoApiKey}');
			        Kakao.isInitialized();
			    });
			
			    function loginWithKakao() {
			        Kakao.Auth.authorize({ 
			        redirectUri: '${kakaoRedirectUri}' 
			        }); // 등록한 리다이렉트uri 입력
			        
			    }
			</script>	
		
			<script>
				function redirectToSocial(type) {
				    const socialType = '${social_type}';
				    const naverId = '${user.me_naverUserId}';
				    const kakaoId = '${user.me_kakaoUserId}';
				    const naverUrl = '${naverApiUrl}';
				    
			        if (type === 'NAVER') {
			            if (!naverId) { 
			                if (confirm('naver 연동이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) {
			                    // 네이버 소셜로그인 페이지로 이동(현재 로그인한 아이디와 연동)
			                	window.location.href = naverUrl;
			                }
			            } else if (socialType === 'NAVER') {
			                window.location.href = '<c:url value="/mypage/socialcheck"/>';
			            } else {
			                // 네이버 소셜로그인 페이지로 이동
			            	window.location.href = naverUrl;
			            }
			            return;
			        }
				    
			        if (type === 'KAKAO') {
			            if (!kakaoId) {
			                if (confirm('kakao 연동이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) {
			                    // 카카오 소셜로그인 페이지로 이동(현재 로그인한 아이디와 연동)
			                	loginWithKakao();
			                }
			            } else if (socialType === 'KAKAO') {
			                window.location.href = '<c:url value="/mypage/socialcheck"/>';
			            } else {
			                // 카카오 소셜로그인 페이지로 이동
			            	loginWithKakao();
			            }
			            return;
			        }
				    
				}
			</script>