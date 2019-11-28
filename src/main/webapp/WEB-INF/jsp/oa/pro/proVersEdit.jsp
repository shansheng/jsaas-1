<%-- 
    Document   : 项目版本编辑页
    Created on : 2015-12-21, 0:11:48
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>版本编辑</title>
<%@include file="/commons/edit.jsp"%>
<link href="${ctxPath}/scripts/ueditor/form-design/form-def.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var data2=[{ id: 'DRAFTED', text: '草稿' }, { id: 'RUNNING', text: '进行中'}];
</script>
<style type="text/css">
	.column_2_m > tbody>tr>td{
		padding: 0 !important;
	}
	.td-grid .edui-default .edui-editor{
		border: none;
	}
	
</style>
</head>
<body>
<div class="topToolBar">
	<rx:toolbar toolbarId="toolbar1" pkId="${proVers.versionId}" hideRemove="true" hideRecordNav="true">
	<div class="self-toolbar"></div>
	</rx:toolbar>
</div>
<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="versionId" class="mini-hidden" value="${proVers.versionId}" />
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>版本基本信息</caption>
                    <tr class="belong2plan" style="display: none;">
						<td>项目或产品 </td>
						<td><input name="projectId" value="${proVers.projectId}" class="mini-textbox" vtype="maxLength:64" style="width: 90%" /></td>
					</tr>
					<tr class="belong2plan">
						<td>
							<span class="starBox">
								版本号 <span class="star">*</span>
							</span> 
						</td>
						<td>
							<input 
								name="version" 
								value="${proVers.version}" 
								class="mini-textbox" 
								vtype="maxLength:50" 
								style="width: 90%" 
								required="true"
								emptyText="请输入版本号" 
							/>
						</td>
						<td>
							<span class="starBox">
								状　态<span class="star">*</span>
							</span> 
						</td>
						<td>
							<input 
								name="status" 
								value="${proVers.status}" 
								class="mini-combobox" 
								data="data2" 
								style="width: 90%" 
								required="true"
							/>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="td-grid"><ui:UEditor height="300" name="descp" id="descp">${proVers.descp}</ui:UEditor></td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</div>
	<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/form-design/ueditor-ext.js"></script>
	<rx:formScript formId="form1" baseUrl="oa/pro/proVers"  entityName="com.redxun.oa.pro.entity.ProVers"/>
	<script type="text/javascript">
	if(${!empty plan}){
		$(function(){
			$(".belong2plan").hide();
		});
	}
	
	//重写了saveData方法
	function selfSaveData(issave){
		var form = new mini.Form("form1");
		form.validate();
	    if (!form.isValid()) {//验证表格
	        return; }
	    var formData=$("#form1").serializeArray();
	    //加上租用Id
	    if(tenantId!=''){
	        formData.push({
	        	name:'tenantId',
	        	value:tenantId });
	    }
	    _SubmitJson({
	    	url:"${ctxPath}/oa/pro/proVers/save.do?",
	    	method:'POST',
	    	data:formData,
	    	success:function(result){
	    		//如果存在自定义的函数，则回调
	    		if(isExitsFunction('successCallback')){
	    			successCallback.call(this,result);
	    			return;	
	    		}
	    		var pkId=mini.get("pkId").getValue();
	    		//为更新
	    		if (pkId!=''){
	    			CloseWindow('ok');
	    			return;
	    		}
	    		CloseWindow('ok');} });
	}
	</script>
</body>
</html>