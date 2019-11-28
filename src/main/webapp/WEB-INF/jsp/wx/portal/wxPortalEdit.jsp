<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>编辑手机门户类别</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="sysDirFile.id" />
	<form id="form1" method="post">
		<input id="pkId" name="id" class="mini-hidden" value="${wxPortal.id}"/>
		<table class="table-detail" cellspacing="1" cellpadding="0" style="width:50%;margin:auto;">
			<caption>基本信息</caption>
			<tr>
				<th>名称</th>
				<td><input name="name" class="mini-textbox" required="true" value="${wxPortal.name}"/></td>
			</tr>
			<tr>
				<th>标识</th>
				<td><input name="typeId" class="mini-textbox" required="true" value="${wxPortal.typeId}"/></td>
			</tr>
			<tr>
				<th>应用类型</th>
				<td>
					<input name="btnType" class="mini-combobox" style="width:150px;" textField="text" valueField="id" 
    					data="[{id:'pic',text:'图片'},{id:'btn',text:'按钮图标'}]" value="${wxPortal.btnType}" showNullItem="true"/>     
				</td>
			</tr>
		</table>
	</form>
	
	<script>
		mini.parse();
		var form = new mini.Form("#form1");
	
		function onOk(){
			form.validate();
		    if (!form.isValid()) {
		        return;
		    }
		    var data=form.getData();
		  //检测标识是否重复
		  	$.post('${ctxPath}/wx/portal/wxPortal/checkTypeRepeat.do', data, function(dat){
			  	if(dat > 0){
			  		alert("标识已经存在！");
			  		return false;
			  	}
				var config={
					url:"${ctxPath}/wx/portal/wxPortal/save.do",
		        	method:'POST',
		        	postJson:true,
		        	data:data,
		        	success:function(result){
		        		CloseWindow('ok');
		        	}
		        	}
				_SubmitJson(config);
		  	});
		}
	</script>
</body>
</html>