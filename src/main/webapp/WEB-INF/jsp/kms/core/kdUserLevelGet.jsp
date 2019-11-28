<%-- 
    Document   : [KdUserLevel]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[KdUserLevel]明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<div class="topToolBar">
	<div>
 	<rx:toolbar toolbarId="toolbar1" />
</div>
</div>
	<div class="heightBox"></div>
<div class="mini-fit">
	<div id="form1" class="form-container">
		<table style="width: 100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
			<caption>等级基本信息</caption>
			<tr>
				<td>起  始  值</td>
				<td>${kdUserLevel.startVal}</td>
			</tr>
			<tr>
				<td>结  束  值</td>
				<td>${kdUserLevel.endVal}</td>
			</tr>
			<tr>
				<td>等级名称</td>
				<td>${kdUserLevel.levelName}</td>
			</tr>
			<tr>
				<td>头像Icon</td>
				<td>${kdUserLevel.headerIcon}</td>
			</tr>
			<tr>
				<td>备　　注</td>
				<td>${kdUserLevel.memo}</td>
			</tr>
		</table>
	</div>
</div>
	<rx:detailScript baseUrl="kms/core/kdUserLevel" entityName="com.redxun.kms.core.entity.KdUserLevel" formId="form1" />
	<script type="text/javascript">
		addBody();
	</script>
	
</body>
</html>