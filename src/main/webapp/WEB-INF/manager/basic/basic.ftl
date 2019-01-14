<@ms.html5>
    <@ms.nav title="基础内容更新">
    	<@ms.saveButton postForm="basicForm"/>
    </@ms.nav>
    <@ms.panel>

						<#assign basicTitle="">
						<#assign basicId="0">
						<#assign basicDescription="">
						<#assign action="${managerPath}/basic/save.do">
						<#if basic?has_content>
							<#assign basicTitle="${basic.basicTitle?default('')}">
							<#assign basicDescription="${basic.basicDescription?default('')}">
							<#assign basicId="${basic.basicId}">
							<#assign action="${managerPath}/basic/update.do">
						</#if>    
 						<@ms.form action="${action}" name="basicForm" redirect="${managerPath}/basic/${categoryId?default('0')}/list.do">
								<@ms.hidden  name="basicId" value="${basicId?default('')}"/>
								<@ms.hidden  name="basicCategoryId" value="${categoryId?default('0')}"/>
								<@ms.text label="标题" name="basicTitle" value="${basicTitle?default('')}" size="33" style="width:40%" maxlength="120" />
								<@ms.textarea label="描述" name="basicDescription" value="${basicDescription?default('')}" cols="110" rows="5" maxlength="1000" />
						</@ms.form>
    </@ms.panel>
</@ms.html5>