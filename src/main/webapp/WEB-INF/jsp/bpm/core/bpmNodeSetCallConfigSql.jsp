<%@page contentType="text/html" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html>
<html>
<head>
	<title>流程全局事件或节点接口调用配置--SQL调用配置</title>
	<%@include file="/commons/edit.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
</head>
<body>

	<div class="topToolBar">
		<div>
			<a class="mini-button" plain="true"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button" plain="true"  onclick="CloseWindow()">关闭</a>		
		</div>
	</div>
	
	<table class="table-detail column_2_m"  cellspacing="1" cellpadding="0" style="width:100%;">
		<caption>调用SQL配置</caption>
		<tr>
			<td colspan="2">
				<ul id="popVarsMenu" style="display:none" class="mini-menu">
		 			<c:forEach items="${configVars}" var="var">
			 			<li   onclick="appendScript('${var.key}')">${var.name}[${var.key} (${var.type})] </li>
			 		</c:forEach>
			    </ul>
				<div class="mini-toolbar" style="margin-bottom:2px;padding:10px;">
			 		<a class="mini-menubutton "   menu="#popVarsMenu" >插入流程变量</a>
			 		<a class="mini-button"  plain="true" onclick="showFormFieldDlg()">从表单中添加</a>
			 		常量:
					<input id="constantItem" class="mini-combobox" showNullItem="true" nullItemText="可用常量"
						url="${ctxPath}/sys/core/public/getConstantItem.do" valueField="key"  textField="val"
						onvalueChanged="constantFreeChanged" />
		 			数据源:<input class="mini-buttonedit" id="dbAlias" name="dbAlias" onbuttonclick="selDataSource" showClose="true" oncloseclick="_ClearButtonEdit"></div>
		 		</div>
			</td>
		</tr>
		<tr>
			<td>
				<textarea id="script" name="script" style="width:100%;height:380px"></textarea>
			</td>
		</tr>
	</table>
		
	<script type="text/javascript">
		mini.parse();
		
		var dbAliasEditor=mini.get("dbAlias");
		var scriptEditor = CodeMirror.fromTextArea(document.getElementById('script'),{
	        lineNumbers: true,
	        matchBrackets: true,
	        mode: "text/x-sql"
		});
		
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
							appendScript(',');
						}
						var f=fields[i].formField.replace('.','_');
						var str="$" +"{" + f + "}";
						appendScript(str);
					}
				}
			})
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
			var sql=scriptEditor.getValue();
			var json={dbAlias:dbAliasEditor.getValue(),sql:sql};
			return JSON.stringify(json);
		}
		
		function setData(setting){
			if(!setting) return;
			setting=setting.trim();
			if(setting.startWith("{")){
				var obj=eval("("+setting+")");
				dbAliasEditor.setText(obj.dbAlias);
				dbAliasEditor.setValue(obj.dbAlias);
				scriptEditor.setValue(obj.sql);	
			}
			else{
				scriptEditor.setValue(setting);
			}
		}
		
	</script>
</body>
</html>
