package com.h5tchigram.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		//images/** ::: images 의 하위 디렉터리 모두
		registry.addResourceHandler("/images/**")
		.addResourceLocations("file:///D:\\1\\06_Spring_Project\\quiz\\QuizProjectWorkSpace\\H5tchigram\\images/");//실제 파일 저장 위치
		// http://localhost/images/---만들었던 유일한 폴더 -- 접근 가능하게 매핑해주는 역할을 해준다.
		//우리파일이 어디에 있는지?
	}
}
