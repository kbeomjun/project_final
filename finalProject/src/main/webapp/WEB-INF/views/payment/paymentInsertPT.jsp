<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<html>
<head>
    <title>PT 결제</title>
</head>
<body>
    <h2 class="mb10">PT 결제</h2>
    
    <!-- 기존 회원권 정보 표시 -->
    <c:set var="isRePayment" value="${not empty firstStartDate}" />

    <c:if test="${firstStartDate != null && firstStartDate != ''}">
        <div class="membership-info my-10">
            <p class="mb-0">회원님의 회원권 시작일: <strong class="text-success">${firstStartDate}</strong></p>
            <p>회원님의 회원권 만료일: <strong class="text-primary">${lastEndDate}</strong></p>
        </div>
    </c:if>
    
    <!-- PT 결제 여부 표시 -->
	<c:if test="${!isRePaymentForPT}">
	    <div class="alert alert-info">PT 결제는 첫 결제입니다.</div>
	</c:if>
	<c:if test="${isRePaymentForPT}">
	    <div class="alert alert-warning">PT 결제는 재결제입니다.</div>
	    <p class="mb-0">회원님의 PT 시작일: <strong class="text-success">${ptFirstStartDate}</strong></p>
            <p>회원님의 PT 만료일: <strong class="text-primary">${ptLastEndDate}</strong></p>
	</c:if>
    
    <form id="paymentForm" action="<c:url value='/payment/paymentInsertPT'/>" method="post">
    	<input type="hidden" name="pt_type" id="pt_type" value="${pt_type}" />
        <div>
            <div class="mb10">
                <label for="pt_num">이용권 종류를 선택하세요</label>
                <select name="pt_num" id="pt_num" class="form-control">
                	<c:forEach items="${paymentPTList}" var="pt">
					    <option value="${pt.pt_num}" data-name="${pt.pt_name}" data-type="${pt.pt_type}" data-date="${pt.pt_date}" data-count="${pt.pt_count}" data-price="${pt.pt_price}" <c:if test="${pt.pt_num == 1}">selected</c:if>>${pt.pt_name}</option>
					</c:forEach>
				</select>
            </div>

            <div id="subMenu" class="">
                <div class="form-inline">
                    <label for="pt_date">기간(일):</label>
                    <select name="pt_date" id="pt_date" class="form-control" disabled>
                        <option value="30">30일</option>
                    </select>

                    <label for="pt_count">횟수:</label>
                    <select name="pt_count" id="pt_count" class="form-control" disabled>
                        <option value="1">1회</option>
                    </select>

                    <label for="pt_price">가격(원):</label>
                    <select name="pt_price" id="pt_price" class="form-control" disabled>
                        <option value="300000">300,000원</option>
                    </select>
                    
				    <%-- value는 하단의 script로 값을 가져오고 있음. --%>
					<!-- PT 결제 시작일 표시 -->
					<c:if test="${isRePaymentForPT}">
					    <!-- 재결제인 경우 시작일 필드 숨김 -->
					    <p>회원님의 PT 재시작일: <strong class="text-success">${newStartDate}</strong></p>
					    <input type="hidden" name="pa_start" value="${newStartDate}" />
					</c:if>
					
					<c:if test="${!isRePaymentForPT}">
					    <!-- 첫 결제인 경우 시작일 입력 필드 표시 -->
					    <label for="pa_start">PT 시작 날짜:</label>
					    <input type="date" id="pa_start" name="pa_start" class="form-control" min="${firstStartDate}" max="${lastEndDate}" required>
					</c:if>
                </div>
				<div class="my-3">
					<p>오늘 날짜 : ${currentDate}</p>
					<p>회원권 시작일 : ${firstStartDate} / 회원권 만료일 : ${lastEndDate}</p>
					<p>PT 시작일 : ${ptFirstStartDate} / PT 만료일 : ${ptLastEndDate}</p>
				</div>
            </div>
        </div>
        
        <div class="text-right">
            <button type="button" class="btn btn-danger js-btn-insert">결제</button>
        </div>

    </form>

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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" id="confirmPayment" class="btn btn-danger">결제하기</button>
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
	        var currentDate = new Date().toISOString().split('T')[0]; // 현재 날짜 yyyy-MM-dd

	        console.log('paEnd:', paEnd);
	        console.log('currentDate:', currentDate);

			// 선택된 날짜가 회원권 시작일과 만료일 사이인지 확인
	        $('#pa_start').on('change', function() {
	            const selectedDate = new Date($(this).val());
	            const startDate = new Date('${firstStartDate}'); // JSP에서 시작일을 가져옴
	            const expirationDate = new Date('${lastEndDate}'); // JSP에서 회원권 만료일을 가져옴
	            const selectedDateStr = $(this).val(); // 선택한 날짜 문자열 가져오기
                // 현재 사용자가 선택한 날짜와 비교하는 기존 로직 유지
                const selectedStartDate = new Date(pa_start); // 사용자가 선택한 날짜

	            // 선택된 날짜가 회원권 기간 내에 있는지 확인
	            if (selectedDate < startDate || selectedDate > expirationDate) {
	                alert("PT 시작 날짜는 회원권 기간 내에 있어야 합니다.\n" + 
	                      "시작일: " + '${firstStartDate}' + "\n" + 
	                      "만료일: " + '${lastEndDate}' + "를 참고하세요.");
	                $(this).val(''); // 잘못된 날짜를 선택했을 경우 입력 필드 비우기
	            }
	            
	            // 선택한 PT의 시작 날짜가 회원권 만료일보다 이전인지 확인
	            if (selectedStartDate < expirationDate) {
	                alert("선택한 PT 이용권의 시작 날짜가 회원권 만료일(${lastEndDate})보다 이전입니다. 회원권을 먼저 결제하세요.");
	                $(this).val(''); // 시작 날짜 필드 초기화
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
		        pt_date.append('<option value="' + date + '">' + date + '일</option>');
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
		        const start = ${isRePaymentForPT} ? '${newStartDate}' : $('#pa_start').val(); // 결제 시작 날짜 값 가져오기
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
		        
		     	// 선택된 옵션의 데이터 가져오기
		        const ptPeriod = parseInt(selectedOption.data('date'), 10); // PT 기간 가져오기 (예: 30일)
		        let ptEndDate;
		        
		        if (${isRePaymentForPT}) {
		            const ptLastEndDateStr = '${ptLastEndDate}'; // 서버에서 전달받은 PT 마지막 만료일
		            ptEndDate = new Date(ptLastEndDateStr); // PT 마지막 만료일을 Date 객체로 변환
		            ptEndDate.setDate(ptEndDate.getDate() + 1); // 재결제는 마지막 만료일 + 1일로 설정
		        } else {
		            const startDate = $('#pa_start').val(); // 사용자가 선택한 시작 날짜
		            if (startDate) {
		                ptEndDate = new Date(startDate);
		            } else {
		                alert("시작 날짜를 선택해야 합니다."); // 시작 날짜가 없으면 경고
		                return;
		            }
		        }

		        ptEndDate.setDate(ptEndDate.getDate() + ptPeriod); // PT 만료일 계산

				// 회원권 만료일 비교
		        const membershipEndDateStr = '${lastEndDate}'; // 서버에서 전달받은 회원권 만료일
		        const membershipEndDate = new Date(membershipEndDateStr);

		        if (ptEndDate > membershipEndDate) {
		            // PT 시작일 계산
		            const ptStartDate = ${isRePaymentForPT} ? ptEndDate : new Date($('#pa_start').val()); // 시작일 설정
		            const formattedPtEndDate = ptEndDate.toISOString().split('T')[0]; // 만료일 형식 지정

		            alert("PT 만료일이 회원권 만료일보다 큽니다. 회원권을 결제해야 합니다.\n" +
		            	  "회원님의 회원권 만료일 : " + membershipEndDateStr + "\n" +
		                  "선택한 PT의 만료일 : " + formattedPtEndDate);
		            
					// 추가 알림을 띄우기
		            const confirmPayment = confirm("회원권을 결제하시겠습니까?");
		            if (confirmPayment) {
		                // 회원권 결제 페이지로 리다이렉트
		                window.location.href = "<c:url value='/payment/paymentInsert'/>"; // 회원권 결제 URL로 변경
		            }
		            
		            return; // 결제 모달을 열지 않도록 종료
		        } else {
		            // 결제 모달을 표시하는 코드
		            $('#confirmModal').modal('show'); // 결제 확인 모달을 띄움
		        }
		        
		        // 팝업 내용 설정
		        const modalContent = `
		            <p>결제하시겠습니까?</p>
		            <p>이용권: \${name}</p>
		            <p>이용권 종류: \${type}</p>
		            <p>기간(일): \${date}</p>
		            <p>PT 시작일: \${start}</p>
		            <p>횟수: \${count}</p>
		            <p>가격: \${formattedPrice}원</p>
		        `;
		        
		        // 팝업 내용 업데이트
		        $('#modalBody').html(modalContent);
		        $('#confirmModal').modal('show'); // 팝업 표시
		
		        // 결제하기 버튼 클릭 시 결제 요청
		        $('#confirmPayment').off('click').on('click', function() {
					// 현재 사용자의 시작 날짜 (예시: 2024-10-15)
		            const currentStartDate = new Date('${currentDate}'); // DB에서 가져와야 함
		            const lastPTEndDate = new Date('${newStartDate}'); // JSP에서 마지막 PT 결제 만료일 가져오기

		            console.log(lastPTEndDate);
		            
		            // PT 재결제 여부 확인
		            const isRePaymentForPT = ${isRePaymentForPT}; // JSP에서 변수 가져오기

		            if (isRePaymentForPT) {
		                // 재결제인 경우, 시작 날짜를 마지막 만료일 +1로 설정
		                const expectedStartDate = new Date(lastPTEndDate);
		                expectedStartDate.setDate(expectedStartDate.getDate() + 1); // +1일 추가
		                
		                // 시작 날짜를 자동으로 입력
		                $('#pa_start').val(expectedStartDate.toISOString().split('T')[0]); // YYYY-MM-DD 형식으로 입력
		                
		                // 추가적인 유효성 검사를 건너뛰고, 다음 단계로 진행
		            } else {
		                // 시작 날짜가 비어있으면 경고 메시지 표시 및 제출 방지
		                const pa_start = $('#pa_start').val(); // 시작 날짜 값 가져오기
		                if (!pa_start) {
		                    console.log("시작 날짜 선택 안함"); // 선택하지 않은 경우 메시지 출력
		                    alert("시작 날짜를 선택해주세요."); // 경고 메시지
		                    event.preventDefault(); // 폼 제출 방지
		                    return;
		                }
		                
		                // 현재 사용자가 선택한 날짜와 비교하는 기존 로직 유지
		                const selectedStartDate = new Date(pa_start); // 사용자가 선택한 날짜
		                
		                // 선택한 시작 날짜가 현재 시작 날짜보다 이전인지 확인
		                if (selectedStartDate < currentStartDate) {
		                    alert("시작 날짜는 현재 시작 날짜 이후여야 합니다."); // 경고 메시지
		                    event.preventDefault(); // 폼 제출 방지
		                    return;
		                }
		            }
		            
		            // 하위 Select 요소 활성화
		            $('#pt_date').prop('disabled', false);
		            $('#pt_count').prop('disabled', false);
		            $('#pt_price').prop('disabled', false);
		
		            // 선택한 가격 가져오기
		            const amount = $('#pt_price').val(); // 선택한 가격 가져오기
		            const newStartDate = '${newStartDate}'; // JSP 변수를 JavaScript 변수에 할당
		            
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
		                        	pa_start: isRePaymentForPT ? newStartDate : $('#pa_start').val() // 재결제인 경우 newStartDate 사용
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
		                    
		                 	// 콘솔 로그로 값 확인
		                 	console.log("사용자가 선택한 시작 날짜:", start);

		                    console.log("rsp 내용 : ", rsp); // 응답 내용 출력
		                    console.log("전송할 데이터 : ", paymentData); // 전송할 데이터 출력
		
		                    // AJAX 요청으로 결제 정보 전송
		                    jQuery.ajax({
		                        url: contextPath + "/payment/paymentInsertPT", // Ajax 요청 URL
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
