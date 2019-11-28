<%-- 
    Document   : [自定义查询]编辑页
    Created on : 2017-02-21 15:32:09
    Author     : cjx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]预览</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">
	.search-ui::after{
		clear:both;
		display: block;
		content:'' ;
	}
	.search-ui li{
		float:left;
	}
</style>
</head>
<body>
<body>

		<input id="pkId" name="id" class="mini-hidden" value="${invokeScript.id}" />
		<input id="alias" name="alias" class="mini-hidden" value="${invokeScript.key}" />
<div class="fitTop"></div>
<div class="mini-fit">
		<div class="form-container">
			<div class="mini-toolbar">
				<div class="searchBox">
					<form id="form1" class="search-form">
						<ul>
							<li><a class="mini-button"  plain="true" onclick="doCustomQuery()">查询</a></li>
							<li><a class="mini-button" plain="true" onclick="clearQuery()">清空查询</a></li>

						</ul>
					</form>
				</div>
			</div>
			参数设置:
			<div style="width:100%;">
				<textarea class="mini-textarea" id="params" name="params" emptyText="请输入"  style="width:100%;height:200px;"></textarea>
			</div>
			返回JSON数据:
			<div style="width:100%;">
				<textarea class="mini-textarea" id="sqlDiy" name="sqlDiy" emptyText="请输入"  style="width:100%;height:350px;"></textarea>
			</div>
		</div>
</div>
	<script type="text/javascript">
		mini.parse();
		function clearQuery() {
			mini.get("sqlDiy").setValue('');
			mini.get("params").setValue('');
		} 

		function doCustomQuery(){
			var formData=mini.get("params").getValue();
			var callBack=function(result){
				var dataJson = JSON.stringify(result.data);
				mini.get("sqlDiy").setValue(dataJson);
			};
			invokeScript('${name}',formData,callBack);
		}
	</script>
</body>
</html>