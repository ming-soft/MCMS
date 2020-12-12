/**
 * The MIT License (MIT)
 * Copyright (c) 2020 铭软科技(mingsoft.net)
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
package net.mingsoft.config;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;

import io.swagger.models.Path;
import io.swagger.models.Swagger;

@Aspect
@EnableAspectJAutoProxy
@Component
public class SwaggerSuffixAspect {

	@AfterReturning(pointcut = "execution(public io.swagger.models.Swagger springfox.documentation.swagger2.mappers.ServiceModelToSwagger2MapperImpl.mapDocumentation(..))", returning = "swagger")
	public void doBeforeBussinessCheck(Swagger swagger) {
		Map<String, Path> paths = swagger.getPaths();
		if (null != paths) {
			Map<String, Path> newPaths = new HashMap<String, Path>(paths);
			paths.clear();
			Iterator<String> it = newPaths.keySet().iterator();
			while (it.hasNext()) {
				String oldKey = it.next();
				String newKey = oldKey + ".do";
				paths.put(newKey, newPaths.get(oldKey));
			}
			newPaths = null;
		}
	}
}
