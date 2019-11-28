<%-- 
    Document   : 关系类型编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>关系类型编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="${osRelType.id}"/>
<div class="mini-fit">
<div class="form-container">
	<form id="form1" method="post">
		<input id="pkId" name="id" class="mini-hidden" value="${osRelType.id}" />
		<table class="table-detail column-four" cellspacing="1" cellpadding="0">
			<caption>关系类型基本信息</caption>
			<tr>
				<td>
					名称 <span class="star">*</span>
				</td>
				<td><input name="name" value="${osRelType.name}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入关系名" style="width:100%"/></td>

				<td>
					业务标识 <span class="star">*</span>
				</td>
				<td><input name="key" value="${osRelType.key}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入关系业务标识" style="width:100%"/></td>
			</tr>

			<tr>
				<td>
					类型<span class="star">*</span>
				</td>
				<td>
					<input id="relType" name="relType" class="mini-combobox" style="width:100%" data="[{id:'GROUP-USER',text:'用户组与用户关系'},{id:'USER-USER',text:'用户间关系'},{id:'GROUP-GROUP',text:'用户组间关系'}]"
					textField="text" valueField="id" emptyText="请选择关系类型..." value="${osRelType.relType}"  required="true"  onvaluechanged="relTypeChange"/>
				</td>
				<td>
					约束类型<span class="star">*</span>

				</td>
				<td>
					<input id="constType" name="constType" class="mini-combobox" style="width:100%" data="[{id:'ONE-ONE',text:'一对一'},{id:'ONE-MANY',text:'一对多'},{id:'MANY-MANY',text:'多对多'},{id:'MANY-ONE',text:'多对一'}]"
					textField="text" valueField="id" emptyText="请选择关系约束类型..." value="${osRelType.relType}"  required="true" />
				</td>
			</tr>

			<tr>
				<td>
					当前方名称 <span class="star">*</span>
				</td>
				<td><input name="party1" value="${osRelType.party1}" class="mini-textbox" vtype="maxLength:128" required="true" emptyText="请输入关系当前方名称" style="width:100%"/></td>
				<td>
					关联方名称 <span class="star">*</span>
				</td>
				<td><input name="party2" value="${osRelType.party2}" 
						   class="mini-textbox" vtype="maxLength:128" 
						   required="true" emptyText="请输入关系关联方名称" 
						   style="width:100%"/></td>
			</tr>

			<tr id="rowDim" style="display:none;">
				<td>当前方维度</td>
				<td>
					<input id="dimId1" onvaluechanged="changeDim" name="dimId1" class="mini-combobox" style="width:150px;" textField="name" valueField="dimId" emptyText="请选择..."
					 url="${ctxPath}/sys/org/osDimension/jsonAll.do?tenantId=${param['tenantId']}" value="${osRelType.dimId1}"   showNullItem="true" nullItemText="请选择..."/>

					等级:
					<input id="level"  name="level" class="mini-combobox" style="width:100%" textField="name" valueField="level" emptyText="请选择..."
					 url="${ctxPath}/sys/org/osRankType/listByDimId.do" value="${osRelType.level}"   showNullItem="true" nullItemText="请选择..."/>

				</td>
				<td>关联方维度</td>
				<td>
					<input id="dimId2"  name="dimId2" class="mini-combobox" style="width:100%;" textField="name" valueField="dimId" emptyText="请选择..."
					 url="${ctxPath}/sys/org/osDimension/jsonAll.do?tenantId=${param['tenantId']}"
						   value="${osRelType.dimId2}"
						   showNullItem="true"
						   nullItemText="请选择..."
					/>
				</td>
			</tr>

			<tr>
				<td>
					<span class="starBox">
						状　　态<span class="star">*</span>
					</span>
				</td>
				<td>
				<div name="status" class="mini-radiobuttonlist" value="${osRelType.status}" repeatDirection="vertical" required="true" emptyText="请输入状态"
						  repeatLayout="table" data="[{id:'ENABLED',text:'激活'},{id:'DISABLED',text:'禁用'}]" textField="text" valueField="id" ></div>
				</td>
				<td>
					<span class="starBox">
						是否双向 <span class="star">*</span>
					</span>
				</td>
				<td>
					<div name="isTwoWay" class="mini-radiobuttonlist" value="${osRelType.isTwoWay}"  repeatDirection="vertical" required="true" emptyText="请输入状态"
						  repeatLayout="table" data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]" textField="text" valueField="id"></div>
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
	<script type="text/javascript">
		$(function(){
			var relType='${osRelType.relType}';
			if(relType=='')return;
			if(relType=='USER-USER'){
				$("#rowDim").css("display","none");
			}else{
				$("#rowDim").css("display","");
			}
		});
		function relTypeChange(e){
			var val=mini.get('#relType').getValue();
			if(val=='USER-USER'){
				$("#rowDim").css("display","none");
			}else{
				$("#rowDim").css("display","");
			}
		}
		
		function changeDim(e){
			var url=__rootPath +"/sys/org/osRankType/listByDimId.do?dimId=" + e.value;
			var objLevel=mini.get("level");
			objLevel.load(url);
		}
	</script>
</body>
</html>