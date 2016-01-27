<@ms.html5>
	<@ms.nav title="自定义模型管理"></@ms.nav>
	<@ms.panel>
		<@ms.panelNav>
			<@ms.panelNavBtnGroup>
				<@ms.addButton openModal="contentModelField" openModalBefor="resetForm"/>
				<@ms.delButton fieldName="fieldId" onclick="deleteForm"/>
			</@ms.panelNavBtnGroup>
		</@ms.panelNav>
		<@ms.table head=['描述,100','字段名,100',"类型,100","允许空,60","支持搜索,80","默认值"] checkbox="fieldId">
			<#if contentModelFieldList?has_content>
				<#list contentModelFieldList as item>
					<tr>
					<td><input type="checkbox" name="fieldId" value="${item.fieldId}"/></td>
					<td>${item.fieldTipsName}</td>
					<td><a href="javascript:editContentModelField('${item.fieldId}')" data-toggle="tooltip"  data-original-title="编辑字段">${item.fieldFieldName}</a></td>
					<td>${item.fieldTypeString?default('')}</td>
					<td class="text-center">
					<#if item.fieldIsNull=0>
					必填
					<#elseif item.fieldIsNull==1>
					可选
					</#if>
					</td>
					<td class="text-center">
					<#if item.fieldIsSearch=0>
					否
					<#elseif item.fieldIsSearch==1>
					是
					</#if>				
					</td>
					<td>${item.fieldDefault?default("")}</td>
					</tr>
				</#list>
			<#else>
				<tr><td colspan="8"><@ms.nodata/></td></tr>
			</#if>
		</@ms.table> 
		
	</@ms.panel>
</@ms.html5>	
<@ms.modal modalName="contentModelField" title="字段设置">
	<@ms.modalBody height="400">
		<@ms.form isvalidation=true  name="fieldForm" action="${base}/manager/contentModel/contentModelField/save.do" redirect="${base}/manager/contentModel/contentModelField/${contentModelId}/list.do">
			<@ms.hidden name="fieldCmid" value="${contentModelId}"  />
			<@ms.hidden name="fieldId" value="0"  />
			<@ms.text label="提示文字" maxlength="10" value="" placeholder="请输入提示文字" name="fieldTipsName" validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符"} />
			<@ms.text label="字段名" maxlength="10" value=""  placeholder="请输入字段名称" name="fieldFieldName"  
			validation={"required":"true", "data-bv-regexp":"true","data-bv-regexp-regexp":"^[a-zA-Z]+$","data-bv-regexp-message":"只能是字母组成","data-bv-notempty-message":"名称不能为空且只能由字母组成！","data-bv-stringlength":"true","data-bv-stringlength-max":"10","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-15个字符"}/>			
			<@ms.select label="类型" list=fieldTypes name="fieldType" value="1"/>
			<#--@ms.text label="长度" name="fieldLength" value="0" maxlength="5" validation={"data-bv-regexp":"true","data-bv-regexp-regexp":"^[0-9]+$","data-bv-regexp-message":"只能是整型"}/-->
			<@ms.radio label="必填字段" name="fieldIsNull" list=[{"key":"0","value":"必填"},{"key":"1","value":"可选"}] listKey="key" listValue="value" value="0"/>
			<@ms.radio label="搜索字段" name="fieldIsSearch" list=[{"key":"0","value":"否"},{"key":"1","value":"是"}] listKey="key" listValue="value" value="0"/>
			<@ms.textarea label="默认值" name="fieldDefault"  placeholder="下拉框,多选框等存在多个默认值的必须使用英文逗号隔开" help="日期、html类型无效"/>
		</@ms.form>
     </@ms.modalBody>
     <@ms.modalButton>   		
		<@ms.saveButton  id="saveOrUpdate" postForm="fieldForm"/>  
	 </@ms.modalButton>
</@ms.modal>
	
<script type="text/javascript">	
//删除内容模型
function deleteForm(fieldIds){
		var URL = base+"/manager/contentModel/contentModelField/delete.do"
		$(this).request({url:URL,data:"fieldId=" + fieldIds,type:"json",method:"post",func:function(msg) {
			if (msg) {
				location.reload();
			}
		}});	
}

function editContentModelField(fieldId){
		var URL = base+"/manager/contentModel/contentModelField/"+fieldId+"/edit.do";
		$(this).request({url:URL,type:"json",method:"post",func:function(model) {
			if (model) {
				$("#fieldForm").attr("action","${base}/manager/contentModel/contentModelField/update.do");
				$("#contentModelField input[name='fieldId']").val(model.fieldId);
				$("#contentModelField input[name='fieldTipsName']").val(model.fieldTipsName);
				$("#contentModelField input[name='fieldFieldName']").val(model.fieldFieldName);
				$("#contentModelField select[name='fieldType']").val(model.fieldType);
				
				$("#contentModelField input[name='fieldFieldName']").attr("readonly","readonly");
				$("#contentModelField input[name='fieldLength']").val(model.fieldLength);
				$("#contentModelField input[name='fieldIsNull']").each(function(o) {
					if ($(this).val()==model.fieldIsNull) {
						$(this).attr("checked",true);
					}
				});
				$("#contentModelField input[name='fieldIsSearch']").each(function(o) {
					if ($(this).val()==model.fieldIsSearch) {
						$(this).attr("checked",true);
					}
				});				
				
				$("#contentModelField textarea[name='fieldDefault']").val(model.fieldDefault);
				$("#contentModelField").modal();
			}
		}});
}

function resetForm() {
		$("#contentModelField input[name='fieldId']").val(0);
		$("#contentModelField input[name='fieldFieldName']").removeAttr("readonly");
}

function editContentModel(cmId){
	location.href= base+"/manager/cms/contentModel/"+cmId+"/edit.do";
}
</script>
