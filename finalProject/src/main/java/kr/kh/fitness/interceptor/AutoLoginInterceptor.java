package kr.kh.fitness.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter {

    private static final Logger logger = Logger.getLogger(AutoLoginInterceptor.class);

    @Autowired
    private MemberService memberService;

    @Override
    public boolean preHandle(HttpServletRequest request, 
                             HttpServletResponse response, 
                             Object handler) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");

        // 이미 로그인된 사용자는 인터셉터 처리 불필요
        if (user != null) {
            logger.info("사용자가 이미 로그인 상태입니다. 세션 유지 중.");
            return true;
        }

        // "me_cookie"라는 이름의 쿠키를 가져옴
        Cookie cookie = WebUtils.getCookie(request, "me_cookie");

        // 쿠키가 없는 경우, 자동 로그인 처리를 하지 않고 요청을 진행
        if (cookie == null) {
            logger.info("자동 로그인 쿠키가 존재하지 않습니다.");
            return true;
        }

        // 쿠키 값 확인
        String Id = cookie.getValue();
        logger.info("자동 로그인 쿠키 값: " + Id);

        // 쿠키 값을 통해 사용자 정보를 조회
        user = memberService.getMemberID(Id);
        logger.info("조회된 사용자 정보: " + (user != null ? user.getMe_id() : "null"));

        // 사용자 정보가 유효한 경우 세션에 사용자 정보 저장
        if (user != null) {
            session.setAttribute("user", user);
            logger.info("세션에 사용자 정보 설정 완료. 사용자 ID: " + user.getMe_id());
        } else {
            logger.warn("자동 로그인 쿠키를 통해 사용자를 찾을 수 없습니다.");
        }

        // 요청 처리를 계속 진행
        return true;
    }
}
