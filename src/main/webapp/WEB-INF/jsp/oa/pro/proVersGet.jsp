<%-- 
    Document   : 版本明细页
    Created on : 2015-12-18, 17:42:57
    Autdor     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>版本明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<div class="topToolBar">
	<div>
		<rx:toolbar toolbarId="toolbar1" hideRecordNav="true" excludeButtons="remove">
			<div class="self-toolbar">
				<a class="mini-button" plain="true" onclick="location.reload();">刷新</a>
			</div>
		</rx:toolbar>
	</div>
</div>
<div class="mini-fit">
	<div id="form1" class="form-container">
		<div style="padding: 5px;">
			<table style="widtd: 100%" class="table-detail column_2_m" cellpadding="0"
				cellspacing="1">
				<caption>版本基本信息</caption>
				<tr>
					<td>版  本  号</td>
					<td>${proVers.version}</td>
					<td>状　　态</td>
					<td>${proVers.status}</td>
				</tr>
				<tr>
					<td>描　　述</td>
					<td colspan="5">${proVers.descp}</td>
				</tr>
			</table>
		</div>
		<div style="padding: 5px">
			<table class="table-detail column_2_m" cellpadding="0" cellspacing="1">
				<caption>更新信息</caption>
				<tr>
					<td>创  建  人</td>
					<td><rxc:userLabel userId="${proVers.createBy}" /></td>
					<td>创建时间</td>
					<td><fmt:formatDate value="${proVers.createTime}"
							pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>更  新  人</td>
					<td><rxc:userLabel userId="${proVers.updateBy}" /></td>
					<td>更新时间</td>
					<td><fmt:formatDate value="${proVers.updateTime}"
							pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>
		</div>
	</div>
</div>
	<rx:detailScript baseUrl="oa/pro/proVers" formId="form1"  entityName="com.redxun.oa.pro.entity.ProVers"/>
</body>
</html>