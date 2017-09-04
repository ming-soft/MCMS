package com.mingsoft.cms.action;


import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.biz.IColumnBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.constant.Const;
import com.mingsoft.basic.constant.ModelCode;
import com.mingsoft.basic.constant.e.SessionConstEnum;
import com.mingsoft.basic.entity.CategoryEntity;
import com.mingsoft.basic.entity.ColumnEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.StringUtil;

import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;



/**
 * 铭飞MS平台，通用栏目分类,为了区分文章栏目与其他栏目的权限，该类是从basic模块复制过来
 * @author 铭飞开发团队
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2017年8月9日<br/>
 * 历史修订：<br/>
 */
@Controller("articleColumnAction")
@RequestMapping("/${managerPath}/cms/column")
public class ColumnAction extends BaseAction{
	
	
	/**
	 * 栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;
	@Autowired
	private ICategoryBiz categoryBiz;
	
	/**
	 * 模块业务层注入
	 */
	@Autowired
	private IModelBiz modelBiz;
	/**
	 * 返回主界面index
	 */
	@RequestMapping("/index")
	@RequiresPermissions("cms:column:view")
	public String index(HttpServletResponse response,HttpServletRequest request){
		return view ("/column/index");
	}
	/**
	 * 栏目添加跳转页面
	 * 
	 * @return
	 */
	@RequestMapping("/add")
	public String add(HttpServletRequest request,ModelMap model) {
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConstEnum.MANAGER_SESSION);
		// 站点ID
		int appId =this.getAppId(request);
		List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request));
		ColumnEntity columnSuper = new ColumnEntity();
		model.addAttribute("appId",appId);
		model.addAttribute("columnSuper", columnSuper);
		model.addAttribute("column",new ColumnEntity());
		model.addAttribute("listColumn", JSONArray.toJSONString(list));
		return view("/column/form");
	}

	/**
	 * 后台验证填写的栏目信息是否合法
	 * @param column  栏目信息
	 * @param response
	 * @return false:不合法 true:合法
	 */
	private boolean checkForm(ColumnEntity column, HttpServletResponse response){
		//栏目标题空值验证
		if(StringUtil.isBlank(column.getCategoryTitle())){
			this.outJson( response, ModelCode.COLUMN, false, getResString("err.empty", this.getResString("categoryTitle")));
			return false;
		}
		//栏目标题长度验证
		if(!StringUtil.checkLength(column.getCategoryTitle(), 1, 31)){
			this.outJson( response, ModelCode.COLUMN, false, getResString("err.length", this.getResString("categoryTitle"), "1", "30"));
			return false;
		}
		//栏目属性空值验证
		if(StringUtil.isBlank(column.getColumnType())){
			this.outJson( response, ModelCode.COLUMN, false, getResString("err.empty", this.getResString("columnType")));
			return false;
		}
		//栏目描述处理
		if(StringUtil.checkLength(column.getColumnDescrip(), 0, 500)){
			column.setColumnDescrip(StringUtil.subString(column.getColumnDescrip(), 500));
		}
		//栏目简介处理
		if(StringUtil.checkLength(column.getColumnKeyword(), 0, 500)){
			column.setColumnKeyword(StringUtil.subString(column.getColumnKeyword(), 500));
		}
		return true;
	}

	/**
	 * 组织栏目链接地址
	 * @param request
	 * @param column 栏目实体
	 */
	private void columnPath(HttpServletRequest request,ColumnEntity column){
		String columnPath = "";
		String file = this.getRealPath(request,null)+IParserRegexConstant.HTML_SAVE_PATH+File.separator+ column.getAppId();
		String delFile = "";
		//修改栏目路径时，删除已存在的文件夹
		column = (ColumnEntity) columnBiz.getEntity(column.getCategoryId());
		delFile = file + column.getColumnPath();
		if(!StringUtil.isBlank(delFile)){
			File delFileName = new File(delFile);
			delFileName.delete();
		}
		//若为顶级栏目，则路径为：/+栏目ID
		if(column.getCategoryCategoryId() == 0){
			column.setColumnPath(File.separator+column.getCategoryId());
			file = file + File.separator + column.getCategoryId();
		} else {
			List<ColumnEntity> list = columnBiz.queryParentColumnByColumnId(column.getCategoryId());
			if(!StringUtil.isBlank(list)){
				String temp = "";
				for(int i = list.size()-1; i>=0; i--){
					ColumnEntity entity = list.get(i);
					columnPath = columnPath + File.separator + entity.getCategoryId();
					temp = temp + File.separator + entity.getCategoryId();
				}
				column.setColumnPath(columnPath + File.separator + column.getCategoryId());
				file = file + temp + File.separator + column.getCategoryId();
			}
		}
		columnBiz.updateEntity(column);
		//生成文件夹
		File fileName = new File(file);
        fileName.mkdir();
	}
	
	/**
	 * @param column 栏目表实体
	 * <i>column参数包含字段信息参考：</i><br/>
	 * columnCategoryid:多个columnCategoryid直接用逗号隔开,例如columnCategoryid=1,2,3,4
	 * 批量删除栏目表
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            <dd>{code:"错误编码",<br/>
	 *            result:"true｜false",<br/>
	 *            resultMsg:"错误信息"<br/>
	 *            }</dd>
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(HttpServletResponse response, HttpServletRequest request) {
		int[] ids = BasicUtil.getInts("ids", ",");
		for(int i=0;i<ids.length;i++){
			columnBiz.deleteCategory(ids[i]);
		}
		this.outJson(response, true);
	}
		
	/**
	 * 栏目更新页面跳转
	 * @param columnId 栏目ID
	 * @param request
	 * @param model
	 * @return 编辑栏目页
	 */
	@RequestMapping("/{columnId}/edit")
	public String edit(@PathVariable int columnId, HttpServletRequest request,ModelMap model) {
		// 获取管理实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConstEnum.MANAGER_SESSION);
		// 站点ID
		int appId = this.getAppId(request);
		List<ColumnEntity> list = new ArrayList<ColumnEntity>();
		// 判断管理员权限,查询其管理的栏目集合
		list = columnBiz.queryAll(appId, this.getModelCodeId(request));
		//查询当前栏目实体
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(columnId);
		model.addAttribute("appId",appId);
		model.addAttribute("column", column);
		model.addAttribute("columnc", column.getCategoryId());
		ColumnEntity columnSuper = new ColumnEntity();
		// 获取父栏目对象
		if (column.getCategoryCategoryId() != Const.COLUMN_TOP_CATEGORY_ID) {
			columnSuper = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
		}
		model.addAttribute("columnSuper", columnSuper);
		model.addAttribute("listColumn", JSONArray.toJSONString(list));
		return view("/column/form");
	}
	
	/**
	 * 栏目首页面列表显示
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping("/list")
	public void list(@ModelAttribute ColumnEntity column,HttpServletResponse response, HttpServletRequest request,ModelMap model) {

		// 站点ID有session获取
		int websiteId = this.getAppId(request);
		// 需要打开的栏目节点树的栏目ID
		List list = columnBiz.queryAll(websiteId, this.getModelCodeId(request));
		EUListBean _list = new EUListBean(list, list.size());
		this.outJson(response, net.mingsoft.base.util.JSONArray.toJSONString(_list));
	}
	
	/**
	 * 栏目添加
	 * 
	 * @param column
	 *            栏目对象
	 * @return 返回页面跳转
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute ColumnEntity column,HttpServletRequest request,HttpServletResponse response) {
		if(!checkForm(column,response)){
			return;
		}
		column.setCategoryAppId( this.getAppId(request));
		column.setAppId(BasicUtil.getAppId());
		column.setCategoryManagerId(getManagerBySession(request).getManagerId());
		column.setCategoryDateTime(new Timestamp(System.currentTimeMillis()));
		column.setCategoryModelId(this.getModelCodeId(request));
		if(column.getColumnType()==ColumnEntity.ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()){
			column.setColumnListUrl(null);
		}
		columnBiz.saveCategory(column);
		this.columnPath(request,column);
		this.outJson(response, ModelCode.COLUMN, true,null,JSONArray.toJSONString(column.getCategoryId()));
	}
	
	/**
	 * 更新栏目
	 * @param column 栏目实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute ColumnEntity column,HttpServletRequest request,HttpServletResponse response) {
		//获取站点ID
		int websiteId = this.getAppId(request);
		//检测栏目信息是否合法
		if(!checkForm(column,response)){
			return;
		}
		//若栏目管理属性为单页，则栏目的列表模板地址设为Null
		if(column.getColumnType()==ColumnEntity.ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()){
			column.setColumnListUrl(null);
		}
		column.setCategoryManagerId(getManagerBySession(request).getManagerId());
		column.setAppId(websiteId);
		columnBiz.updateCategory(column);
		this.columnPath(request,column);
		//查询当前栏目是否有子栏目，
		List<ColumnEntity> childList = columnBiz.queryChild(column.getCategoryId(), websiteId,this.getModelCodeId(request),null);
		if(childList != null && childList.size()>0){
			//改变子栏目的顶级栏目ID为当前栏目的父级栏目ID
			for(int i=0;i<childList.size();i++){
				childList.get(i).setCategoryCategoryId(column.getCategoryId());
				childList.get(i).setCategoryManagerId(getManagerBySession(request).getManagerId());
				childList.get(i).setAppId(websiteId);
				columnBiz.updateCategory(childList.get(i));
				//组织子栏目链接地址
				this.columnPath(request, childList.get(i));
			}
		}
		this.outJson(response, ModelCode.COLUMN, true,null,JSONArray.toJSONString(column.getCategoryId()));
	}
}
