package com.mingsoft.cms.action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.base.constant.ModelCode;
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
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments:数据导入控制层，继承BasicAction
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-9-25
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
@Controller
@RequestMapping("/manager/cms/dede")
public class DedeAction extends BaseAction {

	/**
	 * 栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 文章业务层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 数据库连接
	 */
	private Connection conn = null;

	/**
	 * 接收SQL语句执行后的数据
	 */
	private ResultSet rs = null;

	/**
	 * 发送SQL语句
	 */
	private PreparedStatement pstmt = null;

	/**
	 * 跳转至数据导入页面
	 * 
	 * @param model
	 * @param request
	 *            请求
	 * @return 返回页面
	 */
	@RequestMapping("/dede")
	public String dede(ModelMap model, HttpServletRequest request) {
		ManagerSessionEntity managerSession = getManagerBySession(request);
		// 获取本地栏目
		List<ColumnEntity> localColumnList = columnBiz.queryColumnListByWebsiteId(managerSession.getBasicId());
		model.addAttribute("localColumnList", JSONArray.toJSONString(localColumnList));
		return "/manager/cms/dede/dede";
	}

	/**
	 * 链接数据库
	 * 
	 * @param request
	 *            请求
	 */
	@RequestMapping("/connection")
	public void connection(HttpServletRequest request, HttpServletResponse response) {
		String prefixName = request.getParameter("prefixName");
		conn = this.getConnection(request);
		if (conn == null) {
			this.outJson(response, ModelCode.COM_DEDE_DATA_IMPORT, false, this.getResString("err"));
			return;
		}
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List remoteColumnList = new ArrayList();
		// 获取表前缀

		// 获取远程栏目
		String sql = "select id,typename,reid from " + prefixName + "arctype";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				map.put("id", rs.getInt("id"));
				map.put("pId", rs.getInt("reid"));
				map.put("name", rs.getString("typename"));
				remoteColumnList.add(map);
			}
			conn.close();
			this.outJson(response, JSONObject.toJSONString(remoteColumnList));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 开始导入数据
	 * 
	 * @param request
	 */
	@RequestMapping("/importData")
	@ResponseBody
	public void importData(HttpServletRequest request, HttpServletResponse response) {
		
		// 获取表前缀
		String prefixName = request.getParameter("prefixName");
		// 获取选中的的远程和本地栏目ID
		String remoteColumnId = request.getParameter("remoteColumnId");
		String localColumnId = request.getParameter("localColumnId");
		if (StringUtil.isBlank(remoteColumnId) || StringUtil.isBlank(localColumnId)) {
			this.outJson(response, ModelCode.COM_DEDE_DATA_IMPORT, false);
			return;
		}
		
		conn = this.getConnection(request);
		if (conn == null) {
			this.outJson(response, ModelCode.COM_DEDE_DATA_IMPORT, false, this.getResString("err"));
			return;
		}
		ManagerSessionEntity managerSession = getManagerBySession(request);

		try {
			// 获取远程该栏目信息
			String queryColumnSql = "select * from " + prefixName + "arctype where id=" + remoteColumnId;
			pstmt = conn.prepareStatement(queryColumnSql);
			rs = pstmt.executeQuery();
			ColumnEntity column = null;
			String columnContent = "";
			while (rs.next()) {
				column = (ColumnEntity) columnBiz.getEntity(Integer.valueOf(localColumnId));
				column.setCategoryCategoryId(column.getCategoryCategoryId()); // 父栏目ID
				column.setColumnKeyword(rs.getString("keywords")); // 栏目关键字
				column.setColumnDescrip(rs.getString("description")); // 栏目描述
				column.setColumnType(rs.getInt("ispart") + 1); // 栏目类型，本地系统的栏目类型均比远程的大1个数值
				// 获取栏目内容
				columnContent = rs.getString("content");
			}
			// 修改本地栏目信息
			columnBiz.updateCategory(column);
			// 判断栏目是否为封面模板,如果是则取出封面内容
			if (column.getColumnType() == ColumnEntity.COLUMN_TYPE_COVER) {
				ArticleEntity article = new ArticleEntity();
				article.setArticleContent(columnContent);// 文章内容
				article.setBasicTitle(column.getCategoryTitle());// 文章标题
				article.setArticleKeyword(column.getColumnKeyword());// 文章关键字
				article.setBasicThumbnails(column.getColumnDescrip());// 文章描述
				article.setArticleType("");
				article.setBasicAppId(managerSession.getBasicId());
				article.setArticleWebId(managerSession.getBasicId());// 文章所属站点id
				article.setBasicCategoryId(Integer.valueOf(localColumnId)); // 文章所属栏目ID
				article.setColumn(column);
				articleBiz.saveBasic(article);
			} else {
				// 获取远程该栏目下的文章信息
				String queryArticleSql = "select * from " + prefixName + "archives ar left join " + prefixName
						+ "addonarticle ad on ar.id = ad.aid where ar.typeid =" + remoteColumnId;
				pstmt = conn.prepareStatement(queryArticleSql);
				rs = pstmt.executeQuery(); 
				while (rs.next()) {
					ArticleEntity article = new ArticleEntity();
					Long dates = Long.parseLong(rs.getInt("pubdate")+"")*1000;
					Timestamp date  = new Timestamp(dates);					
					article.setArticleAuthor(rs.getString("writer")); // 文章作者
					article.setArticleContent(rs.getString("body")); // 文章内容
					article.setArticleType(rs.getString("flag")); // 文章属性
					article.setArticleSource(rs.getString("source")); // 文章来源
					article.setArticleLinkURL(rs.getString("redirecturl")); // 文章跳转URL
					article.setArticleKeyword(rs.getString("keywords")); // 文章关键词
					article.setArticleFreeOrder(rs.getInt("sortrank")); // 文章自定义排序
					article.setArticleWebId(managerSession.getBasicId()); // 文章站点ID
					article.setBasicTitle(rs.getString("title")); // 文章标题
					article.setBasicThumbnails(rs.getString("litpic")); // 文章缩略图
					article.setBasicHit(rs.getInt("click")); // 文章点击量
					article.setColumn(column);// 文章所属栏目
					article.setBasicDateTime(date); // 文章发布日期
					article.setBasicCategoryId(Integer.valueOf(localColumnId)); // 文章所属栏目ID
					article.setBasicUpdateTime(date); // 文章更新时间
					// 导入远程文章信息
					articleBiz.saveBasic(article);
				}				
			}
			this.outJson(response, ModelCode.COM_DEDE_DATA_IMPORT, true);
			conn.close();
			return;
		} catch (SQLException e) {
			e.printStackTrace();
			this.outJson(response, ModelCode.COM_DEDE_DATA_IMPORT, false, this.getResString("err"));
		}
	}

	private Connection getConnection(HttpServletRequest request) {
		String ipAddress = request.getParameter("ipAddress");
		String port = request.getParameter("port");
		String databaseName = request.getParameter("databaseName");
		String userName = request.getParameter("userName");
		String userPassword = request.getParameter("userPassword");

		try {
			// 加载数据库驱动
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			// 建立链接
			conn = DriverManager.getConnection("jdbc:mysql://" + ipAddress + ":" + port + "/" + databaseName
					+ "?useUnicode=true&characterEncoding=utf8", userName, userPassword);
			return conn;
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 关闭数据库连接
	 */
	@RequestMapping("/close")
	@ResponseBody
	public boolean close() {
		try {
			if (conn != null) {
				conn.close();
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			return false;
		}
	}
}
