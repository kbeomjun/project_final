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
	        return false; // member가 null이면 false 반환
	    }

	    // 아이디가 이미 존재하는지 확인
	    MemberVO existingMember = memberDao.selectMember(member.getMe_id());
	    if (existingMember != null) {
	        return false; // 아이디가 존재하면 false 반환
	    }

	    try {
	        // 회원 정보를 데이터베이스에 삽입
	        return memberDao.insertMember(member);
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
	        return false; // 삽입 실패 시 false 반환
	    }
	}
}

