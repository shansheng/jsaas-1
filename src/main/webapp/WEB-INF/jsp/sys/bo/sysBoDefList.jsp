<%-- 
    Document   : [BO定义]列表页
    Created on : 2017-03-01 23:24:22
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>业务模型列表管理</title>
	<%@include file="/commons/list.jsp"%>
	<script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
</head>
<body>
<ul id="treeMenu" class="mini-contextmenu" >
	<li  onclick="addCatNode">新增分类</li>
	<li  onclick="editCatNode">编辑分类</li>
	<li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	<div
			title="业务模型分类"
			region="west"
			width="220"
			showSplitIcon="true"
			showCollapseButton="false"
			showProxy="false"
	>
		<div class="treeToolBar" >
			<a class="mini-button"   plain="true" onclick="addCatNode()">新增</a>
			<a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
		</div>
		<div class="mini-fit">
			<ul
					id="systree"
					class="mini-tree"
					url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW"
					style="width:100%;"
					showTreeIcon="true"
					textField="name"
					idField="treeId"
					resultAsTree="false"
					parentField="parentId"
					expandOnLoad="true"
					onnodeclick="treeNodeClick"
					contextMenu="#treeMenu"
			></ul>
		</div>
	</div>
	<div region="center" showHeader="false" showCollapseButton="false">
		<div class="mini-toolbar" >
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li>
							<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK">
						</li>
						<li>
							<span class="text">别名：</span><input class="mini-textbox" name="Q_ALAIS__S_LK">
						</li>
						<li class="liBtn">
							<a class="mini-button " onclick="searchForm(this)" >搜索</a>
							<a class="mini-button  btn-red" onclick="onClearList(this)">清空</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
						</li>
					</ul>
					<div id="moreBox">
						<ul>
							<li>
								<span class="text">支持数据表：</span>
								<input
										class="mini-combobox"
										textField="text"
										valueField="id"
										name="Q_SUPPORT_DB__S_EQ"
										data="[{id:'yes',text:'支持'},{id:'no',text:'不支持'}]"
										value=""
										showNullItem="true"
								/>
							</li>
						</ul>
					</div>
				</form>
			</div>
			<ul class="toolBtnBox">
				<li>
					<a class="mini-button"    onclick="addDef()">新增</a>
				</li>
				<li>
					<a class="mini-button"   onclick="edit(true)">编辑</a>
				</li>
				<li>
					<a class="mini-button btn-red"  onclick="delByDefId()">删除</a>
				</li>
			</ul>
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>
		<div class="mini-fit rx-grid-fit" style="height: 100%;">
			<div
					id="datagrid1"
					class="mini-datagrid"
					style="width: 100%; height: 100%;"
					allowResize="false"
					url="${ctxPath}/sys/bo/sysBoDef/listData.do"
					idField="id"
					multiSelect="true"
					showColumnsMenu="true"
					sizeList="[5,10,20,50,100,200,500]"
					pageSize="20"
					allowAlternating="true"
			>
				<div property="columns">
					<div type="checkcolumn" width="20"  headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="130"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="name"  sortField="NAME_"  width="160" headerAlign="" allowSort="true">名称</div>
					<div field="alais"  sortField="ALAIS_"  width="150" headerAlign="" allowSort="true">别名</div>
					<div field="genMode"  sortField="GEN_MODE_"  width="100" renderer="onGenModeRenderer" headerAlign="" allowSort="true">生成方式</div>
					<div field="supportDb" renderer="onDbRenderer"  sortField="SUPPORT_DB_"  width="80" headerAlign="" allowSort="true">支持数据表</div>
					<div field="createTime" sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss" width="100" headerAlign="" allowSort="true">创建时间</div>
				</div>
			</div>
		</div>
		<div
				id="formWin"
				class="mini-window"
				iconCls="icon-script"
				title="关联表单"
				style="width: 550px; height: 350px; display: none;"
				showMaxButton="true"
				showShadow="true"
				showToolbar="true"
				showModal="true"
				allowResize="true"
				allowDrag="true"
		>
			<div class="form-toolBox" style="text-align: right">
				<a class="mini-button btn-red"  plain="true" onclick="hiddenFormWindow">关闭</a>
			</div>
			<div class="mini-fit rx-grid-fit">
				<div class="mini-tabs" style="height: 100%; width: 100%">
					<div title="PC表单">
						<div id="pcGrid" class="mini-datagrid" style="width: 100%; height: 150px" allowResize="false" showPager="false"
							 allowAlternating="true">
							<div property="columns">
								<div field="name" width="140" headerAlign="">名称</div>
								<div field="alias" width="200" headerAlign="">别名</div>
							</div>
						</div>
					</div>
					<div title="手机表单">
						<div id="mobileGrid" class="mini-datagrid" style="width: 100%; height: 150px" allowResize="false" showPager="false"
							 allowAlternating="true">
							<div property="columns">
								<div field="name" width="140" headerAlign="">名称</div>
								<div field="alias" width="200" headerAlign="">别名</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="/WEB-INF/jsp/sys/bo/incJsonView.jsp" %>


<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.bo.entity.SysBoDef" winHeight="450"
				   winWidth="700" entityTitle="BO定义" baseUrl="sys/bo/sysBoDef" />

<script type="text/javascript">
	var categoryId="";

	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var aryButton=[];
		aryButton.push('<span class="" title="数据结构" onclick="viewJson(\'' + pkId + '\')">数据结构</span>');
		aryButton.push('<span class="" title="关联表单" onclick="relationForm(\'' + pkId + '\',true)">关联表单</span>');
		if(record.genMode=="create"){
			aryButton.push('<span  title="删除BO" onclick="delByDefId(\'' + pkId + '\')">删除BO</span>');
			aryButton.push('<span  title="编辑BO" onclick="editRow(\'' + pkId + '\',true)">编辑BO</span>');
		}
		else{
			aryButton.push('<span class="" title="管理BO" onclick="boManage(\'' + pkId + '\')">管理BO</span>');
		}
		return aryButton.join("");
	}


	function delByDefId(pkId){
		var pk=pkId;
		if(!pk){
			var rows=mini.get('datagrid1').getSelecteds();
			if(rows && rows.length>0){
				pk=rows[0].id;
				for(var i=1;i<rows.length;i++){
					pk+=","+rows[i].id;
				}
			}
		}

		if(!pk){
			alert("请选择至少一行！");
			return;
		}

		var url= __rootPath+"/sys/bo/sysBoDef/removeByDefId.do";
		mini.confirm("确定删除选中记录？","确定？",function(action){
			if(action!='ok') return;
			_SubmitJson({
				url: url,
				method:'POST',
				data:{defIds: pk},
				success: function(obj) {
					if(!obj.success){
						top._ShowTips({msg:obj.message});
					}
					else{
						grid.load();
					}
				}
			});
		});

	}

	function onDbRenderer(e) {
		var record = e.record;
		var supportDb = record.supportDb;

		var arr = [ {'key' : 'yes', 'value' : '是','css' : 'green'},
			{'key' : 'no','value' : '否','css' : 'red'} ];

		return $.formatItemValue(arr,supportDb);
	}

	function onGenModeRenderer(e) {
		var record = e.record;
		var genMode = record.genMode;

		var arr = [ {'key' : 'form', 'value' : '表单','css' : 'green'},
			{'key' : 'create','value' : '设计','css' : 'red'} ];

		return $.formatItemValue(arr,genMode);
	}




	function relationForm(pkId){
		var url=__rootPath +"/sys/bo/sysBoDef/getRelForm.do?pkId=" +pkId;
		var pcGrid=mini.get("pcGrid");
		var mobileGrid=mini.get("mobileGrid");
		$.get(url,function(data){
			pcGrid.setData(data.pc);
			mobileGrid.setData(data.mobile);
			var win = mini.get("formWin");
			win.show();
		});

	}

	function boManage(boDefId){
		_OpenWindow({
			title:'表单编辑管理',
			url:__rootPath+'/sys/bo/sysBoDef/manage.do?boDefId=' + boDefId,
			height:450,
			width:800,
			max:true
		});
	}



	function hiddenFormWindow() {
		var win = mini.get("formWin");
		win.hide();
	}

	function onFormRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var s = '<span  title="数据结构" onclick="viewJson(\'' + pkId + '\')">数据结构</span>'
				+ ' <span title="关联表单" onclick="relationForm(\'' + pkId + '\',true)">关联表单</span>';

		return s;
	}

	function treeNodeClick(e){
		var node=e.node;
		var treeId=node.treeId;
		categoryId=treeId;
		var url=__rootPath +"/sys/bo/sysBoDef/listData.do?Q_TREE_ID__S_EQ=" + treeId;
		grid.setUrl(url);
		grid.reload();
	}

	function addDef() {
		var width=getWindowSize().width;
		var height=getWindowSize().height;
		var url=__rootPath +"/sys/bo/sysBoDef/edit.do?treeId=" + categoryId;

		_OpenWindow({
			url: url,
			title: "新增BODEF定义", width: width, height: height,
			ondestroy: function(action) {
				if(action!= 'ok') return;
				grid.reload();
			}
		});
	}


</script>
</body>
</html>