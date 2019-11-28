<%-- 
    Document   : [planTask]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>计划明细</title>
<%@include file="/commons/get.jsp"%>
<style type="text/css">
div.mar{
margin-bottom: -5px;
}
div.topmar{
margin-top: -5px;
}

.linear{ 
width:100%; 
height:100%; 
FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#CCEEFF,endColorStr=#fafafa); /*IE*/ 
background:-moz-linear-gradient(top,#CCEEFF,#fafafa);/*火狐*/ 
background:-webkit-gradient(linear, 0% 0%, 0% 100%,from(#CCEEFF), to(#fafafa));/*谷歌*/ 
background-image: -webkit-gradient(linear,left bottom,left top,color-start(0, #CCEEFF),color-stop(1, #fafafa));/* Safari & Chrome*/ 
filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#CCEEFF', endColorstr='#fafafa'); /*IE6 & IE7*/ 
-ms-filter: "progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#CCEEFF', endColorstr='#fafafa')"; /* IE8 */ 
background: -ms-linear-gradient(top, #CCEEFF,  #fafafa);/* IE 10 */
} 
</style>
</head>
<body>

	<rx:toolbar toolbarId="toolbar1" hideRecordNav="true" excludeButtons="remove">
       <div class="self-toolbar">
       <a class="mini-button" plain="true" onclick="location.reload();">刷新</a>
       <a class="mini-button" plain="true" onclick="payAttention()">关注</a>
       </div>
	</rx:toolbar>
	<div class="form-container">
		<table class="table-detail column-four" cellpadding="0" border="1" style="width: 100%">
			<caption>标题</caption>
			<tr>
				<td>所属项目：</td>
				<td>${projectName}</td>
				<td>创建人：</td>
				<td><rxc:userLabel userId="${planTask.createBy}" /></td>
			</tr>
			<tr>
				<td>版本：</td>
				<td>${planTask.version}</td>
				<td>状态：</td>
				<td>${planTask.status}</td>
			</tr>
			<tr>
				<td>分配人：</td>
				<td>${assign}</td>
				<td>所属人：</td>
				<td>${owner}</td>
			</tr>
			<tr>
				<td>执行人：</td>
				<td>${exe}</td>
				<td>工作日志数量：</td>
				<td>${tasknum}</td>
			</tr>
			<tr>
				<td>创建时间：</td>
				<td><fmt:formatDate value="${planTask.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				<td>计划开始时间：</td>
				<td><fmt:formatDate value="${planTask.pstartTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td>计划结束时间：</td>
				<td><fmt:formatDate value="${planTask.pendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>实际开始时间：</td>
				<td><fmt:formatDate value="${planTask.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td>所属需求：</td>
				<td colspan="3"><a style="font-size: xx-small;color:#AA0000;">${reqSubject}</a></td>
			</tr>
		</table>

		<div class="contentBoxs" style="min-height:200px;border:1px solid #eee;padding: 4px;">
			${planTask.content}
		</div>
	</div>

	<rx:detailScript baseUrl="oa/pro/planTask" formId="form1"  entityName="com.redxun.oa.pro.entity.planTask"/>
	<script type="text/javascript">
	$(function(){
		if(${empty planTask.pendTime}){//如果没有计划结束时间则隐藏
			$("#pendtime").hide();
		}
		if(${empty planTask.startTime}){//如果没有开始时间则隐藏
			$("#starttime").hide();
		}
		if(${empty planTask.endTime}){//如果没有结束时间则隐藏
			$("#endtime").hide();
		}
		if(${empty projectName}){//如果没有所属项目则隐藏
			$("#project").hide();
		}
		if(${empty reqSubject}){//如果没有所属需求则隐藏
			$("#req").hide();
		}
		if(${empty planTask.version}){//如果没有所属需求则隐藏
			$("#version").hide();
		}
		if(${empty assign}){
			$("#assign").after("<a style='color: #AA0000;'>无</a>");//如果没有则写入一个"无"
		}
		if(${empty owner}){
			$("#owner").after("<a style='color: #AA0000;'>无</a>");//如果没有则写入一个"无"
		}
		if(${empty exe}){
			$("#exe").after("<a style='color: #AA0000;'>无</a>");//如果没有则写入一个"无"
		}
		
	});
	//打开项目的日志列表
	function listTask(){
		_OpenWindow({
    		url: __rootPath+"/oa/pro/workLog/list.do?planId="+${planTask.planId}+"&planTask="+"YES",
            title: "日志列表", width: 800, height: 600,
            ondestroy: function(action) {
            }
    	});	
	}
	
	
	
	//关注任务
	function payAttention(){
		$.ajax({
            type: "Post",
            async: false,
            url : '${ctxPath}/oa/pro/proWorkAtt/checkAttention.do?typePk=${planTask.planId}',
            success: function (result) {
            	if(result.success==true){
            		 mini.confirm("确定要关注此计划 ？", "确定？",
            		            function (action) {
            		                if (action == "ok") {
            		                	$.ajax({
            		                        type: "Post",
            		                        url : '${ctxPath}/oa/pro/proWorkAtt/payAttention.do?typePk=${planTask.planId}&type=PLAN',
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
                    content: "<b>提示</b> <br/>您已经关注此计划",
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