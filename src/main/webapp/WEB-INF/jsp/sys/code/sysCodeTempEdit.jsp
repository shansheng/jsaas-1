<%-- 
    Document   : [模板文件管理表]编辑页
    Created on : 2018-11-01 16:22:40
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[模板文件管理表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="sysCodeTemp.id" />	
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysCodeTemp.id}" />
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>[模板文件管理表] 基本信息</caption>
					
					
			            <tr>
						<th>名称：</th>
						<td>
								<input name="name"  class="mini-textbox" />
						</td>
						<th>别名：</th>
						<td>
								<input name="alias"  class="mini-textbox" />
						</td>
						<th>生成文件后缀名：</th>
						<td>
								<input name="suffix"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>文件路径：</th>
						<td colspan="5">
								<input name="path"  class="mini-combobox" width="100%"/>
						</td>
						</tr>
				</table>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${sysCodeTemp.id}';
	$(function(){
		initPath();
		initForm();
	})
	
	function initPath(){
		var url="${ctxPath}/sys/code/sysCodeTemp/getPathAll.do";
		$.post(url,{},function(json){
			mini.getByName("path").setData(json);
		});
	}
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/sys/code/sysCodeTemp/getJson.do";
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
        	url:"${ctxPath}/sys/code/sysCodeTemp/save.do",
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