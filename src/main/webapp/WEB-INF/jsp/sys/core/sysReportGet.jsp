<%-- 
    Document   : [SysReport]明细页
    Created on : 2015-3-28, 17:42:57
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 使用范围：
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[SysReport]明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
	<div class="heightBox"></div>
	<div id="form1" class="form-outer shadowBox90">
		<div>
			<table style="width: 100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
				<caption>报表基本信息</caption>
				<tr>
					<td style="width:100px;">报表分类</td>
					<td>${sysReport.sysTree.name}</td>
				</tr>
				<tr>
					<td>标　　题</td>
					<td>${sysReport.subject}</td>
				</tr>
				<tr>
					<td>标识key</td>
					<td>${sysReport.key}</td>
				</tr>
				<tr>
					<td>描　　述</td>
					<td>${sysReport.descp}</td>
				</tr>
				<tr>
					<td>jasper路径</td>
					<td>${sysReport.filePath}</td>
				</tr>
				<tr>
					<td>是否缺省</td>
					<td>${sysReport.defaults}</td>
				</tr>
				<tr>
					<td>报表解析引擎</td>
					<td>${sysReport.engine}</td>
				</tr>
			</table>
		</div>
	</div>
	<rx:detailScript baseUrl="sys/core/sysReport" formId="form1" entityName="com.redxun.sys.core.entity.SysReport"/>
	<script type="text/javascript">
		addBody();
	</script>
	
</body>
</html>