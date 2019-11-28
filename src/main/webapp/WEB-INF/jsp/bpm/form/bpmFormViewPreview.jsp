<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>业务表单预览明细</title>
<%@include file="/commons/customForm.jsp"%>
<!-- 加上扩展控件的支持 -->
<link rel="stylesheet" href="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.css" />
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.js"></script>
<style type="text/css">
	.button-container{
        display: none;
    }
</style>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  plain="true" onclick="viewJson">查看JSON</a>
			<a class="mini-button"  plain="true" onclick="mini.layout();Print()">打印</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
			<div id="form-panel"  class="customform">
				<div class="form-model" id="formModel1">

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
				<div class="mini-fit rx-grid-fit">
					<div class="mini-tabs" style="height: 100%; width: 100%;padding-top:10px;">
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
	//mini.parse();
	$(window).resize(function() {
		mini.layout();
	});
	var formContent=null;
	function setContent(content,conf) {
		formContent=content;
		var dom = $(content);
		//取得其script的内容，并且加载到预览页面
		dom.filter('script').each(function() {
			if (this.src) {
				var script = document.createElement('script'), i, attrName, attrValue, attrs = this.attributes;
				for (i = 0; i < attrs.length; i++) {
					attrName = attrs[i].name;
					attrValue = attrs[i].value;
					script[attrName] = attrValue;
				}
				document.body.appendChild(script);
			} else {
				$.globalEval(this.text || this.textContent || this.innerHTML || '');
			}
		});
		
		$("#formModel1").append(content);
		
		renderMiniHtml(conf);
		
		initFieldSet();
	}
	//查看json
	function viewJson() {
		var data = _GetFormJsonMini('form-panel');
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