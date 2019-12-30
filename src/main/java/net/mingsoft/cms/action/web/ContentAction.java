package net.mingsoft.cms.action.web;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.mingsoft.base.entity.BaseEntity;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.entity.ContentEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
/**
 * 文章管理控制层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Api(value = "文章接口")
@Controller("WebcmsContentAction")
@RequestMapping("/cms/content")
public class ContentAction extends net.mingsoft.cms.action.BaseAction{
	
	
	/**
	 * 注入文章业务层
	 */	
	@Autowired
	private IContentBiz contentBiz;

	/**
	 * 查询文章列表
	 * @param content 文章实体
	 */
	@ApiOperation(value = "查询文章列表接口")
	@ApiImplicitParams({
    	@ApiImplicitParam(name = "contentTitle", value = "文章标题", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentCategoryId", value = "所属栏目", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentType", value = "文章类型", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentDisplay", value = "是否显示", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentAuthor", value = "文章作者", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentSource", value = "文章来源", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentDatetime", value = "发布时间", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentSort", value = "自定义顺序", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentImg", value = "文章缩略图", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentDescription", value = "描述", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentKeyword", value = "关键字", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentDetails", value = "文章内容", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentUrl", value = "文章跳转链接地址", required =false,paramType="query"),
    	@ApiImplicitParam(name = "appid", value = "文章管理的应用id", required =false,paramType="query"),
    	@ApiImplicitParam(name = "createBy", value = "创建人", required =false,paramType="query"),
    	@ApiImplicitParam(name = "createDate", value = "创建时间", required =false,paramType="query"),
    	@ApiImplicitParam(name = "updateBy", value = "修改人", required =false,paramType="query"),
    	@ApiImplicitParam(name = "updateDate", value = "修改时间", required =false,paramType="query"),
    	@ApiImplicitParam(name = "del", value = "删除标记", required =false,paramType="query"),
    	@ApiImplicitParam(name = "id", value = "编号", required =false,paramType="query"),
    })
	@RequestMapping("/list")
	@ResponseBody
	public ResultData list(@ModelAttribute @ApiIgnore ContentEntity content,HttpServletResponse response, HttpServletRequest request,@ApiIgnore ModelMap model,BindingResult result) {
		BasicUtil.startPage();
		List contentList = contentBiz.query(content);
		return ResultData.build().success(new EUListBean(contentList,(int)BasicUtil.endPage(contentList).getTotal()));
	}
	

	/**
	 * 获取文章
	 * @param content 文章实体
	 */
	@ApiOperation(value = "获取文章列表接口")
    @ApiImplicitParam(name = "id", value = "编号", required =true,paramType="query")
	@GetMapping("/get")
	@ResponseBody
	public ResultData get(@ModelAttribute @ApiIgnore ContentEntity content,HttpServletResponse response, HttpServletRequest request,@ApiIgnore ModelMap model){
		if(content.getId()==null) {
			return ResultData.build().error();
		}
		ContentEntity _content = (ContentEntity)contentBiz.getEntity(Integer.parseInt(content.getId()));
		return ResultData.build().success(_content);
	}

	@ApiOperation(value = "查看文章点击数")
	@ApiImplicitParam(name = "contentId", value = "文章编号", required = true,paramType="path")
	@GetMapping(value = "/{contentId}/hit")
	@ResponseBody
	public void hit(@PathVariable @ApiIgnore int contentId, HttpServletRequest request, HttpServletResponse response){
	 	if(contentId<=0){
			this.outString(response, "document.write(0)");
			return;
		}
		ContentEntity content = (ContentEntity)contentBiz.getEntity(contentId);
	 	if(content == null){
			this.outString(response, "document.write(0)");
			return;
		}
		if(content.getAppId() == null || content.getAppId() != BasicUtil.getAppId()){
			this.outString(response, "document.write(0)");
			return;
		}
		this.outString(response, "document.write(" + content.getContentHit() + ")");
		return;
	}

}