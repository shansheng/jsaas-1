
<%-- 
    Document   : [消息提醒]编辑页
    Created on : 2018-04-28 11:01:07
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[消息提醒]编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/oa/info/osRemindEdit.js?version=${static_res_version}"></script>
</head>

<body>
	  <rx:toolbar toolbarId="toolbar1" pkId="oaRemindDef.id" />
	<div class="mini-fit">
	<div id="p1" class="form-container" >
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden" value="${oaRemindDef.id}" />
			<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
				<caption>
					提醒信息
				</caption>
				<tr>
					<td>主 题</td>
					<td><input name="subject" value="${oaRemindDef.subject}"
						class="mini-textbox" style="width: 90%" required="true"/></td>
				</tr>
				<tr>
					<td>排序</td>
					<td><input name="sn"
						value="${oaRemindDef.sn}" minValue="1"
						maxValue="1000" class="mini-spinner" style="width: 90%;"  /></td>
				</tr>
				<tr>
					<td>跳转URL</td>
					<td><input required="true" name="url"
						value="${oaRemindDef.url}" class="mini-textbox"
						style="width: 90%" /></td>
				</tr>
				<tr>
					<td>是否有效</td>
					<td><input id="enabled" name="enabled"
						value="${oaRemindDef.enabled}"
						class="mini-radiobuttonlist" valueField="id" textField="text"
						data="[{'id':1,'text':'是'},{'id':0,'text':'否'}]" /></td>
				</tr>
				<tr>
					<td>数 据 源</td>
					<td><input name="dsalias"
						value="${oaRemindDef.dsalias}" id="dsalias"
						style="width: 90%;" text="${oaRemindDef.dsalias}"
						class="mini-buttonedit" showClose="true"
						onbuttonclick="onDatasource" oncloseclick="onCloseClick" />
					</td>
				</tr>
				<tr>
					<td>查询类型</td>
					<td>
						<div class="mini-radiobuttonlist" textField="text"
							valueField="id" value='${oaRemindDef.type!=null?oaRemindDef.type:"func"}'
							data="[{id:'func',text:'调用方法'},{id:'groovySql',text:'Groovy Sql'},{id:'sql',text:'Sql'}]"
							name="type" id="type"
							onvaluechanged="initType()"></div>
					</td>
				</tr>

				<tr >
					<td>输入SQL或者方法</td>
					<td style="padding: 4px 0 0 0 !important;">
						常量: <input id="constantItem" class="mini-combobox"
								showNullItem="true" nullItemText="可用常量"
								url="${ctxPath}/sys/core/public/getConstantItem.do"
								valueField="key" textField="val"
								onvalueChanged="constantChanged" />
						<div id="divScript">
							<textarea id="settingScript" emptyText="请输入脚本" rows="5" cols="100"
								width="500" style="height: 50px;">${oaRemindDef.setting}</textarea>
						</div>	
						<div id="divSql">
							<textarea id="settingSql" emptyText="请输入SQL" rows="5" cols="100"
								width="500" style="height: 50px;">${oaRemindDef.setting}</textarea>
						</div>
					</td>
				</tr>
				<tr >
					<td>消息描述</td>
					<td><input name="description" value="${oaRemindDef.description}"
						class="mini-textbox" style="width: 90%" /><br>
						[count]表示数量。例如:你有[count]条待办,显示为 你有 8条待办。
						</td>
				</tr>


			</table>
					
				
		</form>
	</div>
	</div>

	<script type="text/javascript">
		mini.parse();
		$(function(){
			initCodeMirror();
			initType();
		})
		
	</script>
</body>
</html>