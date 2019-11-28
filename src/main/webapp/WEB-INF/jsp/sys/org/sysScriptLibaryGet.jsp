
<%--
    Document   : 系统脚本库明细页
    Created on : 2019-03-29 18:12:21
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>系统脚本库明细</title>
	<%@include file="/commons/get.jsp" %>
</head>
<body>
<div class="topToolBar">
	<div>
		<rx:toolbar toolbarId="toolbar1"/>
	</div>
</div>
<%--<div id="toptoolbarBg"></div>--%>
<div class="mini-fit">
	<div id="form1" class="form-container">
		<div>
			<table style="width:100%" class="table-detail " cellpadding="0" cellspacing="1">
				<caption>系统脚本库基本信息</caption>
				<tr>
					<td>分类：</td>
					<td>
						${treeName}
					</td>
					<td>脚本全名：</td>
					<td>
						${sysScriptLibary.fullClassName}
					</td>
				</tr>
				<tr>
					<td>方法名：</td>
					<td>
						${sysScriptLibary.method}
					</td>
					<td>所属类：</td>
					<td>
						${sysScriptLibary.beanName}
					</td>
				</tr>
				<tr>
					<td>返回类型:</td>
					<td colspan="3">
						${sysScriptLibary.returnType}
					</td>
				</tr>
				<tr>
					<td>脚本代码：</td>
					<td colspan="3">
						<textarea name="example" id="example" style="width: 100%;height:300px;" readonly="true"  class="mini-textarea"><c:out value="${sysScriptLibary.example}" escapeXml="true"/></textarea>
					</td>
				</tr>
				<tr>
					<td>说明方法的详细使用：</td>
					<td colspan="3">
						<textarea name="dos" id="dos" style="width: 100%;height:300px;" readonly="true"  class="mini-textarea"><c:out value="${sysScriptLibary.dos}" escapeXml="true"/></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<rx:detailScript baseUrl="sys/org/sysScriptLibary"
					 entityName="com.redxun.sys.org.entity.SysScriptLibary"
					 formId="form1"/>

	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysScriptLibary.libId}';
		var dateOperator =mini.get('#dateOperator');

		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/org/sysScriptLibary/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}
			});
			var dataUrl = '${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=SCRIPT_SERVICE_CLASS';
			$.getJSON(dataUrl,function callbact(json){
				dateOperator.setData(json);
			});
		})
	</script>
</div>
</body>
</html>