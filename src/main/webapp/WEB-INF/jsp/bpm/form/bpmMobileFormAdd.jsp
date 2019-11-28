<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <title>新建手机表单</title>
        <%@include file="/commons/edit.jsp" %>
        <script type="text/javascript" src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/sys/bo/BoUtil.js?version=${static_res_version}"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/flow/form/bpmFormView.js?version=${static_res_version}"></script>
		<style>
			select{
				width: 100%;
			}
		</style>
    </head>
    <body > 
        <div class="topToolBar">
			<div>
		    	<a class="mini-button"  onclick="next('mobile')">下一步</a>
			</div>
		</div>
		<div class="mini-fit">
			   <div id="p1" class="form-container2">
					<form id="form1" method="post" >
						<input id="pkId" name="id" class="mini-hidden" value="${bpmMobileForm.id}"/>
						<table class="table-detail" cellspacing="1" cellpadding="0">
							<caption>新建手机表单</caption>
							<tr>
								<td>
									选择业务对象<span class="star">*</span>
								</td>
								<td>
									<input id="viewName"  allowInput="false" class="mini-textbox input-60" vtype="maxLength:60" required="true" style="width: 70%"/>
									<a class="mini-button"  onclick="selectBo('mobile')">选择</a>
								</td>
							</tr>
							<tbody id="tbody"></tbody>
						</table>																																																																																																																																																										                       </table>
					</form>
				</div>
		</div>
        <script id="templateList"  type="text/html">
		<#for(var i=0;i<list.length;i++){
			var obj=list[i];
			var tempAry=obj.template;
		#>
		<tr >
				<td ><#=obj.name#></td>
				<td>
					<select name="template" alias="<#=obj.key#>" type="<#=obj.type#>">
						<#for(var n=0;n<tempAry.length;n++){
							var tmp=tempAry[n];
						#>
							<option value="<#=tmp.alias#>"><#=tmp.name#></option>
						<#}#>
					</select>
					<#if (obj.type!="main") {#>
					<input type="checkbox" checked="checked" >
					<#}#>
				</td>
		</tr>
		<#}#>
		</script>
      <rx:formScript formId="form1" 
       baseUrl="bpm/form/bpmFormTemplate"
       entityName="com.redxun.bpm.form.entity.BpmFormTemplate" />
    </body>
</html>