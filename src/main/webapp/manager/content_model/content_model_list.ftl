<@ms.html5>
	<@ms.nav title="自定义模型管理"></@ms.nav>
	<@ms.panel>
		<@ms.panelNav>
			<@ms.panelNavBtnGroup>
				<@ms.addButton openModal="contentModelModal" openModalBefor="resetForm"/>
				<@ms.delButton fieldName="cmId" onclick="deleteForm"/>
			</@ms.panelNavBtnGroup>
		</@ms.panelNav>
		<@ms.table head=['模型名称,200','模型表名']  checkbox="cmId">
			<#if listContentModel?has_content>
				<#list listContentModel as item>
					<tr>
					<td><input type="checkbox" name="cmId" value="${item.cmId}"/></td>
					<td><a href="javascript:editContentModel('${item.cmId}')" data-toggle="tooltip"  data-original-title="编辑模型">${item.cmTipsName}</a></td>
					<td>
						<a href="${base}/manager/contentModel/contentModelField/${item.cmId}/list.do" data-toggle="tooltip"  data-original-title="查看模型字段">
							${item.cmTableName?split("_")[1]}
						</a>
					</td>
					</tr>
				</#list>
			<#else>
				<tr><td colspan="3"><@ms.nodata/></td></tr>
			</#if>
		</@ms.table> 
		
	</@ms.panel>
</@ms.html5>

<@ms.modal id="contentModelModal" title="模型" >
	<@ms.modalBody>
		<@ms.form  name="contentModelForm" isvalidation=true action="${base}/manager/contentModel/save.do" redirect="${base}/manager/contentModel/list.do">
			<@ms.hidden name="cmId" value="0" />
			<!--模型名称-->
			<@ms.text label="名称" name="cmTipsName" title="名称"   placeholder="请输入模型名称"  validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"10","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-15个字符"}/>
			<!--模型表名-->
			<@ms.text label="表名" name="cmTableName"  title="名称" maxlength="15"  placeholder="表名只能为英文字符"  validation={"required":"true", "data-bv-regexp":"true","data-bv-regexp-regexp":"^[a-zA-Z]+$","data-bv-regexp-message":"表名只能是字母组成","data-bv-notempty-message":"名称不能为空且只能由字母组成！","data-bv-stringlength":"true","data-bv-stringlength-max":"10","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-15个字符"}/>
		</@ms.form>		
	</@ms.modalBody>
	<@ms.modalButton>
		<@ms.saveButton postForm="contentModelForm"/>  
	</@ms.modalButton>
</@ms.modal>
	
<script type="text/javascript">	
//删除内容模型
function deleteForm(cmId){
		var URL = base+"/manager/contentModel/delete.do"
		$(this).request({url:URL,data:"cmId=" + cmId,type:"json",method:"post",func:function(msg) {
			if (msg) {
				location.reload();
			}
		}});	
}

function editContentModel(cmId){
		var URL = base+"/manager/contentModel/"+cmId+"/edit.do";
		$(this).request({url:URL,type:"json",method:"post",func:function(model) {
			if (model) {
				$("#contentModelForm").attr("action","${base}/manager/contentModel/update.do");
				$("#contentModelModal input[name='cmId']").val(model.cmId);
				$("#contentModelModal input[name='cmTipsName']").val(model.cmTipsName);
				$("#contentModelModal input[name='cmTableName']").attr("readonly","readonly");
				$("#contentModelModal input[name='cmTableName']").val(model.cmTableName.split("_")[1]);
				$("#contentModelModal").modal();
			}
		}});
}

function resetForm() {
		$("#contentModelModal input[name='cmTableName']").removeAttr("readonly");
}
</script>
