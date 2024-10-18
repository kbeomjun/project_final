package kr.kh.fitness.controller;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.dto.PaymentDetailsDTO;
import kr.kh.fitness.model.dto.PaymentRequestDTO;
import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.model.vo.PaymentHistoryVO;
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
	public String paymentList(Model model, HttpSession session) {
		// 사용자 ID 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    boolean hasMembership = false; // 기본적으로 false로 설정

	    // 사용자의 회원권 정보를 가져오는 로직
	    if (user != null) {
	    	
	        PaymentVO existingPayment = paymentService.getPayment(user.getMe_id());
	        
		    // 기존 결제 정보를 가져옴
		    PaymentDetailsDTO paymentDetails = paymentService.getPaymentDetails(user.getMe_id());
		    
	        hasMembership = existingPayment != null && existingPayment.getPa_end() != null && paymentDetails.getFirstStartDate() != null;
	        System.out.println("리스트의 멤버십 : " + hasMembership);
	    }
	    
	    
	    // 모델에 회원권 유무 추가
	    model.addAttribute("hasMembership", hasMembership);
		
	    // 회원권 조회
	    List<PaymentTypeVO> membershipList = paymentService.membershipList();
 		
	    model.addAttribute("membershipList", membershipList);
	    return "/payment/paymentList";
	}

	// 회원권 결제 get
	@GetMapping("/paymentInsert")
	public String paymentInsert(Model model, HttpSession session,
	        HttpServletRequest request, HttpServletResponse response) {

	    // 현재 날짜를 yyyy-MM-dd 형식으로 포맷
	    LocalDateTime today = LocalDateTime.now();
	    String currentDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

	    // 사용자 ID 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    // 기존 결제 정보를 가져옴
	    PaymentDetailsDTO paymentDetails = paymentService.getPaymentDetails(user.getMe_id());
	    
		// 디버깅 정보 출력
		System.out.println("컨트롤러의 첫 번째 결제 시작일 : " + paymentDetails.getFirstStartDate());
		System.out.println("컨트롤러의 마지막 결제의 만료일 : " + paymentDetails.getLastEndDate());
		System.out.println("컨트롤러의 재결제 여부 : " + paymentDetails.isRePayment());
		System.out.println("컨트롤러의 재결제 시작일 : " + paymentDetails.getNewStartDate()); // newStartDate 확인

	    // 모델에 필요한 값 추가
	    model.addAttribute("currentDate", currentDate);
	    model.addAttribute("firstStartDate", paymentDetails.getFirstStartDate());
	    model.addAttribute("lastEndDate", paymentDetails.getLastEndDate());
	    model.addAttribute("isRePayment", paymentDetails.isRePayment());
	    
	    // 시작일을 최초 시작일 +1일로 설정
	    if (paymentDetails.getFirstStartDate() != null && paymentDetails.getLastEndDate() != null) {
	        String lastEndDateStr = paymentDetails.getLastEndDate(); // 여기를 수정
	        System.out.println("컨트롤러의 가져온 lastEndDate : " + lastEndDateStr); // 디버깅 출력
	        LocalDate lastEndDate = LocalDate.parse(lastEndDateStr);
	        LocalDate newStartDate = lastEndDate.plusDays(1);

	        System.out.println("컨트롤러의 회원의 재결제 시작일 : " + newStartDate);

	        model.addAttribute("newStartDate", newStartDate);
	    }
	    
	    // 회원권 조회
	    List<PaymentTypeVO> paymentList = paymentService.getMembershipList();
	    model.addAttribute("paymentList", paymentList);
	    
	    return "/payment/paymentInsert";
	}

	// 회원권 결제 post 메서드 (JSON)
	@PostMapping("/paymentInsert")
	@ResponseBody
	public Map<String, Object> paymentInsertPost(@RequestBody PaymentRequestDTO request, HttpSession session) {
	    PaymentVO payment = request.getPayment();
	    PaymentTypeVO paymentType = request.getPaymentType();
	    PaymentHistoryVO history = request.getPaymentHistory();
	    
	    Map<String, Object> response = new HashMap<String, Object>();
	
	    try {
	        MemberVO user = (MemberVO) session.getAttribute("user");
	        String userId = user.getMe_id(); // 사용자 ID를 가져옴
	
	        // 기존 결제 정보를 조회
	        PaymentVO existingPayment = paymentService.getLastPaymentByUserId(userId, paymentType.getPt_num());
	        System.out.println("결제 타입 번호 : " + paymentType.getPt_num());
	
	        boolean isNewPayment = (existingPayment == null);
	
	        // 새로운 결제 또는 기존 결제 정보에 따라 처리
	        LocalDateTime startDateTime = handleStartDate(payment, existingPayment, response);
	
	        // 만료일 계산
	        LocalDateTime expirationDateTime = calculateExpirationDate(startDateTime, paymentType.getPt_date());
	        String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	        System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
	
	        // 결제 상태 처리
	        String paymentStatus = history.getPh_status();
	        StatusName(payment, paymentStatus);
	        System.out.println("결제 기록 저장용 텍스트 값 : " + payment.getPa_state());
	
	        // 결제 기록 삽입
	        boolean historyInserted = paymentService.insertPaymentHistory(paymentType, history, user);
	        if (!historyInserted) {
	            response.put("success", false);
	            response.put("message", "결제 기록 추가에 실패했습니다.");
	            return response; // 결제 기록 추가 실패 시 응답
	        }
	
	        // 결제 처리
	        boolean res = processMembershipPayment(payment, paymentType, history, formattedDateTime, user, response, isNewPayment);
	
	        if (res) {
	            response.put("url", "/payment/paymentList");
	        } else {
	            response.put("success", false);
	            response.put("message", "결제 업데이트에 실패했습니다.");
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생하였습니다: " + e.getMessage());
	    }
	    return response; // JSON 형식으로 응답
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

	// PT 결제 get
	@GetMapping("/paymentInsertPT")
	public String paymentInsertPT(Model model, HttpSession session,
	        HttpServletRequest request, HttpServletResponse response) {
		
	    // 현재 날짜를 yyyy-MM-dd 형식으로 포맷
	    LocalDateTime today = LocalDateTime.now();
	    String currentDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

	    // 사용자 ID 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    // 회원권 조회
	    List<PaymentTypeVO> paymentPTList = paymentService.getMembershipPTList();
	    
	    // 결제 정보를 가져옴
	    PaymentDetailsDTO paymentDetails = paymentService.getPaymentDetails(user.getMe_id());
	    
	    // 회원권 유무 확인
	    boolean hasMembership = paymentDetails.getFirstStartDate() != null;
	    
	    // PT 결제 가능 여부
	    boolean canPayPT = hasMembership && paymentDetails.isRePayment();
	    
	    // model에 보내기
	    model.addAttribute("paymentPTList", paymentPTList);
	    model.addAttribute("hasMembership", hasMembership);
	    model.addAttribute("canPayPT", canPayPT);
	    model.addAttribute("firstStartDate", paymentDetails.getFirstStartDate());
	    model.addAttribute("lastEndDate", paymentDetails.getLastEndDate());
	    model.addAttribute("ptFirstStartDate", paymentDetails.getPtFirstStartDate());
	    model.addAttribute("ptLastEndDate", paymentDetails.getPtLastEndDate());
	    model.addAttribute("isRePaymentForPT", paymentDetails.isRePaymentForPT());
	    model.addAttribute("currentDate", currentDate);
	    
	    System.out.println("회원권 유무 확인 : " + hasMembership);
	    System.out.println("PT결제 가능 여부 : " + canPayPT);
	    System.out.println("PT 결제 정보 : " + paymentDetails);
	    System.out.println("이용권 시작일 : " + paymentDetails.getFirstStartDate());
	    System.out.println("이용권 만료일 : " + paymentDetails.getLastEndDate());
	    System.out.println("PT 시작일 : " + paymentDetails.getPtFirstStartDate());
	    System.out.println("PT 만료일 : " + paymentDetails.getPtLastEndDate());
	    System.out.println("PT는 재결제 인가요? : " + paymentDetails.isRePaymentForPT());
	    
	    // newStartDate 선언
	    LocalDate newStartDate = null; // 여기에서 선언

	    // 재시작일을 마지막 결제일의 만료일 +1일로 설정
	    String ptLastEndDateStr = paymentDetails.getPtLastEndDate(); 

	    if (ptLastEndDateStr != null) {
	        LocalDate lastPTEndDate = LocalDate.parse(ptLastEndDateStr);
	        newStartDate = lastPTEndDate.plusDays(1); // 만료일 + 1
	        System.out.println("재시작일: " + newStartDate);
	    } else {
	        // ptLastEndDateStr가 null일 경우 첫 결제로 처리
	        System.out.println("PT 결제 내역이 없습니다. 첫 결제로 처리합니다.");
	        // 여기에서 첫 결제에 대한 처리 로직 추가 가능
	        // 예: newStartDate = LocalDate.now(); 또는 다른 적절한 날짜
	    }

	    model.addAttribute("newStartDate", newStartDate);
	    
	    return "/payment/paymentInsertPT";
	}
	
	// PT 결제 post 메서드 (JSON)
	@PostMapping("/paymentInsertPT")
	@ResponseBody
	public Map<String, Object> paymentInsertPTPost(@RequestBody PaymentRequestDTO request, HttpSession session) {
		PaymentVO payment = request.getPayment();
	    PaymentTypeVO paymentType = request.getPaymentType();
	    PaymentHistoryVO history = request.getPaymentHistory();
	    
	    Map<String, Object> response = new HashMap<String, Object>();
	    
	    try {
	        MemberVO user = (MemberVO) session.getAttribute("user");
	        String userId = user.getMe_id(); // 사용자 ID를 가져옴
	
	        System.out.println("유저 정보 : " + user);
	        System.out.println("결제 정보 : " + payment);
	        System.out.println("결제 타입 : " + paymentType);
	        System.out.println("결제 유형 : " + history);
	
	        // 기존 결제 정보를 조회
	        PaymentVO existingPayment = paymentService.getLastPaymentByUserId(userId, paymentType.getPt_num());
	        System.out.println("결제 타입 번호 : " + paymentType.getPt_num());
	
	        if (existingPayment != null) {
	            // Ajax로 전달된 새로운 결제 시작일을 가져와서 설정
	            Date newStartDate = payment.getPa_start(); // Ajax로 전달된 시작일 가져오기
	            
	            // 기존 결제의 시작일을 초기 시작일로 저장
	            Date initialStartDate = existingPayment.getPa_start(); // 기존 시작일
	            response.put("initialStartDate", initialStartDate); // 화면에 보여줄 데이터로 추가

	            if (newStartDate != null) {
	                LocalDateTime startDateTime = newStartDate.toInstant()
	                    .atZone(ZoneId.systemDefault())
	                    .toLocalDate()
	                    .atStartOfDay(); // 시작일의 00:00:00으로 설정
	                existingPayment.setPa_start(Timestamp.valueOf(startDateTime)); // 새로운 시작일로 설정
	                System.out.println("새로운 결제 시작 날짜: " + startDateTime);
	            }
	            
	            LocalDateTime startDateTime = payment.getPa_start().toInstant()
	                .atZone(ZoneId.systemDefault())
	                .toLocalDate()
	                .atStartOfDay(); // 시작일의 00:00:00으로 설정
	            payment.setPa_start(Timestamp.valueOf(startDateTime)); // Timestamp로 변환하여 설정
	            
	            // 만료일 계산
	            LocalDateTime expirationDateTime = calculateExpirationDate(startDateTime, paymentType.getPt_date());

	            // 형식 지정
	            String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
	
	            // 걸제 기록(결제 히스토리) 삽입 (히스토리 객체는 DTO에서 가져옴)
	            boolean historyInserted = paymentService.insertPaymentHistory(paymentType, history, user);
	            if (!historyInserted) {
	                response.put("success", false);
	                response.put("message", "결제 기록 추가에 실패했습니다.");
	                return response; // 결제 기록 추가 실패 시 응답
	            }
	            
	            // 결제 상태 처리
	            String paymentStatus = history.getPh_status();
	            StatusName(payment, paymentStatus);
	            System.out.println("결제 기록 저장용 텍스트 값 : " + payment.getPa_state());

	    	    // 기존 결제 정보를 가져옴
	    	    PaymentDetailsDTO paymentDetails = paymentService.getPaymentDetails(user.getMe_id());
	    	    
	            // 결제 처리
	            processPayment(payment, paymentType, history, formattedDateTime, user, response, paymentDetails);
	            
	        } else {
	            // 새로운 결제인 경우 - 사용자가 선택한 시작 날짜를 사용
	            if (payment.getPa_start() == null) {
	                response.put("success", false);
	                response.put("message", "시작 날짜를 선택해주세요.");
	                return response;
	            }
	            
	            // 새로운 결제 처리
	            LocalDateTime startDateTime = payment.getPa_start().toInstant()
	                .atZone(ZoneId.systemDefault())
	                .toLocalDate()
	                .atStartOfDay(); // 시작일의 00:00:00으로 설정
	            payment.setPa_start(Timestamp.valueOf(startDateTime)); // Timestamp로 변환하여 설정
	
	            System.out.println("사용자가 선택한 이용권 시작 날짜(시간은 자동으로 00:00:00으로 들어옴) : " + startDateTime);
		            
		        // 만료일 계산
	            LocalDateTime expirationDateTime = calculateExpirationDate(startDateTime, paymentType.getPt_date());

	            // 형식 지정
	            String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            System.out.println("계산된 만료일 및 시간: " + formattedDateTime);

	            // 결제 상태 처리
	            String paymentStatus = history.getPh_status();
	            StatusName(payment, paymentStatus);
	            System.out.println("결제 기록 저장용 텍스트 값 : " + payment.getPa_state());
	            
	            // 기존 결제 정보를 가져옴
	            PaymentDetailsDTO paymentDetails = paymentService.getPaymentDetails(user.getMe_id());

	            // 결제 처리
	            processPayment(payment, paymentType, history, formattedDateTime, user, response, paymentDetails);
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생하였습니다: " + e.getMessage());
	    }
	    return response; // JSON 형식으로 응답
	}
	
	
	
	
	
	
	/**
	 * 결제 상태에 따라 PaymentVO 객체의 결제 상태를 업데이트하는 메서드
	 * @param payment 결제 정보 객체
	 * @param paymentStatus 
	 * @return paymentStatus에 따라 pa_state를 설정하고, 해당 상태를 반환한다.
	 * 예) 결제 상태가 "paid"이면 pa_state를 "결제완료"로 설정
	 */
	public String StatusName(PaymentVO payment, String paymentStatus) {
		switch (paymentStatus) {
	        case "paid":
	            payment.setPa_state("결제완료");
	            break;
	        case "pending":
	            payment.setPa_state("결제진행중");
	            break;
	        case "failed":
	            payment.setPa_state("결제실패");
	            break;
	        case "canceled":
	            payment.setPa_state("결제취소");
	            break;
	        case "refunded":
	            payment.setPa_state("결제환불");
	            break;
	        default:
	            payment.setPa_state("알 수 없는 상태");
	            break;
	    }
		return paymentStatus;
	}
	
	
	
	/**
	 * 주어진 시작일(startDateTime)로부터 기간(period)만큼의 만료일을 계산하는 메소드.
	 * 1월 31일의 경우 3월 1일로 넘어가도록 처리하며, 2월의 경우도 적절히 보완.
	 * 
	 * @param startDateTime 결제 시작일 (LocalDateTime)
	 * @param period 결제 기간 (월 단위, 예: 1개월, 2개월 등)
	 * @return 계산된 만료일 (LocalDateTime)
	 */
	private LocalDateTime calculateExpirationDate(LocalDateTime startDateTime, int period) {
	    LocalDateTime expirationDateTime = startDateTime.plusMonths(period); // 월 단위로 더함

	    // 해당 월의 마지막 날 계산
	    YearMonth yearMonth = YearMonth.from(expirationDateTime);
	    int lastDayOfMonth = yearMonth.lengthOfMonth(); // 해당 월의 마지막 날짜 계산

	    // 2월 28일 또는 29일인 경우, 3월 1일로 설정하는 처리
	    if (startDateTime.getMonth() == Month.JANUARY && startDateTime.getDayOfMonth() == 31) {
	        if (expirationDateTime.getMonth() == Month.FEBRUARY) {
	            expirationDateTime = expirationDateTime.plusMonths(1).withDayOfMonth(1); // 3월 1일로 설정
	        }
	    } else if (startDateTime.getMonth() == Month.FEBRUARY && startDateTime.getDayOfMonth() == 1) {
	        // 2월 1일인 경우, 1개월 후는 3월 1일로 설정
	        expirationDateTime = expirationDateTime.withDayOfMonth(1);
	    } else if (startDateTime.getMonth() == Month.FEBRUARY && (startDateTime.getDayOfMonth() == 28 || startDateTime.getDayOfMonth() == 29)) {
	        expirationDateTime = expirationDateTime.plusMonths(1).withDayOfMonth(1); // 2월 말일이면 3월 1일로 설정
	    } else {
	        // 현재 날짜에서 하루 전으로 설정하되, 첫째 날일 경우 말일로 설정
	        int newDayOfMonth = startDateTime.getDayOfMonth() == 1 ? lastDayOfMonth : startDateTime.getDayOfMonth() - 1;
	        newDayOfMonth = Math.min(newDayOfMonth, lastDayOfMonth); // 새로운 날짜가 말일을 넘지 않도록 설정

	        // 새로운 날짜 설정
	        expirationDateTime = expirationDateTime.withDayOfMonth(newDayOfMonth);
	    }

	    return expirationDateTime;
	}

	
	
	
	/**
	 * 기존 결제 또는 새로운 결제 시작 날짜를 처리하는 메소드
	 * 
	 * @param payment 결제 정보 객체
	 * @param existingPayment 기존 결제 정보 객체
	 * @param response 응답 객체
	 * @return LocalDateTime으로 변환된 시작 날짜
	 */
	private LocalDateTime handleStartDate(PaymentVO payment, PaymentVO existingPayment, Map<String, Object> response) {
	    LocalDateTime startDateTime;
	    
	    if (existingPayment != null) {
	        // 기존 결제의 시작일을 초기 시작일로 저장
	        Date initialStartDate = existingPayment.getPa_start();
	        response.put("initialStartDate", initialStartDate); // 화면에 보여줄 데이터로 추가
	
	        Date newStartDate = payment.getPa_start(); // Ajax로 전달된 새로운 결제 시작일
	        if (newStartDate != null) {
	            startDateTime = newStartDate.toInstant()
	                .atZone(ZoneId.systemDefault())
	                .toLocalDate()
	                .atStartOfDay(); // 시작일의 00:00:00으로 설정
	            existingPayment.setPa_start(Timestamp.valueOf(startDateTime)); // 새로운 시작일로 설정
	            System.out.println("새로운 결제 시작 날짜: " + startDateTime);
	        } else {
	            startDateTime = existingPayment.getPa_start().toInstant()
	                .atZone(ZoneId.systemDefault())
	                .toLocalDate()
	                .atStartOfDay(); // 기존 시작일을 그대로 사용
	        }
	    } else {
	        // 새로운 결제인 경우
	        startDateTime = payment.getPa_start().toInstant()
	            .atZone(ZoneId.systemDefault())
	            .toLocalDate()
	            .atStartOfDay(); // 시작일의 00:00:00으로 설정
	        payment.setPa_start(Timestamp.valueOf(startDateTime)); // Timestamp로 변환하여 설정
	        System.out.println("사용자가 선택한 이용권 시작 날짜 : " + startDateTime);
	    }
	
	    return startDateTime;
	}
	
	
	/**
	 * 회원권 :: 주어진 결제 정보와 사용자 정보를 바탕으로 회원권 결제 처리 및 결과를 반환하는 메소드.
	 * 결제가 성공했는지 여부에 따라 적절한 메시지를 response에 담아 응답.
	 * 
	 * @param payment 결제 정보 (PaymentVO)
	 * @param paymentType 결제 타입 정보 (PaymentTypeVO)
	 * @param history 결제 이력 정보 (PaymentHistoryVO)
	 * @param formattedDateTime 계산된 만료일을 포함한 포맷된 날짜 문자열 (String)
	 * @param user 결제하는 사용자 정보 (MemberVO)
	 * @param response 클라이언트로 반환할 응답 데이터 (Map<String, Object>)
	 * @return 결제가 성공했는지 여부 (boolean)
	 */
	private boolean processMembershipPayment(PaymentVO payment, PaymentTypeVO paymentType, PaymentHistoryVO history, String formattedDateTime, MemberVO user, Map<String, Object> response, boolean isNewPayment) {
	    boolean res = paymentService.insertPayment(payment, paymentType, history, formattedDateTime, user);

	    if (res) {
	        if (isNewPayment) {
	            // 새 결제인 경우
	            response.put("success", true);
	            response.put("message", "결제가 완료되었습니다.");
	            response.put("url", "/payment/paymentList");
	        } else {
	            // 재결제인 경우
	            response.put("success", true);
	            response.put("message", "결제가 완료되었습니다. 만료일이 연장되었습니다.");
	            response.put("url", "/payment/paymentList");
	        }
	    } else {
	        if (isNewPayment) {
	            response.put("success", false);
	            response.put("message", "결제가 실패하였습니다.");
	            response.put("url", "/payment/paymentInsert");
	        } else {
	            response.put("success", false);
	            response.put("message", "결제 업데이트에 실패했습니다.");
	        }
	    }

	    return res;
	}

	
	
	
	/**
	 * PT :: 주어진 결제 정보와 사용자 정보를 바탕으로 결제 처리 및 결과를 반환하는 메소드.
	 * 결제가 성공했는지 여부에 따라 적절한 메시지를 response에 담아 응답.
	 * 
	 * @param payment 결제 정보 (PaymentVO)
	 * @param paymentType 결제 타입 정보 (PaymentTypeVO)
	 * @param history 결제 이력 정보 (PaymentHistoryVO)
	 * @param formattedDateTime 계산된 만료일을 포함한 포맷된 날짜 문자열 (String)
	 * @param user 결제하는 사용자 정보 (MemberVO)
	 * @param response 클라이언트로 반환할 응답 데이터 (Map<String, Object>)
	 * @param paymentDetails 사용자의 결제 상태 정보 (PaymentDetailsDTO)
	 * @return 결제가 성공했는지 여부 (boolean)
	 */
	private boolean processPayment(PaymentVO payment, PaymentTypeVO paymentType, PaymentHistoryVO history, String formattedDateTime, MemberVO user, Map<String, Object> response, PaymentDetailsDTO paymentDetails) {
	    boolean res = paymentService.insertPayment(payment, paymentType, history, formattedDateTime, user);

	    if (res) {
	        if (paymentDetails.isRePaymentForPT()) {
	            // 재결제인 경우
	            response.put("success", true);
	            response.put("message", "PT 재결제가 완료되었습니다. 만료일이 연장되었습니다.");
	        } else {
	            // 첫 결제인 경우
	            response.put("success", true);
	            response.put("message", "첫 PT 결제가 완료되었습니다.");
	        }
	        response.put("url", "/payment/paymentList");
	    } else {
	        response.put("success", false);
	        response.put("message", "결제 업데이트에 실패했습니다.");
	    }

	    return res;
	}
	
	
	
}