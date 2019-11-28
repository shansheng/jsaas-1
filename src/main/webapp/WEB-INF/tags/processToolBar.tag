
<%@tag import="com.redxun.bpm.core.entity.config.ButtonConfig"%>
<%@ tag language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="buttons" type="java.util.ArrayList" %>
<div class="topToolBar">
	<div>
<%
	if(buttons.size()==0){
%>
	<a class="mini-button"   onclick="startProcess">提交</a>
	<a class="mini-button"  onclick="saveDraft" >保存</a>
	<a class="mini-button"  onclick="formPrint" >打印</a>
	<a class="mini-button"  onclick="openFlowImg" >流程图</a>
	<c:if test="${not empty param['tmpInstId']}">
		<a class="mini-button" onclick="showLinkData">关联数据</a>
	</c:if>
<%
	}
	else{
		for(int i=0;i<buttons.size();i++){
			ButtonConfig conf=(ButtonConfig)buttons.get(i);
%>
	<a class="mini-button" onclick="<%=conf.getScript()%>" ><%=conf.getName()%></a>
<%
		}
	}
%>
	</div>
</div>
