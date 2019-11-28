<%-- 
    Document   : 系统脚本库列表页
    Created on : 2019-03-29 18:12:21
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>系统脚本库列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<ul id="exportMenu" class="mini-menu" style="display:none;">
	<li  onclick="exportAllPage(this)">导出所有页</li>
	<li  onclick="exportCurPage(this)">导出当前页</li>
</ul>
<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
	<div title="分类"
		 showProxyText="true"
		 region="west"
		 width="200"
		 showSplitIcon="true"
		 showCollapseButton="false"
		 showProxy="false"
		 expanded="true"
	>
		<div id="toolbar2" class="treeToolBar">
			<a class="mini-button"  plain="true" onclick="createNewTree()">新增分类</a>
		</div>
		<div class="mini-fit">
			<ul id="leftTree" class="mini-tree" url="" showTreeIcon="true"
				textField="name"  expandOnLoad="false"
				style="width: 100%; height: 100%;" onnodeclick="groupNodeClick"
				onbeforeload="loadSubChildren">
			</ul>
		</div>
	</div>
	<div title="center" region="center">
		<div class="mini-toolbar" >
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li><span class="text">脚本全名：</span><input class="mini-textbox" name="Q_FULL_CLASS_NAME__S_LK"></li>
						<li><span class="text">方法名：</span><input class="mini-textbox" name="Q_METHOD__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button"  plain="true" onclick="searchFrm()">查询</a>
							<a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
						</li>
					</ul>
					<div id="moreBox">
						<li><span class="text">所属类：</span><input class="mini-textbox"  name="Q_BEAN_NAME__S_LK"></li>
					</div>
				</form>
			</div>
			<ul class="toolBtnBox">
				<li>
					<a class="mini-button"  plain="true" onclick="initScriptFu()">初始化</a>
					<a class="mini-button"  plain="true" onclick="add()">增加</a>
					<a class="mini-button"  plain="true" onclick="edit()">编辑</a>
					<a class="mini-button btn-red" plain="true" onclick="remove()">删除</a>
					<a class="mini-menubutton"  plain="true" menu="#exportMenu">导出</a>
				</li>
			</ul>
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>
		<div class="mini-fit" style="height: 100%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				 url="${ctxPath}/sys/org/sysScriptLibary/listData.do" idField="libId"
				 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="120"   renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="fullClassName"  sortField="FULL_CLASS_NAME_"  width="120"  allowSort="true">脚本全名</div>
					<div field="method"  sortField="METHOD_"  width="120"  allowSort="true">方法名</div>
					<div field="beanName"  sortField="BEAN_NAME_"  width="120"  allowSort="true">所属类</div>
				</div>
			</div>
		</div>
	</div>
</div>

	<script type="text/javascript">
		mini.parse();
		var  sysScriptLibaryTreeId="";
		var datagrid1=mini.get('#datagrid1');

		//加载分类：SCRIPT_SERVICE_CLASS
		var leftTree=mini.get('#leftTree');
		leftTree.setUrl('${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=SCRIPT_SERVICE_CLASS');


		//初始化数据
		function initScriptFu(){
			var url="${ctxPath}/sys/org/sysScriptLibary/initScriptFu.do";
			$.getJSON(url,function callbact(json){
				mini.alert(json.message);
				datagrid1.setUrl(__rootPath+'/sys/org/sysScriptLibary/listData.do');
				datagrid1.load();
				leftTree.load();
			});
		}

		//点击分类，查询对应数据
		function groupNodeClick(e){
			var record=e.record;
			var treeId=record.treeId;

			if(!treeId) return;

			sysScriptLibaryTreeId=treeId;

			datagrid1.setUrl(__rootPath+'/sys/org/sysScriptLibary/getListBytreeId.do?treeId='+treeId);
			datagrid1.load();

		}

		//加载子树数据
		function loadSubChildren(e){
			var tree = e.sender;    //树控件
			var node = e.node;      //当前节点
			var params = e.params;  //参数对象
			//可以传递自定义的属性
			params.parentId = node.groupId; //后台：request对象获取"myField"
		}

		function createNewTree(){
			var type = "SCRIPT_SERVICE_CLASS"
			_OpenWindow({
				title:'新增表单视图分类',
				url:__rootPath+'/sys/core/sysTree/edit.do?catKey=' + type,
				width:720,
				height:350,
				ondestroy:function(action){
					leftTree.load();
				}
			});
		}
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.org.entity.SysScriptLibary" winHeight="450"
		winWidth="700" entityTitle="系统脚本库" baseUrl="sys/org/sysScriptLibary" />
</body>
</html>