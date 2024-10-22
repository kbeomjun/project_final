package kr.kh.fitness.service;

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
            return user;
        }
        return null;
    }

    @Override
    public boolean signup(MemberVO member) {
        if (member == null) {
            return false;
        }
        System.out.println();
        
        // 정규 표현식
        String usernameRegex = "^[A-Za-z0-9]{4,10}$"; // 아이디: 4~10자 영문자 및 숫자
        String passwordRegex = "^[a-zA-Z0-9!@#$]{4,15}$"; // 영어, 숫자, 특수문자(!@#$)만 가능하며, 4~15자
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"; // 이메일: 기본 이메일 형식
        
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
        	e.printStackTrace();
            return false;
        }
    }

	@Override
	public boolean checkId(String id) {
		return memberDao.selectMember(id) == null;
	}

	@Override
	public void updateMemberCookie(MemberVO user) {
		if(user == null) {
			return;
		}
		memberDao.updateMemberCookie(user);
	}
	
	@Override
	public MemberVO getMemberID(String sid) {
		return memberDao.selectMemberByCookie(sid);
	}

	@Override
	public boolean joinSocialMember(String social_type, MemberVO socialUser) {
		
		KakaoService kakaoService = new KaKaoServiceImp();
		// 등록된 social이 아니라면
		if(!kakaoService.isValidSocialName(social_type)) {
			return false;
		}
		
		// 필수 정보가 누락되었다면
		if( socialUser.getMe_id() ==null || 
			socialUser.getMe_pw() == null ||
			socialUser.getMe_email() == null) {
			return false;
		}
		
		// 기본 정보 DB에 등록.
		if(!signup(socialUser)) {
			return false;
		}
		
		// social에서 받은 정보 추가 등록
		// socialUserID, gender, phone, name
		try {
			if(memberDao.updateSocialUser(social_type, socialUser) == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			memberDao.deleteUser(socialUser);
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean updateUserSocialAccount(String social_type, MemberVO socialUser) {
		System.out.println(social_type);
		return memberDao.updateSocialUser(social_type, socialUser)==0?false:true;
	}
}
