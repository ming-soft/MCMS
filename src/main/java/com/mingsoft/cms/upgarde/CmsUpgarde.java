package com.mingsoft.cms.upgarde;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.mingsoft.base.entity.ResultJson;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.biz.IRoleModelBiz;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.basic.entity.RoleModelEntity;
import com.mingsoft.mdiy.action.BaseAction;
import com.mingsoft.util.AESUtil;
import com.mingsoft.util.StringUtil;

import net.mingsoft.base.util.PropertiesUtil;
import net.mingsoft.base.util.SpringUtil;

/**
 * cms4.6.0版本自定义的管理升级包
 * 
 * @author 小伍
 *
 */
public class CmsUpgarde extends BaseAction  {

	
	private static final long serialVersionUID = 7575749647205573895L;
	
	public ResultJson setup() {
		ResultJson result = new ResultJson();
		
		//检查当前系统是拥有代码
	   if(!this.checkModel("com.mingsoft.mdiy.action.DictAction")) {
			result.setResult(false);
			result.setResultMsg("请先使用源码或Maven方式加载模块到系统！");
			return result;
		}

	   //获取当前模块版本号
	    String version = this.getVersion("com/mingsoft/cms","02000000");
	    if(version == null) {
	    	result.setResult(false);
			result.setResultMsg("当前系统模块版本号异常！");
			return result;	
	    }
	    
	    //业务处理代码
	    IModelBiz modelBiz = (IModelBiz) SpringUtil.getBean(IModelBiz.class);
	    IRoleModelBiz roleModelBiz = (IRoleModelBiz) SpringUtil.getBean(IRoleModelBiz.class);
	    ModelEntity modelParent = modelBiz.getEntityByModelCode("20000000");
	    if(modelParent == null){
	    	modelParent = new ModelEntity();
	    	modelParent.setModelTitle("自定义管理");
	    	modelParent.setModelCode("20000000");
	    	modelParent.setModelIcon("&#xe6dd");
	    	modelParent.setModelDatetime(new Timestamp(System.currentTimeMillis()));
	    	modelParent.setModelIsMenu(1);
	    	modelBiz.saveEntity(modelParent);
	    }else{
	    	result.setResult(false);
			result.setResultMsg("当前系统模块版本最新");
			return result;
	    }
	    //自定义页面菜单
	    ModelEntity diyPageModel = modelBiz.getEntityByModelCode("12030100");
	    if(diyPageModel !=null){
	    	diyPageModel.setModelModelId(modelParent.getModelId());
	    	diyPageModel.setModelCode("20010000");
	    	diyPageModel.setModelIsMenu(1);
	    	diyPageModel.setModelParentIds(modelParent.getModelId()+"");
	    	modelBiz.updateEntity(diyPageModel);
	    	int modelId = diyPageModel.getModelId();
	    	String modelParentIds = diyPageModel.getModelParentIds()+","+diyPageModel.getModelId();
	    	//子功能添加
	    	String pageSql = "INSERT INTO model (model_title,model_code,model_modelid,model_url,model_ismenu,model_parent_ids)VALUES('查看','20010001',"+modelId+",'mdiy:page:view',0,'"+modelParentIds+"'),('新增','20010002',"+modelId+",'mdiy:page:save',0,'"+modelParentIds+"'),('修改','20010004',"+modelId+",'mdiy:page:update',0,'"+modelParentIds+"'),('删除','20010003',"+modelId+",'mdiy:page:del',0,'"+modelParentIds+"')";
	    	modelBiz.excuteSql(pageSql);
	    }
	    //自定义表单菜单
	    ModelEntity diyFromModel = modelBiz.getEntityByModelCode("12050000");
	    if(diyFromModel !=null){
	    	diyFromModel.setModelModelId(modelParent.getModelId());
	    	diyFromModel.setModelCode("20020000");
	    	diyFromModel.setModelIsMenu(1);
	    	diyFromModel.setModelParentIds(modelParent.getModelId()+"");
	    	modelBiz.updateEntity(diyFromModel);
	    	int modelId = diyFromModel.getModelId();
	    	String modelParentIds = diyFromModel.getModelParentIds()+","+diyFromModel.getModelId();
	    	//子功能添加
	    	String pageSql = "INSERT INTO model (model_title,model_code,model_modelid,model_url,model_ismenu,model_parent_ids)VALUES('查看','20020001',"+modelId+",'mdiy:form:view',0,'"+modelParentIds+"'),('新增','20020002',"+modelId+",'mdiy:form:save',0,'"+modelParentIds+"'),('修改','20020004',"+modelId+",'mdiy:form:update',0,'"+modelParentIds+"'),('删除','20020003',"+modelId+",'mdiy:form:del',0,'"+modelParentIds+"')";
	    	modelBiz.excuteSql(pageSql);
	    }
	    //自定义模型菜单
	    ModelEntity diyContentModel = modelBiz.getEntityByModelCode("02060000");
	    if(diyContentModel !=null){
	    	diyContentModel.setModelModelId(modelParent.getModelId());
	    	diyContentModel.setModelCode("20030000");
	    	diyContentModel.setModelIsMenu(1);
	    	diyContentModel.setModelParentIds(modelParent.getModelId()+"");
	    	modelBiz.updateEntity(diyContentModel);
	    	int modelId = diyContentModel.getModelId();
	    	String modelParentIds = diyContentModel.getModelParentIds()+","+diyContentModel.getModelId();
	    	//子功能添加
	    	String pageSql = "INSERT INTO model (model_title,model_code,model_modelid,model_url,model_ismenu,model_parent_ids)VALUES('查看','20030001',"+modelId+",'mdiy:content:view',0,'"+modelParentIds+"'),('新增','20030002',"+modelId+",'mdiy:content:save',0,'"+modelParentIds+"'),('修改','20030004',"+modelId+",'mdiy:content:update',0,'"+modelParentIds+"'),('删除','20030003',"+modelId+",'mdiy:content:del',0,'"+modelParentIds+"')";
	    	modelBiz.excuteSql(pageSql);
	    }
	    //自定义搜索菜单
	    ModelEntity diySearchModel = modelBiz.getEntityByModelCode("02050000");
	    if(diySearchModel !=null){
	    	diySearchModel.setModelModelId(modelParent.getModelId());
	    	diySearchModel.setModelCode("20040000");
	    	diySearchModel.setModelIsMenu(1);
	    	diySearchModel.setModelParentIds(modelParent.getModelId()+"");
	    	modelBiz.updateEntity(diySearchModel);
	    	int modelId = diySearchModel.getModelId();
	    	String modelParentIds = diySearchModel.getModelParentIds()+","+diySearchModel.getModelId();
	    	//子功能添加
	    	String pageSql = "INSERT INTO model (model_title,model_code,model_modelid,model_url,model_ismenu,model_parent_ids)VALUES('查看','20040001',"+modelId+",'mdiy:search:view',0,'"+modelParentIds+"'),('新增','20040002',"+modelId+",'mdiy:search:save',0,'"+modelParentIds+"'),('修改','20040004',"+modelId+",'mdiy:search:update',0,'"+modelParentIds+"'),('删除','20040003',"+modelId+",'mdiy:search:del',0,'"+modelParentIds+"')";
	    	modelBiz.excuteSql(pageSql);
	    }
	    //自定义字典菜单
	    ModelEntity diyDictModel = modelBiz.getEntityByModelCode("20050000");
	    if(diyDictModel ==null){
	    	diyDictModel = new ModelEntity();
	    	diyDictModel.setModelTitle("自定义字典");
	    	diyDictModel.setModelModelId(modelParent.getModelId());
	    	diyDictModel.setModelUrl("mdiy/dict/index.do");
	    	diyDictModel.setModelCode("20050000");
	    	diyDictModel.setModelIsMenu(1);
	    	diyDictModel.setModelParentIds(modelParent.getModelId()+"");
	    	modelBiz.saveEntity(diyDictModel);
	    	int modelId = diyDictModel.getModelId();
	    	String modelParentIds = diyDictModel.getModelParentIds()+","+diyDictModel.getModelId();
	    	//子功能添加
	    	String pageSql = "INSERT INTO model (model_title,model_code,model_modelid,model_url,model_ismenu,model_parent_ids)VALUES('查看','20050001',"+modelId+",'mdiy:dict:view',0,'"+modelParentIds+"'),('新增','20050002',"+modelId+",'mdiy:dict:save',0,'"+modelParentIds+"'),('修改','20050004',"+modelId+",'mdiy:dict:update',0,'"+modelParentIds+"'),('删除','20050003',"+modelId+",'mdiy:dict:del',0,'"+modelParentIds+"')";
	    	modelBiz.excuteSql(pageSql);
	    }
	    //角色的权限
		List list = new ArrayList();
		HttpServletRequest request = SpringUtil.getRequest();
		
		//页面菜单权限
		RoleModelEntity roleModePageView = new RoleModelEntity();
		ModelEntity model = modelBiz.getEntityByModelCode("20010001");
		int people = this.getManagerBySession(request).getManagerRoleID();
		roleModePageView.setModelId(model.getModelId());
		roleModePageView.setRoleId(people);
		list.add(roleModePageView);
		//顶级菜单
		RoleModelEntity roleModeParentView = new RoleModelEntity();
		roleModeParentView.setModelId(modelParent.getModelId());
		roleModeParentView.setRoleId(people);
		list.add(roleModeParentView);
		//表单菜单权限
		RoleModelEntity roleModeFormView = new RoleModelEntity();
		model = modelBiz.getEntityByModelCode("20020001");
		roleModeFormView.setModelId(model.getModelId());
		roleModeFormView.setRoleId(people);
		list.add(roleModeFormView);
		//模型菜单权限
		RoleModelEntity roleModeContentView = new RoleModelEntity();
		model = modelBiz.getEntityByModelCode("20030001");
		roleModeContentView.setModelId(model.getModelId());
		roleModeContentView.setRoleId(people);
		list.add(roleModeContentView);
		//搜索菜单权限
		RoleModelEntity roleModeSearchView = new RoleModelEntity();
		model = modelBiz.getEntityByModelCode("20040001");
		roleModeSearchView.setModelId(model.getModelId());
		roleModeSearchView.setRoleId(people);
		list.add(roleModeSearchView);
		//字典菜单权限
		RoleModelEntity roleModeDictView = new RoleModelEntity();
		model = modelBiz.getEntityByModelCode("20050001");
		roleModeDictView.setModelId(model.getModelId());
		roleModeDictView.setRoleId(people);
		list.add(roleModeDictView);
		RoleModelEntity roleModeDict = new RoleModelEntity();
		roleModeDict.setModelId(diyDictModel.getModelId());
		roleModeDict.setRoleId(people);
		list.add(roleModeDict);
		roleModelBiz.saveEntity(list);
		result.setResult(true);
		result.setResultMsg("安装成功");
		return result;
	}
	
	
	private boolean checkModel(String className) {
		try {
			Class cls = Class.forName(className);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	private String getVersion(String pak,String modelCode) {
		try {
			String value = PropertiesUtil.get(pak+"/resources/resources_zh_CN.properties", "version");
			value = AESUtil.decrypt(value, StringUtil.Md5(modelCode).substring(16));
			if(value==null) {
				return null;
			}
			return value;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}

}