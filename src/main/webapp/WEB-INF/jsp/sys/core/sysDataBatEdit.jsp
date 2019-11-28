<%-- 
    Document   : [数据批量录入]编辑页
    Created on : 2019-01-02 10:49:42
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[数据批量录入]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="sysDataBat.id" />	
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysDataBat.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[数据批量录入] 基本信息</caption>
					
					
			            <tr>
						<th>上传文件ID：</th>
						<td>
								<input name="uploadId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>批次ID：</th>
						<td>
								<input name="batId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>服务名：</th>
						<td>
								<input name="serviceName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>子系统ID：</th>
						<td>
								<input name="appId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>类型：</th>
						<td>
								<input name="type"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>EXCEL文件：</th>
						<td>
								<input name="excelId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>表名：</th>
						<td>
								<input name="tableName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>流程实例ID：</th>
						<td>
								<input name="instId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>流程实例状态：</th>
						<td>
								<input name="instStatus"  class="mini-textbox" />
						</td>
						</tr>
				</table>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${sysDataBat.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/sys/core/sysDataBat/getJson.do";
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
        	url:"${ctxPath}/sys/core/sysDataBat/save.do",
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