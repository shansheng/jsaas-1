
<%-- 
    Document   : [权限转移日志表]编辑页
    Created on : 2018-06-20 17:12:34
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[权限转移日志表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="sysTransferLog.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysTransferLog.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[权限转移日志表]基本信息</caption>
					<tr>
						<th>操作描述：</th>
						<td>
							
								<input name="opDescp"  class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>权限转移人：</th>
						<td>
							
								<input name="authorPerson"  class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>目标转移人：</th>
						<td>
							
								<input name="targetPerson"  class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
		</form>
	</div>
	
	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${sysTransferLog.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		$.ajax({
			type:'POST',
			url:"${ctxPath}/sys/translog/sysTransferLog/getJson.do",
			data:{ids:pkId},
			success:function (json) {
				form.setData(json);
			}					
		});
	}
		
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		var config={
        	url:"${ctxPath}/sys/translog/sysTransferLog/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		//如果存在自定义的函数，则回调
        		if(isExitsFunction('successCallback')){
        			successCallback.call(this,result);
        			return;	
        		}
        		
        		CloseWindow('ok');
        	}
        }
	        
		_SubmitJson(config);
	}	
	
	
	
	
	
	

	</script>
</body>
</html>