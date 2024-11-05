package kr.kh.fitness.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.fitness.model.vo.MemberVO;

public class GuestInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 로그인한 사용자가 login을 시도할 때
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");

		if (user != null) {

			response.setContentType("text/html; charset=UTF-8;");
			response.getWriter().write("<script>alert(\"로그인 상태로 이용이 불가합니다.\")</script>");
			response.getWriter().write("<script>location.href='"+request.getContextPath() + "/" + "'</script>");
			response.flushBuffer();
			
			return false;
		}

		return true;
	}
}
