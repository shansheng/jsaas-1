<%-- 
    Document   : 用户组维度明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="rx" uri="http://www.redxun.cn/detailFun"%>
<html>
<head>
<title>用户组维度明细</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container">
		<div id="form1" >

				<table style="width: 100%" class="table-detail column-four" cellpadding="0" cellspacing="0">
					<caption>用户组维度基本信息</caption>
					<tr>
						<td>维度名称</td>
						<td>${osDimension.name}</td>
						<td>维度业务主键</td>
						<td>${osDimension.dimKey}</td>
					</tr>
					<tr>
						<td>是否组合维度</td>
						<td>${osDimension.isCompose=='NO'?'否':'是'}</td>
						<td>是否系统预设维度</td>
						<td>${osDimension.isSystem=='NO'?'否':'是'}</td>
					</tr>
					<tr>
						<td>状　　态 </td>
						<td>${osDimension.status=='ENABLED'?'启用':'禁用'}</td>
						<td>序　　号</td>
						<td>${osDimension.sn}</td>
					</tr>
					<tr>
						<td>数据展示类型</td>
						<td>${osDimension.showType=='TREE'?'树形':'平铺'}</td>
					
						<td>是否参与授权</td>
						<td>${osDimension.isGrant=='NO'?'否':'是'}</td>
					</tr>
					<tr>
						<td>描　　述</td>
						<td colspan="3">${osDimension.desc}</td>
					</tr>
					<tr>
						<td>创建人</td>
						<td ><rxc:userLabel userId="${osDimension.createBy}" /></td>
						
						<td>创建时间</td>
						<td ><fmt:formatDate value="${osDimension.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
					<tr>
						<td>更新人</td>
						<td ><rxc:userLabel userId="${osDimension.updateBy}" /></td>
						
						<td>更新时间</td>
						<td ><fmt:formatDate value="${osDimension.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
				</table>

		</div>
	<rx:detailScript baseUrl="sys/org/osDimension" formId="form1" />

</div>
</div>
	<script type="text/javascript">
		addBody();
	</script>
</body>
</html>