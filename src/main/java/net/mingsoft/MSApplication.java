package net.mingsoft;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.mingsoft","net.mingsoft"})
@MapperScan(basePackages={"**.dao"})
@ServletComponentScan(basePackages = {"com.mingsoft","net.mingsoft"})
public class MSApplication {

	public static void main(String[] args) {
		SpringApplication.run(MSApplication.class, args);
	}

}

	