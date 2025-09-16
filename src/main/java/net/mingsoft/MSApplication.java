/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.mingsoft;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;

import java.util.logging.Logger;

@SpringBootApplication(scanBasePackages = {"net.mingsoft"})
@MapperScan(basePackages={"**.dao","com.baomidou.**.mapper"})
@ServletComponentScan(basePackages = {"net.mingsoft"})
public class MSApplication {
	public static void main(String[] args) {
		SpringApplication springApplication = new SpringApplication(MSApplication.class);
		springApplication.setBannerMode(Banner.Mode.OFF);
		ConfigurableApplicationContext configurableApplicationContext = springApplication.run(args);
		Environment env = configurableApplicationContext.getEnvironment();
		String port = env.getProperty("server.port", "8080");
		String managerPath = env.getProperty("ms.manager.path", "");
		String profiles = String.join(", ", env.getActiveProfiles());

		System.out.printf(
				"\n" +
						"\033[1;36m" + // 青色加粗
						"╔══════════════════════════════════════════════════════════╗\n" +
						"║ \033[1;33m🚀 MCms Application Started Successfully! \033[1;36m               ║\n" +
						"╠══════════════════════════════════════════════════════════╣\n" +
						"║ \033[0;32m➜ Manager URL: \033[0;33mhttp://localhost:%s\033[1;36m%s\033[1;36m/login.do         ║\n" +
						"║ \033[0;32m➜ Front URL: \033[0;33mhttp://localhost:%s/\033[1;36m                      ║\n" +
						"║ \033[0;32m➜ Activate Profiles: \033[0;35m%s\033[1;36m                                 ║\n" +
						"╚══════════════════════════════════════════════════════════╝" +
						"\033[0m", // 重置颜色
				port,
				managerPath,
				port,
				profiles
		);
	}
}


