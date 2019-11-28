<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>验证规则对话框</title>
<%@include file="/commons/edit.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<style>
	.mini-layout-region{
		background: transparent;
	}
</style>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">	
	    <div region="south" showSplit="false" showHeader="false" height="40" showSplitIcon="false"  
	    	style="width:100%" bodyStyle="border:0;text-align:center;padding-top:5px;">
			
			    <a class="mini-button"   onclick="CloseWindow('ok');">确定</a>
			    <a class="mini-button"   onclick="CloseWindow('cancel');">取消</a>
				 
		 </div>
		     
	    <div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
			
			<table id="formExcel" class="table-detail" cellspacing="1" cellpadding="0">
				<caption>[验证规则配置]</caption>
				<tr>
					<td>
						<span class="starBox"> 名称
							<span class="star">*</span>
						</span>
					</td>
					<td colspan="3">
						<input name="name"
						value="" class="mini-textbox"
						required="true" style="width: 100%" />
					</td>
				</tr>
				<tr>
					<td >规则配置</td>
					<td colspan="3">
						<textarea id="script" name="conf" style="width:100%;height:380px"></textarea>
					</td>
				</tr>
			</table>
	</div>
		     
		  
		</div>
		<script type="text/javascript">
		mini.parse();
		
		function setData(valid){
			if(!valid)return;
			mini.getByName("name").setValue(valid.name);
			scriptEditor.setValue(valid.conf);
		}
		
		function getData(){
			var valid = {};
			valid.name = mini.getByName("name").getValue();
			valid.conf = scriptEditor.getValue();
			return {valid:valid,validName:valid.name};
		}
		
		var scriptEditor = CodeMirror.fromTextArea(document.getElementById('script'),{
	        lineNumbers: true,
	        matchBrackets: true,
	        mode: "text/x-groovy"
		});
		   	
	   	function onOk(){
	   		CloseWindow('ok');
	   	}
	   	
	   	function onCancel(){
	   		CloseWindow('cancel');
	   	}
	   	
    </script>
	
	
</body>
</html>