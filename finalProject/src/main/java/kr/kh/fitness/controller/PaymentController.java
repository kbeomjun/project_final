package kr.kh.fitness.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.dto.PaymentRequestDTO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentCategoryVO;
import kr.kh.fitness.model.vo.PaymentTypeVO;
import kr.kh.fitness.model.vo.PaymentVO;
import kr.kh.fitness.service.PaymentService;

// 회원권 결제 컨트롤러
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	PaymentService paymentService;

	// 회원권 조회
	@GetMapping("/paymentList")
	public String paymentList(Model model) {
	    List<PaymentTypeVO> paymentList = paymentService.getMembershipList();
	    // 가격 포맷팅
 		for (PaymentTypeVO pt : paymentList) {
 			pt.setFormattedPrice(NumberFormat.getInstance(Locale.KOREA).format(pt.getPt_price()));
 		}
	    model.addAttribute("paymentList", paymentList);
	    return "/payment/paymentList";
	}

	// 회원권 결제 get
	@GetMapping("/paymentInsert")
	public String paymentInsert(Model model, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		List<PaymentTypeVO> paymentList = paymentService.getMembershipList();

	    // 현재 날짜를 yyyy-MM-dd 형식으로 포맷
	    LocalDateTime today = LocalDateTime.now();
	    String currentDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	    
	    // 사용자 ID 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    // 로그인하지 않은 상태라면, 사용자가 로그인되어 있지 않으면 이전 URL을 세션에 저장하고 로그인 페이지로 리다이렉트
	    if (user == null) {
	        try {
	            // 현재 요청 URL을 세션에 저장 (로그인 후 돌아올 수 있게)
	            String prevUrl = request.getRequestURL().toString();
	            session.setAttribute("prevUrl", prevUrl);
	            System.out.println("저장된 이전 URL: " + prevUrl);

	            // 로그인 페이지로 리다이렉트 (JavaScript로 처리)
	            response.setContentType("text/html; charset=UTF-8");
	            response.getWriter().write("<script>alert(\"로그인이 필요합니다. 로그인 페이지로 이동합니다.\");</script>");
	            response.getWriter().write("<script>window.location.href='" + request.getContextPath() + "/login';</script>");
	            return null;  // 더 이상 처리하지 않음
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	    
	    // 기존 결제 정보를 조회
	    PaymentVO existingPayment = paymentService.getPayment(user.getMe_id());
	    
	    System.out.println(user.getMe_id() + "의 결제 정보 : " + existingPayment);
	    
	    // 기존 결제 정보가 있을 경우에만 시작일과 만료일을 설정
	    String paStart = null;
	    String paEnd = null;

	    if (existingPayment != null) {
	        if (existingPayment.getPa_start() != null) {
	            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	            paStart = formatter.format(existingPayment.getPa_start()); // 시작일 설정
	        }

	        if (existingPayment.getPa_end() != null) {
	            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	            paEnd = formatter.format(existingPayment.getPa_end()); // 만료일 설정
	        }
	        
		    System.out.println("시작일 : " + paStart);
		    System.out.println("만료일 : " + paEnd);
	    } else {
	        // 결제 정보가 없을 때
	        System.out.println("해당 사용자는 기존 결제 정보가 없습니다.");
	    }
	    // 현재 날짜 및 기존 결제 시작일 추가
	    model.addAttribute("currentDate", currentDate);
	    model.addAttribute("paStart", paStart);  // 기존 회원권의 시작일
	    model.addAttribute("paEnd", paEnd);  // 기존 회원권의 만료일
	    model.addAttribute("paymentList", paymentList);
	    
	    return "/payment/paymentInsert";
	}

	// 회원권 결제 post 메서드 (JSON)
	@PostMapping("/paymentInsert")
	@ResponseBody
	public Map<String, Object> paymentInsertPost(@RequestBody PaymentRequestDTO request, HttpSession session) {
		PaymentVO payment = request.getPayment();
		PaymentTypeVO paymentType = request.getPaymentType();
	    PaymentCategoryVO category = request.getPaymentCategory();
	    
		Map<String, Object> response = new HashMap<String, Object>();
		try {
	        MemberVO user = (MemberVO) session.getAttribute("user");
	        String userId = user.getMe_id(); // 사용자 ID를 가져옴
	        System.out.println("유저 정보 : " + user);
	        
			// payment, category 확인
	        System.out.println("결제 정보 : " + payment);
			System.out.println("결제 타입 : " + paymentType);
		    System.out.println("결제 유형 : " + category);
		    
		    // 기존 결제 정보를 조회
		    PaymentVO existingPayment = paymentService.getLastPaymentByUserId(userId, paymentType.getPt_num());
		    System.out.println("결제 타입 번호 : " + paymentType.getPt_num());
		    
		    // 기존 결제가 있는 경우 - 결제 시작일 및 만료일 업데이트
		    if (existingPayment != null) {
		    	// Ajax로 전달된 새로운 결제 시작일을 받아와서 설정
		    	Date newStartDate = payment.getPa_start(); // Ajax로 전달된 시작일 가져오기
		        
		    	// Date를 String으로 변환 (yyyy-MM-dd 형식으로 변환)
		        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		        String formattedStartDate = formatter.format(newStartDate);  // Date를 String으로 변환
		        System.out.println("새로운 시작 날짜 : " + formattedStartDate);

		        /// String을 LocalDateTime으로 변환하여 처리
		        LocalDateTime startDateTime = LocalDate.parse(formattedStartDate, 
		        					DateTimeFormatter.ofPattern("yyyy-MM-dd"))
                        			.atStartOfDay();  // 시작일의 00:00:00으로 설정
		        
		        // 새로운 시작일을 Timestamp로 변환하여 PaymentVO에 설정
		        existingPayment.setPa_start(Timestamp.valueOf(startDateTime));  // Timestamp로 변환하여 설정
		        System.out.println("새로운 결제 시작 날짜: " + startDateTime);

		        // 기존 결제의 만료일 계산
		        long pcPaidAtTimestamp = existingPayment.getPa_end().getTime(); // Date에서 long으로 변환
		        LocalDateTime paidAtDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(pcPaidAtTimestamp), ZoneId.systemDefault());
		        
		        // 만료일 계산 (기간 추가)
		        LocalDateTime expirationDateTime = paidAtDateTime.plusDays(paymentType.getPt_date());
		        System.out.println("만료일 계산 : " + expirationDateTime);

		        // 만료일을 LocalDateTime에서 Timestamp로 변환
		        Timestamp expirationTimestamp = Timestamp.valueOf(expirationDateTime);

		        // 만료일 업데이트
		        existingPayment.setPa_end(expirationTimestamp);
		        System.out.println("실제 들어간 만료일 계산값 : " + existingPayment.getPa_end());

		        // 카테고리 삽입 (카테고리 객체는 DTO에서 가져옴)
	            boolean categoryInserted = paymentService.insertPaymentCategory(paymentType, category, user);
	            if (!categoryInserted) {
	                response.put("success", false);
	                response.put("message", "카테고리 삽입에 실패했습니다.");
	                return response; // 카테고리 삽입 실패 시 응답
	            }
		        
		        // 결제 업데이트 서비스 호출
		        System.out.println("결제 업데이트를 위한 필드 : " + existingPayment);
		        paymentService.updatePayment(existingPayment);

		        boolean updateResult = paymentService.updatePayment(existingPayment);
		        if (updateResult) {
		            response.put("success", true);
		            response.put("message", "결제가 완료되었습니다. 만료일이 연장되었습니다.");
		            response.put("url", "/payment/paymentList");
		        } else {
		            response.put("success", false);
		            response.put("message", "결제 업데이트에 실패했습니다.");
		        }
		    } else {
		    	// 새로운 결제인 경우 - 사용자가 선택한 시작 날짜를 사용
	            if (payment.getPa_start() == null) {
	                response.put("success", false);
	                response.put("message", "시작 날짜를 선택해주세요.");
	                return response;
	            }
	            
	            // 날짜 문자열에서 타임존과 시간을 제거하고 'yyyy-MM-dd' 형식으로 변환
	            Date paStartDate = payment.getPa_start();

	            // Date 객체를 LocalDateTime으로 변환하여 시간 정보를 무시하고 00:00:00으로 설정
	            LocalDateTime startDateTime = paStartDate.toInstant()
	                                                       .atZone(ZoneId.systemDefault())
	                                                       .toLocalDate()
	                                                       .atStartOfDay(); // 시작일의 00:00:00으로 설정

				// pa_start를 Timestamp로 변환하여 PaymentVO에 설정
				payment.setPa_start(Timestamp.valueOf(startDateTime)); // Timestamp로 변환하여 설정
	            
	            System.out.println("사용자가 선택한 이용권 시작 날짜(시간은 자동으로 00:00:00으로 들어옴) : " + startDateTime);

			    // 기간을 숫자로 변환
			    int period = paymentType.getPt_date(); // 예: 30, 60, 90일
			    LocalDateTime expirationDateTime = startDateTime.plusDays(period); // 기간을 더함

			    // 날짜 및 시간 포맷팅
			    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			    String formattedDateTime = expirationDateTime.format(formatter);
			    System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
			    
			    // 결제 처리
			    boolean res = paymentService.insertPayment(payment, paymentType, category, formattedDateTime, user);
			    
			    // 결제가 완료되면 결제 완료 창이 뜨고, 결제에 실패하면 실패 창이 뜸.
				// 결제가 성공적으로 끝나면 membershipList로 감, 실패하면 그대로 유지
                if (res) {
                    response.put("success", true);
                    response.put("message", "결제가 완료되었습니다.");
                    response.put("url", "/payment/paymentList");
                } else {
                    response.put("success", false);
                    response.put("message", "결제가 실패하였습니다.");
                    response.put("url", "/payment/paymentInsert");
                }
	        }
		}catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생하였습니다: " + e.getMessage());
		}
		return response; // JSON 형식으로 응답 : ajax에서는 model형식 쓰는거 불가능...
	}
	
	// 유효성 체크 메서드
	@GetMapping("/checkValidity")
	@ResponseBody
	public Map<String, Object> checkValidity(HttpSession session, @RequestParam("pt_num") int ptNum) {
	    // 세션에서 user 정보를 직접 가져옴
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    Map<String, Object> response = new HashMap<String, Object>();
	    boolean hasValidLicense = false;

	    // 세션에 user 정보가 올바르게 설정되었는지 확인
	    if (user == null) {
	        // 세션에 user 정보가 없음
	        response.put("error", "로그인 정보가 없습니다."); // String 타입의 에러 메시지를 추가
	        return response;
	    }

	    // 사용자 ID로 결제 정보를 조회
	    PaymentVO existingPayment = paymentService.getLastPaymentByUserId(user.getMe_id(), ptNum);
	    
	    if (existingPayment != null) {
	        // pa_end가 현재 날짜 이후이면 유효한 라이센스
	        LocalDate today = LocalDate.now();
	        
	        // existingPayment.getPa_end()가 Date 타입일 때
	        Date paEndDate = existingPayment.getPa_end();
	        LocalDate expirationDate = paEndDate.toInstant()
	                                             .atZone(ZoneId.systemDefault())
	                                             .toLocalDate();

	        hasValidLicense = expirationDate.isAfter(today) || expirationDate.isEqual(today);
	    }

	    response.put("hasValidLicense", hasValidLicense);
	    return response;
	}

	
}