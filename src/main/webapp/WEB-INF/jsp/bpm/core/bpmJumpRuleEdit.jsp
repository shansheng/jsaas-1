
<%-- 
    Document   : [流程跳转规则]编辑页
    Created on : 2018-04-10 13:44:42
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[流程跳转规则]编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js" type="text/javascript"></script>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="bpmJumpRule.id">
		<div class="self-toolbar">
			<a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
		</div>
	</rx:toolbar>
	

	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${bpmJumpRule.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[流程跳转规则]基本信息</caption>
					<tr>
						<td>说明</td>
						<td colspan="3">
							流程跳转规则：是基于流程定义以外，提供运行时，动态更改流程的执行路径的规则设置方式。
						</td>
					</tr>
					<tr>
						<td>规则名：</td>
						<td>
							<input name="name" value="${bpmJumpRule.name}"
							class="mini-textbox"   style="width: 90%" required="true" />
						</td>
						<td>序号：</td>
						<td>
							<input id="sn" name="sn" class="mini-spinner" value="${bpmJumpRule.sn}" minValue="1" maxValue="20" />
						</td>
						
					</tr>
					<tr>
						<td>源节点：</td>
						<td>
							${bpmJumpRule.nodeName}
						</td>
						<td>目标节点：</td>
						<td>
							<input id="target" name="target" textName="targetName" class="mini-buttonedit" 
								emptyText="请输入..."  onbuttonclick="onSelectNode" selectOnFocus="true" style="width:90%"
								value="${bpmJumpRule.target}" text="${bpmJumpRule.targetName}" required="true"/>
							
						</td>
					</tr>
					<tr>
						<td>规则脚本：
							<br/>
							<a class="mini-button"   onclick="showExpressionEditor()">插入表达式</a>
						</td>
						<td colspan="3">
							<textarea name="rule" id="rule" rows="5" cols="60" >${bpmJumpRule.rule}</textarea>
						</td>
					</tr>
				
					<tr>
						<td>描述：</td>
						<td colspan="3">
							<textarea name="description" value="${bpmJumpRule.description}"
							class="mini-textarea" style="height:100px;width:90%" ></textarea>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="bpm/core/bpmJumpRule"
		entityName="com.redxun.bpm.core.entity.BpmJumpRule" />
	<script type="text/javascript">
		var nodeId="${bpmJumpRule.nodeId}";
		var nodeName="${bpmJumpRule.nodeName}";
		var solId="${bpmJumpRule.solId}";
		var actDefId="${bpmJumpRule.actdefId}";
		function onSelectNode(){
			var conf={single:"true",end:"true"};
			openSolutionNode(actDefId,conf,function(data){
				var obj=data[0];
				var target=mini.get("target");
				target.setText(obj.name);
				target.setValue(obj.activityId);
				target.doValueChanged();
			});
		}
		
		//显示编辑器
		function showExpressionEditor(){
			_OpenWindow({
				title:'表达式设计',
				iconCls:'icon-formula',
				url:__rootPath+'/bpm/core/bpmSolution/expEditor.do?solId='+solId+'&nodeId='+nodeId+'&actDefId='+actDefId,
				width:800,
				height:450,
				ondestroy:function(action){
					if(action!='ok') return;
					var win=this.getIFrameEl().contentWindow;
					var content=win.getFormula();
					addExp(content);
				}
			});
		}
		
		var editor = null;
		function initCodeMirror() {
			var obj = document.getElementById("rule");
			editor = CodeMirror.fromTextArea(obj, {
				matchBrackets : true,
				lineNumbers: true,
				mode : "text/x-groovy"
			});
			editor.setSize('auto', '200px');
		}
		
		function addExp(scriptText){
    		var doc = editor.getDoc();
       		var cursor = doc.getCursor(); // gets the line number in the cursor position
      		doc.replaceRange(scriptText, cursor); // adds a new line
    	}

		initCodeMirror() ;
		
		function handleFormData(data){
			for(var i=0;i<data.length;i++){
				var o=data[i];
				var name=o.name;
				if(name=="rule"){
					o.value=editor.getValue();
				}
			}
			data.push({name:"nodeId",value:nodeId});
			data.push({name:"nodeName",value:nodeName});
			data.push({name:"actdefId",value:actDefId});
			data.push({name:"solId",value:solId});
			
			var rtn={formData:data,isValid:true};
			return rtn;
		}

	</script>
</body>
</html>