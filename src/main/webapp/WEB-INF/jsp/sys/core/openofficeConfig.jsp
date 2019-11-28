<%-- 
    Document   : [BpmSolUsergroup]编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>soffice开关</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body >
	<div id="div_toolbar1" class="topToolBar" >
		<div>
		   	 <a class="mini-button" plain="true" onclick="saveConfig">保存</a>
		</div>
	</div>
<div class="mini-fit">
	<div id="form" class="form-container">
		<div style="margin:auto;padding:20px;">

			<div id="spanResult" ></div>
		</div>
			<table id="openOfficeTable" class="table-detail" >

				<tr>
					<td >
						<label for="openOffice_installPath$text">安装路径：</label>
					</td>
					<td>
						<input name="installPath" class="mini-textbox" required="true" width="300px"/>
						<div>说明：需要在服务端安装<a href="http://www.openoffice.org/">OpenOffice</a>服务，并且配置以下信息，可实现在线查看Office文档。</div>
					</td>
				</tr>
				<tr>
					<td >
						<label  >启动服务的IP：</label>
					</td>
					<td>
						<input name="service_ip" class="mini-textbox" required="true" />
					</td>
				</tr>
				<tr>
					<td>
						<label  >启动服务的端口：</label>
					</td>
					<td>
						<input  name="service_port" class="mini-textbox" required="true" />
					</td>
				</tr>
				<tr>
					<td>
						<label>是否开启openOffice转换功能：</label>
					</td>
					<td>
						<input   name="enabled" class="mini-checkbox" trueValue="YES" falseValue="NO" />
					</td>
				</tr>


			</table>

	</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form");

		$(function() {
			var url=__rootPath +"/sys/core/openoffice/getOfficeConfig.do";
			$.get(url,function(result){
				var success=result.success;
				$("#spanResult").html(result.message);
				var config=eval("(" +  result.data +")");
				form.setData(config);
			})
		});

		function saveConfig(){
			var config=JSON.stringify( form.getData());
			var url=__rootPath +"/sys/core/openoffice/updateOfficeConfig.do";
			_SubmitJson({
				url:url,
				data:{configJson:config}
			})
		}

	</script>
</body>
</html>
