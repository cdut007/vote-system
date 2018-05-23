package com.itender;

import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configurable
@EnableAutoConfiguration
@ComponentScan(basePackages = "com.itender")
@MapperScan(basePackages = "com.itender.ms.mapper")
@SpringBootApplication
@EnableTransactionManagement
@EnableSwagger2
@ServletComponentScan
public class Application{





    public static void main(String[] args) {
        SpringApplication.run(Application.class,args);

    }

    @Bean
    public FilterRegistrationBean WebStatfilterRegistrationBean(){
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();

        WebStatFilter webStatFilter = new WebStatFilter();
        filterRegistrationBean.setFilter(webStatFilter);
        filterRegistrationBean.addUrlPatterns("/*");
        filterRegistrationBean.addInitParameter("exclusions","*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");

        return filterRegistrationBean;
    }

    @Bean
    public ServletRegistrationBean servletRegistrationBean(){
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean();
        servletRegistrationBean.setServlet(new StatViewServlet());
        servletRegistrationBean.addUrlMappings("/druid/*");
        return servletRegistrationBean;
    }




//    @Bean
//    public Configuration configuration(){
//        Configuration configuration = new Configuration(new Version(2,3,27));
//        return configuration;
//    }

    @Bean
    public Docket createRestApi(){
        return new Docket(DocumentationType.SWAGGER_2)

                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.itender.ms.controller"))
                .paths(PathSelectors.any())

                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("综改区交易监督API接口")
                .description("综改区交易监督API接口")
                .contact(new Contact("金蝉","",""))
                .version("1.0")
                .build();
    }

}
