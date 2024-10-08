<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>회원권 결제</title>
</head>
<body>
    <h2 class="mb10">회원권 결제</h2>
    <form id="paymentForm" action="<c:url value='/membership/membershipInsert'/>" method="post">
    	<input type="hidden" name="pt_type" id="pt_type" value="${pt_type}" />
        <div>
            <div class="mb10">
                <label for="pt_num">이용권 종류를 선택하세요</label>
                <select name="pt_num" id="pt_num" class="form-control">
                	<c:forEach items="${paymentList}" var="pt">
					    <option value="${pt.pt_num}" data-type="${pt.pt_type}" data-date="${pt.pt_date}" data-count="${pt.pt_count}" data-price="${pt.pt_price}" <c:if test="${pt.pt_num == 1}">selected</c:if>>${pt.pt_type}</option>
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
    
    <c:set var="user" value="${sessionScope.user}" />
    
	<!-- 아이엠포트 SDK :: CDN -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script>
        $(document).ready(function () {
        	var IMP = window.IMP; // 생략 가능
            IMP.init('imp56284313'); // 실제 가맹점 식별 코드 - i'mport에서 가져와야 함
            var buyerMeId = "${user.me_id}";    // 세션에서 가져온 사용자 이름
            var buyerEmail = "${user.me_email}";  // 세션에서 가져온 사용자 이메일
            
            console.log(buyerMeId);
            console.log(buyerEmail);
        	
            // 초기 상태로 하위 select 값을 설정.
            $('#pt_num').trigger('change');

            $('#pt_num').on('change', function () {
                const pt_date = $('#pt_date');
                const pt_count = $('#pt_count');
                const pt_price = $('#pt_price');
                const selectedOption = $(this).find('option:selected');

                // 선택된 옵션의 데이터 속성 가져오기
                const date = selectedOption.data('date');
                const count = selectedOption.data('count');
                const type = selectedOption.data('type');
                const price = selectedOption.data('price');

                // 하위 select 초기화
                pt_date.empty();
                pt_count.empty();
                pt_price.empty();

                // 하위 Select 메뉴에 값을 추가
                pt_date.append('<option value="' + date + '">' + date + '일</option>');
                pt_count.append('<option value="' + count + '">' + count + '회</option>');
                pt_price.append('<option value="' + price + '">' + Number(price).toLocaleString() + '원</option>');

                // 하위 Select 비활성화 상태 유지
                pt_date.prop('disabled', true);
                pt_count.prop('disabled', true);
                pt_price.prop('disabled', true);
            });
            
            
            // '결제' 버튼을 클릭하면 사용자가 어떤 값으로 결제 할 것인지에 대한 정보와 함께 결제 모달창 나옴
            $('.js-btn-insert').on('click', function () {
                // 선택된 옵션 가져오기
                const selectedOption = $('#pt_num option:selected');

                // 선택된 옵션이 비어 있지 않은지 확인
                if (selectedOption.length === 0) {
                    console.error("선택된 옵션이 없습니다.");
                    return; // 종료
                }

                const date = selectedOption.data('date');
                const count = selectedOption.data('count');
                const type = selectedOption.data('type');
                const price = selectedOption.data('price');
                
                // hidden input에 pt_type 설정
                $('#pt_type').val(type);

                // 가격 포맷팅
                const formattedPrice = Number(price).toLocaleString();
                
				// 확인용...
                console.log(date);
                console.log(count);
                console.log(type);
                console.log(price);

                // 모달 내용 설정
                const modalContent = `
                    <p>결제하시겠습니까?</p>
                    <p>이용권 종류: \${type}</p>
                    <p>기간(일): \${date}</p>
                    <p>횟수: \${count}</p>
                    <p>가격: \${formattedPrice}원</p>
                `;

                // 모달 내용 업데이트
                $('#modalBody').html(modalContent);
                $('#confirmModal').modal('show'); // 모달 표시
                
				// 결제하기 버튼 클릭 시 하위 select 활성화 및 결제 요청
                $('#confirmPayment').off('click').on('click', function() {
                    // 하위 select 요소 활성화
                    $('#pt_date').prop('disabled', false);
                    $('#pt_count').prop('disabled', false);
                    $('#pt_price').prop('disabled', false);

                    // 선택한 가격 가져오기
                    const amount = $('#pt_price').val(); // 선택한 가격 가져오기
                    
                    // 아이엠포트 결제 요청
                    IMP.request_pay({
                        pg: 'kakaopay',
                        pay_method: 'card',
                        merchant_uid: 'merchant_' + new Date().getTime(),
                        name: '카카오페이결제',
                        amount: amount, // 동적으로 설정된 가격
                        buyer_email: buyerEmail, // 구매자 이메일
                        custom_data: {
                        	buyer_me_id: buyerMeId, // 사용자 ID
                        },
                        /* buyer_tel: '010-1234-5678', // 구매자 전화번호
                        buyer_addr: '서울시 강남구', // 구매자 주소
                        buyer_postcode: '123-456', // 구매자 우편번호 */
                    }, function(rsp) {
                        if (rsp.success) {
                            // [1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                            const postData = {
                            	imp_uid: rsp.imp_uid, // 여기에서 imp_uid 값이 올바르게 전달되는지 확인
                                status: rsp.status, // 상태 추가
                                buyer_me_id: rsp.custom_data.buyer_me_id, // custom_data에서 ID 값 가져오기
                                amount: amount,
                                pt_num: $('#pt_num').val(),
                                pt_type: $('#pt_type').val(),
                                pt_date: $('#pt_date').val(),
                                pt_count: $('#pt_count').val(),
                                pt_price: $('#pt_price').val(),
                                
                            };
                            
                            console.log("rsp 내용:", rsp);

                            console.log("전송할 데이터:", postData); // 전송할 데이터 출력
                            
                            jQuery.ajax({
                                url: "/fitness/membership/membershipInsert", // 서버의 결제 완료 처리 URL
                                type: 'POST',
                                contentType: 'application/json', // Content-Type 설정
                                dataType: 'json',
                                data: JSON.stringify(postData), // 데이터를 JSON 형식으로 변환하여 전송
                                success: function(response) {
                                    console.log("응답 데이터:", response); // 응답 데이터 출력
                                },
                                error: function(xhr, status, error) {
                                    console.error("AJAX 요청 실패:", error);
                                }
                            });
                            location.href='<%=request.getContextPath()%>/membership/membershipList?msg='+msg;
                        } else {
                            // 결제 실패 처리
                            msg = '결제에 실패하였습니다.';
                            msg += '에러내용 : ' + rsp.error_msg;
                            alert(msg);
                            // 실패 시 이동할 페이지
                            location.href = "<%=request.getContextPath()%>/membership/membershipInsert";
                        }
                        
                    }); // rsp end
                    
                    
                }); // #confirmPayment click end

            });

            
        });
    </script>
	    
</body>
</html>
