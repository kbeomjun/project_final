package kr.kh.fitness.config;

import javax.annotation.Resource;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
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
		
		// "/uploads/**" 경로를 로컬 디렉토리로 매핑
		registry.addResourceHandler("/uploadss/**")
				.addResourceLocations("file:///D:/git/final_project/project_final/storage/");
		//.addResourceLocations("file:///" + uploadPath.replace("\\", "/"));
	}
}
