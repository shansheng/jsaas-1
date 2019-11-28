<%-- 
    Document   : 用户组维度编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户组维度编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
    <div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="SaveData()">保存</a>
		</div>
    </div>
	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
				<input id="pkId" name="dimId" class="mini-hidden" value="${osDimension.dimId}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>用户组维度基本信息</caption>
					<tr>
						<td>
							维度名称 <span class="star">*</span>
						</td>
						<td colspan="3"><input name="name" value="${osDimension.name}" class="mini-textbox" vtype="maxLength:40" required="true" emptyText="请输入维度名称"  style="width:100%"/></td>
					</tr>
					<tr>
						<td>
							维度业务主键 <span class="star">*</span>
						</td>
						<td ><input name="dimKey" value="${osDimension.dimKey}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入维度业务主键" style="width:100%"/></td>
						<td>排  序  号</td>
						<td><input name="sn" value="${osDimension.sn}"
								   class="mini-spinner"
								   vtype="maxLength:10" required="true"
								   emptyText="请输入排序号" minValue="1"
								   maxValue="1000"
								   style="width: 100%;"
						/></td>
					</tr>
				
					<tr>
						<td>
							数据展示类型 <span class="star">*</span>
						</td>
						<td>
							<div name="showType"
								 class="mini-radiobuttonlist"
								 value="${osDimension.showType}"
								 required="true"
								 emptyText="请输入数据展示类型"
								 data="[{'id':'TREE','text':'树型'},{'id':'FLAT','text':'平铺型'}]"
								 textField="text" valueField="id" vtype="maxLength:40"></div>
						</td>
						<td>
							状　　态 <span class="star">*</span>
						</td>
						<td>
							<div name="status" class="mini-radiobuttonlist" value="${osDimension.status}" required="true"   emptyText="请输入状态" 
								  repeatLayout="table" data="[{id:'ENABLED',text:'启用'},{id:'DISABLED',text:'禁用'}]" textField="text" valueField="id"  vtype="maxLength:40"></div>
						</td>
					</tr>
					<tr>
						<td>
							是否参与授权 <span class="star">*</span>
						</td>
						<td colspan="3">
							<div name="isGrant" class="mini-radiobuttonlist" value="${osDimension.isGrant}" required="true" 
								 data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]" textField="text" valueField="id" vtype="maxLength:10"></div>
						</td>
					</tr>
					<tr>
						<td>描　　述</td>
						<td colspan="3">
							<textarea name="desc" class="mini-textarea" vtype="maxLength:255" style="width: 100%;">${osDimension.desc}</textarea>
						</td>
					</tr>
				</table>
		</form>
	</div>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/org/osDimension" tenantId="${param['tenantId']}"/>

	<script type="text/javascript">
		addBody();
	</script>
	
	
</body>
</html>