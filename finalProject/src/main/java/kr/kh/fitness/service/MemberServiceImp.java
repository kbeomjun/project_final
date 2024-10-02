package kr.kh.fitness.service;

import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.fitness.dao.MemberDAO;
import kr.kh.fitness.model.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{
	
	@Autowired
	private MemberDAO memberDao;
	
	@Override
	public MemberVO login(MemberVO member, HttpServletResponse response) {
		if(member == null || member.getMe_id() == null || member.getMe_pw() == null) {
		    return null;
		}
		MemberVO user = memberDao.selectMember(member.getMe_id());
		if(user == null) {
			return null;
		}
		if(member.getMe_pw().equals(user.getMe_pw())) {
			Cookie cookie = new Cookie("me_cookie", user.getMe_id());
	        cookie.setMaxAge(48 * 60 * 60); // 48시간
	        cookie.setPath("/"); // 모든 경로에서 유효
	        response.addCookie(cookie);
			
		    return user;
		}
		return null;
	}

	@Override
	public boolean signup(MemberVO member) {
		 if (member == null) {
			 return false;
		 }
		 if (!checkRegex(member.getMe_id(), "^\\w{4,10}$")) {
		     return false;
		 }
		 if (!checkRegex(member.getMe_pw(), "^[a-zA-Z0-9!@#$]{6,15}$")) {
		     return false;
		 }
		 try {
		     return memberDao.insertMember(member);
		 } catch (Exception e) {
		     e.printStackTrace(); // 예외 처리
		     return false; // 삽입 실패 시 false 반환
		 }
    }
	private boolean checkRegex(String str, String regex) {
		if(str != null && Pattern.matches(regex, str)) {
			return true;
		}
		return false;
	}

	@Override
	public boolean checkId(String id) {
	    return memberDao.selectMember(id) == null;
	}

}

