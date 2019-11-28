<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun"%>
<!DOCTYPE html>
<html>
<head>
	<title>流程活动节点的结束节点配置页</title>
	<%@include file="/commons/edit.jsp"%>
		<!-- code codemirror start -->	
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
	<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
	<!-- code minitor end -->
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" plain="true"  onclick="saveConfig">保存</a>
			<a class="mini-button" plain="true" onclick="CloseWindow()">关闭</a>	
		</div>
	</div>
	
	
	
	<div class="mini-fit">
	  	
		
			<c:if test="${fn:length(configVars)>0}">
				<ul id="popVarsMenu" style="display:none" class="mini-menu">
		 			<c:forEach items="${configVars}" var="var">
			 			<li iconCls="icon-var"  onclick="appendScript('${var.key}')">${var.name}[${var.key} (${var.type})] </li>
			 		</c:forEach>
				</ul>
	 		</c:if>
	       	
	       	<div class="mini-toolbar" style="margin-bottom:2px;padding:10px;">
		 		<a class="mini-menubutton "  iconCls="icon-var"  menu="#popVarsMenu" >插入流程变量</a>
		 		<a class="mini-button" iconCls="icon-formAdd" plain="true" onclick="showFormFieldDlg()">从表单中添加</a>
		 		<a class="mini-button" iconCls="icon-script" href="javascript:showScriptLibary()">常用脚本</a>
			</div>
			    
	    	<div>
	    		<div style="width:100%;border-bottom: solid 1px #ccc">在此编写Groovy脚本，<a href="#">帮助</a> &nbsp; <a href="javascript:showScriptLibary()">常用脚本</a> </div>
	    		<textarea id="script" class="textarea" name="script" style="width:99%;"><c:if test="${not empty setting }">${setting.script }</c:if></textarea>
	    	</div>
			
	   
	</div>
	<script type="text/javascript">
		var solId="${param['solId']}";
		var nodeType="${param['nodeType']}";
		var nodeId="${param['nodeId']}";
		var actDefId="${param['actDefId']}";
		
		
		mini.parse();
		
		var editor=null;
		
		
		function initCodeMirror() {
			var obj = $("#script");
			var h=$("body").height()-150;
			editor = CodeMirror.fromTextArea(obj[0], {
				matchBrackets : true,
				mode : "text/x-groovy"
			});
			
			editor.setSize('auto', h);
		}
		
		initCodeMirror();
		
		//在当前活动的tab下的加入脚本内容
		function appendScript(scriptText){
       		var doc = editor.getDoc();
       		var cursor = doc.getCursor(); // gets the line number in the cursor position
      		doc.replaceRange(scriptText, cursor); // adds a new line
		}
		
		function showFormFieldDlg(){
			openFieldDialog({
				nodeId:'${param.nodeId}',
				actDefId:'${param.actDefId}',
				solId:'${param.solId}',
				callback:function(fields){
					for(var i=0;i<fields.length;i++){
						if(i>0){
							appendScript(' ');
						}
						var f=fields[i].formField.replace('.','_');
						appendScript(f);
					}
				}
			})
		}
		
		//显示脚本库
		function showScriptLibary(){
			_OpenWindow({
				title:'脚本库',
				iconCls:'icon-script',
				url:__rootPath+'/bpm/core/bpmScript/libary.do',
				height:450,
				width:800,
				onload:function(){
					
				},
				ondestroy:function(action){
					if(action!='ok'){
						return;
					}
					var win=this.getIFrameEl().contentWindow;
					var row=win.getSelectedRow();
					
					if(row){
						 appendScript(row.example);
					}
				}
			});
		}
	
		//保存配置信息
		function saveConfig(){
			var script=editor.getValue();
			var configJson={type:"Script",script:script};
			_SubmitJson({
				url:__rootPath+'/bpm/core/bpmNodeSet/saveNodeConfig.do',
				method:'POST',
				data:{
					solId:solId,
					nodeType:nodeType,
					nodeId:nodeId,
					actDefId:actDefId,
					configJson:mini.encode(configJson)
				},
				success:function(text){
					CloseWindow();
				}
			});
		}
	</script>
</body>
</html>
	