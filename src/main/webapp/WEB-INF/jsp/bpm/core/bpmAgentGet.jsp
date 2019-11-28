<%-- 
    Document   : [BpmAgent]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[BpmAgent]明细</title>
<%@include file="/commons/get.jsp"%>
<style>
.form-title li{
	width: 25%;
}
</style>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
<div class="form-container">
	<div class="form-title">
		<h1>更新信息</h1>
		<ul class="form-messages">
			<li>
				<span>创  建  人：<rxc:userLabel userId="${bpmAgent.createBy}" /></span>
			</li>
			<li>
				<span>更  新  人：<rxc:userLabel userId="${bpmAgent.updateBy}" /></span>
			</li>
			<li>
				<span>创建时间：<fmt:formatDate value="${bpmAgent.createTime}" pattern="yyyy-MM-dd HH:mm" /></span>
			</li>
			<li>
				<span>更新时间：<fmt:formatDate value="${bpmAgent.updateTime}" pattern="yyyy-MM-dd HH:mm" /></span>
			</li>
		</ul>
	</div>

	<div id="form1" >
		<table style="width: 100%" class="table-detail column-two " cellpadding="0" cellspacing="1">
			<caption>[BpmAgent]基本信息</caption>
			<tr>
				<td>代理简述</td>
				<td>${bpmAgent.subject}</td>
			</tr>
			<tr>
				<td>代理人ID</td>
				<td><rxc:userLabel userId="${bpmAgent.toUserId}"></rxc:userLabel></td>
			</tr>
			<tr>
				<td>被代理人ID</td>
				<td><rxc:userLabel userId="${bpmAgent.agentUserId}"></rxc:userLabel></td>
			</tr>
			<tr>
				<td>开始时间</td>
				<td><fmt:formatDate  value="${bpmAgent.startTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>结束时间</td>
				<td><fmt:formatDate  value="${bpmAgent.endTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>代理类型</td>
				<td id="td_type">${bpmAgent.type}</td>
			</tr>
			<tr>
				<td>状　　态</td>
				<td id="td_status">${bpmAgent.status}</td>
			</tr>
			<tr>
				<td>描　　述</td>
				<td>${bpmAgent.descp}</td>
			</tr>
		</table>

<%-- 			<table class="table-detail column_2" cellpadding="0" cellspacing="1">
			<caption>更新信息</caption>
			<tr>
				<th>创建人</th>
				<td><rxc:userLabel userId="${bpmAgent.createBy}" /></td>
				<th>创建时间</th>
				<td><fmt:formatDate value="${bpmAgent.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
			<tr>
				<th>更新人</th>
				<td><rxc:userLabel userId="${bpmAgent.updateBy}" /></td>
				<th>更新时间</th>
				<td><fmt:formatDate value="${bpmAgent.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</table> --%>






	</div>
	
	
	</div>
	</div>
	<rx:detailScript baseUrl="bpm/core/bpmAgent"  entityName="com.redxun.bpm.core.entity.BpmAgent" formId="form1" />
</div>
	<script type="text/javascript">
		addBody();
		
		$(function(){
			var desc = $("#td_type");
			if($.trim(desc.text()) == "ALL"){
				desc.text("启用");
			} else if($.trim(desc.text()) == "PART") {
				desc.text("禁用");
			}
			var status = $("#td_status");
			if(status.text() == "ENABLED"){
				status.text("全部");
			} else if(status.text() == "DISABLED") {
				status.text("部分");
			}
		});
	</script>
</body>
</html>