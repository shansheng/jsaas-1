<%-- 
    Document   : [BpmOpinionLib]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>常用审批意见明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
<div class="fitTop"></div>
<div class="mini-fit">
	<div class="form-container">
		<div class="form-title">
			<h1>更新信息</h1>
			<ul class="form-messages">
				<li>
					<span>创  建  人：<rxc:userLabel userId="${bpmOpinionLib.createBy}" /></span>
				</li>
				<li>
					<span>更  新  人：<rxc:userLabel userId="${bpmOpinionLib.updateBy}" /></span>
				</li>
				<li>
					<span>创建时间：<fmt:formatDate value="${bpmOpinionLib.createTime}" pattern="yyyy-MM-dd HH:mm" /></span>
				</li>
				<li>
					<span>更新时间：<fmt:formatDate value="${bpmOpinionLib.updateTime}" pattern="yyyy-MM-dd HH:mm" /></span>
				</li>
			</ul>
		</div>
			<div id="form1" >
				<div>
					<table style="width: 100%" class="table-detail column-four" cellpadding="0"
						cellspacing="1">
						<caption>常用审批意见基本信息</caption>
						<tr>
							<td>用户Id</td>
							<td>${bpmOpinionLib.userId}</td>
						</tr>
						<tr>
							<td>审批意见</td>
							<td>${bpmOpinionLib.opText}</td>
						</tr>
					</table>
				</div>
			</div>
	</div>
</div>
	<rx:detailScript baseUrl="bpm/core/bpmOpinionLib"
		entityName="com.redxun.bpm.core.entity.BpmOpinionLib" formId="form1" />
		
	<script type="text/javascript">
		addBody();
	</script>
</body>
</html>