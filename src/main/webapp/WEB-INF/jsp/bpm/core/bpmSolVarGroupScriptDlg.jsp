<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>
<!DOCTYPE html>
<html>
<head>
<title>人员脚本运算</title>
<%@include file="/commons/edit.jsp" %>
<style type="text/css">
	.mini-panel-border .mini-grid-row:last-of-type .mini-grid-cell{
		border-bottom: none;
	}
</style>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a id="saveButton" class="mini-button"  onclick="saveTheScript">保存</a>
		</div>
	</div>
	<div id="form1" class="form-container">
			<table style="width: 100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
				<tr>
					<td>类    名</td>
					<td><input id="scriptId" name="scriptId" class="mini-hidden" /> <input id="className" name="className" class="mini-treeselect"
						url="${ctxPath}/bpm/core/bpmGroupScript/getAllClass.do" multiSelect="false" valueFromSelect="false" textField="key" valueField="val"
						allowInput="false" showTreeIcon="false" style="width: 90%" showRadioButton="false" showTreeLines="false"
						onvaluechanged="changeClassName" /></td>
				</tr>
				<tr id="medthodTr">
					<td>方法名</td>
					<td><input id="methodName" name="methodName" class="mini-treeselect" multiSelect="false" valueFromSelect="false"
						textField="methodName" valueField="methodName" allowInput="false" showTreeIcon="false" style="width: 90%"
						value="${bpmGroupScript.className}" showRadioButton="false" showTreeLines="false" onvaluechanged="changMethodName"
						onnodeclick="rememberMsg" /></td>
				</tr>
				<tr id="descriptionTr">
					<td>方法描述</td>
					<td><textarea class="mini-textarea" id="methodDesc" name="methodDesc" emptyText="请输入关于方法的描述" style="width: 90%"></textarea></td>
				</tr>
				
			</table>
			<br/>
			<div class="caption">参数配置</div>
			<br/>
			<div 
				id="datagrid1" 
				class="mini-datagrid" 
				style="width: 100%; height: auto;" 
				showPager="false" 
				allowCellSelect="true"
				allowCellEdit="true" 
				oncellbeginedit="OnCellBeginEdit"
				allowAlternating="true"
			>
				<div property="columns">
					<div field="paraName" width="120" headerAlign="center">参数名</div>
					<div field="paraType" width="120" headerAlign="center">类型</div>
					<div field="paraDesc" width="120" headerAlign="center">
						描述<input property="editor" class="mini-textbox" style="width: 100%;" />
					</div>
					<div field="selector" width="120" headerAlign="center">
						选择器<input property="editor" class="mini-buttonedit" onbuttonclick="selector" />
					</div>
					<div field="bindField" width="120" headerAlign="center">
						绑定字段<input property="editor" class="mini-combobox" textField="field" valueField="field" style="width: 100%;" />
					</div>
					
				</div>
			</div>
	</div>
	<script type="text/javascript">
		addBody();
		mini.parse();
		var grid = mini.get("datagrid1");

		var className = mini.get("className");
		var methodName = mini.get("methodName");
		var scriptId = mini.get("scriptId");
		var methodDesc = mini.get("methodDesc");
		var currentEditor = null;
		var bindFieldsJson = null;

		/*回填参数用*/
		function _initData(dataObject) {
			className.setValue(dataObject.className);
			methodName.setValue(dataObject.methodName);
			methodName.setText(dataObject.methodName);
			methodDesc.setValue(dataObject.methodDesc);
			scriptId.setValue(dataObject.scriptId);
			grid.setData(mini.decode(dataObject.argument));
		}

		function changeClassName() {
			$("#medthodTr").show();
			var classNameValue = className.getText();
			methodName.load("${ctxPath}/bpm/core/bpmGroupScript/getAllMethodByClassName.do?className="+ classNameValue);
		}

		function initMethod(dataObject){
			methodName.load("${ctxPath}/bpm/core/bpmGroupScript/getAllMethodByClassName.do?className="+ className.text);
			methodName.setValue(dataObject.methodName);
			methodName.setText(dataObject.methodName);
		}
		
		function changMethodName(e) {
			$("#saveButton").show();
			$("#paramTr").show();
			$("#descriptionTr").show();
		}

		function rememberMsg(e) {
			var node = e.node;
			mini.get("methodDesc").setValue(node.methodDesc);
			grid.setData(node.para);
		}

		function OnCellBeginEdit(e) {
			var record = e.record, field = e.field;
			currentEditor = e.editor;
			if (field == "bindField") {
				// e.cancel = true;   
				initComboxData();
			}

		}

		function saveTheScript() {
			var form = new mini.Form("#form1");
			var formData = form.getData();
			var gridData = mini.encode(grid.getData());
			formData.argument = gridData;
			$.ajax({
				url : "${ctxPath}/bpm/core/bpmGroupScript/saveGroupScript.do",
				type : 'POST',
				data : formData,
				success : function(result) {
				},
				error : function(e) {
					CloseWindow('ok');
				}
			});
		}

		function selector(e) {
			var row = grid.getSelected();
			_OpenWindow({
				title : '人员脚本配置',
				width : 750,
				url : __rootPath + '/sys/core/sysBoList/select.do',
				height : 500,
				onload : function() {
					var iframe = this.getIFrameEl().contentWindow;
				},
				ondestroy : function(action) {
					if (action != 'ok') {
						return;
					}
					var iframe = this.getIFrameEl().contentWindow;
					var frameRow = iframe.getSelectedRow();
					grid.cancelEdit();
					grid.updateRow(row, {
						selector : frameRow.key
					});
					//currentEditor.setText(frameRow.name);
				}
			});
		}

		function initComboxData() {
			var bindFieldEditor = currentEditor;
			var row = grid.getSelected();
			$.ajax({
				url : "${ctxPath}/sys/core/sysBoList/getByKey.do",
				type : "post",
				data : {
					"key" : row.selector
				},
				success : function(result) {
					bindFieldEditor.setData(result.fieldsJson);
				}
			});

		}
	</script>
</body>
</html>