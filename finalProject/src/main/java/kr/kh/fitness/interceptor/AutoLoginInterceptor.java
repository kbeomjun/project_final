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
            return true;
        }
        Cookie cookie = WebUtils.getCookie(request, "me_cookie");
        if (cookie == null) {
            return true;
        }

        String sid = cookie.getValue();
        user = memberService.getMemberID(sid);
        if (user != null) {
            session.setAttribute("user", user);
        }
        return true;
    }
}
