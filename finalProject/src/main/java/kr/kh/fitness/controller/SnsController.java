package kr.kh.fitness.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.fitness.model.vo.MemberVO;
import kr.kh.fitness.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class SnsController {

    private static final Logger logger = LoggerFactory.getLogger(SnsController.class);

    @Autowired
    MemberService memberService;
    
    // SNS ID 체크 (회원 존재 여부 확인)
    @ResponseBody
    @PostMapping("/sns/{sns}/check/id")
    public boolean snsCheckId(@PathVariable("sns") String sns, @RequestParam("id") String id) {
        try {
            // SNS ID와 관련된 회원 여부 확인
            boolean isMember = memberService.idCheck(sns, id);
            return isMember;
        } catch (Exception e) {
            logger.error("SNS ID 체크 중 에러 발생: {}", e.getMessage());
            return false;
        }
    }

    // SNS 회원가입 처리
    @ResponseBody
    @PostMapping("/sns/{sns}/signup")
    public boolean snsSignup(@PathVariable("sns") String sns, @RequestParam("id") String id, @RequestParam("email") String email) {
        try {
            // SNS 회원가입 처리
            boolean signupSuccess = memberService.signupSns(sns, id, email);
            return signupSuccess;
        } catch (Exception e) {
            logger.error("SNS 회원 가입 중 에러 발생: {}", e.getMessage());
            return false;
        }
    }

    // SNS 로그인 처리
    @ResponseBody
    @PostMapping("/sns/{sns}/login")
    public boolean snsLogin(@PathVariable("sns") String sns, @RequestParam("id") String id, HttpSession session) {
        try {
            // SNS 로그인 처리
            MemberVO user = memberService.loginSns(sns, id);
            if (user != null) {
                // 세션에 사용자 정보 저장
                session.setAttribute("user", user);
                logger.info("SNS 로그인 성공: {}", id);
                return true;
            } else {
                logger.warn("SNS 로그인 실패: {}", id);
                return false;
            }
        } catch (Exception e) {
            logger.error("SNS 로그인 중 에러 발생: {}", e.getMessage());
            return false;
        }
    }
}
