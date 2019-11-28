<%-- 
    Document   : 项目明细页
    Created on : 2016-1-18, 17:42:57
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>项目明细</title>
<%@include file="/commons/get.jsp"%>
<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
<style type="text/css">
*{
	font-family: '微软雅黑';
	color: #666;
}
h1{
	font-size: 18px;
	color: #666;
	text-align: center;
}
.title h2{
	font-size: 12px;
	color: #666;
}

.title h2::after{
	content:'';
	display: block;
	clear: both;
}

h2>span{
	float:left;
	width: 50%;
	text-align: center;
}

.column_2_m{
	width: 100%;
}

.column_2_m th,
.column_2_m td{
	border: 1px solid #ececec;
	font-size: 14px;
	padding: 8px;
}

.content p{
	margin: 0;
}



</style>
</head>
<body>
<div class="topToolBar">
	<div>
		<a class="mini-button" plain="true" onclick="location.reload();">刷新</a>
		<a class="mini-button" plain="true" onclick="payAttention()">关注</a>
	</div>
</div>
	<div class="form-container" >
		<div class="title">
			<h1>
				<a>
					${project.name}
					<a>${project.type}</a>
				</a>
			</h1>
			<h2>
				 <span>
				 	评论数量：
				 	<a href="javascript:listMat();">${MatNum}</a>
			 	</span>
			 	<span>当前版本：${project.version}</span>
			</h2>
		</div>
		<table class="table-detail column-four" >
			<tr>
				<td>创&nbsp;&nbsp;建&nbsp;&nbsp;人</td>
				<td><rxc:userLabel userId="${project.createBy}" /></td>
				<td>创建时间</td>
				<td><fmt:formatDate value="${project.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>		
			<tr>
				<td>标　　签</td>
				<td>${project.tag}</td>
				<td>编　　号</td>
				<td>${project.proNo}</td>
			</tr>		
			<tr>
				<td>启动时间</td>
				<td><fmt:formatDate value="${project.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>结束时间</td>
				<td><fmt:formatDate  value="${project.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td>负&nbsp;&nbsp;责&nbsp;&nbsp;人</td>
				<td>${repor}</td>
				<td>参&nbsp;&nbsp;与&nbsp;&nbsp;人</td>
				<td>${AttPeople}</td>
			</tr>
			<tr>
				<td>参&nbsp;&nbsp;与&nbsp;&nbsp;组</td>
				<td>${AttGroup}</td>
				<td>预计费用</td>
				<td>${project.costs}</td>
			</tr>
			<tr>
				<td>状　　态</td>
				<td id="run_status">${project.status}</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>项目内容</td>
				<td colspan="3" class="content">${project.descp}</td>
			</tr>
		</table>
	<!-- tab -->
	<div style="height: 500px;width:100%; ">
		<div id="tabs1" class="mini-tabs" style="width: 100%;height: 100%;" >
		    <div title="评论内容" url="${ctxPath}/oa/pro/proWorkMat/list.do?projectId=${project.projectId}"></div>
			<div title="参与人员" id="tabAtt" url="${ctxPath}/oa/pro/proAttend/list.do?projectId=${project.projectId}"></div>
			<div title="版本控制" id="tabVer" url="${ctxPath}/oa/pro/proVers/list.do?projectId=${project.projectId}"></div>
			<div title="项目需求" id="tabAct" url="${ctxPath}/oa/pro/reqMgr/list.do?projectId=${project.projectId}"></div>
			<div title="动态" id="tabaction" url="${ctxPath}/oa/pro/proWorkMat/listforact.do?type=ACTION&projectId=${project.projectId}&noact=noact"></div>
			<div title="工作计划" id="tabaction" url="${ctxPath}/oa/pro/planTask/list.do?projectId=${project.projectId}"></div>
		</div>
	</div>
	
	</div>
	<rx:detailScript baseUrl="oa/pro/project" formId="form1"  entityName="com.redxun.oa.pro.entity.Project"/>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<script type="text/javascript">
		addBody();
		mini.parse();
		
		$(function(){
			var status = $("#run_status");
			var txt = $.trim(status.text());
			if(txt == "DEPLOYED"){
				status.text("发布");
			} else if(txt == "DRAFTED") {
				status.text("草稿");
			} else if(txt == "RUNNING") {
				status.text("进行中");
			} else if(txt == "FINISHED") {
				status.text("完成");
			}
		});

	//打开项目的评论列表
	function listMat(){
		_OpenWindow({
    		url: __rootPath+"/oa/pro/proWorkMat/list.do?projectId="+${project.projectId},
            title: "评论列表", 
            width: 800, 
            height: 600,
            ondestroy: function(action) {
            }
    	});	
	}
	
	//按模板生成word
	function generate1(){
		_OpenWindow({
    		url: __rootPath+"/oa/pro/project/generateToWord.do?projectId="+${project.projectId},
            title: "she", width: 800, height: 600,
            ondestroy: function(action) {
            }
    	});	
		
		$.ajax({
            type: "Post",
            url : '${ctxPath}/oa/pro/project/generateToWord.do?projectId='+${project.projectId},
            success: function () {
            }
        }); 
	}
	
	
	//关注项目
	function payAttention(){
		$.ajax({
            type: "Post",
            async: false,
            url : '${ctxPath}/oa/pro/proWorkAtt/checkAttention.do?typePk=${project.projectId}',
            success: function (result) {
            	if(result.success==true){
            		 mini.confirm("确定要关注此项目？", "提示",
            		            function (action) {
            		                if (action == "ok") {
            		                	$.ajax({
            		                        type: "Post",
            		                        url : '${ctxPath}/oa/pro/proWorkAtt/payAttention.do?typePk=${project.projectId}&type=PROJECT',
            		                        success: function (result) {
            		                        	if(result.success==true){
            		                        		mini.showTips({
            		                                    content: "<b>提示</b> <br/>关注成功",
            		                                    state: 'success',
            		                                    x: 'center',
            		                                    y: 'top',
            		                                    timeout: 3000});
            		                        		}
            		                        }
            		                            }); 
            	                                        }
            		                }
            		             );
            }else{
            	mini.showTips({
                    content: "<b>提示</b> <br/>您已经关注此项目",
                    state: 'warning',
                    x: 'center',
                    y: 'top',
                    timeout: 3000});
                  }
            
                                           }
	});
	}
	</script>
</body>


</html>