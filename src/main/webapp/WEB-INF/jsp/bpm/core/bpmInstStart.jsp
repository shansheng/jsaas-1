<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>流程实例启动页</title>
<%@include file="/commons/customForm.jsp"%>
<script src="${ctxPath }/scripts/flow/inst/bpminst.js?version=${static_res_version}"></script>

<script type="text/javascript">
	var conf={
		solId:"${bpmSolution.solId}",
		mainSolId:"${param.mainSolId}",
		taskId:"${param.taskId}",
		instId:'${instId}',
		tmpInstId:'${param.tmpInstId}',
		formType:"${formModels[0].type}",
		actDefId:"${bpmSolution.actDefId}",
		confirmStart:"${processConfig.confirmStart}",
		selectUser:"${processConfig.selectUser}",
		isSkipFirst:"${processConfig.isSkipFirst}",
		showExecPath:"${processConfig.showExecPath}",
		needOpinion:"${processConfig.needOpinion}",
		from:"${from}"
	};
	
	$(function() {
		//解析动态表单
		if(conf.formType!="SEL-DEV"){
			renderMiniHtml({});	
		}else{
			//自动高度
			autoHeightOnLoad($("#formFrame"));	
		}
	 });
</script>
</head>
<body>
	
<rxTag:processToolBar buttons="${buttons }"></rxTag:processToolBar>
<div class="mini-fit">
<div class="form-container">
	<div id="errorMsg" style="margin:0 auto;<c:if test="${formModel.result}">display:none;</c:if> color:red;">
		${formModel.msg}
	</div>
	

	<form id="processForm">
			<rxTag:processForm formModels="${formModels}"></rxTag:processForm>
	</form>
</div>
</div>
</body>
</html>