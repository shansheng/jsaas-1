<%-- 
    Document   : 关系类型编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户组类型编辑</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">

.shadowBox{
	margin-bottom: 0;
}
</style>

</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="${osRelType.id}"/>
<div class="mini-fit">
	<div class="form-container">
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden" value="${osRelType.id}" />
			<input class="mini-hidden" name="relType" value="${osRelType.relType}"/>
			<input class="mini-hidden" name="constType" value="${osRelType.constType}"/>
			<table class="table-detail column-four" cellspacing="1" cellpadding="0">
				<caption>关系类型基本信息</caption>
				<tr>
					<td><span class="starBox">关  系  名 <span class="star">*</span></span></td>
					<td><input name="name" value="${osRelType.name}"
							   class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入关系名" style="width:100%"/></td>
					<td>关系业务标识 <span class="star">*</span></td>
					<td><input name="key" value="${osRelType.key}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入关系业务标识" style="width:100%"/></td>
				</tr>

				<tr>
					<td>关系当前方名称 <span class="star">*</span> </td>
					<td><input name="party1" value="${osRelType.party1}" class="mini-textbox" vtype="maxLength:128" required="true" emptyText="请输入关系当前方名称" style="width:100%"/></td>
					<td>关系关联方名称 <span class="star">*</span>
					</td>
					<td><input name="party2" value="${osRelType.party2}" class="mini-textbox" vtype="maxLength:128" required="true" emptyText="请输入关系关联方名称" style="width:100%"/></td>
				</tr>
				<tr>
					<td>当前方维度</td>
					<td>
						<input id="dimId1"  name="dimId1" class="mini-combobox" style="width:100%;" textField="name" valueField="dimId" emptyText="请选择..." enabled="false"
						 url="${ctxPath}/sys/org/osDimension/jsonAll.do?tenantId=${param['tenantId']}" value="${osRelType.dimId1}" showNullItem="true" nullItemText="请选择..."/>
					</td>
					<td>关联方维度</td>
					<td>
						<input id="dimId2"  name="dimId2" class="mini-combobox" style="width:100%;" textField="name" valueField="dimId" emptyText="请选择..."
						 url="${ctxPath}/sys/org/osDimension/jsonAll.do?tenantId=${param['tenantId']}" value="${osRelType.dimId2}"   showNullItem="true" nullItemText="请选择..."/>
					</td>
				</tr>
				<tr>
					<td><span class="starBox">状　　态<span class="star">*</span></span></td>
					<td>
						<div name="status" class="mini-radiobuttonlist" value="${osRelType.status}" required="true" repeatDirection="vertical" emptyText="请输入状态"
							  repeatLayout="table" data="[{id:'ENABLED',text:'激活'},{id:'DISABLED',text:'禁用'}]" textField="text" valueField="id" vtype="maxLength:40"></div>
					</td>
					<td><span class="starBox">是否是双向 <span class="star">*</span></span> </td>
					<td>
						<ui:miniRadioList name="isTwoWay" data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]" value="${osRelType.isTwoWay}" required="true"/>
					</td>
				</tr>
				<tr>
					<td>关系备注 </td>
					<td colspan="3">
						<textarea name="memo" class="mini-textarea" vtype="maxLength:255" style="width: 100%">${osRelType.memo}</textarea>
					</td>
				</tr>
			</table>
		</form>
		<rx:formScript formId="form1" baseUrl="sys/org/osRelType" tenantId="${param['tenantId']}"/>
	</div>
</div>
	
</body>
</html>