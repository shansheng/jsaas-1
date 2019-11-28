<%-- 
    Document   : [巡检单填写记录]编辑页
    Created on : 2019-10-21 11:32:36
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[巡检单填写记录]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="patrolFullbillRecord.id" />	
<div class="mini-fit">
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${patrolFullbillRecord.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[巡检单填写记录] 基本信息</caption>
					
					
			            <tr>
						<td>填单人ID：</td>
						<td>
								<input name="staff"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>填单人：</td>
						<td>
								<input name="staffName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>巡检单ID：</td>
						<td>
								<input name="questionnaire"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>巡检单：</td>
						<td>
								<input name="questionnaireName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>填单时间：</td>
						<td>
								<input name="fulldate"  class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
						</tr>
			            <tr>
						<td>状态ID：</td>
						<td>
								<input name="status"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>状态：</td>
						<td>
								<input name="statusName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>外键：</td>
						<td>
								<input name="refId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>父ID：</td>
						<td>
								<input name="parentId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>流程实例ID：</td>
						<td>
								<input name="instId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>状态：</td>
						<td>
								<input name="instStatus"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>组ID：</td>
						<td>
								<input name="groupId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>门店ID：</td>
						<td>
								<input name="shop"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>门店：</td>
						<td>
								<input name="shopName"  class="mini-textbox" />
						</td>
						</tr>
				</table>
		</form>
	
	
</div>	
</div>
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${patrolFullbillRecord.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/wxrepair/core/patrolFullbillRecord/getJson.do";
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
        	url:"${ctxPath}/wxrepair/core/patrolFullbillRecord/save.do",
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