<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

			<section class="sub_banner sub_banner_05"></section>
			<section class="sub_content">
			
				<!-- 왼쪽 사이드바 -->
				<%@ include file="/WEB-INF/views/layout/brAdminSidebar.jsp" %>
				
				<!-- 오른쪽 컨텐츠 영역 -->
				<section class="sub_content_group">
					<div class="sub_title_wrap">
						<h2 class="sub_title">${me.me_name} 회원 상세보기</h2>
						<p class="sub_title__txt">※ 지점 관리자는 노쇼 경고 횟수만 수정할 수 있습니다.</p>
					</div>
					
					<div class="table_wrap">
						<table class="table">
							<colgroup>
								<col style="width: 20%;">
								<col style="width: 80%;">
							</colgroup>
							
							<tbody>
								<tr>
									<th scope="row">
										<label for="me_id">아이디</label>
									</th>
									<td>
										<div class="form-group">${me.me_id}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_name">이름</label>
									</th>
									<td>
										<div class="form-group">${me.me_name}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_gender">성별</label>
									</th>
									<td>
										<div class="form-group">${me.me_gender}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_birth">생년월일</label>
									</th>
									<td>
										<div class="form-group">
											<fmt:formatDate value="${me.me_birth}" pattern="yyyy년 MM월 dd일" />
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_phone">전화번호</label>
									</th>
									<td>
										<div class="form-group">${me.me_phone}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_email">이메일</label>
									</th>
									<td>
										<div class="form-group">${me.me_email}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_address">주소</label>
									</th>
									<td>
										<div class="form-group">(${me.me_postcode}) ${me.me_address}${me.me_extraAddress} ${me.me_detailAddress}</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_noshow">노쇼 경고 횟수</label>
									</th>
									<td>
										<div class="form-group d-flex">
									        <span class="mr-2" id="noshow-count" style="align-content: center;">${me.me_noshow}</span>
									        <button type="button" class="btn" id="btn-noshow-minus">
									        	<img src="<c:url value="/resources/image/icon/ic_minus.svg"/>" alt="-" style="width: 20px; height: 20px;">
									        </button>
									        <button type="button" class="btn" id="btn-noshow-plus">
									        	<img src="<c:url value="/resources/image/icon/ic_plus.svg"/>" alt="+" style="width: 20px; height: 20px;">
									        </button>
									        <button type="button" class="btn btn_red" id="btn-noshow-reset">초기화</button>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="me_cancel">노쇼 제한시간</label>
									</th>
									<td>
										<div class="form-group d-flex" id="noshow-limit-time">
											<fmt:formatDate value='${me.me_cancel}' pattern='yyyy/MM/dd HH:mm:ss' />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<a href="<c:url value="/admin/member/list"/>" class="btn btn_cancel">뒤로</a>
						</div>
					</div>					
					
				</section>
			</section>
						

			<script>
			    // - 버튼 클릭 시
			    document.getElementById("btn-noshow-minus").addEventListener("click", function() {
			        adjustNoshowCount(-1);
			    });
			
			    // + 버튼 클릭 시
			    document.getElementById("btn-noshow-plus").addEventListener("click", function() {
			        adjustNoshowCount(1);
			    });
			    
			    // 초기화 버튼 클릭 시
			    document.getElementById("btn-noshow-reset").addEventListener("click", function() {
			        resetNoshow();
			    });
			
			    function adjustNoshowCount(delta) {
			        // 현재 노쇼 카운트 가져오기
			        let currentCount = parseInt(document.getElementById("noshow-count").textContent);
			        let memberId = '${me.me_id}';
			        
			        // 새로운 카운트 계산
			        let newCount = currentCount + delta;
			        if (newCount < 0) newCount = 0; // 0 이하로 내려가지 않게
			        if (newCount > 5) newCount = 5; // 5회 이상으로 올라가지 않게
			        
			        
			        $.ajax({
			            async: true,
			            url: '<c:url value="/admin/member/update"/>', 
			            type: 'post', 
			            data: {noshow: newCount, me_id: memberId}, 
			            dataType: "json", 
			            success: function(data) {
			                document.getElementById("noshow-count").textContent = data.me.me_noshow;
			                // 'me_cancel' 값을 Unix Timestamp에서 사람이 읽을 수 있는 형식으로 변환
			                if (data.me.me_cancel) {
			                    let date = new Date(data.me.me_cancel); // Unix Timestamp를 Date 객체로 변환
			                    let formattedDate = date.getFullYear() + '/' +
			                        ('0' + (date.getMonth() + 1)).slice(-2) + '/' +
			                        ('0' + date.getDate()).slice(-2) + ' ' +
			                        ('0' + date.getHours()).slice(-2) + ':' +
			                        ('0' + date.getMinutes()).slice(-2) + ':' +
			                        ('0' + date.getSeconds()).slice(-2);
			                    document.getElementById("noshow-limit-time").textContent = formattedDate;
			                } else {
			                    document.getElementById("noshow-limit-time").textContent = '';
			                }
			            }, 
			            error: function(jqXHR, textStatus, errorThrown) {
			                console.log(jqXHR);
			            }
			        });
			    }
			    
			    // 노쇼 경고횟수 초기화 함수
			    function resetNoshow() {
			    	let memberId = '${me.me_id}';
		
			        // 초기화 요청 보내기
			        $.ajax({
			            async: true,
			            url: '<c:url value="/admin/member/reset"/>',  // 초기화용 별도의 URL로 요청 보냄
			            type: 'post',
			            data: {me_id: memberId},
			            dataType: "json",
			            success: function(data) {
			                // 노쇼 횟수 0으로 설정
			                document.getElementById("noshow-count").textContent = 0;
			                // 노쇼 제한시간 비우기
			                document.getElementById("noshow-limit-time").textContent = '';
			            },
			            error: function(jqXHR, textStatus, errorThrown) {
			                console.log(jqXHR);
			            }
			        });
			    }	    
			</script>