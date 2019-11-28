<%-- 
    Document   : 新闻评论明细页,暂时没用
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>新闻评论明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
<div class="mini-fit">
	<div id="form1" class="form-container">
		<div>
			<table style="width: 100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
				<caption>新闻评论基本信息</caption>
				<tr>
					<td>新闻标题</td>
					<td>${insNewsCm.insNews.subject}</td>
				</tr>
				<tr>
					<td>评论人名</td>
					<td>${insNewsCm.fullName}</td>
				</tr>
				<tr>
					<td>评论内容</td>
					<td>${insNewsCm.content}</td>
				</tr>
				<tr>
					<td>赞同与顶</td>
					<td>${insNewsCm.agreeNums}</td>
				</tr>
				<tr>
					<td>反对与鄙视次数</td>
					<td>${insNewsCm.refuseNums}</td>
				</tr>
				<tr>
					<td>是否为回复</td>
					<td>${insNewsCm.isReply}</td>
				</tr>
				<tr>
					<td>回复的评论内容</td>
					<td>${insNewsCm.repContent}</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="table-detail column-fours" cellpadding="0" cellspacing="1">
				<caption>更新信息</caption>
				<tr>
					<td>创  建  人</td>
					<td><rxc:userLabel userId="${insNewsCm.createBy}" /></td>
					<td>创建时间</td>
					<td><fmt:formatDate value="${insNewsCm.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>更  新  人</td>
					<td><rxc:userLabel userId="${insNewsCm.updateBy}" /></td>
					<td>更新时间</td>
					<td><fmt:formatDate value="${insNewsCm.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>
		</div>
	</div>
</div>
	<rx:detailScript baseUrl="oa/info/insNewsCm" formId="form1" entityName="com.redxun.oa.info.entity.InsNewsCm"/>
	<script type="text/javascript">
		addBody();
	</script>
</body>
</html>