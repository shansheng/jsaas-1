<%-- 
    Document   : 系统树分类编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>系统树分类编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="${sysTreeCat.catId}"/>
<div class="mini-fit">
<div class="form-container">
	<div id="p1">
		<form id="form1" method="post">
			<input id="pkId" name="pkId" class="mini-hidden" value="${sysTreeCat.catId}" />
			<table class="table-detail column-four" cellspacing="1" cellpadding="0">
				<caption>系统树分类基本信息</caption>
				<tr>
					<td>
						分类名称<span class="star">*</span>
					</td>
					<td colspan="3"><input name="name" value="${sysTreeCat.name}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入分类名称" style="width:100%"/></td>
				</tr>
				
				<tr>
					<td>
						分类  Key <span class="star">*</span>
					</td>
					<td><input name="key" value="${sysTreeCat.key}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入分类Key" style="width:100%"/></td>
					<td>序　　号 </td>
					<td  ><input name="sn" value="${sysTreeCat.sn}" class="mini-spinner" minValue="1" maxValue="200" vtype="maxLength:10" style="width:100%"/></td>
				</tr>
				<tr>
					<td>描　　述</td>
					<td colspan="3"><textarea name="descp" class="mini-textarea" vtype="maxLength:255" style="width: 100%">${sysTreeCat.descp}</textarea></td>
				</tr>
			</table>
			
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/core/sysTreeCat" />
</div>
</div>
	<script type="text/javascript">
		addBody();
	</script>
	
</body>
</html>