package com.mingsoft.basic.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.StringUtil;

/**
 * 文件上传通用servlet
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@WebServlet(urlPatterns = "/upload")
public class UploadServlet extends BaseServlet {

	/**
	 * 处理post请求上传文件
	 * @param req HttpServletRequest对象
	 * @param res HttpServletResponse 对象
	 * @throws ServletException 异常处理
	 * @throws IOException 异常处理
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		String uploadPath = this.getServletContext().getRealPath(File.separator); // 上传的文件路径
		String isRename = "";// 是否重命名 true:重命名
		String _tempPath = req.getServletContext().getRealPath(File.separator) + "temp";//存放文件的临时目录路径
		FileUtil.createFolder(_tempPath);
		File tempPath = new File(_tempPath); // 用于存放临时文件的目录

		int maxSize = 1000000; // 允许上传文件大小,最大上传文件，单位：字节 1000000/1024=0.9M
		//String allowedFile = ".jpg,.gif,.png,.zip"; // 允许上传文件
		String deniedFile = ".exe,.com,.cgi,.asp"; // 不允许上传文件

		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		// 允许设置内存中存储数据的门限，单位：字节
		factory.setSizeThreshold(4096);
		// the location for saving data that is larger than getSizeThreshold()
		// 如果文件大小大于SizeThreshold，则保存到临时目录
		factory.setRepository(tempPath);

		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum size before a FileUploadException will be thrown
		
		try {
			List fileItems = upload.parseRequest(req);
			
			Iterator iter = fileItems.iterator();

			// 正则匹配，过滤路径取文件名
			String regExp = ".+\\\\(.+)$";

			// 过滤掉的文件类型
			String[] errorType = deniedFile.split(",");
			Pattern p = Pattern.compile(regExp);
			String outPath = ""; //输出保存后的图片路径
			while (iter.hasNext()) {
				
				FileItem item = (FileItem) iter.next();
				if (item.getFieldName().equals("uploadPath")) {
					 outPath += item.getString(); 
					 uploadPath += outPath;
				} else if (item.getFieldName().equals("isRename")) {
					isRename = item.getString();
				} else if (item.getFieldName().equals("maxSize")) {
					maxSize = Integer.parseInt(item.getString())*1048576;
				} else if (item.getFieldName().equals("allowedFile")) {
//					allowedFile = item.getString();
				} else if (item.getFieldName().equals("deniedFile")) {
					deniedFile = item.getString();
				} else if (!item.isFormField()) { // 忽略其他不是文件域的所有表单信息
					String name = item.getName();
					long size = item.getSize();
					if ((name == null || name.equals("")) && size == 0)
						continue;
					try {
						// 最大上传文件，单位：字节 1000000/1024=0.9M
						upload.setSizeMax(maxSize);
						
						// 保存上传的文件到指定的目录
						// 在下文中上传文件至数据库时，将对这里改写
						String fileName = System.currentTimeMillis() + name.substring(name.indexOf("."));
						String savePath = uploadPath + File.separator;
						FileUtil.createFolder(savePath);
						// 重命名
						if (StringUtil.isBlank(isRename) || Boolean.parseBoolean(isRename)) {
							savePath += fileName;
							outPath += fileName;
						} else {
							savePath += name;
							outPath += name;
						}
						item.write(new File(savePath));
						out.print(outPath.trim());
						logger.debug("upload file ok return path " + outPath);
						out.flush();
						out.close();
					} catch (Exception e) {
						this.logger.debug(e);
					}

				}
			}
		} catch (FileUploadException e) {
			this.logger.debug(e);
		}
	}

//	/**
//	 * 处理get请求上传文件
//	 * @param request HttpServletRequest对象
//	 * @param response HttpServletResponse 对象
//	 * @throws ServletException Servlet异常处理
//	 * @throws IOException IO异常处理
//	 */
//	@Override
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		String uploadPath = request.getParameter("uploadPath"); // 上传的文件路径
//		String fileSize = request.getParameter("fileSize"); // 上传的文件大小
//		String fileType = request.getParameter("fileType"); // 上传的文件类型
//		String deniedFileType = request.getParameter("deniedFileType"); // 不允许上传的文件类型，
//	}
}