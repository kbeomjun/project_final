package kr.kh.fitness.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import kr.kh.fitness.dao.MemberDAO;
import kr.kh.fitness.model.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
    
    @Autowired
    private MemberDAO memberDao;
    
    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Override
    public MemberVO login(MemberVO member, HttpServletResponse response) {
        if (member == null || member.getMe_id() == null || member.getMe_pw() == null) {
            return null;
        }
        MemberVO user = memberDao.selectMember(member.getMe_id());
        if (user == null) {
            return null;
        }
        if(passwordEncoder.matches(member.getMe_pw(), user.getMe_pw())) {
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
        
        // 정규 표현식
        String usernameRegex = "^[A-Za-z0-9]{4,16}$"; // 아이디: 4~16자 영문자 및 숫자
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,20}$"; // 비밀번호: 8~20자 영문 대소문자, 숫자, 특수문자 포함
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"; // 이메일: 기본 이메일 형식
        
        // 유효성 검사
        if (!member.getMe_id().matches(usernameRegex)) {
            return false; // 아이디가 유효하지 않음
        }
        
        if (!member.getMe_pw().matches(passwordRegex)) {
            return false; // 비밀번호가 유효하지 않음
        }

        if (!member.getMe_email().matches(emailRegex)) {
            return false; // 이메일이 유효하지 않음
        }

        // 비밀번호 암호화
        String encPw = passwordEncoder.encode(member.getMe_pw());
        // 암호화된 비밀번호로 회원 정보를 수정
        member.setMe_pw(encPw);
        try {
            // 아이디 중복, 이메일 중복일 때 예외 발생
            return memberDao.insertMember(member);
        } catch (Exception e) {
            return false;
        }
    }

	@Override
	public boolean checkId(String id) {
		return memberDao.selectMember(id) == null;
	}
}
