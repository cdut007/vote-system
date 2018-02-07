package com.itender.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.itender.interceptor.AuthenticationInterceptor;

/**
 * 项目配置类
 *
 * @author 邓洁芃
 * @create 2018-01-04 下午3:10
 **/

@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

	@Bean
	AuthenticationInterceptor authenticationInterceptor(){
		return new AuthenticationInterceptor();
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry){
		registry.addInterceptor(authenticationInterceptor()).addPathPatterns("/**");
	}

}
