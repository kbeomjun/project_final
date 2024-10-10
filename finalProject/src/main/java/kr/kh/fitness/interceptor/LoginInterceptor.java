package kr.kh.fitness.interceptor;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;


public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Autowired
	MemberService memberService;
	
	@Override
	public void postHandle(
	    HttpServletRequest request, 
	    HttpServletResponse response, 
	    Object Object, 
	    ModelAndView modelAndView)
	    throws Exception {
		
		MemberVO user = (MemberVO) modelAndView.getModel().get("user");
		if(user == null) {
			return;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		if(!user.isAutoLogin()) {
			return;
		}
		String sid = session.getId();
		Cookie cookie = new Cookie("me_cookie", sid);
		int time = 60 * 60 * 24 * 2;//이틀
		cookie.setMaxAge(time);
		cookie.setPath("/");
		
		Date date = new Date(System.currentTimeMillis()+time*1000);
		user.setMe_cookie(sid);
		user.setMe_limit(date);
		memberService.updateMemberCookie(user);
		
		response.addCookie(cookie);
	}
}
