
<%-- 
    Document   : [ins_portal_def]编辑页
    Created on : 2017-08-15 16:07:14
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>自定义门户编辑</title>
	<%@include file="/commons/edit.jsp"%>
</head>
<body>


<rx:toolbar toolbarId="toolbar1" pkId="insPortalDef.portId" />


<div class="mini-fit">
	<div class="form-container" >
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${insPortalDef.portId}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>自定义门户基本信息</caption>
					<tr>
						<td>门户名称</td>
						<td>
							<input name="name" value="${insPortalDef.name}"
								   class="mini-textbox"  required="true" style="width: 80%" />
						</td>

						<td>门户 Key</td>
						<td>
							<input name="key" value="${insPortalDef.key}"
								   class="mini-textbox"  required="true" style="width: 80%" />
						</td>
					</tr>
					<tr>
						<td>是否缺省</td>
						<td>
							<div class="mini-radiobuttonlist" value="${insPortalDef.isDefault}"
								 textField="text" valueField="id"  id="isDefault" name="isDefault"  data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]" ></div>
						</td>

						<td>优  先  级</td>
						<td>
							<input name="priority" value=""
								   class="mini-spinner"  minValue="0" maxValue="10000" style="width: 80%" />
						</td>
					</tr>
<tr>
						<td>手机门户</td>
						<td colspan="3">
							<div class="mini-radiobuttonlist" value='${empty insPortalDef.isMobile ? "NO" : "YES"}'
    						textField="text" valueField="id" id="isMobile" name="isMobile" data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]" ></div>							
						</td>
					</tr>				</table>
			</div>
		</form>

		<rx:formScript formId="form1" baseUrl="oa/info/insPortalDef"
					   entityName="com.redxun.oa.info.entity.InsPortalDef" />
	</div>
</div>
<script type="text/javascript">
	addBody();
	$(function(){
		mini.getByName("priority").setValue("${insPortalDef.priority}");
	})
	
	function handleFormData(formData){
		var result = {isValid:true};
		for(var i=0;i<formData.length;i++){
			if("priority"==formData[i].name){
				formData[i].value=mini.getByName("priority").getValue();
				break;
			}
		}
		result.formData=formData;
		return result;
	}
</script>
</body>
</html>