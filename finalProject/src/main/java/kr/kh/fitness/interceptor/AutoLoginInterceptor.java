package kr.kh.fitness.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;

import java.util.Date;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private MemberService memberService;

    @Override
    public boolean preHandle(HttpServletRequest request, 
                             HttpServletResponse response, 
                             Object handler) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        if (user != null) {
            return true; // 이미 세션에 사용자가 있는 경우, 자동 로그인 처리할 필요 없음
        }

        // 자동 로그인 쿠키 확인
        Cookie cookie = WebUtils.getCookie(request, "me_cookie");
        if (cookie == null) {
            return true; // 쿠키가 없는 경우, 자동 로그인 처리할 필요 없음
        }

        String sid = cookie.getValue();
        user = memberService.getMemberID(sid);

        // 사용자가 있고 자동 로그인 만료 시간이 현재 시간 이후인 경우에만 세션 설정
        if (user != null && user.getMe_limit() != null && user.getMe_limit().after(new Date())) {
            session.setAttribute("user", user);
        } else {
            // 만료된 쿠키는 삭제 처리
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        return true;
    }
}
