package kr.kh.fitness.service;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
    
    @Autowired
	private JavaMailSender mailSender;

    // 로그인 처리
    @Override
    public MemberVO login(MemberVO member, HttpServletResponse response) {
        if (member == null || member.getMe_id() == null || member.getMe_pw() == null) {
            return null; // 입력된 회원 정보가 없거나 아이디, 비밀번호가 null인 경우 로그인 실패
        }
        MemberVO user = memberDao.selectMember(member.getMe_id());
        if (user == null) {
            return null; // 아이디에 해당하는 사용자가 없는 경우 로그인 실패
        }
        // 비밀번호 일치 여부 확인 (암호화된 비밀번호 비교)
        if(passwordEncoder.matches(member.getMe_pw(), user.getMe_pw())) {
            return user; // 비밀번호가 일치하면 사용자 정보 반환
        }
        return null; // 비밀번호가 일치하지 않는 경우 로그인 실패
    }

    // 회원가입 처리
    @Override
    public boolean signup(MemberVO member) {
        if (member == null) {
            return false; // 회원 정보가 null인 경우 회원가입 실패
        }
        
        // 정규 표현식을 통한 유효성 검사
        String usernameRegex = "^[A-Za-z0-9]{4,16}$"; // 아이디: 4~16자 영문자 및 숫자
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,20}$"; // 비밀번호: 8~20자 영문 대소문자, 숫자, 특수문자 포함
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"; // 이메일: 기본 이메일 형식
        
        // 유효성 검사 실패 시 회원가입 실패
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
        member.setMe_pw(encPw); // 암호화된 비밀번호로 회원 정보를 수정
        try {
            // 회원 정보 데이터베이스에 저장 (아이디나 이메일이 중복될 경우 예외 발생)
            return memberDao.insertMember(member);
        } catch (Exception e) {
            return false; // 회원가입 중 오류 발생 시 회원가입 실패
        }
    }

    // 아이디 중복 체크
	@Override
	public boolean checkId(String id) {
		return memberDao.selectMember(id) == null; // 아이디가 존재하지 않으면 true 반환
	}

    // 자동 로그인 쿠키 업데이트
	@Override
	public void updateMemberCookie(MemberVO user) {
		if(user == null) {
			return; // 사용자 정보가 null인 경우 아무 작업도 수행하지 않음
		}
		memberDao.updateMemberCookie(user); // 사용자 정보에 쿠키 업데이트
	}
	
	// 자동 로그인 쿠키 삭제
	@Override
	public void clearLoginCookie(String me_id) {
		memberDao.updateMemberCookieDelete(me_id); // me_cookie 값을 null로 설정하여 쿠키 삭제
	}
	
	// 쿠키 값으로 사용자 정보 조회
	@Override
	public MemberVO getMemberID(String sid) {
		return memberDao.selectMemberByCookie(sid); // 쿠키 값으로 회원 정보 조회
	}

	// SNS 로그인 시 ID 생성 방식 적용 (숫자일 경우 두 배, 문자일 경우 SNS 이름과 결합)
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
		return user != null; // 해당 ID로 사용자가 존재하면 true 반환
	}

	// SNS 로그인 처리
	@Override
	public MemberVO loginSns(String sns, String id) {
	    try {
	        int num = Integer.parseInt(id);
	        num = num * 2; // 숫자일 경우 두 배로 계산
	        id = sns + "!" + num;
	    } catch(Exception e) {
	        id = sns + "!" + id; // 숫자가 아닌 경우 처리
	    }
	    return memberDao.selectMember(id); // 변환된 ID로 회원 조회
	}

	// SNS 회원가입 처리
	@Override
	public boolean signupSns(String sns, String id, String email) {
	    try {
	        int num = Integer.parseInt(id);
	        num = num * 2; // 두 배로 계산
	        id = sns + "!" + num;
	    } catch (Exception e) {
	        id = sns + "!" + id; // 숫자가 아닌 경우 처리
	    }
	    
	    MemberVO memberVO = new MemberVO(id, email); // MemberVO 객체 생성
	    return memberDao.insertMember(memberVO); // 회원 정보 데이터베이스에 저장
	}

	// 비밀번호 찾기 (임시 비밀번호 발급 및 메일 전송)
	@Override
	public boolean findPw(String id) {
		String newPW = randomPassword(6); // 임시 비밀번호 생성 (6자리)
		
		MemberVO user = memberDao.selectMember(id);
		if(user == null) {
			return false; // 사용자가 존재하지 않으면 실패 반환
		}
		
		mailsend(
				user.getMe_email(),
				"임시 비밀번호를 발급했습니다",
				"임시 비밀번호는 <b>" +  newPW + " 입니다"); // 임시 비밀번호 이메일 발송
		
		String encPw = passwordEncoder.encode(newPW); // 임시 비밀번호 암호화
		user.setMe_pw(encPw);
		return memberDao.updateMember(user); // 사용자 정보 업데이트 (암호 변경)
	}

	// 이메일 전송 메서드
	public boolean mailsend(String to, String title, String content) {
		String setfrom = "sujifi@naver.com";
		   try{
		        MimeMessage message = mailSender.createMimeMessage();
		        MimeMessageHelper messageHelper
		            = new MimeMessageHelper(message, true, "UTF-8");

		        messageHelper.setFrom(setfrom); // 보내는 사람 설정
		        messageHelper.setTo(to); // 받는 사람 설정
		        messageHelper.setSubject(title); // 메일 제목 설정
		        messageHelper.setText(content, true); // 메일 내용 설정

		        mailSender.send(message); // 메일 전송
		        return true;
		    } catch(Exception e){
		        e.printStackTrace();
		        return false; // 메일 전송 실패 시 false 반환
		    }
		}

	// 임시 비밀번호 생성 메서드
	private String randomPassword(int size) {
		String pw = "";
		int max = 10 + 26 + 26;
		while(pw.length() < size) {
			Random random = new Random();
			int r = random.nextInt(max);
			// 0~9 숫자
			if(r < 10) {
				pw += r;
			}
			// 10~35 : a~z 소문자
			else if(r < 36) {
				pw += (char)('a' + r - 10);
			}
			// 36~61 : A~Z 대문자
			else {
				pw += (char)('A' + r - 36);
			}
		}
		return pw;
	}

	// 아이디 찾기 메서드
    @Override
    public String findId(String name, String email) {
        if (name == null || email == null) {
            return null; // 이름 또는 이메일이 null인 경우 아이디 찾기 실패
        }
        // DAO를 통해 이름과 이메일에 해당하는 사용자 정보 조회
        MemberVO user = memberDao.selectMemberByNameAndEmail(name, email);
        return user != null ? user.getMe_id() : null; // 사용자 정보가 있으면 아이디 반환, 없으면 null 반환
    }
}
