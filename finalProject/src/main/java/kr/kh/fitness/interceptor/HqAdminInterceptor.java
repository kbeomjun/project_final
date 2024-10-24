package kr.kh.fitness.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.fitness.model.vo.MemberVO;


public class HqAdminInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
			
		if(user == null || !user.getMe_authority().equals("HQADMIN")) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write("<script>alert(\"본사 관리자만 접근할 수 있습니다.\")</script>");
			response.getWriter().write("<script>location.href=\""+request.getContextPath() 
				+ "/"+"\"</script>");
			response.flushBuffer();
			return false;
		}
		
		return true;
	}
}
