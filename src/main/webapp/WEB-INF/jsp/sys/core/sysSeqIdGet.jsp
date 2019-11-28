<%-- 
    Document   : 系统流水号明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>系统流水号明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
<div class="fitTop"></div>
<div class="mini-fit">
	<div id="form1" class="form-container">
			<table class="table-detail column-four" cellpadding="0" cellspacing="1">
				<caption>系统流水号基本信息</caption>
				<tr>
					<td>名　　称</td>
					<td>${sysSeqId.name}</td>

					<td>别　　名</td>
					<td>${sysSeqId.alias}</td>
				</tr>
				<tr>
					<td>当前日期值</td>
					<td>
						<c:if test="${not empty sysSeqId.curDate }">
							<fmt:formatDate value="${sysSeqId.curDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>规　　则</td>
					<td colspan="3">${sysSeqId.rule}</td>
				</tr>
				
				<tr>
					<td>生成方式 </td>
					<td colspan="3">${sysSeqId.genType}</td>
				</tr>
				<tr>
					<td>流水号长度</td>
					<td>${sysSeqId.len}</td>
					<td>当  前  值</td>
					<td>${sysSeqId.curVal}</td>
				</tr>
				<tr>
					<td>初  始  值</td>
					<td>${sysSeqId.initVal}</td>
					<td>步　　长</td>
					<td>${sysSeqId.step}</td>
				</tr>
				<tr>
					<td>备　　注</td>
					<td colspan="3">${sysSeqId.memo}</td>
				</tr>
			</table>
		
			<table class="table-detail column-four" cellpadding="0" cellspacing="1">
				<caption>更新信息</caption>
				<tr>
					<td>创  建  人</td>
					<td><rxc:userLabel userId="${sysSeqId.createBy}" /></td>
					<td>创建时间</td>
					<td><fmt:formatDate value="${sysSeqId.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>更  新  人</td>
					<td><rxc:userLabel userId="${sysSeqId.updateBy}" /></td>
					<td>更新时间</td>
					<td><fmt:formatDate value="${sysSeqId.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>
	</div>
</div>
	<rx:detailScript baseUrl="sys/core/sysSeqId" entityName="com.redxun.sys.core.entity.SysSeqId" formId="form1" />
	<script type="text/javascript">
		addBody();
	</script>
	
</body>
</html>