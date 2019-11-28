<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun"%>
<!DOCTYPE html>
<html>
<head>
	<title>流程活动节点的结束节点配置页</title>
	<%@include file="/commons/edit.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/xml/xml.js"></script>
	<script src="${ctxPath}/scripts/codemirror/addon/mode/multiplex.js"></script>
	<!-- code minitor end -->
	
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" plain="true"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button btn-red" plain="true"  onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<div style="display: none;">
			<input id="valueDefTextBox" class="mini-textbox" style="width: 100%;"
				minWidth="120" /> <input id="scriptEditor" class="mini-buttonedit"
				onbuttonclick="getScript" allowInput="false" style="width: 100%;" />
			<input id="constantEditor" class="mini-combobox"
				url="${ctxPath}/sys/core/public/getConstantItem.do" valueField="key"
				textField="val" style="width: 100%;" />
			<input id="popVarsEditor" class="mini-combobox"
				valueField="key" textField="name" style="width: 100%;" />
			<input id="formVarsEditor" class="mini-combobox"
				valueField="name" textField="comment" style="width: 100%;" />
	</div>
	<div class="mini-fit">
			<c:if test="${fn:length(configVars)>0}">
				<ul id="popVarsMenu" style="display:none" class="mini-menu">
		 			<c:forEach items="${configVars}" var="var">
			 			<li   onclick="appendScript('${var.key}')">${var.name}[${var.key} (${var.type})] </li>
			 		</c:forEach>
				</ul>
 			</c:if>
		<div class="form-outer">
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>服务请求配置</caption>
					<tr>
						<td >
							服务设置<span class="star">*</span>
						</td>
						<td >
							<input id="set" class="mini-buttonedit icon-dep-button"  required="true" allowInput="false" onbuttonclick="selectDataBind" style="width:60%"/>
							<a class="mini-button" onclick="onNewWebReqDef()">新建请求定义</a>
						</td>
						<td colspan="2">
							<a class="mini-button"  onclick="loadApp">测试</a>
						</td>
					</tr>
					<tr>
						<td >
							<span class="starBox">
								请求别名: 
							</span>
						</td>
						<td><span id="key"></span></td>
						<td >请求地址:  </td>
						<td><span id="url"></span></td>
					</tr>
                    <tr>
                        <td> 出错是否继续</td>
                        <td colspan="3"><input class="mini-checkbox" name="isContinue" /></td>
                    </tr>

                    <tr>
                        <td>
                            重试次数
                        </td>
                        <td>
                            <input name="retryTime" class="mini-spinner"/>
                        </td>
                        <td>
                            重试间隔（分）
                        </td>
                        <td>
                            <input name="retryInterval" class="mini-spinner"  />
                        </td>
                    </tr>

					<tr>
						<td>
							参数配置
						</td>
						<td colspan="3">
						<div id="tabs" class="mini-tabs" activeIndex="0" onactivechanged="activeChanged">
							<div title="参数设置">
								<div id="gridWhere" class="mini-datagrid" style="width: 100%;"
								showPager="false" allowCellEdit="true" allowCellSelect="true"
								oncellbeginedit="gridWhereCellBeginEdit" allowAlternating="true">
									<div property="columns">
										<div type="indexcolumn" width="40">序号</div>
										<div field="key" width="120" headerAlign="center">键</div>
										<div field="description"  width="120" headerAlign="center">说明</div>
										<div name="valueSource" field="valueSource" vtype="required"
											width="100" renderer="onvalueSourceRenderer" align="center"
											headerAlign="center" editor="valueSourceEditor">
											值来源 <input property="editor" class="mini-combobox"
												data="valueSource" />
										</div>
										<div name="valueDef" field="valueDef" width="180"
											headerAlign="center">默认值</div>
									</div>
							  </div>
							</div>
							<div title="请求报文">
								<textarea id="listHtml" name="listHtml" ></textarea>
							</div>
							<div title="返回内容">
								<textarea id="responseHtml" name="responseHtml" ></textarea>
							</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td>
							调用后执行脚本
						</td>
						<td colspan="3">
								<div class="mini-toolbar" style="margin-bottom:2px;padding:10px;">
							 		<a class="mini-menubutton "    menu="#popVarsMenu" >插入流程变量</a>
							 		<a class="mini-button"  plain="true" onclick="showFormFieldDlg()">从表单中添加</a>
							 		<a class="mini-button"  href="javascript:showScriptLibary()">常用脚本</a>
							 		<div class="div-helper" >
						    			<div  class="iconfont helper icon-Help-configure" title="帮助" placement="w" helpid="scriptHelp"></div>
						    		</div>
								</div>
								    
						    	<div>
						    		<div style="width:100%;border-bottom: solid 1px #ccc">在此编写Groovy脚本，<a href="#">帮助</a> &nbsp; <a href="javascript:showScriptLibary()">常用脚本</a> </div>
						    		<textarea id="script" class="textarea" name="script" style="width:99%;"></textarea>
						    	</div>
						</td>
					</tr>
					
				</table>
			
		</div>
	</div>
<div style="display:none;width:300px;" id="scriptHelp">
<pre>
上下文变量:
vars:流程变量为一个MAP对象。
data:表单数据对象为一个MAP对象。
actInstId:流程实例ID。
cmd:cmd对象。
execution:execution 对象，同步方法中可以使用。
result: WEB调用后返回的结果数据。

</pre>
</div>
	<script type="text/javascript">
		var solId="${param['solId']}";
		var nodeType="${param['nodeType']}";
		var nodeId="${param['nodeId']}";
		var actDefId="${param['actDefId']}";

		mini.parse();
		var tabs = mini.get("tabs");
		var popVarsEditor = mini.get("popVarsEditor");
		var formVarsEditor = mini.get("formVarsEditor");
		
		var grid = mini.get("gridWhere");
		var dataBind = null;
		
		var editor=null;
		var editor1=null;
		var editor2=null;
		
		//加载请求报文
		initCodeMirror();
		//加载脚本
		initCodeMirror1();
		
		function setData(setting){
			popVarsEditor.setData(mini.decode('${configVarsJson}'));
			formVarsEditor.setData(${formVarsJson});
			if(!setting)return;
			//初始化参数数据
			grid.setData(mini.decode(setting.paramsData));
			editor1.setValue(setting.script);
			//初始化
			init(setting.key);
		}
		
		function init(key){
			$.ajax({
	             type: "POST",
	             url: __rootPath+"/sys/webreq/sysWebReqDef/getKey.do",
	             data: {key:key},
	             dataType: "json",
	             success: function(data){
	             	var key = data.key;
	             	var text = data.name;
				 	var url = data.url;
				 	var temp = data.temp;
				 	
				 	var aa = mini.get("set");
				 	aa.setText(text);
				 	$("#key").text(key);
				 	$("#url").text(url);
				 	editor.setValue(temp);
	             }
	         });
		}
		
		function initCodeMirror(){
			//请求报文文本框渲染
			CodeMirror.defineMode("selfHtml", function(config) {
				return CodeMirror.multiplexingMode(
					CodeMirror.getMode(config, "text/xml"),
					{open: "<<", close: ">>",
					mode: CodeMirror.getMode(config, "text/plain"),
					delimStyle: "delimit"}
					);
			});
			editor = CodeMirror.fromTextArea(document.getElementById("listHtml"), {
					  mode: "selfHtml",
					  lineNumbers: true,
					  lineWrapping: true,
					  readOnly:"nocursor"
				});
			editor.setSize('auto','100%');
			
			editor2 = CodeMirror.fromTextArea(document.getElementById("responseHtml"), {
				  mode: "selfHtml",
				  lineNumbers: true,
				  lineWrapping: true
			});
			editor2.setSize('auto','100%');
		}
		function initCodeMirror1() {
			var obj = $("#script");
			var h=$("body").height()-550;
			editor1 = CodeMirror.fromTextArea(obj[0], {
				matchBrackets : true,
				mode : "text/x-groovy"
			});
			
			editor1.setSize('auto', h);
		}

		//tab改变时修改
		function activeChanged(e){
			editor.refresh();
			editor2.refresh();
		}
		
		//在当前活动的tab下的加入脚本内容
		function appendScript(scriptText){
       		var doc = editor1.getDoc();
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
		
		//显示对话框
		function onSelDialog(e,url,title){
			var btnEdit=e.sender;
			mini.open({
				url : url,
				title : title,
				width : 650,
				height : 380,
				ondestroy : function(action) {
					if(!action || action=="cancel")return;
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);
					if (data) {
						btnEdit.setValue(data.id);
						btnEdit.setText(data.name);
					} else {
						btnEdit.setValue(null);
						btnEdit.setText(null);
					}
					var key = action.key;
					var url = action.url;
					var temp = action.temp;
					
					$("#key").text(key);
					$("#url").text(url);
					editor.setValue(temp==null?'':temp);
					grid.setData(mini.decode(action.data));
				}
			});
		}
		
		function getScript(e) {
			var buttonEdit = e.sender;
			var row = mini.get("gridWhere").getSelected();
			var scriptContent = typeof (row.valueDef) == 'undefined' ? ""
					: row.valueDef;

			_OpenWindow({
				url : __rootPath + "/sys/db/sysDb/scriptDialog.do",
				title : "脚本内容",
				height : "450",
				width : "600",
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setScript(scriptContent);
				},
				ondestroy : function(action) {
					if (action != 'ok')
						return;
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.getScriptContent();
					buttonEdit.value = data;
					buttonEdit.text = data;
				}
			});
		}
		
		//服务设置
		function selectDataBind(e){
			var url = __rootPath+"/sys/webreq/sysWebReqDef/dialog.do";
			onSelDialog(e,url,"选择服务设置");
		}
		var valueSource = [ {
			id : "bpmParam",
			text : '流程变量'
		}, {
			
			id : "formParam",
			text : '表单参数'
		}, {
			id : "fixedVar",
			text : '固定值'
		}, {
			id : "script",
			text : '脚本'
		}, {
			id : "constantVar",
			text : '常量'
		} ];
		function onvalueSourceRenderer(e) {
			for (var i = 0, l = valueSource.length; i < l; i++) {
				var g = valueSource[i];
				if (g.id == e.value)
					return g.text;
			}
			return "";
		}
		
		//单元格开始编辑事件处理
		function gridWhereCellBeginEdit(e) {
			var field = e.field;
			var record = e.record;
			if (field == 'valueDef') {
				if (record.valueSource == '' || !record.valueSource)
					e.cancel = true;
				else if (record.valueSource == 'formParam')
					e.editor = mini.get("formVarsEditor");
				else if (record.valueSource == 'bpmParam')
					e.editor = mini.get("popVarsEditor");
				else if (record.valueSource == 'script')
					e.editor = mini.get("scriptEditor");
				else if (record.valueSource == 'constantVar')
					e.editor = mini.get("constantEditor");
				else
					e.editor = mini.get("valueDefTextBox");
			}
			e.column.editor = e.editor;
			curGrid = e.sender;
		}

		//保存配置信息
		function getData(){
			var dataGridWhere = grid.getData();
			var paramsData = [];

			for (var i = 0; i < dataGridWhere.length; i++) {
				var obj = {};
				obj.key = dataGridWhere[i].key;
				obj.description = dataGridWhere[i].description;
				obj.valueSource = dataGridWhere[i].valueSource;
				obj.valueDef = dataGridWhere[i].valueDef;
				paramsData.push(obj);
			}
			var script=editor1.getValue();
			var configJson={type:"HttpInvoke",paramsData:paramsData,key:$("#key").text(),script:script};
			return configJson;
		}
		
		function loadApp(){
			var url = __rootPath +"/sys/webreq/sysWebReqDef/start.do";
			config = {
					key:$("#key").text(),
					paramsData : mini.encode(grid.getData())
				};
			postSubmit(url,config);
		}
		
		function getTabShow(title,flag){
			var ary = tabs.getTabs();
			for(var i=0;i<ary.length;i++){
				var obj = ary[i];
				if(obj.title==title){
					tabs.updateTab(obj, {
						visible : flag
					});
					return obj;
				}
			}
		}
        /**
		 * 新建Web请求定义
         */
		function onNewWebReqDef(){
			_OpenWindow({
				url:__rootPath+'/sys/webreq/sysWebReqDef/edit.do',
				title:'新建Web请求定义',
				height:450,
				width:700
			});
		}
		
		function postSubmit(url,config){
			$.post(url,config,function(data){
				if(data.success){
					editor2.setValue(data.data);
					if(data.message!=""){
						mini.showTips({content:data.message});
					}
					tabs.activeTab(getTabShow("返回内容",true));
				}
				else{
					alert("出错信息:" +data.message);
				}
			});
		}
	</script>
</body>
</html>
	