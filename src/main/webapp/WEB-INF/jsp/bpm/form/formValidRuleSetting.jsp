<%-- 
    Document   : [FORM_VALID_RULE]编辑页
    Created on : 2018-11-27 22:58:37
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>验证规则</title>
	<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div style="display:none;">
		<input class="mini-combobox" id="fieldCombo" style="width: 150px;"   textField="name" valueField="name" showNullItem="false"  />
		<input class="mini-combobox" id="aliasCombo" style="width: 150px;"  textField="ruleName" valueField="alias" showNullItem="false"  />
		<div id="actionList" class="mini-combobox" style="width:150px;" 
				popupWidth="250" textField="text" valueField="id" 
			    multiSelect="true">
		</div>
		<input class="mini-textbox" id="ruleName" style="width:100%;" />
		<input id="buttonEditEditor" class="mini-buttonedit" allowInput="false" onbuttonclick="onScriptEdit"/>
	</div>
	<div class="mini-fit">
		<div class="mini-tabs" id="tables" style="height: 100%"></div>
	</div>
	<div class="bottom-toolbar" style="text-align: center;">
		<a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button" onclick="CloseWindow()">关闭</a>
		
	</div>
	<script type="text/javascript">
		mini.parse();
		var gridTab=mini.get('tables');
		var boDefId = '${boDefId}';
		var pkId = '${ruleId}';
		var setId = '${sysCustomFormSetting.id}';
		var formKey = '${sysCustomFormSetting.formAlias}';
		
		$(function(){
			var tables = ${tables};
			for(var i=0;i<tables.length;i++){
				addTableTab(tables[i]);
			}
			var tab = gridTab.getTab(0);
			gridTab.activeTab(tab);
		})
		
		function getData(){
			var json = {};
			var tabs = gridTab.getTabs();
			for(var i=0;i<tabs.length;i++){
				var tab = tabs[i];
				var grid = mini.get("grid-"+tab.name+"-"+boDefId);
				var ary = grid.getList();
				var rules = {};
				for(var j=0;j<ary.length;j++){
					var obj = ary[j];
					if(obj.isConf || !obj.name)continue;
					rules[obj.name] = obj.children;
				}
				if(i==0){
					json.main=rules;
				}else{
					json[tab.name]=rules;
				}
			}
			return json;
		}
		
		function onOk(){
			var formData = {};
			var json = getData();
			formData.id = pkId;
			formData.json = mini.encode(json);
			formData.formKey = formKey;
			formData.solId = setId;
			_SubmitJson({
				url:__rootPath+'/bpm/form/formValidRule/save.do',
				data: formData,
				method:'POST',
				postJson:true,
				success:function(result){
					CloseWindow("ok");
				}
			});
		}
	</script>
	<script id="vaildRuleSettingTemplate"  type="text/html">
		<div id="toolbar-<#=name#>-<#=boDefId#>" class="form-toolBox" >
				<a class="mini-button"   plain="true" onclick="addRule('grid-<#=name#>-<#=boDefId#>')">添加</a>
				<a class="mini-button btn-red"  plain="true" onclick="removeRule('grid-<#=name#>-<#=boDefId#>')">删除</a>
		</div>
		<div class="mini-fit">
			<div id="grid-<#=name#>-<#=boDefId#>" class="mini-treegrid" style="width:100%;height:100%;"
				showTreeIcon="true" multiSelect="true" oncellbeginedit="OnCellBeginEdit" allowCellEdit="true" allowCellSelect="true"
				treeColumn="name" resultAsTree="false">
					<div property="columns">
					<div type="checkcolumn"></div>
					<div name="name" field="name" width="200">名称</div>
					<div field="alias" displayField="ruleName" width="100">规则别名</div>
					<div field="action" width="100" dateFormat="yyyy-MM-dd">触发条件</div>
					<div field="conf" width="100" dateFormat="yyyy-MM-dd">规则配置</div>
				</div>
			</div>
		</div>
	</script>
	
	<script src="${ctxPath}/scripts/flow/validRule/tablevalidrule.js"></script>
</body>
</html>