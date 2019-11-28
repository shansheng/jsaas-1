<%-- 
    Document   : [流程超时节点表]编辑页
    Created on : 2019-03-27 18:50:23
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[流程超时节点表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="bpmOvertimeNode.id" />	
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${bpmOvertimeNode.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[流程超时节点表] 基本信息</caption>
					
					
			            <tr>
						<th>解决方案ID：</th>
						<td>
								<input name="solId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>流程实例ID：</th>
						<td>
								<input name="instId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>流程节点ID：</th>
						<td>
								<input name="nodeId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>操作类型：</th>
						<td>
								<input name="opType"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>操作内容：</th>
						<td>
								<input name="opContent"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>超时时间：</th>
						<td>
								<input name="OVERTIME"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>节点状态：</th>
						<td>
								<input name="status"  class="mini-textbox" />
						</td>
						</tr>
				</table>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${bpmOvertimeNode.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/bpm/core/bpmOvertimeNode/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
		});
	}
		
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		var config={
        	url:"${ctxPath}/bpm/core/bpmOvertimeNode/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}	
	</script>
</body>
</html>