package kr.kh.fitness.advise;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
@ControllerAdvice
public class ErrorAdvise {
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception e, Model model) {
		log.error("예외 발생: {"+e.getMessage()+"}" ); // 간단한 예외 메시지 출력
		return "/error/500";
	}
	@ExceptionHandler(NoHandlerFoundException.class)
	public String handleNoHandlerFoundException(NoHandlerFoundException e, Model model) {
		log.error("404 오류 - 페이지를 찾을 수 없음: {"+e.getMessage()+"}" ); // 간단한 예외 메시지 출력
		return "/error/404";
	}
}