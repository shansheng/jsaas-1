<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[单据表单方案]编辑</title>
<%@include file="/commons/customForm.jsp"%>
<script type="text/javascript">
var form = "detail";

$(function(){
	//解析表单。
	renderMiniHtml({});
})

function showInstInfo(instId){
	var url=__rootPath+"/bpm/core/bpmInst/info.do?instId="+instId;
	_OpenWindow({
		url : url,
		max:true,
		title : "流程图实例",
		width : 800,
		height : 600
	});
}

function onPrint(){
	printForm({formAlias:"${setting.formAlias}"});
}

</script>
<style type="text/css">
	.table-view > tbody > tr > td{
		border: none;
	}
	.customform .mini-tabs{
		overflow: auto;
	}
</style>

</head>
<body>
<div class="topToolBar">
	<div class="noPrint">
		<c:if test="${hasInst }">
			<a class="mini-button"    plain="true" onclick="showInstInfo('${instId}')">流程信息</a>
		</c:if>
		<a class="mini-button"  onclick="onPrint();">打印</a>
		<input class="mini-hidden" name="_VIEW_ID_"  id="_VIEW_ID_" value="${viewId}"/>
	</div>
</div>
	<div class="mini-fit">
		<div class="form-container">
			<div class="customform  form-model" id="form-panel" boDefId="${formModel.boDefId}">
				${formModel.content}
				<input class='mini-hidden' name='seting_bodefId_' value='${setting.bodefId}'>
				<input class='mini-hidden' name='seting_alias_' value='${setting.alias}'>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		addBody();
	</script>
	
</body>
</html>