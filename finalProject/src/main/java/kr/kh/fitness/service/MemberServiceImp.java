package kr.kh.fitness.service;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import kr.kh.fitness.dao.MemberDAO;
import kr.kh.fitness.model.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
    
    @Autowired
    private MemberDAO memberDao;
    
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
	private JavaMailSender mailSender;

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

	@Override
	public void updateMemberCookie(MemberVO user) {
		if(user == null) {
			return;
		}
		memberDao.updateMemberCookie(user);
	}
	
	@Override
	public void clearLoginCookie(String me_id) {
		memberDao.updateMemberCookieDelete(me_id);
	}
	
	@Override
	public MemberVO getMemberID(String sid) {
		return memberDao.selectMemberByCookie(sid);
	}

	@Override
	public boolean idCheck(String sns, String id) {
		try {
			int num = Integer.parseInt(id);
			num = num * 2;
			id = sns + "!" + num;
		}catch(Exception e) {
			id = sns + "!" + id;
		}
		MemberVO user = memberDao.selectMember(id);
		System.out.println(id);
		return user != null;
	}

	@Override
	public boolean signupSns(String sns, String id, String email) {
	    // 숫자인지 확인하고 처리
	    try {
	        int num = Integer.parseInt(id);
	        num = num * 2;  // 두 배로 계산
	        id = sns + "!" + num;  // SNS와 결합
	    } catch (Exception e) {
	        // 숫자가 아닌 경우 처리
	        id = sns + "!" + id;  // SNS와 결합
	    }
	    
	    // MemberVO 객체 생성 (회원 정보 담음)
	    MemberVO memberVO = new MemberVO(id, email);
	    
	    // 회원 정보 데이터베이스에 저장
	    return memberDao.insertMember(memberVO);
	}

	@Override
	public MemberVO loginSns(String sns, String id) {
	    try {
	        // ID가 숫자인지 확인
	        int num = Integer.parseInt(id);
	        // 숫자일 경우 두 배로 계산
	        num = num * 2;
	        // SNS 이름과 결합하여 새로운 ID 생성
	        id = sns + "!" + num;
	    } catch(Exception e) {
	        // 숫자가 아닌 경우, SNS 이름과 결합하여 새로운 ID 생성
	        id = sns + "!" + id;
	    }
	    
	    // 변환된 ID로 회원 조회
	    return memberDao.selectMember(id);
	}

	@Override
	public boolean findPw(String id) {
		String newPW = randomPassword(6);
		
		MemberVO user = memberDao.selectMember(id);
		if(user == null) {
			return false;
		}
		
		mailsend(
				user.getMe_email(),
				"임시 비밀번호를 발급했습니다",
				"임시 비밀번호는 <b>" +  newPW + " 입니다");
		
		String encPw = passwordEncoder.encode(newPW);
		user.setMe_pw(encPw);
		return memberDao.updateMember(user);
	}

	public boolean mailsend(String to, String title, String content) {
		
		String setfrom = "sujifi@naver.com";
		   try{
		        MimeMessage message = mailSender.createMimeMessage();
		        MimeMessageHelper messageHelper
		            = new MimeMessageHelper(message, true, "UTF-8");

		        messageHelper.setFrom(setfrom);// 보내는사람 생략하거나 하면 정상작동을 안함
		        messageHelper.setTo(to);// 받는사람 이메일
		        messageHelper.setSubject(title);// 메일제목은 생략이 가능하다
		        messageHelper.setText(content, true);// 메일 내용

		        mailSender.send(message);
		        return true;
		    } catch(Exception e){
		        e.printStackTrace();
		        return false;
		    }
		}

	private String randomPassword(int size) {
		String pw = "";
		int max = 10 + 26 + 26;
		while(pw.length() < size) {
			Random random = new Random();
			int r = random.nextInt(max);
			//0~9 숫자
			if(r < 10) {
				pw += r;
			}
			//10~35 : a~z 소문자
			else if(r < 36) {
				pw += (char)('a' + r - 10);
			}
			//36~61 : A~Z 대문자
			else {
				pw += (char)('A' + r - 36);
			}
		}
		return pw;
	}

	@Override
	public String findId(String name, String email) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
