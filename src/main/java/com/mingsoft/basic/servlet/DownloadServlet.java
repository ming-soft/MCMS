package com.mingsoft.basic.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 文件下载通用servlet
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@WebServlet(urlPatterns = "/download")
public class DownloadServlet extends BaseServlet {

	/**
	 * 处理get请求下载文件
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @throws ServletException Servlet异常处理
	 * @throws IOException IO异常处理
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 获取网站部署路径(通过ServletContext对象)，用于确定下载文件位置，从而实现下载
		String type = request.getParameter("type");
		String filePath = request.getParameter("file");
		filePath = "/upload/"+filePath;
		// 1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
		response.setContentType("multipart/form-data");
		// 2.设置文件头：最后一个参数是设置下载文件名(假如我们叫a.pdf)
		response.setHeader("Content-Disposition", "attachment;fileName=" + request.getParameter("file"));
		ServletOutputStream out;
		// 通过文件路径获得File对象(假如此路径中有一个download.pdf文件)
		File file = new File(this.getRealPath(request, filePath));

		try {
			FileInputStream inputStream = new FileInputStream(file);

			// 3.通过response获取ServletOutputStream对象(out)
			out = response.getOutputStream();

			int b = 0;
			byte[] buffer = new byte[512];
			while (b != -1) {
				b = inputStream.read(buffer);
				// 4.写到输出流(out)中
				out.write(buffer, 0, b);
			}
			inputStream.close();
			out.close();
			out.flush();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}