<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<html>
<head>
    <title>회원권 결제</title>
</head>
<body>
	<section class="sub_banner sub_banner_02"></section>
    
    <!-- 기존 회원권 정보 표시 -->
    <c:set var="isRePayment" value="${not empty firstStartDate}" />

    <section class="sub_content">
		<section class="sub_content_group">
			<div class="sub_title_wrap">
				<h2 class="sub_title">회원권 결제</h2>
				<p class="sub_title__txt">※ PT 이용권은 지정된 기간 내에 사용하지 않으면 소멸됩니다.</p>
				<p class="sub_title__txt">※ 회원권 결제는 로그인 후 이용 가능 합니다.</p>
			</div>
			<div class="table_wrap">
				<form id="paymentForm" action="<c:url value='/payment/paymentInsert'/>" method="post">
					<input type="hidden" name="pt_type" id="pt_type" value="${pt_type}" />
					<div class="text_small text-right mb10"><span class="color_red">*</span>는 필수 기재 항목 입니다.</div>
					<table class="table">
						<caption class="blind">이용권 종류에 관한 테이블</caption>
						<colgroup>
							<col style="width: 20%;">
							<col style="width: 80%;">
						</colgroup>
						<tbody>
							<c:if test="${!isRePayment}">
				                <tr>
				                	<th scope="row">
				                		<!-- 첫 결제인 경우 시작일 입력 필드 표시 -->
										<label for="pa_start">회원권 시작 날짜</label>
				                	</th>
				                	<td>
					                	<div id="subMenu" class="">
											<input type="date" id="pa_start" name="pa_start" class="form-control custom-calender" min="${currentDate}" required>
					                    </div>
				                	</td>
				                </tr>
							</c:if>
						    <c:if test="${firstStartDate != null && firstStartDate != ''}">
							    <tr>
							    	<th scope="row">회원권 시작일</th>
							    	<td>
								        <div class="membership-info my-10">
								            <strong class="text-success">${firstStartDate}</strong>
								        </div>
							        </td>
						        </tr>
					        </c:if>
						    <c:if test="${firstStartDate != null && firstStartDate != ''}">
							    <tr>
							    	<th scope="row">회원권 만료일</th>
							    	<td>
								        <div class="membership-info my-10">
								        	<strong class="text-primary">${lastEndDate}</strong>
								        </div>
							        </td>
						        </tr>
						    </c:if>
							<c:if test="${isRePayment}">
				                <tr>
				                	<th scope="row">
										<p>이용권 재결제 시작일</p>
				                	</th>
				                	<td>
					                	<div id="subMenu" class="">
						                	<strong class="text-success">${newStartDate}</strong>
											<input type="hidden" name="pa_start" value="${newStartDate}" />
					                    </div>
										<p class="text_middle">이용권 재결제 시작일은 회원님의 만료일 +1일로 자동으로 계산됩니다.</p>
				                	</td>
				                </tr>
			                </c:if>
							<tr>
								<th scope="row">
									<label for="pt_num" class="_asterisk">이용권 종류</label>
								</th>
				                <td>
									<select name="pt_num" id="pt_num" class="form-control custom-select">
					                	<c:forEach items="${paymentList}" var="pt">
										    <option value="${pt.pt_num}" data-name="${pt.pt_name}" data-type="${pt.pt_type}" data-date="${pt.pt_date}" data-count="${pt.pt_count}" data-price="${pt.pt_price}" <c:if test="${pt.pt_num == 1}">selected</c:if>>${pt.pt_name}</option>
										</c:forEach>
									</select>
								</td>
			                </tr>
			                <tr>
			                	<th scope="row">
									<label for="pt_date">기간(개월)</label>
			                	</th>
			                	<td>
				                	<div id="subMenu" class="">
					                    <select name="pt_date" id="pt_date" class="form-control custom-select" disabled>
					                        <option value="1">1개월</option>
					                    </select>
				                    </div>
			                	</td>
			                </tr>
			                <tr>
			                	<th scope="row">
									<label for="pt_count">횟수</label>
			                	</th>
			                	<td>
				                	<div id="subMenu" class="">
										<select name="pt_count" id="pt_count" class="form-control custom-select" disabled>
											<option value="1">1회</option>
										</select>
				                    </div>
			                	</td>
			                </tr>
			                <tr>
			                	<th scope="row">
									<label for="pt_price">가격(원)</label>
			                	</th>
			                	<td>
				                	<div id="subMenu" class="">
										<select name="pt_price" id="pt_price" class="form-control custom-select" disabled>
											<option value="300000">300,000원</option>
										</select>
				                    </div>
			                	</td>
			                </tr>
						</tbody>
					</table>
					<div class="btn_wrap">
						<div class="btn_right_wrap">
							<div class="btn_link_black">
								<button type="button" class="btn btn_black js-btn-insert">
									<span>회원권 결제<i class="ic_link_share"></i></span>
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
    

    <!-- Modal -->
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">결제 확인</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modalBody"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn_black" data-dismiss="modal">취소</button>
					<button type="button" id="confirmPayment" class="btn btn_red">결제하기</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- user 정보 -->
    <c:set var="user" value="${sessionScope.user}" />
    
	<!-- 아이엠포트 SDK :: CDN -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script>
		$(document).ready(function () {
		    var IMP = window.IMP; // 생략 가능, 아이엠포트 객체 초기화
		    IMP.init('imp56284313'); // 실제 가맹점 식별 코드 - I'mport에서 가져와야 함
		    var me_id = "${user.me_id}"; // 세션에서 가져온 사용자 ID
		    var me_email = "${user.me_email}"; // 세션에서 가져온 사용자 이메일
		    var contextPath = '<%=request.getContextPath()%>'; // 현재 경로를 가져옴
		    
            // isRePayment 변수 설정
            var isRePayment = ${isRePayment ? 'true' : 'false'};
            console.log("isRePayment:", isRePayment);
		    
			// 페이지 로드 시 서버에서 넘긴 paEnd 값 설정 및 min 속성 설정
	        var paEnd = '${lastEndDate}';  // 서버에서 넘긴 paEnd 값
	        var currentDate = new Date().toISOString().split('T')[0];  // 현재 날짜 yyyy-MM-dd

	        $('#pa_start').attr('min', currentDate);  // 최소 선택 가능한 날짜는 현재 날짜

	        console.log('paEnd:', paEnd);
	        console.log('currentDate:', currentDate);
	        
	        // 페이지 로드 시 입력 요소의 값 설정
	        if (paEnd < currentDate) {
	            $('#pa_start').val(currentDate); // paEnd가 현재 날짜보다 이전이면 현재 날짜로 설정
	        } else {
	            $('#pa_start').val(paEnd); // 그렇지 않으면 paEnd 값을 설정
	        }

			// 선택된 날짜가 기존 만료일보다 이전일 경우 경고 및 수정
	        $('#pa_start').on('change', function() {
	            const selectedDate = new Date($(this).val());
	            const expirationDate = new Date('${lastEndDate}'); // JSP에서 만료일을 가져옴

	            // 선택된 날짜가 만료일보다 이전이면 경고 및 기존 만료일로 설정
	            if (selectedDate < expirationDate) {
	                alert("시작 날짜는 이용권 만료일(" + '${lastEndDate}' + ") 이후여야 합니다.");
	                $(this).val('${lastEndDate}'); // 기존 만료일로 다시 설정
	            }
	        });
		
		    // user 정보가 없는 경우 결제 버튼 숨기기 및 경고 메시지 표시
		    if (!me_id) {
		        alert("로그인 정보가 없습니다. 결제를 진행할 수 없습니다.");
		        location.href = '<%=request.getContextPath()%>/payment/paymentList'; // paymentList 페이지로 이동
		        return;
		    }
		
		    // 이용권 종류 선택 시 하위 Select 업데이트
		    $('#pt_num').on('change', function () {
		    	console.log('pt_num change event triggered');
		        updateSubSelectOptions(); // 하위 Select 옵션 업데이트 함수 호출
		    });
		
		    // 초기 상태로 하위 Select 값을 설정
		    $('#pt_num').trigger('change');
		    
		    // 하위 Select 업데이트를 위한 함수
		    function updateSubSelectOptions() {
		        const pt_date = $('#pt_date'); // 기간 Select
		        const pt_count = $('#pt_count'); // 횟수 Select
		        const pt_price = $('#pt_price'); // 가격 Select
		        const pa_start = $('#pa_start'); // 시작 날짜 input
		        const selectedOption = $('#pt_num option:selected'); // 선택된 옵션
		
		        // 선택된 옵션의 데이터 속성 가져오기
		        const date = selectedOption.data('date'); // 날짜
		        const count = selectedOption.data('count'); // 횟수
		        const type = selectedOption.data('type'); // 종류
		        const price = selectedOption.data('price'); // 가격
		
		        // 하위 Select 초기화
		        pt_date.empty();
		        pt_count.empty();
		        pt_price.empty();
		
		        // 하위 Select 메뉴에 값을 추가
		        pt_date.append('<option value="' + date + '">' + date + '개월</option>');
		        pt_count.append('<option value="' + count + '">' + count + '회</option>');
		        pt_price.append('<option value="' + price + '">' + Number(price).toLocaleString() + '원</option>');
		
		        // AJAX 요청을 위한 데이터 설정
		        const data = {
		            pt_num: $('#pt_num').val(), // 선택된 이용권 번호
		        };
		        
		    	const requestUrl = `${contextPath}/payment/checkValidity`;
		    	console.log('AJAX request URL:', requestUrl);
		    	
		    	
		        // AJAX 요청
		        $.ajax({
		            url: `\${contextPath}/payment/checkValidity`, // 유효성 확인 URL
		            type: 'GET',
		            data: data, // 쿼리 파라미터로 데이터 전송
		            success: function(response) {
		                console.log('성공:', response); // 성공 시 응답 출력
		            },
		            error: function(xhr, status, error) {
		                console.error('오류:', error); // 오류 발생 시 출력
		            }
		        });
		
		        // 하위 Select 비활성화 상태 유지
		        pt_date.prop('disabled', true);
		        pt_count.prop('disabled', true);
		        pt_price.prop('disabled', true);
		    }
		
		    // '결제' 버튼 클릭 시 결제 정보 확인 팝업 표시
		    $('.js-btn-insert').on('click', function () {
		        $('#confirmModal').modal('show'); // 팝업 표시
		    	console.log("안녕");
		        // 선택된 옵션 가져오기
		        const selectedOption = $('#pt_num option:selected');
		
		        // 선택된 옵션이 비어 있지 않은지 확인
		        if (selectedOption.length === 0) {
		            console.error("선택된 옵션이 없습니다."); // 오류 메시지 출력
		            return;
		        }

		        // 선택된 옵션의 데이터 가져오기
		        const name = selectedOption.data('name'); // 이름
		        const type = selectedOption.data('type'); // 종류
		        const date = selectedOption.data('date'); // 날짜
		        const start = isRePayment ? '${newStartDate}' : $('#pa_start').val(); // 결제 시작 날짜 값 가져오기
		        const count = selectedOption.data('count'); // 횟수
		        const price = selectedOption.data('price'); // 가격
		        const formattedPrice = Number(price).toLocaleString(); // 가격 포맷팅
		        // hidden input에 pt_type 설정
		        $('#pt_type').val(type);
		        
		        // 확인용
		        console.log(name);
		        console.log(type);
		        console.log(date);
		        console.log("사용자가 선택한 최종 시작 날짜:", start);
		        console.log(count);
		        console.log(formattedPrice);
		
				// 팝업 내용 설정
		        const modalContent = `
		        	<div class="table_wrap">
						<table class="table">
							<caption class="blind">결제에 관한 테이블</caption>
							<colgroup>
								<col style="width: 20%;">
								<col style="width: 80%;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">이용권</th>
									<td>\${name}</td>
								</tr>
								<tr>
									<th scope="row">이용권 종류</th>
									<td>\${type}</td>
								</tr>
								<tr>
									<th scope="row">기간(개월)</th>
									<td>\${date}</td>
								</tr>
								<tr>
									<th scope="row">회원권 시작일</th>
									<td>\${start}</td>
								</tr>
								<tr>
									<th scope="row">횟수</th>
									<td>\${count}</td>
								</tr>
								<tr>
									<th scope="row">가격</th>
									<td>\${formattedPrice}원</td>
								</tr>
							</tbody>
						</table>
		            	<h3 class="text-center mt40">결제하시겠습니까?</h3>
					</div>
		        `;
		        
		        // 팝업 내용 업데이트
		        $('#modalBody').html(modalContent);
		        $('#confirmModal').modal('show'); // 팝업 표시
		
		        // 결제하기 버튼 클릭 시 결제 요청
		        $('#confirmPayment').off('click').on('click', function() {
		            // 시작 날짜가 비어있으면 경고 메시지 표시 및 제출 방지
				    let pa_start;
				    if (isRePayment) {
				        // 재결제인 경우 hidden input에서 값 가져오기
				        pa_start = $('input[name="pa_start"]').val();
				    } else {
				        // 첫 결제인 경우 사용자가 선택한 날짜 가져오기
				        pa_start = $('#pa_start').val();
				    }
				
				    if (!pa_start) {
				        console.log("시작 날짜 선택 안함"); // 선택하지 않은 경우 메시지 출력
				        alert("시작 날짜를 선택해주세요."); // 경고 메시지
				        event.preventDefault(); // 폼 제출 방지
				        return;
				    }
				    console.log(pa_start);
		            
		            // 현재 사용자의 시작 날짜 (예시: 2024-10-15)
		            const currentStartDate = new Date('${currentDate}'); // DB에서 가져와야 함
		            const selectedStartDate = new Date(pa_start); // 사용자가 선택한 날짜
		
		            // 사용자가 선택한 시작 날짜가 현재 시작 날짜보다 이전인지 확인
		            if (selectedStartDate < currentStartDate) {
		                alert("시작 날짜는 현재 시작 날짜 이후여야 합니다."); // 경고 메시지
		                event.preventDefault(); // 폼 제출 방지
		                return;
		            }
		            
		            // 하위 Select 요소 활성화
		            $('#pt_date').prop('disabled', false);
		            $('#pt_count').prop('disabled', false);
		            $('#pt_price').prop('disabled', false);
		
		            // 선택한 가격 가져오기
		            const amount = $('#pt_price').val(); // 선택한 가격 가져오기
		            
		            // 아이엠포트 결제 요청
		            IMP.request_pay({
		                pg: 'kakaopay', // 결제 PG
		                pay_method: 'card', // 결제 방법
		                merchant_uid: 'merchant_' + new Date().getTime(), // 가맹점 주문 ID
		                name: '카카오페이결제', // 결제 이름
		                amount: amount, // 동적으로 설정된 가격
		                buyer_email: me_email, // 구매자 이메일
		                custom_data: {
		                    buyer_me_id: me_id, // 사용자 ID
		                },
		            }, function(rsp) {
		                if (rsp.success) {
		                    // 서버에서 결제 정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
		                    const paymentData = {
		                        payment: {
		                        	pa_start: isRePayment ? '${newStartDate}' : $('#pa_start').val() // 재결제인 경우 newStartDate 사용
		                        },
		                        paymentType: {
		                            pt_num: $('#pt_num').val(), // 이용권 번호
		                            pt_name: name, // 이용권
		                            pt_type: type, // 이용권 종류
		                            pt_date: date, // 기간
		                            pt_count: count, // 횟수
		                            pt_price: price, // 가격
		                        },
		                        paymentHistory: {
		                            ph_imp_uid: rsp.imp_uid, // 결제 고유 ID
		                            ph_merchant_uid: rsp.merchant_uid, // 가맹점에서 설정한 주문 ID
		                            ph_pg_tid: rsp.pg_tid, // 결제 거래 ID
		                            ph_status: rsp.status, // 결제 상태
		                            ph_amount: amount, // 실제 결제 금액
		                            ph_paid_at: rsp.paid_at, // 결제 완료 시간
		                            ph_card_name: rsp.card_name, // 결제된 카드 이름
		                            ph_card_number: rsp.card_number, // 결제된 카드 번호
		                            ph_card_quota: rsp.card_quota, // 결제된 카드 할부 개월 수
		                            ph_me_id: rsp.custom_data.buyer_me_id, // custom_data에서 me_id 값
		                            ph_me_email: rsp.buyer_email, // 사용자 이메일
		                        }
		                    };
		
		                    console.log("rsp 내용 : ", rsp); // 응답 내용 출력
		                    console.log("전송할 데이터 : ", paymentData); // 전송할 데이터 출력
		
		                    // AJAX 요청으로 결제 정보 전송
		                    jQuery.ajax({
		                        url: contextPath + "/payment/paymentInsert", // Ajax 요청 URL
		                        type: 'POST',
		                        contentType: 'application/json',
		                        dataType: 'json',
		                        data: JSON.stringify(paymentData), // 데이터를 JSON 형식으로 변환하여 전송
		                        success: function(response) {
		                            console.log("응답 데이터 : ", response); // 응답 데이터 출력
		                            
		                            if (response.success) {
		                                alert(response.message); // 성공 메시지 표시
		                                window.location.href = contextPath + response.url; // 응답 URL로 이동
		                            } else {
		                                alert(response.message); // 오류 메시지 표시
		                            }
		                        },
		                        error: function(xhr, status, error) {
		                            console.error("오류 발생 : ", error); // 오류 발생 시 출력
		                        }
		                    });
		                } else {
		                    alert("결제 실패: " + rsp.error_msg); // 결제 실패 시 오류 메시지 표시
		                }
		            }); // request_pay
		            
		        }); // confirmPayment end
		        
		    }); // js-btn-insert click
			
		}); // document ready
	</script>

	    
</body>
</html>
