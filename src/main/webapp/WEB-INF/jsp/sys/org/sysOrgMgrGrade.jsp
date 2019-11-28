<%
	//组织架构管理，可管理全部租用组织架构，对于非SaaS管理员，仅能管理其本机构的
	//若传入InstId,并且需要检查当前组织机构的域名是否为在redxun.properties中指定的管理机构，
	//即可以进行格式化处理
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>系统组织架构管理</title>
	<%@include file="/commons/list.jsp"%>
	<script type="text/javascript" src="${ctxPath}/scripts/sys/org/org.js"></script>
	<style type="text/css">
		.mini-layout-border>#center{
			background: transparent;
		}
		.mini-tree .mini-grid-viewport{
			background: #fff;
		}
	</style>
</head>
<body>
<div style="display:none;">
	<input class="mini-combobox" id="levelCombo" textField="name" valueField="level" />
</div>
<div id="orgLayout" class="mini-layout" style="width:100%;height:100%;">

	<div
			title="用户组维度"
			region="west"
			width="170"
			showSplitIcon="true"
			showCollapseButton="false"
			showProxy="false"
	>
		<div id="toolbar1" class="treeToolBar">
			<a class="mini-button"  plain="true" onclick="refreshDims()">刷新</a>
		</div>
		<div class="mini-fit">
			<ul
					id="dimTree"
					class="mini-tree"
					url="${ctxPath}/sys/org/osDimension/gradeJsonAll.do"
					style="width:100%; height:100%;"
					imgPath="${ctxPath}/upload/icons/"
					showTreeIcon="true"
					textField="name"
					idField="dimId"
					resultAsTree="false"
					onnodeclick="dimNodeClick"
					contextMenu="#dimNodeMenu"
			>
			</ul>
		</div>
	</div>

	<div showHeader="false" showCollapseButton="false" iconCls="icon-group" region="center">

		<div class="form-toolBox" >
			<ul>
				<li>
					<a class="mini-button"  onclick="saveGroups()">保存</a>
				</li>
				<li id="addGroupBtn">
					<a class="mini-button"  onclick="newGroupRow()">添加</a>
				</li>
				<li class="other">
					<a class="mini-button"  onclick="newGroupSubRow();">添加子组</a>
				</li>
				<li class="xzqh">
					<a class="mini-button"   onclick="grantGradeRow();">分级配置</a>
				</li>
				<li>
					<ul id="moreMenu" class="mini-menu" style="display:none">
						<li   onclick="expandGrid()">展开</li>
						<li   onclick="collapseGrid()">收起</li>
						<c:if test="${superAdmin || merge}">
							<li   onclick="mergeGroup()">合并</li>
							<li   onclick="splitGroup()">拆分</li>
						</c:if>
					</ul>
					<a class="mini-menubutton"  menu="#moreMenu" >...</a>
				</li>
				<li class="clearfix"></li>
			</ul>
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
					allowCellEdit="true" allowCellSelect="true"
					multiSelect="true" showColumnsMenu="true"
			>
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="185"
						 renderer="onActionRenderer" cellStyle="padding:0;">操作</div>

					<div name="name" field="name" align="left" width="160">组名
						<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
					</div>

					<div  ng-bind="dimId==1" class="xzqhww" name="isSetAdmin" field="isSetAdmin" align="left" width="70">是否配置管理员
					</div>

					<div field="key" name="key" align="left" width="80">组Key
						<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
					</div>
					<div name="rankLevel" field="rankLevel" displayField="rankLevelName" align="left" width="80">用户组等级
						<input property="editor" class="mini-textbox" style="width:100%;" />
					</div>
					<div name="sn" field="sn" align="left" width="60">序号
						<input property="editor" changeOnMousewheel="false" class="mini-spinner"  minValue="1" maxValue="100000" required="true"/>
					</div>
				</div>
			</div>

		</div>
	</div>
	<div
			region="east"
			width="430"
			showSplitIcon="true"
			showHeader="false"
			showCollapseButton="false"
			showProxy="false"
			bodyStyle="border:none;padding:2px;"
	>
		<div class="mini-fit">
			<div class="mini-tabs" style="height:100%;width:100%;border:none;" onactivechanged="resetTab" bodyStyle="border:none;padding:2px;">
				<div title="用户关系" iconCls="icon-user">
					<div class="form-toolBox">
						<ul>
							<li><a class="mini-button"  onclick="addUser();">添加</a></li>
							<li><a class="mini-button"   onclick="joinUser();">加入</a></li>
							<li><a class="mini-button btn-red"   onclick="unjoinUser();">移除</a></li>
							<li><a class="mini-button btn-red"   onclick="deleteUser();">删除</a></li>
							<li><a class="mini-button"   onclick="onSearchUsers()">查询</a></li>
						</ul>
						<form id="userForm" class="text-distance">
							<input type="hidden" id="groupId" name="groupId" value=""/>
							<input class="mini-textbox" id="fullname" name="fullname" emptyText="请输入姓名"/>
							<input class="mini-textbox"  id="userNo" name="userNo" emptyText="请输入用户编号"/>
						</form>
					</div>
					<div class="mini-fit rx-grid-fit" style="padding:2px;">
						<div id="userGridTab" onactivechanged="loadUserGridTabData" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;border:none;" bodyStyle="padding:2px;">
						</div>
					</div>
				</div>

				<div title="扩展属性" iconCls="icon-group">
					<div class="form-toolBox">
						<ul>
							<li><a class="mini-button"   onclick="editOrgAttr()">设置扩展属性</a></li>
						</ul>
					</div>
					<div class="mini-fit rx-grid-fit form-outer5" >
						<div
								id="groupAttr"
								class="mini-treegrid"
								style="width:100%;height:100%;"
								showTreeIcon="true"
								treeColumn="name"
								resultAsTree="false"
								allowResize="true"  allowAlternating="true"
								allowCellValid="true"
								allowCellEdit="true" allowCellSelect="true">
							<div property="columns">
								<div name="treeName" field="treeName" align="left" width="10">属性分类
									<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
								</div>
								<div name="attributeName" field="attributeName" align="left" width="10">属性名称
									<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
								</div>
								<div  name="value" align="left" width="20" renderer="onAttrRenderer" >属性值
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	mini.parse();

	var userId="${userId}";
	var dimTree=mini.get('#dimTree');
	var groupGrid=mini.get('#groupGrid');

	var userGrid=mini.get('#usergrid');
	var defaultDimId='${osDimension.dimId}';
	var userGridTab=mini.get('#userGridTab');
	var groupRelGridTab=mini.get('groupRelGridTab');
	var layout=mini.get('orgLayout');
	//当前操作的机构ID
	var tenantId='${sysInst.instId}';
	var instType='${sysInst.instType}';
	//是否管理员
	var isSuperAdmin = ${isSuperAdmin};
	//是否显示用户组的授权按钮
	var isGrantButton=false;

	var newColumnList = [];
	var isSetAdmin ={};

	var groupGridData =[];
	var isInitGroupGrid =true;

	$.getJSON("${ctxPath}/sys/org/osGradeAdmin/listByMyDimId.do?dimId=1",function callbact(json){
		for(var i=0;json&&i<json.length;i++){
			groupGridData.push(json[i].groupId);
		}
	});


	//重置tab的高度
	function resetTab(){
		mini.layout();
	}

	//屏蔽（是否配置管理员）
	function hideAdmin(){
		var columns = groupGrid.columns;
		for(var i=0;i<columns.length;i++){
			if(columns[i].field && columns[i].field =="isSetAdmin"){
				isSetAdmin=columns[i];
				continue;
			}
			newColumnList.push(columns[i]);
		}
		groupGrid.setColumns(newColumnList)
		newColumnList = [];
	}
	hideAdmin();

	//加入已经存在的用户
	function joinUser(){
		var selectedRow=groupGrid.getSelected();
		if(!selectedRow){
			alert('请选择用户组行!');
			return;
		}

		//获得激活的tab的标属性
		var tab=userGridTab.getActiveTab();

		var groupId=$("#groupId").val();

		if(tab==null || groupId=='') return;
		var relTypeId=tab.name;
		var grid=mini.get('#userGrid_'+relTypeId);
		var conf ={}
		if(isSuperAdmin){
			conf ={
				single:false,
				callback :function(users){
					addUsers(users,tab,groupId,grid);
				}
			};
		}else{
			if(!groupGridData || groupGridData.length==0)return;
			var  groupIdList ="";
			for(var i=0;i<groupGridData.length;i++){
				if(!groupIdList){
					groupIdList = groupGridData[i];
				}else{
					groupIdList =groupIdList+","+ groupGridData[i];
				}
			}
			conf ={
				single:false,
				tenantId:tenantId,
				orgconfig:"selOrg",
				orgid:groupIdList,
				showDimId:true,
				callback :function(users){
					addUsers(users,tab,groupId,grid);
				}
			};
		}
		_UserDialog(conf);
	}
	function addUsers(users,tab,groupId,grid){
		if(!users || users.length==0)return;
		var userIds=[];
		for(var i=0;i<users.length;i++){
			userIds.push(users[i].userId);
		}
		_SubmitJson({
			url:__rootPath+'/sys/org/osUser/joinUser.do',
			method:'POST',
			data:{
				userIds:userIds.join(','),
				relTypeId:tab.name,
				tenantId:tenantId,
				groupId:groupId
			},
			success:function(text){
				var result=mini.decode(text);
				if(result.success){
					grid.load();
				}
			}
		});
	}

	//显示（是否配置管理员）
	function showAdmin(){
		var columns = groupGrid.columns;
		for(var i=0;i<3;i++){
			newColumnList.push(columns[i]);
		}
		newColumnList.push(isSetAdmin);
		for(var i=3;i<columns.length;i++){
			newColumnList.push(columns[i]);
		}
		groupGrid.setColumns(newColumnList)
		newColumnList = [];
	}

	function loadUserGridTabData(e){
		var tab = e.tab;
		if(tab){
			var relTypeId=tab.name;
			var userGrid=mini.get('#userGrid_'+relTypeId);
			userGrid.load();
		}
	}
	function collapseGrid(){
		groupGrid.collapseAll();
	}

	function OnCellBeginEdit(e) {
		var node=dimTree.getSelectedNode();
		var dimId;
		if(!node){
			dimId=defaultDimId;
		}else{
			dimId=node.dimId;
		}

		var field = e.field;
		if (field == "rankLevel") {
			e.editor=mini.get('levelCombo');
			e.editor.setUrl("${ctxPath}/sys/org/osRankType/listByMyDimId.do?dimId="+dimId);
			e.column.editor=e.editor;
		}
	}

	function OnCellEndEdit(e){
		var record = e.record, field = e.field;
		var val=e.value;

		if(field=='name' && (record.key==undefined || record.key=='')){
			//自动拼音
			$.ajax({
				url:__rootPath+'/pub/base/baseService/getPinyin.do',
				method:'POST',
				data:{words:val,isCap:'true',isHead:'true'},
				success:function(result){
					groupGrid.updateRow(record,{key:result.data})
				}
			});
			return;
		}

	}

	//当前维度一样时才切换
	function loadGroupRootNode(){
		var nodes=groupGrid.getRootNode().children;
		for(var i=0;i<nodes.length;i++){
			groupGrid.loadNode(nodes[0]);
		}
	}

	function dimNodeClick(e){
		var node=e.node;
		$(".xzqh").hide();
		$(".other").show();
		hideAdmin();
		dimId =node.dimId;
		if(node.dimId==1){
			$(".xzqh").show();
			$(".other").hide();
			showAdmin();
		}
		if(node.isGrant=='YES'){
			isGrantButton=true;
		}else{
			isGrantButton=false;
		}
		layout.updateRegion("center",{title:'用户组--'+node.name});
		groupGrid.setUrl('${ctxPath}/sys/org/osGradeAdmin/listByMyDimId.do?dimId='+node.dimId);

		loadGroupRootNode();

		layout.expandRegion("south");
		//动态加载该维度用户的关系
		$.getJSON(__rootPath+'/sys/org/osRelType/getRelTypesOfGroupUser.do?tenantId='+tenantId+'&dimId='+node.dimId,function(json){
			loadUserTabs(json);
		});
	}

	//用户组操作列表
	function onActionRenderer(e) {
		var record = e.record;
		var uid = record._uid;
		var s = '';
		if(isSuperAdmin || record.dimId !="1"){
			s= addSpan(record,uid);
		}else if(!groupGridData.contains(record.groupId)){
			s= addSpan(record,uid);
		}

		s+='<span class="icon-button icon-add" title="添加子用户组" onclick="newGroupSubRow()"></span>';
		s+='<span class="icon-button icon-save" title="保存" onclick="saveGroupRow(\'' + uid + '\')"></span>';
		if("1"=="${userId}" || record.createBy && record.createBy=="${userId}"){
			s+='<span class="icon-button icon-remove" title="删除" onclick="delGroupRow(\'' + uid + '\')"></span>';
			s+='<span class="icon-button icon-grant" title="子系统授权" onclick="grantGroupRow(\'' + uid + '\')"></span>';
		}
		if(record.dimId=='1' && record.isType=="0"){
			s+='<span class="icon-button icon-grant" title="分级配置" onclick="grantGradeConfig(\'' + uid + '\')"></span>';
		}
		return s;
	}

	function addSpan(record,uid){
		var s = '';
		s+='<span class="icon-button icon-rowbefore" title="在前添加用户组" onclick="newBeforeRow(\''+uid+'\')"></span>';
		s+='<span class="icon-button icon-rowafter" title="在后添加用户组" onclick="newAfterRow(\''+uid+'\')"></span>';
		return s;
	}
	//配置管理员
	function grantGradeConfig(uid){
		var row=groupGrid.getRowByUID(uid);
		_OpenWindow({
			url:__rootPath+'/sys/org/osUser/dialog1.do?single=false&dimId=1&groupId='+row.groupId,
			height:450,
			width:1080,
			iconCls:'icon-user-dialog',
			title:'用户选择',
			ondestroy:function(action){
				if(action!='ok')return;
				var iframe = this.getIFrameEl();
				var users = iframe.contentWindow.getUsers();
				if(!users || users.length==0)return;
				var ary = [];
				for(var i=0;i<users.length;i++){
					var data = {};
					data.groupId=row.groupId;
					data.userId=users[i].userId;
					data.fullname=users[i].fullname;
					ary.push(data);
				}
				var config={
					url:"${ctxPath}/sys/org/osGradeAdmin/saveAll.do",
					method:'POST',
					postJson:true,
					data:ary,
					success:function(result){
					}
				}
				_SubmitJson(config);
			}
		});

	}

	//分级配置
	function grantGradeRow(){
		var node = groupGrid.getSelectedNode();
		if(!node){
			alert("请选择一行");
			return;
		}
		var menuId = "1";
		var showType = "";
		var title = "分级配置";
		var iconCls = "";
		var url = '/sys/org/sysOrg/mgrConfig.do?groupId='+node.groupId+'&groupName='+node.name+'&nodeDimId='+node.dimId+'&tenantId='+tenantId;
		top.showTabPage({menuId:menuId,showType:showType,title:title,iconCls:iconCls,url:url});
	}

	//授权用户组
	function grantGroupRow(uid){
		var row=groupGrid.getRowByUID(uid);
		_OpenWindow({
			title:'['+row.name + ']'+'--授权管理',
			url:__rootPath+'/sys/org/osGroup/toGrant1.do?groupId='+row.groupId + '&tenantId='+tenantId + "&instType="+ instType,
			width:450,
			height:600
		});
	}

	//在当前选择行的下添加子记录
	function newGroupSubRow(){
		var node = groupGrid.getSelectedNode();
		var newNode = {sn:1,createBy:userId};
		groupGrid.addNode(newNode, "add", node);
		groupGrid.expandNode(node);
	}

	function newGroupRow() {
		var node = groupGrid.getSelectedNode();
		if(typeof(dimId)=="undefined"){
			mini.alert("请选择用户组维度！","提示");
			return;
		}else if(!isSuperAdmin && !node && dimId =="1"){
			mini.alert("请选择用户组维度！","提示");
			return;
		}
		if(!isSuperAdmin && dimId =="1"){
			newGroupSubRow();
			return;
		}
		groupGrid.addNode({sn:1,createBy:userId}, "before", node);
		groupGrid.cancelEdit();
		groupGrid.beginEditRow(node);
	}

	function newAfterRow(row_uid){
		var node = groupGrid.getRowByUID(row_uid);
		groupGrid.addNode({sn:1,createBy:userId}, "after", node);
		groupGrid.cancelEdit();
		groupGrid.beginEditRow(node);
	}

	function newBeforeRow(row_uid){
		var node = groupGrid.getRowByUID(row_uid);
		groupGrid.addNode({sn:1,createBy:userId}, "before", node);
		groupGrid.cancelEdit();
		groupGrid.beginEditRow(node);
	}

	function saveGroupRow(row_uid) {
		//表格检验
		groupGrid.validate();
		if(!groupGrid.isValid()){
			return;
		}
		var row = groupGrid.getRowByUID(row_uid);

		var node = dimTree.getSelectedNode();
		var dimId;
		if(node){
			dimId=node.dimId;
		}else{
			alert("请选择维度！");
			return;
		}

		var json = mini.encode(row);

		_SubmitJson({
			url: "${ctxPath}/sys/org/osGradeAdmin/saveGroup.do",
			data:{
				dimId:dimId,
				tenantId:tenantId,
				data:json},
			method:'POST',
			success:function(text){
				var result=mini.decode(text);
				if(result.data && result.data.groupId){
					groupGrid.updateRow(row,result.data);
				}
			}
		});
	}

	//在当前选择行的下添加子记录
	function newGroupSubRowQY(){
		var node = groupGrid.getSelectedNode();
		if(!node){
			alert("请选择一行");
			return;
		}
		var newNode = {sn:1,isType:0};
		groupGrid.addNode(newNode, "add", node);
		groupGrid.expandNode(node);
	}

	function newGroupSubRowBM(){
		var node = groupGrid.getSelectedNode();
		if(!node){
			alert("请选择一行");
			return;
		}
		_OpenWindow({
			url:"${ctxPath}/sys/org/sysOrg/edit.do?parentId="+node.groupId,
			title:"添加部门",
			width:600,
			height:350,
			ondestroy:function(action){
				groupGrid.load();
			}
		});


	}

	//批量保存用户组
	function saveGroups(){
		var node = dimTree.getSelectedNode();
		var dimId=null;
		if(node){
			dimId=node.dimId;
		}else{
			alert("请选择维度！");
			return;
		}

		//表格检验
		groupGrid.validate();
		if(!groupGrid.isValid()){
			return;
		}

		//获得表格的每行值
		var data = groupGrid.getData();
		if(data.length<=0)return;
		var json = mini.encode(data);

		var postData={
			dimId:dimId,
			gridData:json,
			tenantId:tenantId
		};
		_SubmitJson({
			url: "${ctxPath}/sys/org/osGradeAdmin/batchSaveGroup.do",
			data:postData,
			method:'POST',
			success:function(text){
				groupGrid.load();
			}
		});
	}


	//组的行点击
	function groupRowClick(e){
		var record=e.record;
		var groupId=record.groupId;
		if(!groupId) return;
		$("#groupId").val(groupId);

		layout.updateRegion("south",{title:'用户组关系--'+record.name,visible: true });
		layout.updateRegion("east",{title:'用户--'+record.name,visible: true });

		var level=record.rankLevel;
		var dimId=record.dimId;

		var urlUser=__rootPath+'/sys/org/osRelType/getRelTypesOfGroupUser.do?tenantId='+tenantId+'&dimId='+dimId +"&level=" + level;
		//动态加载该维度用户的关系
		$.getJSON(urlUser,function(json){
			loadUserTabs(json,groupId);
		});

		//动态加载扩展属性
		getAttrList(groupId);
	}

	//用户操作编辑
	function onUserActionRenderer(e){
		var uid = e.record._uid;
		var s = '<span class="icon-button icon-detail" title="用户明细" onclick="userDetail(\''+uid+'\')"></span>';
		s+=' <span class="icon-button icon-edit" title="编辑" onclick="userEdit(\''+uid+'\')"></span>';
		s+=' <span class="icon-button icon-close" title="移除" onclick="userUnjoin(\''+uid+'\')"></span>';
		return s;
	}


	//查找用户
	function onSearchUsers(){
		var formData=$("#userForm").serializeArray();
		var data=jQuery.param(formData);
		var tab=userGridTab.getActiveTab();
		var relTypeId=tab.name;
		var grid=mini.get('userGrid_'+relTypeId);
		grid.setUrl("${ctxPath}/sys/org/osUser/listByGroupIdRelTypeId.do?tenantId="+tenantId+"&relTypeId="+relTypeId + "&"+ data);
		grid.load();
	}

	function expandGrid(){
		groupGrid.expandAll();
	}

	function collapseGrid(){
		groupGrid.collapseAll();
	}

	function mergeGroup(){
		var rows = groupGrid.getSelecteds();
		if (rows.length < 2) {
			alert("请选中大于一条记录");
			return;
		}
		_OpenWindow({
			url:"${ctxPath}/sys/org/sysOrg/merge.do?dimId=1",
			title:"组织历史版本列表",
			width: 800,
			height: 600,
			onload: function () {       //弹出页面加载完成
				var iframe = this.getIFrameEl();
				iframe.contentWindow.setData(rows);
			},
		});
	}

	function splitGroup(){
		var rows = groupGrid.getSelecteds();
		if (rows.length != 1) {
			alert("请选中一条记录");
			return;
		}
		var groupId = rows[0].pkId;
		var obj=getWindowSize();
		_OpenWindow({
			url:"${ctxPath}/sys/org/sysOrg/split.do?dimId=1&groupId="+groupId,
			title:"组织拆分",
			width: obj.width,
			height: obj.height
		});

	}



</script>
</body>
</html>