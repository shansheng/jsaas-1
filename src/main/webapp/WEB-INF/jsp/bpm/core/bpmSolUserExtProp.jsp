<%
	//组织架构管理，可管理全部租用组织架构，对于非SaaS管理员，仅能管理其本机构的
	//若传入InstId,并且需要检查当前组织机构的域名是否为在redxun.properties中指定的管理机构，
	//即可以进行格式化处理
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>用户/用户组扩展属性选择</title>
	<%@include file="/commons/list.jsp"%>
	<script type="text/javascript" src="${ctxPath}/scripts/sys/org/org.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/sys/org/dimension.js"></script>
	<style type="text/css">
		.mini-layout-border>#center{
			background: transparent;
		}
		.mini-tree .mini-grid-viewport{
			background: #fff;
		}
		.mini-grid-cell-inner a.fontBtn{
			color: #29A5BF;
			padding-right: 20px;
		}
		.fontBtn :hover{
			color: #34bfdc;
			cursor: pointer;
		}
		.in-line{
			display: flex;
			padding: 10px;
		}
		.in-line > span.text{
			font-size: 14px;
			color: #333;
			padding-right:10px;
		}

		.mini-grid-cell-inner{
			display: flex;
			align-items: center;
			padding:0 15px;
		}
	</style>
</head>
<body>
<div style="display:none;">
	<input class="mini-combobox" id="treeCombo" textField="name" valueField="treeId"
		   url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE"/>
	<input class="mini-combobox" id="arrtTreeCombo"  textField="attributeName" valueField="id" onvaluechanged="attrValChange"/>
	<input class="mini-combobox" id="dateOperator"  textField="name" valueField="key"/>
	<input id="datepicker" name="paramsName" class="mini-datepicker"  value="paramsValue" style="display: inline-block;"/>
	<input id="spinner" name="paramsName" class="mini-spinner"  value="1"  valueField="paramsValue"  style="display: inline-block;"/>
	<input class="mini-combobox" id="valCombobox"  textField="text" valueField="id"/>
	<input class="mini-combobox" id="valUrlCombobox"  textField="treeName" valueField="value"/>
	<span id="readOnlySpan"  textField="readOnlyName" valueField="readOnlyValue"  readonly="true" />
</div>
<div id="orgLayout" class="mini-layout" style="width:100%;height:100%;">
	<div
			region="south"
			showSplit="false"
			showHeader="false"
			height="40"
			showSplitIcon="false"
			style="width:100%"
			bodyStyle="border:0;text-align:center;padding-top:5px;">
		<a class="mini-button"   onclick="extGet()">预览</a>
		<a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button btn-red"   onclick="onCancel()">取消</a>
	</div>
	<div showHeader="false" showCollapseButton="false" iconCls="icon-group" region="center">
		<div class="in-line">
			<span class="text">扩展属性分类:</span>
			<input id="extPropTree" name="name" class="mini-radiobuttonlist"  onvaluechanged="extPropValChang" style="width: auto"
				   repeatItems="4" repeatLayout="table" textField="name" valueField="extPropId" data=""  />
		</div>
		<div class="mini-fit rx-grid-fit form-outer5" >
			<div
					id="groupGrid"
					class="mini-treegrid"
					style="width:100%;height:100%;"
					showTreeIcon="true"
					treeColumn="name" idField="groupId" parentField="parentId"
					resultAsTree="false"
					allowResize="true"  allowAlternating="true"
					oncellbeginedit="OnCellBeginEdit"
					oncellendedit="OnCellEndEdit"
					allowRowSelect="true"
					onrowclick="groupRowClick" onbeforeload="onBeforeGridTreeLoad"
					allowCellValid="true" oncellvalidation="onCellValidation"
					allowCellEdit="true" allowCellSelect="true">
				<div property="columns">
					<div name="action" cellCls="actionIcons" width="185" headerAlign="center" align="center"
						 renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div name="name" field="treeIdValue" displayField="treeIdName" align="left" width="160">分类
						<input property="editor" class="mini-textbox" style="width:100%;" />
					</div>
					<div name="attrName" field="arrtTreeValue" displayField="attrName" align="left" width="160">属性
						<input property="editor" class="mini-textbox" style="width:100%;" />
					</div>
					<div name="operatorName" field="operatorValue" displayField="operatorName" align="left" width="80">条件
						<input property="editor" class="mini-textbox" style="width:100%;" />
					</div>
					<div name="valName" field="valValue" displayField="valName" align="left" width="80">值
						<input property="editor" class="mini-textbox" style="width:100%;" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	mini.parse();
	var extPropTree = mini.get('#extPropTree');
	var groupGrid=mini.get('#groupGrid');
	//当前选择的分类
	var extPropId ="user";


	//第一层规则总共个
	var firstFloorNume =5;
	//第二层规则总共个
	var secondFloorNume =5;
	var firstFloorNode =0;
	var firstFloorRuleBtm = $('#firstFloorRuleBtm')[0];
	var firstFloorGroupRuleBtm = $('#firstFloorGroupRuleBtm')[0];
	var cantOclik =true;
	var row_num ="";


	var selectSqlList =[];
	var selectNameList =[];

	//按钮字体颜色
	var fontColor_1="red";
	var fontColor_2="rgb(102, 102, 102)";

	//时间(数字)条件：
	var dateOperatorList =[
		{key:"=",name:"等于"},
		{key:">",name:"大于"},
		{key:"<",name:"小于"},
		{key:">=",name:"大于等于"},
		{key:"<=",name:"小于等于"}
	];
	//文本条件：
	var textOperatorList =[
		{key:"=",name:"等于"},
		{key:"like",name:"模糊查询"},
		{key:"leftLike",name:"左模糊查询"},
		{key:"rigthLike",name:"右模糊查询"}
	];
	//下拉框（多选框）条件：
	var comboboxList =[
		{key:"=",name:"等于"},
	];




	//用户组操作列表
	function onActionRenderer(e) {
		var record = e.record;
		var uid = record._uid;
		var s ='<a class="fontBtn" style="color: red !important;" onclick="delGroupRow(\'' + uid + '\')">删除</a>';
		var toggledBtmId ="toggledBtm_"+uid;
		var firstRuleBtmId ="firstFloorRuleBtm_"+uid;
		var firstGroupRuleBtmId ="firstFloorGroupRuleBtm_"+uid;
		if(record.type=="orgRule" && record.sn==0){
			row_num =uid;
			s='';
			s+='<a id="'+firstGroupRuleBtmId+'" class="fontBtn" onclick="newGroupRule(\'' + row_num + '\');">新增组</a>';
			s+='<a id="'+firstRuleBtmId+'" class="fontBtn" onclick="newRule(\'' + row_num + '\');">新增规则</a>';
			s+='<span id="'+toggledBtmId+'" class="'+getBtmAndOr(record.rule)+'" title="组内规则" onclick="selectAndRule(\'' + uid + '\')"></span>';
		}

		if(record.type=="orgRule" && record.sn==1){
			s ='';
			s='<a class="fontBtn" style="color: red !important;padding-right: 35px;" onclick="delGroupRow(\'' + uid + '\')">删除</a>';
			s+='<a  class="fontBtn" onclick="newGroupSubRule();">新增规则</a>'
			s+='<span id="'+toggledBtmId+'" class="'+getBtmAndOr(record.rule)+'" title="组内规则" onclick="selectAndRule(\'' + uid + '\')"></span>';
		}
		return s;
	}
	function getBtmAndOr(rule){
		if(rule=="and"){
			return "toggledBtmAnd"
		}
		return "toggledBtmOr"
	}

	function setReadOnlyEditor(e,id){
		e.editor=mini.get(id);
		e.column.editor=e.editor;
	}

	function OnCellBeginEdit(e) {
		var extPropVal=extPropTree.value;
		if(!extPropVal){
			return;
		}
		var row = e.row;
		if(row.rule){
			setReadOnlyEditor(e,"readOnlySpan");
			return;
		}
		var field = e.field;

		if (field == "treeIdValue") {//分类
			var catKey ="CAT_CUSTOMATTRIBUTE";
			if(extPropVal =="org"){
				catKey ="CAT_CUSTOMATTRIBUTE_GROUP";
			}
			var url ="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey="+catKey;
			setEditor(e,"1",url,"treeCombo",null);
			return;
		}
		if(field == "arrtTreeValue"){//属性
			if(!row.treeIdValue){
				return;
			}
			var url ="${ctxPath}/sys/org/osCustomAttribute/getAttrsByTreeId.do?treeId="+row.treeIdValue;
			setEditor(e,"1",url,"arrtTreeCombo",null);
			return;
		}

		if(field == "operatorValue"){//条件
			operator(e,row)
			return;
		}
		if(field == "valValue"){//值
			valValue(e,row)
			return;
		}
	}


	//值
	function valValue(e,row){
		if(!row.treeIdValue){
			return;
		}
		if(row.attrType=="spinner" ){//数字控件
			setEditor(e,"2",null,"spinner",null);
			return;
		}
		if(row.attrType=="datepicker" ){///时间控件
			setEditor(e,"2",null,"datepicker",null);
			return;
		}
		if(row.attrType=="combobox"  || row.attrType=="radiobuttonlist"){//下拉框和多选框控件
			if(row.sourceType=="CUSTOM"){//自定义
				var valueSource =JSON.parse(row.valueSource);
				setEditor(e,"2",null,"valCombobox",valueSource);
				return;
			}
			if(row.sourceType=="URL"){//URL
				var valueSource =JSON.parse(row.valueSource);
				if(valueSource && valueSource.length>0){
					var url = "${ctxPath}"+valueSource[0].URL;
					setEditor(e,"1",url,"valUrlCombobox",null,valueSource[0].key,valueSource[0].value);
				}

				return;
			}

		}
	}

	//条件选择框
	function operator(e,row){
		if(!row.arrtTreeValue){
			return;
		}
		if(row.attrType=="datepicker" || row.attrType=="spinner" ){//时间和数字控件
			setEditor(e,"2",null,"dateOperator",dateOperatorList);
			return;
		}
		if(row.attrType=="textbox"){//文本控件
			setEditor(e,"2",null,"dateOperator",textOperatorList);
			return;
		}
		if(row.attrType=="combobox"  || row.attrType=="radiobuttonlist" ){//下拉框和多选框控件
			setEditor(e,"2",null,"dateOperator",comboboxList);
			return;
		}
	}

	function setEditor(e,type,url,id,params,textField,valueField){
		e.editor=mini.get(id);
		if(type=="1"){
			e.editor.setUrl(url);
			if(typeof (textField) !="undefined" && typeof (valueField) !="undefined"){
				e.editor.textField=textField;
				e.editor.valueField=valueField;
			}
		}else if (params) {
			e.editor.setData(params);
		}
		e.column.editor=e.editor;
	}

	//第二层
	var secondFloorNodeList =[];
	for(var i=0;i<firstFloorNume;i++){
		var secondFloorNode =0;
		secondFloorNodeList.push(secondFloorNode);
	}

	var extPropList =[
		{name:"用户分类",extPropId:"user"},
		{name:"组分类",extPropId:"org"}
	];
	extPropTree.setData(extPropList);

	function getElemByIds(){
		var firstRuleBtmId ="#firstFloorRuleBtm_"+row_num;
		var firstGroupRuleBtmId ="#firstFloorGroupRuleBtm_"+row_num;
		firstFloorRuleBtm = $(firstRuleBtmId)[0];
		firstFloorGroupRuleBtm = $(firstGroupRuleBtmId)[0];
	}
	/**
	 * 扩展分类切换
	 */
	function extPropValChang(){
		if(extPropId !=extPropTree.value){
			groupGrid.setData(null);
			extPropId =extPropTree.value;
			firstFloorNode =0;
			cantOclik =true;
			initGroupRule();
		}
	}

	/**
	 * 颜色切换
	 */
	function changColor(rule1,colorType1,rule2,colorType2) {
		rule1.style="color:"+colorType1+" ;";
		rule2.style="color: "+colorType2+" ;";
	}

	/**
	 * 第一层选择：and
	 */
	function selectAndRule(row_uid){
		var node = groupGrid.getRowByUID(row_uid);
		node.rule=node.rule=="and"?"or":"and";
		var id ="#toggledBtm_"+row_uid;
		var andOrBtm = $(id)[0];
		var className = andOrBtm.className;
		andOrBtm.className =className=="toggledBtmAnd"?"toggledBtmOr":"toggledBtmAnd";
	}
	/**
	 * 新增
	 */
	function newRule(row_id) {
		if(!cantOclik){
			return;
		}
		var node = groupGrid.getSelectedNode();
		groupGrid.addNode({sn:1,type:"rule"}, "add", node);
		groupGrid.cancelEdit();
		groupGrid.beginEditRow(node);

		firstFloorNode++;
		if(firstFloorNode==firstFloorNume){
			cantOclik =false;
			getElemByIds();
			changColor(firstFloorRuleBtm,fontColor_2,firstFloorGroupRuleBtm,fontColor_2);
		}
	}

	//初始化时添加组
	function initGroupRule(){
		var node =null;
		var newNode = {sn:0,type:"orgRule",rule:"and"};
		groupGrid.addNode(newNode, "before", node);
		groupGrid.expandNode(node);
	}

	//新增组
	function newGroupRule(row_id){
		if(!cantOclik){
			return;
		}
		var node =groupGrid.getSelectedNode();
		var newNode = {sn:1,type:"orgRule",rule:"and"};
		groupGrid.addNode(newNode, "add", node);
		groupGrid.expandNode(node);

		firstFloorNode++;
		if(firstFloorNode==firstFloorNume){
			cantOclik =false;
			getElemByIds();
			changColor(firstFloorRuleBtm,fontColor_2,firstFloorGroupRuleBtm,fontColor_2);
		}
	}

	//在当前选择行的下添加子记录
	function newGroupSubRule(){
		var node = groupGrid.getSelectedNode();
		var childrenList = node.children;
		if(typeof(childrenList)!="undefined" && childrenList.length==secondFloorNume){
			mini.alert("组内规则只能添加"+secondFloorNume+"条！");
			return;
		}
		var newNode = {sn:2,type:"rule"};
		groupGrid.addNode(newNode, "add", node);
		groupGrid.expandNode(node);
	}

	//组的行点击
	function groupRowClick(e){
		var record=e.record;
		var groupId=record.groupId;
		if(!groupId) return;
		$("#groupId").val(groupId);
	}

	//删除用户组行
	function delGroupRow(row_uid) {
		var row=null;
		if(row_uid){
			row = groupGrid.getRowByUID(row_uid);
		}else{
			row = groupGrid.getSelected();
		}

		if(!row){
			mini.alert("请选择删除的用户组！");
			return;
		}


		mini.confirm("确定删除此记录？","提示",function callback(ok){
			if(ok!="ok"){
				return;
			}
			groupGrid.removeNode(row);
			if(row.sn==1){
				firstFloorNode--;
				if(firstFloorNode<firstFloorNume){
					cantOclik=true;
					getElemByIds();
					changColor(firstFloorRuleBtm,fontColor_1,firstFloorGroupRuleBtm,fontColor_1);
				}
			}
			return;
		});
	}

	function attrValChange(e) {
		var node=groupGrid.getSelectedNode();
		node.attrType =e.selected.widgetType;
		if(e.selected.sourceType){
			node.sourceType =e.selected.sourceType;
		}
		if(e.selected.valueSource){
			node.valueSource =e.selected.valueSource;
		}
	}


	function onCancel(){
		CloseWindow('cancel');
	}

	function onOk(){
		var data = groupGrid.getData();
		if(!closeWind(data)){
			return;
		}
		CloseWindow('ok');
	}

	function closeWind(data){
		var childrenData =data[0].children;
		if(typeof (childrenData) =="undefined" || !childrenData || childrenData.length <1){
			mini.alert("请添加查询条件！");
			return false;
		}
		for(var i=0;i<childrenData.length;i++){
			var node = childrenData[i];
			if(node.type=="rule"){
				if(!checkValue(node)){
					return false;
				}
			}else{
				var children =node.children;
				if(typeof (children) =="undefined" || !children || children.length==0){
					mini.alert("组内规则为空！");
					return false;
				}
				for(var k=0;k<children.length;k++){
					if(!checkValue(children[k])){
						return false;
					}
				}
			}
		}
		return true;
	}
	function checkValue(node){
		if(!node.treeIdValue || !node.arrtTreeValue || !node.operatorValue || !node.valValue){
			mini.alert("请选择查询条件！");
			return false;
		}
		return true;
	}

	function getRuls(){
		selectNameList=[];
		var nodeData = groupGrid.getData();
		var data = nodeData[0].children;
		if(nodeData && nodeData.length >0){
			var sqlObj ={
				"type":"condition",
				"value":nodeData[0].rule
			}
			selectSqlList.push(sqlObj);
			for(var i=0;i<data.length;i++){
				var node = data[i];
				setRuleSql(node);
			}
		}
		var  configDescpName = "";
		for(var i=0;i<selectNameList.length;i++){
			if(!configDescpName){
				configDescpName = selectNameList[i];
			}else{
				configDescpName = configDescpName +","+selectNameList[i];
			}
		}
		var config = {"configData":nodeData,"extProType":extPropId};
		var extPropObj ={
			"config":config,
			"configDescp":configDescpName
		}
		return extPropObj;
	}

	function setRuleSql(node){
		var sql ="";
		if(node.type =="orgRule"){
			sql =setOrgRule(node);
		}else{
			sql =setSql(node);
		}
	}
	function setOrgRule(node){
		var children =node.children;
		var chilDrenLength = children.length;
		if(chilDrenLength==1){
			return setSql(children[0]);
		}
		for(var i=0;i<chilDrenLength;i++){
			var chilNode = children[i];
			selectNameList.push(chilNode.attrName+"("+chilNode.valName+")");
		}
	}

	function setSql(node){
		selectNameList.push(node.attrName+"("+node.valName+")");
	}

	function extGet(){
		var data = groupGrid.getData();
		if(!closeWind(data)){
			return;
		}
		var data1 =getRuls();
		var config =mini.encode(data1.config);
		_OpenWindow({
			title:'预览',
			width:900,
			url:__rootPath+'/bpm/core/bpmSolUser/getExtProp.do',
			height:450,
			onload:function(){
				var iframe = this.getIFrameEl().contentWindow;
				iframe.setData(config);
			},
			ondestroy:function(action){
			}
		});
	}

	function setData(config){
		if(typeof (config)!="undefined" && config && config !="{}"){
			var configData = JSON.parse(config);
			var configAttr=configData.configData;
			extPropId =configData.extProType;
			if(!extPropId){
				initData();
				return
			}
			extPropTree.setValue(extPropId)
			groupGrid.setData(configAttr);
		}else{
			initData();
		}
	}
	function initData(){
		initGroupRule();
		extPropId ="user";
		extPropTree.setValue("user")
	}

</script>
</body>
</html>