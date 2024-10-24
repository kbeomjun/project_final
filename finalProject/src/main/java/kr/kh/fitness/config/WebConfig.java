package kr.kh.fitness.config;

import javax.annotation.Resource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.extern.log4j.Log4j;

@Configuration
@EnableWebMvc
@Log4j
public class WebConfig implements WebMvcConfigurer {
	
	@Resource
	String uploadPath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		log.info("WebConfig. addResourceHandlers");
		// log.info("uploadPath : "+uploadPath);
		
		// "/uploads/**" 경로를 로컬 디렉토리로 매핑
		registry.addResourceHandler("/uploads/**")
				.addResourceLocations("file:///"+ uploadPath + "/");
		//.addResourceLocations("file:///" + uploadPath.replace("\\", "/"));
	}
	
	// Spring Framework 환경에서 UTF-8 인코딩을 모든 요청에 적용
    @Bean
    public CharacterEncodingFilter characterEncodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true); // 요청과 응답 모두에 강제 적용
        return filter;
    }
}
