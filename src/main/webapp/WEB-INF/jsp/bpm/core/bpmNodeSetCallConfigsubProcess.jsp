<%@page contentType="text/html" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html>
<html>
<head>
	<title>流程全局事件或节点接口调用配置--SubProcess调用</title>
	<%@include file="/commons/edit.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
</head>
<body>


	<div id="div_toolbar1" class="topToolBar" >
		<div>
			<a class="mini-button" plain="true"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button" plain="true"  onclick="CloseWindow()">关闭</a>		
		</div>
	</div>
	
	<table class="table-detail column_2_m"  cellspacing="1" cellpadding="0" style="width:100%;">
		<caption>SubProcess接口调用</caption>
		<tr>
			<td>子流程</td>
			<td>
				<input id="subProcess" class="mini-combobox" data='${subProcess}' valueField="alias" textField="name"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<ul id="popVarsMenu" style="display:none" class="mini-menu">
		 			<c:forEach items="${configVars}" var="var">
			 			<li   onclick="appendScript('${var.key}')">${var.name}[${var.key} (${var.type})] </li>
			 		</c:forEach>
			    </ul>
				<div class="mini-toolbar" style="margin-bottom:2px;padding:10px;display:inline-block;">
			 		<a class="mini-menubutton "    menu="#popVarsMenu" >插入流程变量</a>
			 		<a class="mini-button" plain="true" onclick="showFormFieldDlg()">从表单中添加</a>
			 		<a class="mini-button"  href="javascript:showScriptLibary()">常用脚本</a>
			 		常量:
					<input  id="constantItem" class="mini-combobox" showNullItem="true" nullItemText="可用常量"
						url="${ctxPath}/sys/core/public/getConstantItem.do" valueField="key" textField="val" 
						onvalueChanged="constantFreeChanged" 
					/>
		 			数据源:<input class="mini-buttonedit" name="dbAlias" onbuttonclick="selDataSource" showClose="true" oncloseclick="_ClearButtonEdit"></div>
		 		</div>
		 		<div class="div-helper" >
   					<div  class="iconfont helper icon-Help-configure" placement="w" title="帮助" helpid="scriptHelp"></div>
   				</div>
		 		
			</td>
		</tr>
		<tr>
			<td width="100px">满足条件</td>
			<td>
				
				<textarea id="script" name="script" style="width:100%;height:350px"></textarea>
			</td>
		</tr>
		
	</table>
	
	<div style="display:none" id="scriptHelp">
	<pre>
java.uitl.List params=new java.util.ArrayList();
String myId=com.redxun.saweb.util.IdUtil.getId();
params.add(myId);
//其中form1为表单的标识键，name为表单下的字段
params.add(form1_name);
String sql="insert abc(ID_,NAME_)values(?,?)";
//sqlScript为系统默认的实现了com.redxun.core.script.GroovyScript Spring的Bean
sqlScript.doExecuteSql(sql,params);	
	</pre>
</div>
	
		
	<script type="text/javascript">
		mini.parse();
		
		initHelp();

		var scriptEditor = CodeMirror.fromTextArea(document.getElementById('script'),{
	        lineNumbers: true,
	        matchBrackets: true,
	        mode: "text/x-groovy"
		});
		scriptEditor.setSize('auto','150');
		var subCombobox = mini.get("subProcess");
		
		function constantFreeChanged(e){
			appendScript(e.value);
		}
		
		//在当前活动的tab下的加入脚本内容
		function appendScript(scriptText){
       		var doc = scriptEditor.getDoc();
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
		
		function selDataSource(e){
			var btn=e.sender;
			_OpenWindow({
				title:'数据源选择',
				height:480,
				width:700,
				url:__rootPath+'/sys/core/sysDatasource/dialog.do',
				ondestroy:function(action){
					if(action!='ok') return;
					var iframe=this.getIFrameEl();
					var data=iframe.contentWindow.GetData();
					btn.setText(data.alias);
					btn.setValue(data.alias);
				}
			});
		}
		
		//获得脚本的配置 
		function getData(){
			return {subProcess:subCombobox.getValue(),script:scriptEditor.getValue()};
		}
		
		function setData(data){
			if(!data) return;
			if(data.subProcess){
				subCombobox.setValue(data.subProcess);
			}
			scriptEditor.setValue(data.script);
		}
		
	</script>
</body>
</html>
