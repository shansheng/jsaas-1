<%-- 
    Document   : 系统树分类明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>系统树分类明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
	<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
<div class="fitTop"></div>
<div class="mini-fit">
	<div id="form1" class="form-container">

		<table style="width: 100%" class="table-detail column-two"
			cellpadding="0" cellspacing="1">
			<caption>基本信息</caption>
			<tr>
				<td>分类 Key<span class="star">*</span>
				</td>
				<td>${sysTreeCat.key}</td>
			</tr>
			<tr>
				<td> 分类名称 <span class="star">*</span></td>
				<td>${sysTreeCat.name}</td>
			</tr>
			<tr>
				<td>序　　 号</td>
				<td>${sysTreeCat.sn}</td>
			</tr>
			<tr>
				<td>描　　述</td>
				<td>${sysTreeCat.descp}</td>
			</tr>
		</table>

		<table class="table-detail column-four" cellpadding="0" cellspacing="1" style="width: 100%;">
			<caption>更新信息</caption>
			<tr >
				<td>创 建 人</td>
				<td><rxc:userLabel userId="${sysTreeCat.createBy}" /></td>
				<td>创建时间</td>
				<td><fmt:formatDate value="${sysTreeCat.createTime}"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
			<tr>
				<td>更 新 人</td>
				<td><rxc:userLabel userId="${sysTreeCat.updateBy}" /></td>
				<td>更新时间</td>
				<td><fmt:formatDate value="${sysTreeCat.updateTime}"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</table>
	</div>
</div>
	<rx:detailScript baseUrl="sys/core/sysTreeCat" formId="form1" />
	<script type="text/javascript">
		addBody();
	</script>


</body>
</html>