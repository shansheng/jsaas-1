<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="rxc"  uri="http://www.redxun.cn/commonFun" %>
<ul class="tip-ul">
	<li>
		<h1>节点：</h1>
		<h2>${taskNodeUser.nodeText}</h2>
	</li>
	<li>
		<h1>
			处理人：
			<c:choose>
				<c:when test="${taskNodeUser.multiInstance=='parallel'}">(并行会签)</c:when>
				<c:when test="${taskNodeUser.multiInstance=='sequential'}">(串行会签)</c:when>
			</c:choose>
		</h1>
		<h2>
			<c:choose>
				<c:when test="${not empty taskNodeUser.userFullnames }">${taskNodeUser.userFullnames} </c:when>
				<c:otherwise>无</c:otherwise>
			</c:choose>
			<c:if test="${not empty nodeJumps}">&nbsp;<a href="javascript:void(0);" onclick="$('#LI_TaskNode${taskNodeUser.nodeId}').toggle();">展开明细</a></c:if>
		</h2>
	</li>
	<c:if test="${not empty nodeJumps}">
	<li id="LI_TaskNode${taskNodeUser.nodeId}" style="display:none">
		<table >
			<c:forEach  items="${nodeJumps }" var="jump" varStatus="i">
				<c:if test="${not empty jump.handlerId}">
				<tr>
					<th>审批人:</th><td><rxc:userLabel userId="${jump.handlerId}"/></td>
				</tr>
				<tr>
					<th>到达时间:</th><td><fmt:formatDate value="${jump.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<th>审批动作:</th><td>${jump.checkStatusText}</td>
				</tr>
				<tr>
					<th>审批时间:</th><td><fmt:formatDate value="${jump.completeTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				 </tr>
				<tr  <c:if test="${i.count<fn:length(nodeJumps)}"> style="border-bottom: solid 1px #ccc;padding-top:5px;"</c:if>>
					<th>审批意见:</th><td>
					<c:choose>
						<c:when test="${not empty jump.remark }">
							${jump.remark}
						</c:when>
						<c:otherwise>无</c:otherwise>
					</c:choose>
					</td>
				</tr>
				</c:if>
			</c:forEach>
		</table>
	</li>
	</c:if>
</ul>
