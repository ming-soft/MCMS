<!DOCTYPE html>
<html lang="zh">
<head>
<title><#if app?has_content>${app.basicTitle}<#else>MS</#if>管理系统</title>
<link rel="bookmark" href="favicon.ico"/> 
<#include "${managerViewPath}/include/macro.ftl"/>
<#include "${managerViewPath}/include/meta.ftl"/>
<script src="http://cdn.mingsoft.net/model/4.6.0/ms.mstore.client.min.js"></script>
</head>
<script type="text/javascript">
    $(function(){
        var menuJson=${modelList};
        $('.dropdown-toggle').dropdown();
        //加载头部菜单
        manager.topMenu.initMenu(menuJson);
        //点击头部菜单从左侧显示当前菜单子菜单
        $(".ms-menu-list").delegate(".ms-menu-detail","click",function(){
            manager.topMenu.showChildMenu($(this),menuJson);
        });
        
        //获取管理员帐号
		$("#editLoginPassword").click(function() {
			$.ajax({
				type: "post",
				dataType: "json",
				url:  "${managerPath}/editPassword.do",
				success: function(msg){
					var json =JSON.parse(msg.resultMsg);
					$(".editLoginPassword input[name='managerName']").val(json);
					//$(".editLoginPassword").modal();
				}
			});
		});
		
		
		//修改密码
		$("#editLoginPasswordButton").click(function() {		
			var vobj = $("#updatePasswordFrom").data('bootstrapValidator').validate();
			if(vobj.isValid()){
				$(this).postForm("#updatePasswordFrom",{func:function(data) {
					if(data.result){
						alert("密码修改成功!");
						location.reload();
					}else{
						alert(data.resultMsg);
					}
		 			
				}});	
			} else {
				alert("表单验证失败");
			}	
			
		});
		
		 //退出系统
		$("#loginOutBtn").click(function() {	
			//$(this).request({func:function(data) {
		 	//		location.reload();
			//}});
			window.location.href="${managerPath}/logout"		
		});
	
		$(".ms-menu-child li a").each(function() {
			var tag = "?";
			if ($(this).data("url").indexOf("?") > 0) {
				tag="&";
			}
			$(this).data("url", "${managerPath}/"+$(this).data("url")+tag+"modelId="+$(this).data("id")+"&modelTitle="+encodeURI($(this).data("title")));
		});
    });
</script>

<body class="over-hide theme-index" >
    <!--顶部开始 -->
    <div class="ms-top">
        <!--头部LOGO-->
        <div class="ms-top-logo">
            <img src="${skin_manager_logo}"/>
            <!--span class="slideMenu">
                <span class="icon iconfont icon-open">&#xe823;</span>
                <span class="icon iconfont icon-close" style="display: none;">&#xe80d;</span>
            </span-->
        </div>
        
        <!--头部一级菜单-->
        <div class="ms-top-menu">
            <div class="menu-default">
            	<#noparse>
                <script id="ms-menu-list-tmpl" type="text/x-jquery-tmpl">
                {{if modelModelId==0}}
                    <li data-model-id="${modelId}" data-model-icon="${modelIcon}" class="ms-menu-detail">${modelTitle}</li>
                {{/if}}
                </script>
                </#noparse>
                <ul class="ms-menu-list">

                </ul>
                <span class="glyphicon glyphicon-menu-hamburger openMenu"></span>
            </div>
        </div>
        <!--头部用户信息/进入MStore-->
        <div class="ms-top-user">
            <div class="dropdown">
                <div id="dLabel" class="ms-top-info" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="glyphicon glyphicon-user"></span>
                    ${Session.manager_session.managerName}
                    <span class="caret"></span>
                </div>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                	<li role="presentation" data-toggle="modal" data-target="#editLoginPassword">
                    	<a role="menuitem" tabindex="-1"><span class="glyphicon glyphicon-cog"></span> 修改密码</a>
                    </li>
                	<li role="presentation" data-toggle="modal" data-target="#loginOut">
                    	<a role="menuitem" tabindex="-1"><span class="glyphicon glyphicon-off"></span> 退出</a>
                    </li>
                </ul>
            </div>

            <div class="ms-top-mstore" data-toggle="tooltip" data-placement="bottom" title="点击进入Mstore">
                <span class="glyphicon glyphicon-th-large animated"></span>
                <span class="mstore-update"></span>
            </div>
        </div>
    </div>

	<#noparse>
    <script id="ms-menu-tmpl" type="text/x-jquery-tmpl">
    {{if modelModelId==0}}
        <div class="ms-menu-parent" data-model-id="${modelId}">
            <div class="ms-menu-parent-header ms-menu-parent-active">
                <div class="ms-menu-parent-title" data-flag="true">
                    <i class="icon iconfont icon-logo">${modelIcon}</i>
                    ${modelTitle}    
                </div>
                <span class="closeMenu">×</span>
            </div>
            <ul class="ms-menu-child child-list${modelId}" id="tab-tools">
            </ul>
        </div>
    {{/if}}
    </script>
    <script id="ms-menu-child-tmpl" type="text/x-jquery-tmpl">
        <li><a style="cursor: pointer;"  data-title='${modelTitle}' data-url='${modelUrl}' data-id='${modelId}'><!--span class="caret"></span-->${modelTitle}</a></li>
    </script>
    </#noparse>
    
    <!--左边菜单开始-->
	<div class="ms-menu-div">
        <div class="slideMenu">
            <span class="icon iconfont icon-open">&#xe823;</span>
            <span class="icon iconfont icon-close" style="display: none;">&#xe80d;</span>
        </div>
    </div>
    <div class="ms-menu">
        <div class="ms-menu-none"></div>
        <!--span class="slideMenu glyphicon glyphicon-tasks"></span-->
    </div>
    <!--左边菜单结束-->

    <!--右边开始-->
    <div class="ms-content">
        <div class="wellcome">
            <h2>欢迎进入MS系统</h2>
            <p>欢迎加群： 221335098 或到
                <a href="http://ms.mingsoft.net/mbbs/main.do" target="_blank" style="text-decoration: none;">官方论坛进行技术交流</a>
            </p>
        </div>
        <div class="easyui-tabs">
        
        </div>
        
    </div>
    <!--右边结束-->
    
    <!--修改登录密码模态框-->
	<@ms.modal id="editLoginPassword" title="修改密码">
		  <@ms.modalBody>
		  		<@ms.form  isvalidation=true name="updatePasswordFrom"  action="${managerPath}/updatePassword.do">
		    		<@ms.text name="managerName" width="280" label="账号:" title="managerName" value="" readonly="readonly" validation={"required":"true", "data-bv-notempty-message":"必填项目"} />
		    		<@ms.password width="280" name="oldManagerPassword" label="旧密码:" title="managerPassword" validation={"required":"true","minlength":"6","maxlength":"20","data-bv-notempty-message":"必填项目","data-bv-stringlength-message":"6-20个字符以内!"}/>
		    		<@ms.password width="280" name="newManagerPassword" label="新密码:" title="managerPassword" validation={"required":"true", "minlength":"6","maxlength":"20", "data-bv-notempty-message":"必填项目","data-bv-stringlength-message":"6-20个字符以内!"}/>
		    	</@ms.form>	
	     </@ms.modalBody>
		 <@ms.modalButton>
		 	<@ms.savebutton value="更新密码" id="editLoginPasswordButton"/>
		 </@ms.modalButton>
	</@ms.modal>
	
	<@ms.modal id="loginOut" title="退出提示!">
		  <@ms.modalBody>
		  		确认退出？
	     </@ms.modalBody>
		 <@ms.modalButton>
		 	<@ms.button value="确认退出" id="loginOutBtn" url="${managerPath}/loginOut.do"/>
		 </@ms.modalButton>
	</@ms.modal>
</body>
</html>