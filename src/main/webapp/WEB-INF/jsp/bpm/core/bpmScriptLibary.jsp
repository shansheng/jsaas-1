<%--
    Document   : [sys_script_libary]列表页
    Created on : 2019-03-29 18:12:21
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>[sys_script_libary]列表管理</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
	<div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false">
		<div class="southBtn">
			<a class="mini-button"     onclick="onOk()">确定</a>
			<a class="mini-button btn-red"    onclick="onCancel()">取消</a>
		</div>
	</div>
	<div title="分类" showProxyText="true" region="west" width="160"
		 expanded="true" showSplitIcon="fa">
		<div class="mini-fit rx-grid-fit form-outer5">
			<ul id="leftTree" class="mini-tree" url="" showTreeIcon="true"
				textField="name"  expandOnLoad="false"
				style="width: 100%; height: 100%;" onnodeclick="groupNodeClick"
				onbeforeload="loadSubChildren">
			</ul>
		</div>
	</div>
	<div title="center" region="center">
		<div class=" mini-toolbar">
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li><span class="text">脚本全名：</span><input class="mini-textbox" name="Q_FULL_CLASS_NAME__S_LK"></li>
						<li ><span class="text" title="方法名(别名)">方法名(别名)：</span><input class="mini-textbox" name="Q_METHOD__S_LK"></li>
						<li class="liBtn" style="margin-right: 0">
							<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
							<a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
						</li>
					</ul>
					<div id="moreBox">
						<ul>
							<li><span class="text">所属类：</span><input class="mini-textbox"  name="Q_BEAN_NAME__S_LK"></li>
						</ul>
					</div>
				</form>
			</div>
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>

		<div class="mini-fit" >
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				 url="${ctxPath}/sys/org/sysScriptLibary/listData.do" idField="libId"
				 multiSelect="false" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="20"></div>
					<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="fullClassName"  sortField="FULL_CLASS_NAME_"  width="120"  allowSort="true">方法描述</div>
					<div field="method"  sortField="METHOD_"  width="120"  allowSort="true">接口名</div>
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
	//行功能按钮
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')"></span>';
		return s;
	}

	function onOk(){
		CloseWindow('ok');
	}

	function getSelectedRow(){
		var selected = datagrid1.getSelected();
		return selected.example;
	}
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.org.entity.SysScriptLibary" winHeight="450"
				   winWidth="700" entityTitle="sys_script_libary" baseUrl="sys/org/sysScriptLibary" />
</body>
</html>