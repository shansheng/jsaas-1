<%@page contentType="text/html" pageEncoding="UTF-8"
		deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html>
<html>
<head>
	<title>流程活动节点的配置页</title>
	<%@include file="/commons/edit.jsp"%>
	<!-- code codemirror start -->
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
	<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>

	<script src="${ctxPath}/scripts/flow/solution/eventSetting.js" type="text/javascript"></script>
	<!-- code minitor end -->
	<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip-blue.css" />
	<script type="text/javascript">
		//设置左分隔符为 <!
		baidu.template.LEFT_DELIMITER='<!';
		//设置右分隔符为 <!
		baidu.template.RIGHT_DELIMITER='!>';
	</script>
</head>
<body>
<script id="rightTemplate" type="text/html">
	<table class="table-detail column-four" >
		<tr>
			<td>子表名</td>
			<td>权限</td>
		</tr>
		<!for(var key in data){
		var json=data[key];
		!>
		<tr class="trName" tbName="<!=key!>">
			<td class="tbName" width="150"><!=key!>(<!=json.comment!>)</td>
			<td class="tbRight" width="450">

				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="user" <!if(json.type=='user'){!>checked='checked'<!}!> />当前用户</label>
				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="group" <!if(json.type=='group'){!>checked='checked'<!}!>/>当前用户组</label>
				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="sql" <!if(json.type=='sql'){!>checked='checked'<!}!>/>SQL</label>
				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="all" <!if(json.type=='all'){!>checked='checked'<!}!>/>全部</label>
				<div class="sql" <!if(json.type!='sql'){!>style="display:none;"<!}!>>
					<div style="margin-top: 6px">
						常&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						量：
						<select onchange='changeConstant(this)' style="width:200px;">
						<!for(var i=0;i<vars.length;i++){
						var obj=vars[i];
						!>
						<option value="<!=obj.key!>"><!=obj.val!></option>
						<!}!>
						</select>
					</div>
					<div style="margin: 6px 0">字段选择：
						<input id="fieldTree" onvaluechanged="fieldSelect" class="mini-treeselect" url="<!=ctx!>/sys/bo/sysBoEnt/getTreeByBoDefId.do?boDefId=<!=boDefId!>"
									   expandOnLoad="true"   popupWidth="200"  parentField="pid" textField="text" valueField="id" />
					</div>
					<div>通用字段：
						<input id="commonTree" onvaluechanged="fieldSelect" class="mini-treeselect" url="<!=ctx!>/sys/bo/sysBoEnt/getCommonField.do"
								expandOnLoad="true"   popupWidth="200"  parentField="pid" textField="text" valueField="id" />
					</div>

					<textarea tbName="<!=key!>" style="width:600px;height:100px">
					 <!if(json.sql){!><!=json.sql!><!}else{!>select * from w_<!=key!> where REF_ID_=#{fk}  <!}!>
					</textarea>
				<div>
			</td>
		</tr>
		<!}!>
	</table>
</script>
<div style="display: none">
	<input id="prevIdentityEditor" class="mini-buttonedit" onbuttonclick="onPrevIdentityClick" style="width: 100%;" minWidth="200" />
	<input id="signIdentityEditor" class="mini-buttonedit" onbuttonclick="onSignIdentityClick" style="width: 100%;" minWidth="200" />
</div>

<div class="topToolBar">
	<div>
		<a class="mini-button" plain="true"  onclick="saveConfig">保存</a>
		<a class="mini-button btn-red" plain="true" onclick="CloseWindow()">关闭</a>
	</div>
</div>
<div class="mini-fit">
<div id="configForm" class="form-container">
	<div id="baseTab" class="mini-tabs" activeIndex="0" style="width: 100%; height: 100%;">
		<div title="选项配置" >
			<table class="table-detail column-four" cellspacing="1"
				   cellpadding="0" style="width: 100%;">
				<tbody>
				<tr>
					<td width="150">自定义审批按钮</td>
					<td>
						<div name="allowConfigButtons" class="mini-checkbox"
							 checked="${allowConfigButtons}"
							 onvaluechanged="changeConfigButtons"
							 falseValue="false" trueValue="true"></div>
					</td>
					<td width="150">可选择执行路径</td>
					<td>
						<div name="allowPathSelect" class="mini-checkbox"
							 checked="${allowPathSelect}"
							 falseValue="false" trueValue="true"></div>
					</td>
				</tr>

				<tr>
					<td>可打印表单</td>
					<td>
						<div name="allowPrint" class="mini-checkbox"
							 checked="${allowPrint}" falseValue="false" trueValue="true"></div>
					</td>
					<td>可选择执行人</td>
					<td>
						<div name="allowNextExecutor" class="mini-checkbox"
							 checked="${allowNextExecutor}"
							 falseValue="false" trueValue="true"></div>
					</td>
				</tr>
				<tr>
					<td>允许执行人为空</td>
					<td >
						<div name="allowEmptyExecutor" class="mini-checkbox"
							 checked="${allowEmptyExecutor}"
							 falseValue="false" trueValue="true"></div>
					</td>
					<td>允许更改路径</td>
					<td >
						<div name="allowChangePath" class="mini-checkbox"
							 checked="${allowChangePath}"
							 falseValue="false" trueValue="true"></div>
					</td>
				</tr>
				<tr>
					<td>通知配置</td>
					<td>
						<div name="notices" class="mini-checkboxlist" value="${notices}"
							 textField="text" valueField="name"
							 url="${ctxPath}/bpm/core/bpmConfig/getNoticeTypes.do"></div>
					</td>
					<td>驳回配置</td>
					<td>
						<div name="jumpTypes" class="mini-checkboxlist" value="${jumpTypes}"
							 textField="text" valueField="id"
							 data="[{id:'BACK',text:'驳回(上一节点)'},{id:'BACK_TO_STARTOR',text:'驳回(发起人)'},{id:'BACK_SPEC',text:'驳回指定节点'}]"></div>
					</td>
				</tr>
				<tr>
					<td>外部表单URL</td>
					<td>
						<input class="mini-textbox" name="extFormUrl" value="${extFormUrl}" width="400px" />
						<div class="div-helper" >
							<div  class="iconfont helper icon-Help-configure" placement="s" title="帮助" helpid="urlHelp"></div>
						</div>
					</td>
					<td>表间公式</td>
					<td >
						<input id="btnFormula" name="formulaId" textName="formulaName"
							   style="width: 90%" class="mini-buttonedit" showClose="true" text="${formulaName}"
							   oncloseclick="_ClearButtonEdit" onbuttonclick="onFormulaSelect" value="${formulaId}"/>
					</td>
				</tr>
				
				<tr>
					<td>超时设置</td>
					<td colspan="3">
						绑定工作日历：<input id="btnCalSetting" name="calSetting"
							   class="mini-buttonedit" showClose="true" text="${calSettingName}"
							   oncloseclick="_ClearButtonEdit" onbuttonclick="onCalSettingSelect" value="${calSettingId}"/>
						&nbsp;&nbsp;&nbsp;
						超时时间(单位:分钟)：
						<input class="mini-textbox" id="overTime" name="overTime" value="${overTime}" vtype="int" width="100" />
					</td>
				</tr>
				<tr>
					<td>子表权限</td>
					<td colspan="3">
						<input id="tableRightJson" name="tableRightJson" class="mini-hidden" />
						<span id="spanTableRightJson"></span>
					</td>
				</tr>
				<tr id="buttonRow"
					style="<c:if test="${(empty allowConfigButtons) or allowConfigButtons=='false'}">display:none</c:if>">
					<td>审批按钮</td>
					<td colspan="3" class="colums-padding">
						<div class="mini-toolbar" style="padding:5px;">
							<a class="mini-button"   onclick="addButton()">添加</a>
							<a class="mini-button"   onclick="addAllButtons()">添加全部</a>
							<a class="mini-button btn-red"  onclick="delButtons()">删除</a>
							<a class="mini-button"  onclick="upRowGrid('buttonGrid')">上移</a>
							<a class="mini-button" 	onclick="downRowGrid('buttonGrid')">下移</a>
						</div>
						<div id="buttons" style="display: none">${buttons}</div>
						<div id="buttonGrid" class="mini-datagrid"
							 style="height: 350px; width: 100%;" idField="id"
							 showPager="false" allowCellEdit="true" allowCellSelect="true"
							 editNextOnEnterKey="true"
							 oncellbeginedit="OnCellbeginedit" editNextRowCell="true" multiSelect="true">
							<div property="columns">
								<div type="indexcolumn"></div>
								<div type="checkcolumn"></div>
								<div name="id" field="id" headerAlign="center">
									ID <input id="editor" class="mini-textbox" property="editor" />
								</div>
								<div name="name" field="name" headerAlign="center">
									名称 <input property="editor" class="mini-textbox" style="width: 100%;" />
								</div>
								<div name="alias" field="alias" headerAlign="center">
									别名 <input property="editor" class="mini-textbox" style="width: 100%;" />
								</div>
								<div name="iconCls" field="iconCls" headerAlign="center">
									图标<input property="editor" class="mini-textbox"  style="width: 100%;" />
								</div>
								<div name="script" field="script" width="150" headerAlign="center">
									JS脚本方法 <input property="editor" class="mini-textarea" 	minValue="0" style="height: 280px; width: 100%;" />
								</div>
							</div>
						</div>
					</td>
				</tr>
				</tbody>
			</table>

		</div>
		<c:if test="${not empty actNodeDef.multiInstance}">
			<div title="会签配置" >
				<table class="table-detail column-four" cellspacing="1"
					   cellpadding="0" style="width: 100%;">
					<colgroup>
						<col />
						<col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<td>投票结果:</td>
						<td><input class="mini-radiobuttonlist" required="true"
								   value="${voteResultType}" name="voteResultType"
								   data="[{id:'PASS',text:'通过'},{id:'REFUSE',text:'拒绝'}]" /></td>
					</tr>
					<tr>
						<td>投票结果满足时:</td>
						<td><input class="mini-radiobuttonlist" required="true"
								   value="${handleType}" name="handleType"
								   data="[{id:'DIRECT',text:'流转下一环节'},{id:'WAIT_TO',text:'等待投票完成'}]" />
						</td>
					</tr>
					<tr>
						<td>投票计算类型:</td>
						<td><input class="mini-radiobuttonlist" required="true"
								   value="${calType}" name="calType"
								   data="[{id:'NUMS',text:'票数'},{id:'PERCENT',text:'百分比'}]" /></td>
					</tr>
					<tr>
						<td>投票值:</td>
						<td><input class="mini-spinner" name="voteValue"
								   value="${voteValue}" minValue="1" maxValue="100" /></td>
					</tr>
					<tr>
						<td>特权会签</td>
						<td>
							<div class="mini-toolbar"
								 style="padding: 2px; border-bottom: none">
								<table style="width: 100%;">
									<tr>
										<td style="width: 100%;">
											<a class="mini-button"   plain="true" onclick="addPrevUser()">添加</a>
											<a class="mini-button btn-red"  plain="true" 	onclick="delPrevUser()">删除</a>
										</td>
									</tr>
								</table>
							</div>
							<div id="votePrivs" style="display: none">${votePrivs}</div>
							<div id="votePrivsGrid" class="mini-datagrid"
								 style="width: 100%;" height="auto" showPager="false"
								 allowCellEdit="true" allowCellSelect="true"
								 oncellbeginedit="onVotePrivsGridCellEdit"
								 editNextOnEnterKey="true" editNextRowCell="true"
								 multiSelect="true">
								<div property="columns">
									<div type="indexcolumn"></div>
									<div type="comboboxcolumn" displayfield="text" name="identityType" field="identityType" headerAlign="center" width="150">
										用户类型 <input class="mini-combobox" data="[{id:'USER',text:'用户'},{id:'GROUP',text:'用户组'}]" property="editor" />
									</div>
									<div name="identityIds" field="identityIds" displayfield="identityNames" headerAlign="center" width="150">用户或组</div>
									<div name="voteNums" field="voteNums" headerAlign="center" width="30">
										票数 <input class="mini-spinner" minValue="1" value="100"
												  maxValue="100" property="editor" />
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>加签权限</td>
						<td>
							<div class="mini-toolbar">
								<a class="mini-button"

								   plain="true"
								   onclick="addSignUser()">添加</a>
								<a  class="mini-button  btn-red"
									plain="true"
									onclick="delSignUser()">删除</a>
							</div>
							<div id="addSigns" style="display: none">${addSigns}</div>
							<div id="addSignsGrid" class="mini-datagrid"
								 style="width: 100%;" height="auto" showPager="false"
								 allowCellEdit="true" allowCellSelect="true"
								 oncellbeginedit="onAddSignGridCellEdit"
								 editNextOnEnterKey="true" editNextRowCell="true"
								 multiSelect="true">
								<div property="columns">
									<div type="indexcolumn"></div>
									<div type="comboboxcolumn" displayfield="text"
										 name="identityType" field="identityType"
										 headerAlign="center" width="150">
										用户类型 <input class="mini-combobox"
													data="[{id:'SIGN_USER',text:'所有会签用户'},{id:'USER',text:'用户'},{id:'GROUP',text:'用户组'}]"
													property="editor" />
									</div>
									<div name="identityIds" field="identityIds"
										 displayfield="identityNames" headerAlign="center"
										 width="150">用户或组</div>
								</div>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</c:if>
		<div title="高级配置"  name="advanceSetting">
			<table class="table-detail column-four" cellspacing="1" cellpadding="0"
				   style="width: 100%;">
				<tr>
					<td data-placement="right">前置处理器</td>
					<td><input class="mini-textbox east" name="preHandle"
							   value="${preHandle}" style="width: 300px" />
						<div class="iconfont icon-Help-configure"
							 style="display: inline-block; width: 25px; height: 17px;"
							 data-placement="right" title="实现TaskPreHandler接口的Spring的BeanId"></div>
					</td>
				</tr>
				<tr>
					<td>后置处理器</td>
					<td><input class="mini-textbox east" name="afterHandle"
							   value="${afterHandle}" style="width: 300px" />
						<div class="iconfont icon-Help-configure"
							 style="width: 25px; height: 17px; display: inline-block;"
							 title="实现TaskAfterHandler接口的Spring的BeanId"
							 data-placement="right"></div>
					</td>
				</tr>
				<tr>
					<td>允许审批判断脚本</td>
					<td>
						<textarea id="allowScript"  style="border:solid 1px #ccc;width:96%">${allowScript}</textarea>
					</td>
				</tr>
				<tr>
					<td>提示信息</td>
					<td>
						<textarea name="allowTipInfo" class="mini-textarea" emptyText="请输入提示信息" style="height:120px;width:96%">${allowTipInfo}</textarea>
					</td>
				</tr>
			</table>
		</div>
		<div title="事件与接口" >

			<table class="table-detail column-two" cellspacing="1"
				   cellpadding="0" style="width: 100%">
				<caption>事件与接口配置</caption>
				<c:forEach items="${eventConfigs}" var="event" varStatus="i">
					<tr>
						<td>【${event.eventName}】事件调用配置</td>
						<td>
							<div class="form-toolBox">
								<a class="mini-button"   onclick="addRowGrid('eventGrid_${i.index}')">添加</a>
								<a class="mini-button btn-red"  onclick="delRowGrid('eventGrid_${i.index}')">删除</a>
								<a class="mini-button"  onclick="upRowGrid('eventGrid_${i.index}')">上移</a>
								<a class="mini-button"  	onclick="downRowGrid('eventGrid_${i.index}')">下移</a>
								<a class="mini-button"  onclick="configRowGrid('eventGrid_${i.index}')">配置</a>
							</div>
							<div id="eventGrid_${i.index}"
								 data-options="{eventKey:'${event.eventKey}',eventName:'${event.eventName}'}"
								 class="mini-datagrid" allowAlternating="true"
								 allowCellEdit="true" allowCellSelect="true" height="auto"
								 idField="id" showPager="false" style="width: 100%;">
								<div property="columns">
									<div type="indexcolumn" width="20"></div>
									<div type="checkcolumn" width="20"></div>
									<div header="异步调用" width="80" field="async"
										 type="checkboxcolumn" truevalue="YES" falsevalue="NO"></div>
									<div type="comboboxcolumn" field="callType" name="callType"
										 displayField="callTypeName" width="140" headerAlign="center">
										接口类型
										<input property="editor"
											   class="mini-combobox"
											   data="[{id:'Script',text:'Groovy脚本'},{id:'HttpInvoke',text:'HTTP请求服务调用'},{id:'Sql',text:'执行SQL'},{id:'ProcessCall',text:'ProcessCall调用接口'},{id:'jms',text:'发送到队列'},{id:'subProcess',text:'启动子流程'}]" />
									</div>
									<div field="jumpType" name="jumpType"
										 displayField="jumpTypeName" width="100">
										满足的审批动作 <input property="editor" class="mini-treeselect"
													   multiSelect="true" textField="jumpTypeName"
													   valueField="jumpType" parentField="parent"
													   data="jumpTypeData" />
									</div>

									<div field="callName" name="config" width="160"
										 headerAlign="center">
										调用功能描述 <input property="editor" class="mini-textbox" />
									</div>
								</div>
							</div> <textarea id="script_${event.eventKey}" name="script"
											 style="display: none">${event.script}</textarea>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div  title="人员配置"
			 url="${ctxPath}/bpm/core/bpmSolution/nodeUser.do?actDefId=${param['actDefId'] }&nodeId=${param['nodeId']}&nodeType=${param['nodeType']}&solId=${param['solId']}&groupType=task">
		</div>
		<div title="抄送配置"
			 url="${ctxPath}/bpm/core/bpmSolution/nodeUserGroup.do?actDefId=${param['actDefId']}&nodeId=${param['nodeId']}&nodeType=${param['nodeType']}&solId=${param['solId']}&groupType=copy">
		</div>

		<div  title="跳转规则"
			 url="${ctxPath}/bpm/core/bpmJumpRule/list.do?actDefId=${param['actDefId']}&nodeId=${param['nodeId']}&solId=${param['solId']}">
		</div>

		<div  title="节点提醒" ">
			<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="width: 100%;">
				<tr>
					<td>节点提醒文字</td>
					<td>
						<input id="checkTip" class="mini-textarea" name="checkTip" value="${checkTip}" style="width:90%;height:100px;" />
					</td>
				</tr>
			</table>
		</div>
		
	</div>
	<!-- end of mini-tab -->
</div>
</div>
<!-- end of mini-fit -->
<div style="display:none" id="urlHelp">
	<pre>
 配置这个URL的场景是：
在我的待办列表中，用户点击待办，系统将跳转到该URL，这个URL配置方法样式如下:
oa/todo.do?taskId={taskId}&busKey={busKey}
上下文变量有：
taskId:任务ID
instId:流程实例ID
solId:解决方案ID
nodeId:节点ID
actInstId:流程实例ID(流程引擎实例)
busKey: 业务主键
	</pre>
</div>

<script type="text/javascript">
	var multiInstance=${not empty actNodeDef.multiInstance};


	mini.parse();

	var tip = new mini.ToolTip();
	tip.set({
		target: document,
		selector: '[title]'
	});
	var buttonGrid=mini.get('buttonGrid');

	var nodeType="${param['nodeType']}";
	var nodeId="${param['nodeId']}";
	var solId="${param['solId']}";
	var actDefId="${param['actDefId']}";
	var tableRightJson=<c:choose><c:when test="${empty tableRightJson}">{}</c:when><c:otherwise>${tableRightJson}</c:otherwise></c:choose>;
	var contextVars='${contextVars}';
	var boDefId='${boDefId}';

	initHelp();



	function beforeCheckNode(e){
		var tree=e.sender;
		var node=e.node;
		var nodes=tree.tree.getAncestors(node);
		tree.tree.uncheckAllNodes();
		tree.tree.checkNodes(nodes);
	}

	function handType(obj){
		var jqObj=$(obj);
		var parent=$(obj).closest("td");
		var divSql=$(".sql",parent);
		var type=jqObj.val();
		if(type=="sql"){
			divSql.show();
		}
		else{
			divSql.hide();
		}
	}

	//常量变换。
	function changeConstant(obj){
		var jqObj=$(obj);
		var parent=$(obj).closest("td");
		var divSql=$("textarea",parent);

		var tableName=divSql.attr("tbName");
		appendContent(tableName,jqObj.val());
	}
	//字段选择。
	function fieldSelect(e){
		var obj=e.sender;
		var node=obj.getSelectedNode();
		if(node.type=='table') return;
		var jqObj=$(obj.el);
		var parent=$(jqObj).closest("td");
		var divSql=$("textarea",parent);
		var tableName=divSql.attr("tbName");

		if(node.type=='field'){
			appendContent(tableName,"F_" + node.id);
		}
		else{
			appendContent(tableName, node.id);
		}
	}

	function appendContent(tabName,content){
		var editor=editorJson[tabName];
		var doc = editor.getDoc();
		var cursor = doc.getCursor(); // gets the line number in the cursor position
		doc.replaceRange(content, cursor); // adds a new line
	}



	//编辑器存储。
	var editorJson={};

	function getRightHtml(){
		if(!tableRightJson) return "";
		var bt=baidu.template;
		var vars =mini.decode(contextVars);
		var data={data:tableRightJson,vars:vars,boDefId:boDefId,ctx:__rootPath};
		var html=bt("rightTemplate",data);
		var parent=$("#spanTableRightJson");

		parent.html(html);

		$("textarea",parent).each(function(i){
			var tabName=$(this).attr("tbName");
			var editor= CodeMirror.fromTextArea(this, {
				matchBrackets: true,
				mode: "text/x-sql"
			});
			editorJson[tabName]=editor;
		});
		$(".CodeMirror",parent).each(function(i){
			$(this).height(150);
		})

		mini.parse();
	}
	//加载权限HTML
	getRightHtml();

	function getRightJson(){
		var spanObj=$("#spanTableRightJson");
		var json={};
		$(".trName",spanObj).each(function(i){
			var tr=$(this);
			var tableName=tr.attr("tbName");
			var tbRight=$(".tbRight",tr);
			var val = $('input:radio:checked',tbRight).val();
			var obj={type:val};
			if(val=="sql"){
				var editor=editorJson[tableName];
				obj.sql=editor.getValue();
			}
			json[tableName]=obj;
		});
		return mini.encode (json );
	}



	//是否会签
	var isSign='${actNodeDef.multiInstance}';

	if(isSign!=''){
		mini.get('votePrivsGrid').setData(mini.decode($('#votePrivs').html()));
		mini.get('addSignsGrid').setData(mini.decode($('#addSigns').html()));
	}


	$(function(){
		$('.east').powerTip({ placement: 'e' });
	});

	$(window).resize(function(){
		setTimeout('mini.layout();',500);
	});
	buttonGrid.setData(mini.decode($("#buttons").html()));

	function OnCellEndEdit(e){
		var record=e.record;
		var grid=e.sender;
		var field=e.field;
		var val=e.value;
		if(field=='name'){
			//更新同行的iconCls;
			var typeEditor=mini.get('typeEditor');
			var buttons=typeEditor.getData();
			for(var i=0;i<buttons.length;i++){
				if(buttons[i].name==val){
					grid.updateRow(record,{iconCls:buttons[i].iconCls});
					return;
				}
			}
		}
	}

	function onVotePrivsGridCellEdit(e){
		var record=e.record;
		var field=e.field;
		var grid=e.sender;
		var editor=mini.get('prevIdentityEditor');

		if(record.identityType!='USER' && record.identityType!='GROUP'){
			return;
		}
		if(field!='identityIds'){
			return;
		}
		e.editor=editor;
		e.column.editor=e.editor;
	}

	function onPrevIdentityClick(e){
		var gd=mini.get('votePrivsGrid');
		var selected=gd.getSelecteds();
		var record=null;
		if(selected==null || selected.length==0){
			return;
		}
		record=selected[0];
		if(record.identityType=='USER'){
			_UserDlg(false,function(users){
				var uIds=[];
				var uNames=[];
				for(var i=0;i<users.length;i++){
					uIds.push(users[i].userId);
					uNames.push(users[i].fullname);
				}
				gd.cancelEdit();
				gd.updateRow(record,{identityIds:uIds.join(','),identityNames:uNames.join(',')});
			});
		}else if(record.identityType=='GROUP'){
			_GroupDlg(false,function(groups){
				var uIds=[];
				var uNames=[];
				for(var i=0;i<groups.length;i++){
					uIds.push(groups[i].groupId);
					uNames.push(groups[i].name);
				}
				gd.cancelEdit();
				gd.updateRow(record,{identityIds:uIds.join(','),identityNames:uNames.join(',')});
			});
		}
	}



	function onAddSignGridCellEdit(e){
		var record=e.record;
		var field=e.field;
		var grid=e.sender;
		var editor=mini.get('signIdentityEditor');

		if(record.identityType!='USER' && record.identityType!='GROUP'){
			return;
		}
		if(field!='identityIds'){
			return;
		}
		e.editor=editor;
		e.column.editor=e.editor;

	}
	//处理加签人员的选择配置
	function onSignIdentityClick(e){
		var gd=mini.get('addSignsGrid');
		var selected=gd.getSelecteds();
		var record=null;
		if(selected==null || selected.length==0){
			return;
		}
		record=selected[0];
		if(record.identityType=='USER'){
			_UserDlg(false,function(users){
				var uIds=[];
				var uNames=[];
				for(var i=0;i<users.length;i++){
					uIds.push(users[i].userId);
					uNames.push(users[i].fullname);
				}
				gd.cancelEdit();
				gd.updateRow(record,{identityIds:uIds.join(','),identityNames:uNames.join(',')});
			});
		}else if(record.identityType=='GROUP'){
			_GroupDlg(false,function(groups){
				var uIds=[];
				var uNames=[];
				for(var i=0;i<groups.length;i++){
					uIds.push(groups[i].groupId);
					uNames.push(groups[i].name);
				}
				gd.cancelEdit();
				gd.updateRow(record,{identityIds:uIds.join(','),identityNames:uNames.join(',')});
			});
		}
	}

	//配置事件接口调用
	function configRowGrid(gridId){
		settingEvent(gridId,solId,actDefId,nodeId,'_PROCESS');
	}

	var jumpTypeData=[
		{jumpType:'AGREE',jumpTypeName:'通过'},
		{jumpType:'REFUSE',jumpTypeName:'反对'},
		{jumpType:'BACK',jumpTypeName:'驳回'},
		{jumpType:'BACK_TO_STARTOR',jumpTypeName:'驳回至发起人'},
		{jumpType:'RECOVER',jumpTypeName:'撤回'},
		{jumpType:'TIMEOUT_SKIP',jumpTypeName:'超时跳过'},
		{jumpType:'SKIP',jumpTypeName:'跳过'},
		{jumpType:'ABSTAIN',jumpTypeName:'弃权'},
		{jumpType:'INTERPOSE',jumpTypeName:'干预'}
	];

	//事件Grid
	var eventGrids=[];
	<c:forEach items="${eventConfigs}" var="event" varStatus="i">
	eventGrids.push(mini.get('eventGrid_${i.index}'));
	</c:forEach>
	for(var i=0;i<eventGrids.length;i++){
		var eventKey=eventGrids[i].eventKey;
		var eventName=eventGrids[i].eventName;
		var script=$('#script_'+eventKey).val();
		if(script && script!=''){
			try{
				var scriptArr=mini.decode(script);
				if(scriptArr instanceof Array){
					eventGrids[i].setData(scriptArr);
				}else{//兼容旧配置
					eventGrids[i].addRow({
						callType:'Script',
						callTypeName:'Groovy脚本',
						callName:'配置调用脚本',
						config:script
					});
				}
			}catch(e){
			}
		}
	}
	//保存配置信息
	function saveConfig(){
		var form=new mini.Form('configForm');
		form.validate();
		if(!form.isValid())  return;

		var configs=_GetFormJsonMini("configForm");

		var tabRightJson=getRightJson();

		configs.tableRightJson=tabRightJson;

		if(isSign!=''){
			configs.votePrivs=mini.get('votePrivsGrid').getData();
			configs.addSigns=mini.get('addSignsGrid').getData();
		}
		configs.buttons=buttonGrid.getData();
		//增加任务是否允许执行脚本
		configs.allowScript=editor.getValue();

		var events=[];

		for(var i=0;i<eventGrids.length;i++){
			var key=eventGrids[i].eventKey;
			var eventName=eventGrids[i].eventName;
			events.push({
				eventKey:key,
				eventName:eventName,
				script:mini.encode(eventGrids[i].getData())
			});
		}

		var checkTip = mini.get("checkTip");
		var tipText = checkTip.getValue();

		var calSetting = mini.get("btnCalSetting");
		var calSettingId = calSetting.getValue();
		var calSettingName = calSetting.getText();
		var overTime = mini.get("overTime");
		var time = overTime.getValue();
		configs.calSettingId=calSettingId;
		configs.calSettingName=calSettingName;
		if(!time){
			time = 0;
		}
		configs.overTime=time;


		var configJson={
			configs:configs,
			events:events,
		};

		_SubmitJson({
			url:__rootPath+'/bpm/core/bpmNodeSet/saveNodeConfig.do',
			method:'POST',
			data:{
				solId:solId,
				nodeType:nodeType,
				nodeId:nodeId,
				actDefId:actDefId,
				configJson:mini.encode(configJson),
				tipText:tipText
			},
			success:function(text){
				CloseWindow();
			}
		});
	}

	function changeConfigButtons(e){
		var checked=this.getChecked();
		if(checked){
			$("#buttonRow").css("display","");
		}else{
			$("#buttonRow").css("display","none");
		}
		//grid.layout();
	}

	//增加按钮配置
	function addButton(){
		buttonGrid.addRow({defaultBtn:0,type:"custom"});
		//grid.layout();
	}

	function addPrevUser(){
		mini.get('votePrivsGrid').addRow({});
	}

	function addSignUser(){
		mini.get('addSignsGrid').addRow({});
	}

	function delSignUser(){
		var gd=mini.get('addSignsGrid');
		var selecteds=gd.getSelecteds();
		gd.removeRows(selecteds);
	}

	function delPrevUser(){
		var gd=mini.get('votePrivsGrid');
		var selecteds=gd.getSelecteds();
		gd.removeRows(selecteds);
	}

	function isButtonExist(rows,key){
		var found=false;
		for(var j=0;j<rows.length;j++){
			var row=rows[j];
			if(row.alias==key){
				found=true;
				break;
			}
		}
		return found;
	}

	//增加所有按钮
	function addAllButtons(){
		var url=__rootPath+'/bpm/core/bpmConfig/getCheckButtons.do?solId='+solId+'&actDefId='+actDefId;
		function handButtons(text){
			var result=mini.decode(text);
			var rows=buttonGrid.getData();
			for(var i=0;i<result.length;i++){
				var obj=result[i];
				obj.isDefault=1;
				var key=obj.alias;
				var found=isButtonExist(rows,key);
				if(found) continue;
				buttonGrid.addRow(obj);
			}
		}
		$.get(url, handButtons);
	}
	//删除按钮
	function delButtons(){
		var selecteds=buttonGrid.getSelecteds();
		buttonGrid.removeRows(selecteds);
	}

	function showFormFieldDlg(){
		openFieldDialog({
			nodeId:'${param.nodeId}',
			actDefId:'${param.actDefId}',
			solId:'${param.solId}',
			callback:function(fields){
				for(var i=0;i<fields.length;i++){
					var f=fields[i].formField.replace('.','_');
					appendScript( f);
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

	var editor = CodeMirror.fromTextArea(document.getElementById("allowScript"), {
		mode: "text/x-groovy",
		lineNumbers: true,
		lineWrapping: true
	});
	editor.setSize('auto','150');

	var tabObject=mini.get("baseTab");
	tabObject.on("activechanged", function(e) {
		if (e.tab.name == "advanceSetting") {
			editor.refresh();
			editor.focus();
		}
	})



	function OnCellbeginedit(e){
		var col=e.column;
		var name=col.name;
		var row=e.record;
		var upName=name.substring(0,1).toUpperCase() + name.substring(1);
		var editor=mini.get("btn" + upName +"Editor");
		if(row.isDefault==1 && ( name=="id" || name=="alias" || name=="script")){
			e.cancel=true;
		}
		else{
			e.cancel=false;
		}

	}

	function onFormulaSelect(e){
		var btn=e.sender;
		if(!boDefId){
			alert("请先在表单设置业务对象模型!");
			return ;
		}
		var conf={boDefId:boDefId,single:false,callBack:function(data){
				var ids=[];
				var names=[];
				for(var i=0;i<data.length;i++){
					var item=data[i];
					ids.push(item.id);
					names.push(item.name);
				}
				btn.setText(names.join(","));
				btn.setValue(ids.join(","));
			}};
		openFormulaDialog(conf);
	}

	function onCalSettingSelect(e){
		var btn=e.sender;
		var conf={single:false,callBack:function(data){
				var ids=[];
				var names=[];
				for(var i=0;i<data.length;i++){
					var item=data[i];
					ids.push(item.settingId);
					names.push(item.calName);
				}
				btn.setText(names.join(","));
				btn.setValue(ids.join(","));
			}};
		openCalSettingDialog(conf);
	}





</script>
</body>
</html>
