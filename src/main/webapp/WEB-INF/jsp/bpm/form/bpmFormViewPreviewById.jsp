<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>业务表单预览明细</title>
<%@include file="/commons/customForm.jsp"%>
<!-- 加上扩展控件的支持 -->
<link rel="stylesheet" href="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.css" />
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.js"></script>
<style>
	body{
		background: #f7f7f7;
	}
	
	.mini-toolbar{
		background: transparent;
		border: none;
	}
	
	#form-panel{
		margin-top: 10px;
	}
	
	#form-panel>table{
 		background: #fff; 
	}
	
	.mini-grid-cell{
		border-bottom-color: #ececec;
	}
	

	.Bauto{
		margin:20px auto;
		
	}
	.topBtn{
		text-align:right;
		
	}
	.mini-panel-viewport .mini-panel-toolbar{
		border-bottom:0;
	}
	.mini-panel-toolbar{
		text-align:left;
		padding-left:8px;
	}
	.mini-panel-body{
		background: #f0f0f0;
		padding: 0;
	}

</style>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="viewJson">查看JSON</a>
		</div>
	</div>
	<div class="mini-fit" >
		<div class="form-container" style="min-height: 100%;height: auto;">
			<div id="content" class="rx-grid-fit">
				<div id="form-panel"  class="customform ">
					<div class="form-model" id="formModel1" boDefId="${boDefId}" formKey="${formKey}">${html}</div>
				</div>
			</div>

			<div
				id="jsonWin"
				class="mini-window"
				iconCls="icon-script"
				title="JSON数据"
				style="width: 550px;
				height: 350px;
				display: none;"
				showMaxButton="true"
				showShadow="true"
				showToolbar="true"
				showModal="true"
				allowResize="true"
				allowDrag="true"
			>
				<div class="form-toolBox" style="text-align: right;margin-bottom: 10px">
						<a class="mini-button btn-red"  plain="true" onclick="hiddenWindow">关闭</a>
				</div>
				<div class="mini-fit rx-grid-fit" style="background: #fff;padding-top: 4px;box-sizing: border-box">
					<div class="mini-tabs" style="height: 100%; width: 100%" >
						<div title="JSON视图">
							<div id="jsonview" style="height: 100%; width: 100%"></div>
						</div>
						<div title="JSON数据">
							<textarea id="json" class="mini-textarea" style="height: 100%; width: 100%"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(function(){
		renderMiniHtml({});
		
	})
	
	//查看json
	function viewJson() {
		var data = getBoFormData(false);
		var win = mini.get("jsonWin");
		mini.get('json').setValue(mini.encode(data));
		$("#jsonview").jsonViewer(data);
		win.show();
	}

	function hiddenWindow() {
		var win = mini.get("jsonWin");
		win.hide();
	}
	
</script>
</body>
</html>