<%-- 
    Document   : 业务流程解决方案明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>业务流程解决方案明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<div class="fitTop"></div>
<div class="mini-fit">
	<div class="form-container">
		<form id="form1">
			<table class="table-detail column_four" cellpadding="0" cellspacing="1">
				<caption>业务流程解决方案基本信息</caption>
				<tr>
					<td>解决方案名称</td>
					<td>${bpmSolution.name}</td>
	
					<td>标  识  键</td>
					<td>${bpmSolution.key}</td>
				</tr>
				<tr>
					<td>绑定流程KEY</td>
					<td>${bpmSolution.defKey}</td>
					<td>状　　态</td>
					<td>${bpmSolution.status}</td>
				</tr>
				<tr>
					<td>解决方案描述</td>
					<td colspan="3">${bpmSolution.descp}</td>
				</tr>
			</table>
		
			<table class="table-detail column_four" cellpadding="0" cellspacing="1">
				<caption>更新信息</caption>
				<tr>
					<td>创  建  人</td>
					<td><rxc:userLabel userId="${bpmSolution.createBy}" /></td>
					<td>创建时间</td>
					<td><fmt:formatDate value="${bpmSolution.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>更  新  人</td>
					<td><rxc:userLabel userId="${bpmSolution.updateBy}" /></td>
					<td>更新时间</td>
					<td><fmt:formatDate value="${bpmSolution.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>
		
		</form>
	</div>
</div>
	<rx:detailScript entityName="com.redxun.bpm.core.entity.BpmSolution"
	baseUrl="bpm/core/bpmSolution" formId="form1" />
	
	<script type="text/javascript">
		addBody();	
	</script>
</body>
</html>