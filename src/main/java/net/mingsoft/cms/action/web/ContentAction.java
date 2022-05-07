/**
 * The MIT License (MIT)
 * Copyright (c) 2012-2022 铭软科技(mingsoft.net)
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


package net.mingsoft.cms.action.web;

import cn.hutool.core.util.ObjectUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.biz.IHistoryLogBiz;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.cms.entity.HistoryLogEntity;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
/**
 * 文章管理控制层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Api(tags={"前端-内容模块接口"})
@Controller("WebcmsContentAction")
@RequestMapping("/cms/content")
public class ContentAction extends net.mingsoft.cms.action.BaseAction{


	/**
	 * 注入文章业务层
	 */
	@Autowired
	private IContentBiz contentBiz;

	@Autowired
	private IHistoryLogBiz historyLogBiz;

	/**
	 * 查询文章列表接口
	 * @param content 文章
	 * @return
	 */
	@ApiOperation(value = "查询文章列表接口")
	@ApiImplicitParams({
    	@ApiImplicitParam(name = "contentTitle", value = "文章标题", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryId", value = "所属栏目", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentType", value = "文章类型", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentDisplay", value = "是否显示", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentAuthor", value = "文章作者", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentSource", value = "文章来源", required =false,paramType="query"),
    	@ApiImplicitParam(name = "contentDatetime", value = "发布时间", required =false,paramType="query"),
    })
	@PostMapping("/list")
	@ResponseBody
	public ResultData list(@ModelAttribute @ApiIgnore ContentBean content) {
		BasicUtil.startPage();
		List contentList = contentBiz.query(content);
		return ResultData.build().success(new EUListBean(contentList,(int)BasicUtil.endPage(contentList).getTotal()));
	}


	/**
	 * 获取文章列表接口
	 * @param content 文章
	 * @return
	 */
	@ApiOperation(value = "获取文章列表接口")
    @ApiImplicitParam(name = "id", value = "编号", required =true,paramType="query")
	@GetMapping("/get")
	@ResponseBody
	public ResultData get(@ModelAttribute @ApiIgnore ContentEntity content){
		if(content.getId()==null) {
			return ResultData.build().error();
		}
		ContentEntity _content = (ContentEntity)contentBiz.getById(content.getId());;
		return ResultData.build().success(_content);
	}

	/**
	 * 查看文章点击数
	 * @param contentId 文章编号
	 * @return
	 */
	@ApiOperation(value = "查看文章点击数")
	@ApiImplicitParam(name = "contentId", value = "文章编号", required = true,paramType="path")
	@GetMapping(value = "/{contentId}/hit")
	@ResponseBody
	public String hit(@PathVariable @ApiIgnore String contentId) {
		if(StringUtils.isEmpty(contentId)){
			return "document.write(0)";
		}
	 	//获取ip
		String ip = BasicUtil.getIp();
		//获取端口（移动/web..）
		boolean isMobileDevice = BasicUtil.isMobileDevice();

		ContentEntity content = contentBiz.getById(contentId);
		if(content == null){
			return "document.write(0)";
		}
	 	//浏览数+1
		if(ObjectUtil.isNotEmpty(content.getContentHit())){
			content.setContentHit(content.getContentHit()+1);
		}else {
			content.setContentHit(1);
		}
		contentBiz.updateEntity(content);

		// cms_history 增加相应记录
		HistoryLogEntity entity = new HistoryLogEntity();
		entity.setHlIsMobile(isMobileDevice);
		entity.setHlIp(ip);
		entity.setContentId(content.getId());
		entity.setCreateDate(new Date());
		historyLogBiz.saveEntity(entity);

		return "document.write(" + content.getContentHit() + ")";
	}

}
