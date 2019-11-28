<%-- 
    Document   : 流程任务列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>流程任务处理页</title>
<%@include file="/commons/customForm.jsp"%>
<script src="${ctxPath }/scripts/flow/inst/bpmtask.js?version=${static_res_version}"></script>
<script src="${ctxPath }/scripts/flow/inst/opinion.js?version=${static_res_version}"></script>
<script src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}" ></script>
<style>
#errorMsg{
	margin: auto; 
	width: 690px; 
	white-space:normal;
	color:red;
	border:solid 1px red;
	padding:5px;
}

.form-title-running h1{
	font-size:22px !important;
}
.table-info{
	width:100%;padding-bottom: 4px;
}

.table-info span{
	font-size:14px;
}

h2{
	font-size:14px;
	color:#000;
	font-weight: bold;
	width:100%;
	text-align: left;
}
h1{
	text-align: center;
	color: #555;
}
</style>
</head>
<body>
<rxTag:taskToolBar bpmTask="${bpmTask}" userTaskConfig="${ taskConfig}"
	isShowDiscardBtn="${isShowDiscardBtn }" canReject="${canReject }"   ></rxTag:taskToolBar>
<div class="mini-fit">
	<div class="form-container" style="min-height: 100%;height: auto;">
		<div class="form-title form-title-running">
			<h1>${bpmInst.subject }</h1>
		</div>
		<table class="table-info" >
			<tr>
				<td style="text-align: left;">本流程由<span>${bpmInst.startDepFull} &nbsp;<rxc:userLabel userId="${bpmInst.createBy}"/></span>发起于&nbsp;<span><fmt:formatDate value="${bpmInst.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
				<td style="text-align:right">单号：<span>${bpmInst.billNo}</span></td>
			</tr>
		</table>
		<br/>
		<div id="errorMsg" style="<c:if test="${empty bpmInst.errors && allowTask.success}">display:none;</c:if>">
			${bpmInst.errors}${allowTask.message}
			<c:if test="${!formModel.result }">${formModel.msg}</c:if>
		</div>
		<form id="processForm">
			<c:if test="${not empty formModels}">
				<c:set var="formModel" value="${formModels[0]}"></c:set>
				<c:choose>
					<c:when test="${formModel.type!='SEL-DEV'}">
						<div class="customform" style="width: 100%" id="form-panel">
							<c:choose>
							   <c:when test="${fn:length(formModels)==1}">
									<div class="form-model" id="formModel1"  boDefId="${formModel.boDefId}" formKey="${formModel.formKey}">
										${formModel.content}
									</div>
							   </c:when>
							   <c:otherwise>
									<div class="mini-tabs" activeIndex="0" style="width:100%;">
										<c:forEach var="model" items="${formModels}" varStatus="i" >
											<div title="${model.description}">
												<div class="form-model" id="formModel${i.index}" boDefId="${model.boDefId}" formKey="${model.formKey}">
													${model.content}
												</div>
											</div>
										</c:forEach>
									</div>
							   </c:otherwise>
							</c:choose>
						</div>
					</c:when>
					<c:otherwise>
						<iframe src="${formModel.content}" style="width:100%;" id="formFrame" frameborder="0" ></iframe>
					</c:otherwise>
				</c:choose>
			</c:if>
		</form>
	</div>
</div>
<script type="text/javascript">
	var formType="${formModel.type}";
	var solId='${bpmInst.solId}';
	var instId='${bpmInst.instId}';
	var procInstId='${bpmTask.procInstId}';
	var taskId='${param.taskId}';
	var token='${bpmTask.token}';
	var nodeId='${bpmTask.taskDefKey}';
	var description = '${bpmTask.description}';
	//是否允许执行。
	var allowTask =${allowTask.success};
		
	$(function(){
		initForm();
	});
		
	function approve(){
		approveTask({
			taskId:taskId,
			formType:formType,
			token:token
		})
	}
</script>
	
</body>
</html>