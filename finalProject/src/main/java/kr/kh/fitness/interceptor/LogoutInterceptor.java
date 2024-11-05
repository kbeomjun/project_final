package kr.kh.fitness.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.fitness.model.vo.MemberVO;

public class LogoutInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 로그인한 회원이 관리자이면 가려던 길을 가고 아니면 메인 페이지로 이동을 시키려고 한다.
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");

		if (user == null) {

			response.setContentType("text/html; charset=UTF-8;");
			response.getWriter().write("<script>alert(\"회원만 접근할 수 있습니다.\")</script>");
			response.getWriter().write("<script>location.href='"+request.getContextPath() + "/login" + "'</script>");
			response.flushBuffer();
			
			return false;
		}

		return true;
	}
}
