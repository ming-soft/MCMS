package net.mingsoft;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

 
@SpringBootApplication
@ComponentScan(basePackages = {"net.mingsoft"})
@MapperScan(basePackages={"**.dao"})
@ServletComponentScan(basePackages = {"net.mingsoft"})
@EnableSwagger2
public class MSApplication {
	public static void main(String[] args) {
		SpringApplication.run(MSApplication.class, args);
	}

}