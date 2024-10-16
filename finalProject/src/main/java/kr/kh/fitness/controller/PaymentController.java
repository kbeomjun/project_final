package kr.kh.fitness.controller;

import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
	        hasMembership = existingPayment != null && existingPayment.getPa_end() != null;
	    }

	    // 모델에 회원권 유무 추가
	    model.addAttribute("hasMembership", hasMembership);
		
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
	    /*
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
	    */
	    
	    // 기존 결제 정보를 조회
	    PaymentVO existingPayment = paymentService.getPayment(user.getMe_id());

	    String firstStartDateStr = null;
	    String lastEndDateStr = null;
	    boolean isRePayment = false; // 재결제 여부

	    // 기존 결제의 최초 시작일과 최근 만료일 가져오기
	    if (existingPayment != null) {
	        String startDateString = paymentService.getFirstPaymentStartDate(user.getMe_id());
	        String endDateString = paymentService.getLastPaymentEndDate(user.getMe_id());

	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식에 맞게 설정
	        
	        try {
	            if (startDateString != null) {
	                Date firstStartDate = formatter.parse(startDateString); // String을 Date로 변환
	                firstStartDateStr = formatter.format(firstStartDate); // 원하는 형식으로 다시 포맷팅
	            }
	            if (endDateString != null) {
	                Date lastEndDate = formatter.parse(endDateString); // String을 Date로 변환
	                lastEndDateStr = formatter.format(lastEndDate); // 원하는 형식으로 다시 포맷팅
	                isRePayment = true; // 재결제임을 나타냄
	            }
	        } catch (ParseException e) {
	            e.printStackTrace(); // 날짜 형식이 맞지 않을 경우 예외 처리
	        }
	    }

	    // 현재 날짜 및 기존 결제 시작일 추가
	    model.addAttribute("currentDate", currentDate);
	    model.addAttribute("firstStartDate", firstStartDateStr);  // 최초 시작일 추가
	    model.addAttribute("lastEndDate", lastEndDateStr);  // 최근 만료일 추가
	    model.addAttribute("isRePayment", isRePayment); // 재결제 여부 추가
	    model.addAttribute("paymentList", paymentList);
	    
	    // 시작일을 최초 시작일 +1일로 설정
	    if (firstStartDateStr != null && lastEndDateStr != null) {
	        LocalDate lastEndDate = LocalDate.parse(lastEndDateStr);
	        LocalDate newStartDate = lastEndDate.plusDays(1); // 만료일에 +1일 추가
	        System.out.println("새시작일 : " + newStartDate);
	        model.addAttribute("newStartDate", newStartDate); // 새로운 시작일을 model에 추가
	    }
	    
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
	            
	            // 만료일 계산 (기존 결제의 만료일에서 기간 추가)
	            int period = paymentType.getPt_date(); // 예: 30, 60, 90일
	            LocalDateTime expirationDateTime = startDateTime.plusDays(period); // 기간을 더함
	            String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
	
	            System.out.println("실제 들어간 만료일 계산값 : " + existingPayment.getPa_end());
	
	            // 걸제 기록(결제 히스토리) 삽입 (히스토리 객체는 DTO에서 가져옴)
	            boolean historyInserted = paymentService.insertPaymentHistory(paymentType, history, user);
	            if (!historyInserted) {
	                response.put("success", false);
	                response.put("message", "결제 기록 추가에 실패했습니다.");
	                return response; // 결제 기록 추ㅏㄱ 실패 시 응답
	            }
	            
	            // 결제 상태 처리
	            String paymentStatus = history.getPh_status();
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
	            System.out.println("결제 기록 저장용 텍스트 값 : " + paymentStatus);

	            // 결제 업데이트 - 하지만 결제 관리 때문에 update가 아닌 insert임
	            boolean res = paymentService.insertPayment(payment, paymentType, history, formattedDateTime, user);
	            if (res) {
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
	            
	            // 새로운 결제 처리
	            LocalDateTime startDateTime = payment.getPa_start().toInstant()
	                .atZone(ZoneId.systemDefault())
	                .toLocalDate()
	                .atStartOfDay(); // 시작일의 00:00:00으로 설정
	            payment.setPa_start(Timestamp.valueOf(startDateTime)); // Timestamp로 변환하여 설정
	
	            System.out.println("사용자가 선택한 이용권 시작 날짜(시간은 자동으로 00:00:00으로 들어옴) : " + startDateTime);
	
	            // 만료일 계산
	            int period = paymentType.getPt_date(); // 예: 30, 60, 90일
	            LocalDateTime expirationDateTime = startDateTime.plusDays(period); // 기간을 더함
	            String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
	
	            // 결제 상태 처리
	            String paymentStatus = history.getPh_status();
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
	            System.out.println("결제 기록 저장용 텍스트 값 : " + payment.getPa_state());
	            
	            // 결제 처리
	            boolean res = paymentService.insertPayment(payment, paymentType, history, formattedDateTime, user);
	
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
	public String paymentPTInsert(Model model, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		List<PaymentTypeVO> paymentPTList = paymentService.getPTMembershipList();

	    // 현재 날짜를 yyyy-MM-dd 형식으로 포맷
	    LocalDateTime today = LocalDateTime.now();
	    String currentDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	    
	    // 사용자 ID 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    // 로그인하지 않은 상태라면, 사용자가 로그인되어 있지 않으면 이전 URL을 세션에 저장하고 로그인 페이지로 리다이렉트
	    /*
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
	    */
	    
	    // 기존 결제 정보를 조회
	    PaymentVO existingPayment = paymentService.getPayment(user.getMe_id());

	    String firstStartDateStr = null;
	    String lastEndDateStr = null;
	    boolean isRePayment = false; // 재결제 여부

	    // 기존 결제의 최초 시작일과 최근 만료일 가져오기
	    if (existingPayment != null) {
	        String startDateString = paymentService.getFirstPaymentStartDate(user.getMe_id());
	        String endDateString = paymentService.getLastPaymentEndDate(user.getMe_id());

	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식에 맞게 설정
	        
	        try {
	            if (startDateString != null) {
	                Date firstStartDate = formatter.parse(startDateString); // String을 Date로 변환
	                firstStartDateStr = formatter.format(firstStartDate); // 원하는 형식으로 다시 포맷팅
	            }
	            if (endDateString != null) {
	                Date lastEndDate = formatter.parse(endDateString); // String을 Date로 변환
	                lastEndDateStr = formatter.format(lastEndDate); // 원하는 형식으로 다시 포맷팅
	                isRePayment = true; // 재결제임을 나타냄
	            }
	        } catch (ParseException e) {
	            e.printStackTrace(); // 날짜 형식이 맞지 않을 경우 예외 처리
	        }
	    }

	    // 현재 날짜 및 기존 결제 시작일 추가
	    model.addAttribute("currentDate", currentDate);
	    model.addAttribute("firstStartDate", firstStartDateStr);  // 최초 시작일 추가
	    model.addAttribute("lastEndDate", lastEndDateStr);  // 최근 만료일 추가
	    model.addAttribute("isRePayment", isRePayment); // 재결제 여부 추가
	    model.addAttribute("paymentPTList", paymentPTList);
	    
	    // 시작일을 최초 시작일 +1일로 설정
	    if (firstStartDateStr != null && lastEndDateStr != null) {
	        LocalDate lastEndDate = LocalDate.parse(lastEndDateStr);
	        LocalDate newStartDate = lastEndDate.plusDays(1); // 만료일에 +1일 추가
	        System.out.println("새시작일 : " + newStartDate);
	        model.addAttribute("newStartDate", newStartDate); // 새로운 시작일을 model에 추가
	    }
	    
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
	            
	            // 만료일 계산 (기존 결제의 만료일에서 기간 추가)
	            int period = paymentType.getPt_date(); // 예: 30, 60, 90일
	            LocalDateTime expirationDateTime = startDateTime.plusDays(period); // 기간을 더함
	            String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
	
	            System.out.println("실제 들어간 만료일 계산값 : " + existingPayment.getPa_end());
	
	            // 걸제 기록(결제 히스토리) 삽입 (히스토리 객체는 DTO에서 가져옴)
	            boolean historyInserted = paymentService.insertPaymentHistory(paymentType, history, user);
	            if (!historyInserted) {
	                response.put("success", false);
	                response.put("message", "결제 기록 추가에 실패했습니다.");
	                return response; // 결제 기록 추ㅏㄱ 실패 시 응답
	            }
	            
	            // 결제 상태 처리
	            String paymentStatus = history.getPh_status();
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
	            System.out.println("결제 기록 저장용 텍스트 값 : " + paymentStatus);

	            // 결제 업데이트 - 하지만 결제 관리 때문에 update가 아닌 insert임
	            boolean res = paymentService.insertPayment(payment, paymentType, history, formattedDateTime, user);
	            if (res) {
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
	            
	            // 새로운 결제 처리
	            LocalDateTime startDateTime = payment.getPa_start().toInstant()
	                .atZone(ZoneId.systemDefault())
	                .toLocalDate()
	                .atStartOfDay(); // 시작일의 00:00:00으로 설정
	            payment.setPa_start(Timestamp.valueOf(startDateTime)); // Timestamp로 변환하여 설정
	
	            System.out.println("사용자가 선택한 이용권 시작 날짜(시간은 자동으로 00:00:00으로 들어옴) : " + startDateTime);
	
	            // 만료일 계산
	            int period = paymentType.getPt_date(); // 예: 30, 60, 90일
	            LocalDateTime expirationDateTime = startDateTime.plusDays(period); // 기간을 더함
	            String formattedDateTime = expirationDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            System.out.println("계산된 만료일 및 시간: " + formattedDateTime);
	
	            // 결제 상태 처리
	            String paymentStatus = history.getPh_status();
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
	            System.out.println("결제 기록 저장용 텍스트 값 : " + payment.getPa_state());
	            
	            // 결제 처리
	            boolean res = paymentService.insertPayment(payment, paymentType, history, formattedDateTime, user);
	
	            if (res) {
	                response.put("success", true);
	                response.put("message", "결제가 완료되었습니다.");
	                response.put("url", "/payment/paymentList");
	            } else {
	                response.put("success", false);
	                response.put("message", "결제가 실패하였습니다.");
	                response.put("url", "/payment/paymentInsertPT");
	            }
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생하였습니다: " + e.getMessage());
	    }
	    return response; // JSON 형식으로 응답
	}

	
}