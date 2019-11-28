<%-- 
    Document   : [BpmFormTemplate]编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单模板编辑</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">
.shadowBox {
    max-width: 1200px;
    margin: 0px auto;
    padding: 20px;
    box-shadow: 2px 1px 3px 0px rgba(179, 179, 179, 0.15);
}
.tableBox{
	width: 100%;
}
	.tableBox th,.tableBox td{
		padding:10px 5px;
		color: #555;
	}
	.tableBox th{
		text-align:right;
		width:15%;
		color: #333;
	}
	.tableBox_tit{
		text-align: left;
	    margin: 10px 0 20px 0;
	    padding-bottom: 15px;
	    border-bottom: 1px solid #ddd;
	}
.mini-textbox{
	width:100%;
}
.mini-textbox-border {
    border-radius: 2px; 
    border-color: #ccc;
    height: 32px;
}
.mini-textbox {
    height: 34px;
    width: 100%;
}
.mini-textbox-input{
	height: 32px;
    line-height: 32px;
    padding: 0 5px;
}
.mini-buttonedit {
    height: 34px;
    width: 100%;
    border-radius: 2px;
}
.mini-buttonedit-border {
    height: 32px;
    border-color: #ccc;
}
.mini-buttonedit-input {
    height: 32px;
    line-height: 32px;
    padding: 0 5px;
}
.mini-buttonedit-buttons .mini-buttonedit-icon {
    width: 26px;
    height: 32px;
    top: 0px;
    margin: 0px;
    left: 0;
}
</style>
</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="${bpmFormTemplate.id}" hideRecordNav="true" hideRemove="true" />
<div class="mini-fit">
<div id="p1" class="form-container">
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden"
				value="${bpmFormTemplate.id}" />
			<table class="table-detail column-two" cellspacing="1" cellpadding="0">
				<caption>表单模版基本信息</caption>
				<tr>
					<td>模版名称： </td>
					<td><input name="name" value="${bpmFormTemplate.name}"
						class="mini-textbox" vtype="maxLength:50"/>

					</td>
				</tr>

				<tr>
					<td>别名：</td>
					<td><input name="alias" value="${bpmFormTemplate.alias}"
						class="mini-textbox" vtype="maxLength:50"/>
					</td>
				</tr>

				<tr>
					<td>模版：</td>
					<td><textarea name="template" class="mini-textarea" 
							vtype="maxLength:65535" style="height: 200px;">${bpmFormTemplate.template}
						</textarea>
					</td>
				</tr>

				<tr>
					<td>模版类型 (pc,mobile)：</td>
					<td>
						<input name="type"  class="mini-combobox" textField="text" valueField="id"  emptyText="请选择..."
						data='[{ "id": "pc", "text": "PC模版" },{ "id": "mobile", "text": "手机" }]' value="${bpmFormTemplate.type}"  showNullItem="true" allowInput="false"/>         
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
	<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormTemplate"
		entityName="com.redxun.bpm.form.entity.BpmFormTemplate" />		
	<script type="text/javascript">
		addBody();s
	</script>
</body>
</html>