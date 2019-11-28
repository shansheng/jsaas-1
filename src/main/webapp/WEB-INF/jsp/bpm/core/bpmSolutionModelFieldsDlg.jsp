<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/commons/edit.jsp"%>
	<title>流程方案表单字段列表</title>
</head>
<body>
<div class="form-toolBox">
		<span style="vertical-align: middle">表单选择：</span>
		<input id="boDefId"
			   class="mini-combobox"
			   name="boDefId"
			   url="${ctxPath}/bpm/core/bpmSolution/boDefFields.do?solId=${param.solId}" onvaluechanged="onBoChanged"
			   valueField="id"
			   textField="name"
			   popupHeight="150"
			   style="width:350px;margin-top: 2px;"
			   required="true"
		/>
		<a class="mini-button"  plain="true" onclick="CloseWindow('ok')">选择</a>
		<a class="mini-button btn-red"  plain="true" onclick="CloseWindow();">关闭</a>
</div>

<div class="mini-fit">
	<div id="grid" class="mini-datagrid" style="width:100%;height:100%;"
		 multiSelect="true"  allowResize="true"  showPager="false" allowAlternating="true">
		<div property="columns">
			<div type="indexcolumn" width="50" headerAlign="center" align="center">序号</div>
			<div type="checkcolumn" width="40"></div>
			<div field="name"  width="160">字段名称</div>
			<div field="key"   width="100">字段Key</div>
			<div field="type"   width="100">类型</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	mini.parse();
	var grid=mini.get('grid');

	//默认选择中第一个表单
	$(function(){
		var boDefId = mini.get("boDefId");
		boDefId.select(0);
		onBoChanged();
	});
	function onDrawGroup(e) {
		e.cellHtml = e.value;
	}

	function getSelectedFields(){
		return grid.getSelecteds();
	}

	function onBoChanged(){
		var boDefId = mini.get("boDefId");
		var id = boDefId.getValue();

		var url = "${ctxPath}/bpm/core/bpmSolution/modelFields.do?boDefId="+id;
		grid.setUrl(url);
		grid.load();
	}

</script>
</body>
</html>