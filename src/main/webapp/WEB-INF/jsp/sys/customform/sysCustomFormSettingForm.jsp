<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[单据表单方案]编辑</title>
<%@include file="/commons/customForm.jsp"%>
<script type="text/javascript" src="${ctxPath }/scripts/sys/customform/customform.js"></script>
<script type="text/javascript">

	var buttonDef='${setting.buttonDef}' || '[]';
	var solId='${setting.solId}';
	var setting={alias:"${setting.alias}"};
	var isTree=${setting.isTree};
	var canStartFlow=${canStartFlow};
	var afterJs=${hasAfterJs};
	var form = "edit";
	//["打印"]
	var hideBtns=[];
	//角色列表
	var osGroupArray = "${osGroupArray}";

	$(function(){
		loadButtons(hideBtns);
		//解析表单。
		renderMiniHtml({});
		//初始化表单状态
		initFormElementStatus();
	})
	
	
	
	
	function handleFormData(data){
		${setting.preJsScript}
		//处理树
		if(isTree){
			if(!window.selectNode)return;
			data.REF_ID_ = window.selectNode.ID_;
		}
	}
	
	function handleData(data){
		data.setting=setting;
	}
	
	function successCallback(result){
		if(isTree==1 && typeof(tree)!="undefined"){
			var action=result.data.action;
			var row=result.data.row;
			if(action=="add"){
				tree.addNode(row, "add", selectNode);
			}
			else{
				tree.updateNode(selectNode,{text_:row.text_});
			}
		}
		if(afterJs){
			${setting.afterJsScript}
		}
		else{
			closeWin('ok');	
		}
	}
	
	if(!$('.mini-window',parent.document).length){
		$('.mini-tabs-body:visible', parent.document).addClass('index_box');
		$('.show_iframe:visible', parent.document).addClass('index_box');
	}
	
	function onPrint(){
		printForm({formAlias:"${setting.formAlias}"});
	}
	
	
	
</script>
<script type="text/javascript">
${setting.customJsScript}
</script>
<style>
	*{
		color: #666;
	}
	.paddingBox{
		padding:6px;
		box-sizing: border-box;
	}
	.paddingBox .shadowBox{
		box-shadow: none;
		padding: 0;
		margin-bottom: 0;
		border-radius: 0;
	}
	.paddingBox>input{
	    border: 1px solid #ececec;
	    box-sizing: border-box;
	    border-radius: 4px;
	    padding: 4px;
	}
	
	.paddingBox>*,
	.paddingBox .shadowBox>*{
		width: 100% !important;
	}
	.mini-toolbar{
		background: transparent;
		border: none;
		overflow:hidden;
	}
	.topBar .mini-button,
	body #toptoolbar>a:hover.mini-button{
		border-color: #fff;
	}
	#toptoolbar{
		text-align:right;
	
	}
</style>
</head>
<body>
	
	<div class="topToolBar">
		<div id="btttonContainer"></div>
	</div>
	<script type="text/html;" id="buttonTemplate">
		<#for(var i=0;i<buttons.length;i++){
			var btn=buttons[i];
		#>
		<a class="mini-button" <#if(btn.icon){#>  <#}#> onclick="<#=btn.method#>"><#=btn.name#></a>
		<#}#>
	</script>
	<div class="mini-fit">
		<div class="form-container">
			<div class="customform  form-model"
				 boDefId="${formModel.boDefId}"
				 id="form-panel"
				 action="/sys/customform/sysCustomFormSetting/saveData.do"
			>
				${formModel.content}
			</div>

		</div>
	</div>
	
</body>
</html>