<%@tag import="com.redxun.core.util.StringUtil"%>
<%@tag import="com.redxun.bpm.core.entity.config.ButtonConfig"%>
<%@tag import="java.util.List"%>
<%@ tag language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="bpmTask"  type="com.redxun.bpm.core.entity.BpmTask" %>
<%@ attribute name="userTaskConfig"  type="com.redxun.bpm.core.entity.config.UserTaskConfig" %>
<%@ attribute name="isShowDiscardBtn"  type="java.lang.Boolean" %>
<%@ attribute name="canReject"  type="java.lang.Boolean" %>
<%@ attribute name="canAddSign"  type="java.lang.Boolean" %>
<div class="topToolBar">
	<div>
<%
	List<ButtonConfig> buttons=userTaskConfig.getButtons();
	if(buttons.size()==0){
%>
	<c:choose>
    	<c:when test="${not empty bpmTask.rcTaskId}">
    		<a class="mini-button"  onclick="replyCommu()">回复沟通</a>
    	</c:when>
    	<c:when test="${bpmTask.genCmTask=='YES'}">
    		<a class="mini-button"  onclick="communicate()">沟通</a>
    		<a class="mini-button"  onclick="revokeCommunicate()">撤销沟通</a>
    	</c:when>
    	<c:otherwise>
			<a id="btnApprove" class="mini-button"  onclick="approve()">审批</a>
			<c:if test="${canAddSign }">
				<a id="btnAddSign" class="mini-button"  onclick="addSign()">加签</a>
			</c:if>
			<c:if test="${canReject }">
				<a id="btnReject" class="mini-button"  onclick="reject()">驳回</a>
			</c:if>
			<a id="btnTransfer" class="mini-button" onclick="doTransfer()">转办</a>
			<a id="btnCommu" class="mini-button" onclick="communicate()">沟通</a>
			<c:if test="${isShowDiscardBtn==true}">
				<a class="mini-button" onclick="discardInst()" >作废</a>
			</c:if>		    	
    	</c:otherwise>
	</c:choose>

	<a class="mini-button" onclick="formPrint()" >打印</a>
	<a class="mini-button" onclick="doSaveData()" >暂存</a>
	<a class="mini-button" onclick="openTaskFlowImg()" >流程图</a>
	<a class="mini-button" onclick="openBpmOpinions()" >审批历史</a>
	<a class="mini-button" onclick="openBpmMessage()">留言</a>
<%
	}
	else{
		for(int i=0;i<buttons.size();i++){
			ButtonConfig conf=buttons.get(i);
			String type=conf.getType();
			String alias=conf.getAlias();
			//回复
			if(StringUtil.isNotEmpty( bpmTask.getRcTaskId()) ){
				 if("approve".equals(type) || "commute".equals(type)) continue;
		%>
			<a id="<%=conf.getId()%>" class="mini-button"  onclick="<%=conf.getScript() %>"><%=conf.getName() %></a>
		<%
		}
		else if("YES".equals(bpmTask.getGenCmTask()) ){
			if( "reply".equals(type) || "approve".equals(type)) continue;
		%>
			<a id="<%=conf.getId()%>" class="mini-button"  onclick="<%=conf.getScript() %>"><%=conf.getName() %></a>
		<%	
		}
		else{
			if(!isShowDiscardBtn && alias.equals("discard")) continue;
			if("reply".equals(type) || "commute".equals(type)) continue;
			if("reject".equals(alias) && !canReject) continue;
			if("addSign".equals(alias) && !canAddSign) continue;
		%>
			<a id="<%=conf.getId()%>" class="mini-button"  onclick="<%=conf.getScript() %>"><%=conf.getName() %></a>
		<%		
		}
	}
}
%>
	</div>
</div>