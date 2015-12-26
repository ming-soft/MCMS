package com.mingsoft.cms.action;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 * 
 * <p>
 * Comments:获取有关模版文件夹或模版文件信息
 * </p>
 * 
 * <p>
 * Create Date:2014-8-12
 * </p>
 * 
 * <p>
 * Modification history:
 * </p>
 */
@Controller
@RequestMapping("/manager/cms/templet")
public class TempletsAction extends BaseAction {
	
	/**
	 * 站点业务层
	 */
	@Autowired
	private IAppBiz appBiz;

	/**
	 * 模版列表分页路径
	 */
	private final static String SKINLIST_PAGE_URL = "/manager/cms/templet/queryTempletSkin.do";
	
	/**
	 * 查询模版风格供站点选择
	 * @param model
	 * @param request 请求
	 * @return 模版文件集合
	 */
	@RequestMapping("/queryAppTempletSkin")
	@ResponseBody
	public Map queryAppTempletSkin(HttpServletRequest request){
		List<String> folderNameList = (List<String>) this.queryTempletsFile( request);
		Map map = new HashMap();
		if(!StringUtil.isBlank(folderNameList)){
			map.put("fileName", folderNameList);
		}
		return map;
	}
	
	/**
	 * 查询模版文件供栏目选择
	 * @param request 请求
	 * @return 返回列表集合
	 */
	@RequestMapping("/queryTempletFileForColumn")
	@ResponseBody
	public List<String> queryTempletFileForColumn(HttpServletRequest request){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		String path = this.getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE)+File.separator  + managerSession.getBasicId();
		int websiteId = managerSession.getBasicId();
		AppEntity website = (AppEntity) appBiz.getEntity(websiteId);
		path =path+File.separator+website.getAppStyle();
		LOG.debug("tempPath:"+ path);
		List<String>  listName= new ArrayList<String>();
		File fileDir=new File(path);
		if(fileDir.isDirectory()){
			File files[]=fileDir.listFiles();
			   for(int i=0;i<files.length;i++){
				   File currFile=files[i];
				   if(currFile.isFile()){
					   String ex = currFile.getName().substring(currFile.getName().indexOf(".") + 1);
					   if(ex.equals("htm") || ex.equals("html")){
						   listName.add(currFile.getName());
					   }
				   } else if(currFile.isDirectory()) {
						File _files[]=currFile.listFiles();
						   for(int k=0;k<_files.length;k++){
							   File _currFile=_files[k];
							   if(_currFile.isFile()){
								   String ex = _currFile.getName().substring(_currFile.getName().indexOf(".") + 1);
								   if(ex.equals("htm") || ex.equals("html")){
									   listName.add(currFile.getName()+File.separator+_currFile.getName());
								   }
							   } 
						 }					   
				   }
			 }
		 }
		return listName;
	}
	
	/**
	 * 点击模版管理，获取所有的模版文件名
	 * @param response 响应
	 * @param model
	 * @param request 请求
	 * @return 返回模版文件名集合
	 */
	@RequestMapping("/queryTempletSkin")
	protected String queryTempletSkin(HttpServletResponse response, ModelMap model, HttpServletRequest request) {
		String pageNo = request.getParameter("pageNo");
		if (!StringUtil.isInteger(pageNo)) {
			pageNo = "1";
		}
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List<String> folderNameList = this.queryTempletsFile( request);
		model.addAttribute("folderNameList", folderNameList);
		model.addAttribute("websiteId",  managerSession.getBasicId());
		int recordCount = 0;
		if(!StringUtil.isBlank(folderNameList)){
			recordCount = folderNameList.size();
		} 
		PageUtil page = new PageUtil(StringUtil.string2Int(pageNo),recordCount, getUrl(request) + SKINLIST_PAGE_URL);
		this.setCookie(request, response, CookieConst.PAGENO_COOKIE, pageNo);
		model.addAttribute("page", page);
		return "/manager/cms/templets/templets_list";
	}
	
	/**
	 * 解压zip模版文件 
	 * @param fileUrl 文件路径
	 * @throws ZipException
	 * @throws IOException
	 */
	@RequestMapping("/unZip")
	@ResponseBody
	public String unZip(ModelMap model, HttpServletRequest request) throws ZipException, IOException {
		String entryName = "";
		String fileUrl = request.getParameter("fileUrl");
		// 创建文件对象
		File file = new File(this.getRealPath(request, fileUrl));
		// 创建zip文件对象
		ZipFile zipFile = new ZipFile(file);
		// 创建本zip文件解压目录
		File unzipFile = new File(this.getRealPath(request, fileUrl.substring( 0, fileUrl.length() - file.getName().length())));
		// 得到zip文件条目枚举对象
		Enumeration<? extends ZipEntry> zipEnum = zipFile.entries();
		// 定义输入输出流对象
		// 循环读取条目
		while (zipEnum.hasMoreElements()) {
			// 得到当前条目
			ZipEntry entry = (ZipEntry) zipEnum.nextElement();
			entryName = new String(entry.getName().getBytes("utf-8"));
			// 若当前条目为目录则创建
			if (entry.isDirectory()) {
				new File(unzipFile.getAbsolutePath() + File.separator + entryName).mkdirs();
			} else {
				// 若当前条目为文件则解压到相应目录
				InputStream input = zipFile.getInputStream(entry);
				OutputStream output = new FileOutputStream(new File( unzipFile.getAbsolutePath() + File.separator + entryName));
				byte[] buffer = new byte[1024 * 8];
				int readLen = 0;
				while ((readLen = input.read(buffer, 0, 1024 * 8)) != -1) {
					output.write(buffer, 0, readLen);
				}
				output.flush();
				output.close();
				input.close();
				input =null;
				output = null;
			}
		}
		zipFile.close();
		return entryName;
	}
	

	/**
	 * 删除模版 
	 * @param name 模版名称
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/{websiteId}/{name}/delete")
	@ResponseBody
	public boolean delete(@PathVariable int websiteId, @PathVariable String name, HttpServletRequest request) {
		String path = this.getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + websiteId + File.separator + name + File.separator);
		try {
			FileUtil.delFolders(path);
			FileUtil.delFile(path);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}

	/**
	 * 获取模版路径
	 * @param request 请求
	 * @param fileNameUrl 文件路径
	 * @return 返回路径
	 */
	private String getTempletsUrl( HttpServletRequest request, String fileNameUrl){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		String templetsUrl = this.getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + managerSession.getBasicId() + File.separator + fileNameUrl);
		return templetsUrl;
	}
	
	/**
	 * 显示子文件和子文件夹
	 * @param response 响应
	 * @param model 
	 * @param request 请求
	 * @return 返回文件名集合
	 */
	@RequestMapping("/showChildFileAndFolder")
	public String showChildFileAndFolder(HttpServletResponse response, ModelMap model, HttpServletRequest request){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List<String> folderNameList = null;
		String skinFolderName = request.getParameter("skinFolderName");
		String templetsUrl = this.getTempletsUrl(request, skinFolderName);
		File files[] = new File(templetsUrl).listFiles();
		if(!StringUtil.isBlank(files)){
			folderNameList = new ArrayList<String>();
			List<String> fileNameList = new ArrayList<String>();
			for (int i = 0; i < files.length; i++) {
				File currFile = files[i];
				if(currFile.isDirectory()){
					folderNameList.add(currFile.toString().substring(currFile.toString().indexOf(skinFolderName)));
				}else {
					fileNameList.add(currFile.toString().substring(currFile.toString().indexOf(skinFolderName)));
				}			
			}
			folderNameList.addAll(fileNameList);
			model.addAttribute("fileNameList", folderNameList);
		}
		String uploadFileUrl = managerSession.getBasicId() + File.separator +  skinFolderName;
		uploadFileUrl = uploadFileUrl.replace(File.separator  + File.separator  ,  File.separator );
		model.addAttribute("uploadFileUrl", uploadFileUrl);
		return "/manager/cms/templets/templets_file_list";
	}
	
	/**
	 * 读取模版文件内容
	 * @param model
	 * @param request 请求
	 * @return 返回文件内容
	 */
	@RequestMapping("/readFileContent")
	public String readFileContent(ModelMap model, HttpServletRequest request){
		String fileName = request.getParameter("fileName");
		if (!StringUtil.isBlank(fileName)) {
			String templets = this.getTempletsUrl(request, fileName);
			model.addAttribute("fileContent",  FileUtil.readFile(templets));
		}
		model.addAttribute("fileName",  fileName.substring(fileName.lastIndexOf(File.separator)+1));
		model.addAttribute("fileNamePrefix",  fileName.substring(0,fileName.lastIndexOf(File.separator)+1));
		return "/manager/cms/templets/templets_edit_file";
	}
	
	/**
	 * 删除模版文件
	 * @param styleName 文件名称
	 * @param request 请求
	 */
	@RequestMapping("/deleteTempletsFile")
	@ResponseBody
	public int deleteTempletsFile(HttpServletRequest request) {
		int pageNo = 1;
		ManagerSessionEntity managerSession = getManagerBySession(request);
		String fileName = request.getParameter("fileName");
		FileUtil.delFile(this.getRealPath(request,IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + managerSession.getBasicId() + File.separator + fileName));
		// 判断当前页码
		this.getHistoryPageNoByCookie(request);
		return pageNo;
	}
	
	/**
	 * 写入模版文件内容 
	 * @param model
	 * @param request 请求
	 * @param response 响应
	 * @throws IOException
	 */
	@RequestMapping("/writeFileContent")
	public void writeFileContent(ModelMap model, HttpServletRequest request,HttpServletResponse response) throws IOException {
		String fileName = request.getParameter("fileName");
		String oldFileName = request.getParameter("oldFileName");		
		String fileContent = request.getParameter("fileContent");
		String fileNamePrefix = request.getParameter("fileNamePrefix");
		ManagerSessionEntity managerSession = getManagerBySession(request);
		if (!StringUtil.isBlank(fileName)) {
			// 文件路径
			String templets = this.getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + managerSession.getBasicId() + File.separator + fileNamePrefix + fileName);
			FileUtil.writeFile(fileContent, templets, "utf-8");
			if(!fileName.equals(oldFileName)){
				//得到一个待命名文件对象  
	            File newName = new File(templets);  
	            //获取新名称文件的文件对象  
	            File oldName = new File(this.getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + managerSession.getBasicId() + File.separator + fileNamePrefix + oldFileName));  
	            //进行重命名  
	            oldName.renameTo(newName); 
	            FileUtil.delFile(fileNamePrefix+oldFileName);
			}
            this.outJson(response, ModelCode.ROLE, true, null);
		}
	}


	/**
	 * 查询模版文件集合
	 * @param request 请求
	 * @return 模版文件集合
	 */
	private List<String> queryTempletsFile(HttpServletRequest request){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List<String> folderNameList = null;
		if (!isSystemManager(request)) {
			String templets = this.getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + managerSession.getBasicId() + File.separator);
			File file = new File(templets);
			String[] str = file.list();
			if (!StringUtil.isBlank(str)) {
				folderNameList = new ArrayList<String>();
				for (int i = 0; i < str.length; i++) {
					// 避免不为文件夹的文件显示
					if (str[i].indexOf(".") < 0) {
						folderNameList.add(str[i]);
					}
				}
			} 
		}
		return folderNameList;
	}

}
