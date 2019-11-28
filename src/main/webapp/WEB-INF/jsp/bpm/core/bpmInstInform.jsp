
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>流程实例明细页</title>
<%@include file="/commons/customForm.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="rxc" uri="http://www.redxun.cn/commonFun"%>
<script src="${ctxPath }/scripts/flow/inst/bpminst.js?version=${static_res_version}"></script>

<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/commons.css">
<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/bpmInstinform.css">
<style type="text/css">
	.table-info span{
		font-size:14px;
	}

	.head-info {

		margin:auto;
		padding-top:5px;
	}
	
	.head-info h1{
		font-size:22px !important;
	}
	.form-title ul{
		width:100%;
	}
</style>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="openBpmMessage()" >留言</a>
			<c:if test="${isShowDiscardBtn==true}">
					<a class="mini-button btn-red"  onclick="discardInst()" >作废</a>
			</c:if>
			<c:if test="${isFromMe==true}">
					<a class="mini-button btn-red" onclick="recoverInst()" >撤回</a>
			</c:if>
			<a class="mini-button" onclick="formPrint()">打印</a>
			<a class="mini-button" onclick="openFlowImg()">流程图</a>
			<a class="mini-button" onclick="openBpmOpinions()">审批历史</a>
		</div>
	</div>

<div class="mini-fit">
	<div class="form-container">
		<div
			<c:choose>
				<c:when test="${bpmInst.status=='RUNNING'}">
					class="form-title form-title-running"
				</c:when>
				<c:when test="${bpmInst.status!='RUNNING'}">
					class="form-title"
				</c:when>
			</c:choose> >
			<table class="table-detail column-four" border="1" cellspacing="0" cellpadding="0" >
				<caption>${bpmInst.subject}</caption>
				<tr>
					<td>流程发起人</td>
					<td>${bpmInst.startDepFull} &nbsp;<rxc:userLabel userId="${bpmInst.createBy}"/></td>
					<td>单号</td>
					<td>${bpmInst.billNo}</td>
				</tr>
				<c:if test="${bpmInst.status=='RUNNING'}">
				<tr>
					<td>当前审批人</td>
					<td>${bpmInst.taskNodeUsers}</td>
					<td>当前审批环节</td>
					<td>${bpmInst.taskNodes}</td>
				</tr>
				</c:if>
				<tr>
					<td>发起时间</td>
					<td><fmt:formatDate value="${bpmInst.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>完成时间</td>
					<td>
						<c:if test="${not empty bpmInst.endTime}">
							<fmt:formatDate value="${bpmInst.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</c:if>
					</td>
				</tr>
			</table>
		</div>

		<form id="processForm">
			<c:if test="${not empty formModels }">
				<c:set var="formModel" value="${formModels[0]}"></c:set>
				<c:choose>
					<c:when test="${formModel.type=='ONLINE-DESIGN' }">
						<div class="customform" style="width: 100%" id="form-panel">
							<c:choose>
							   <c:when test="${fn:length(formModels)==1}">  
							        ${formModels[0].content}         
							   </c:when>
							   <c:otherwise> 
									<div class="mini-tabs" activeIndex="0"  bodyStyle="padding:0">
										<c:forEach var="model" items="${formModels }">
										    <div title="${model.description}">
										        ${model.content}
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
		
		var instId='${bpmInst.instId}';		
		var procInstId='${bpmInst.actInstId}';		
		var fileId = "${bpmInst.checkFileId}";
		var userName = "${userName}";
		
		var conf={
			instId:"${param.instId}"
		}
		
		$(function(){
			renderMiniHtml({});
		})
		
		
		function openBpmMessage(){
			openBpmMessageDialog(instId)
		}
		
		function openFlowImg(){
			openFlowImgDialog({instId:instId});
		}
		
		function openBpmOpinions(){
			openBpmOpinionsDialog(procInstId);
		} 
		
		//撤回当前实例
		function recoverInst(){
			_SubmitJson({
				url:__rootPath+'/bpm/core/bpmInst/recoverInst.do',
				data:{
					instId:instId
				},
				success:function(){
					location.reload();
				}
			});
		}
		
		
	
		function discardInst(){
			
			if(!confirm('确定要作废该流程吗?')){
				return;
			}
			_SubmitJson({
				url:__rootPath+'/bpm/core/bpmInst/discardInst.do',
				data:{
					instId:instId
				},
				method:'POST',
				success:function(){
					CloseWindow("ok");
				}
			})
		}
		
		function editDealer(){
			var taskId="";
			taskId="${taskId}";
			_UserDlg(true,function(user){
        		_SubmitJson({
	        		url:__rootPath+'/bpm/core/bpmTask/batchClaimUsers.do',
	        		data:{
	        			taskIds:taskId,
	        			userId:user.userId
	        		},
	        		success:function(text){
	        			alert("处理完成");
	        		}
	        	});
        	});
		}
		
	
		
		
		
		
	</script>
</body>
</html>