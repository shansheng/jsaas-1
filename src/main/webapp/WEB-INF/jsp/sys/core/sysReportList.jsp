<%-- 
    Document   : 报表列表
    Created on : 2015-12-16, 18:11:48
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 使用范围：
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>报表列表</title>
<%@include file="/commons/list.jsp"%>
<style type="text/css">
	.mini-layout-border>#center{
 		background: transparent;
	}
</style>
</head>
<body>
	<ul id="treeMenu" class="mini-contextmenu">
		<li   onclick="addNodeList()">新增分类</li>
		<li  onclick="editNodeList()">编辑分类</li>
		<li  onclick="delNode()">删除分类</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
		<div 
			title="报表分类" 
			region="west" 
			width=220
			showSplitIcon="true"
	    	showCollapseButton="false"
	    	showProxy="false"
			style=" margin-left:2px" 
		>
			<div class="treeToolBar">
				<a class="mini-button"   plain="true" onclick="addNodeList()">新建分类</a>
				<a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
			</div>
			<div class="mini-fit">
				<ul id="systree"
					class="mini-tree"
					style="width: 100%; height:100%;"
					url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_REPORT"
					showTreeIcon="true" textField="name" idField="treeId" resultAsTree="false" parentField="parentId" expandOnLoad="true" ondrawnode="onDrawNode" onnodeclick="treeNodeClick" contextMenu="#treeMenu">
				</ul>
			</div>
		</div>
		<div region="center"   showHeader="false" showCollapseButton="false">
			<redxun:toolbar entityName="com.redxun.sys.core.entity.SysReport" excludeButtons="popupAddMenu,popupAttachMenu,popupSearchMenu,detail,edit,remove,popupSettingMenu,export,importData">
				<div class="self-toolbar">
					<li>
						<a class="mini-button"   onclick="addOne()" plain="true">新增报表</a>
					</li>
					<li>
						<a class="mini-button"   onclick="searchForm(this)">查询</a>
					</li>
                    <li>
                    	<a class="mini-button btn-red"   onclick="clearSearch()">清空查询</a>
                    </li>
				</div>
			</redxun:toolbar>
			<div class="mini-fit rx-grid-fit" style="height: 100%;">
				<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" url="${ctxPath}/sys/core/sysReport/listData.do" idField="repId" multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
					<div property="columns">
						<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
						<div field="subject" width="220" headerAlign="center" allowSort="true">标题</div>
						<div field="filePath" width="120" headerAlign="center" allowSort="true">报表模板路径</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();
		var reportCat;

		var tree = mini.get(systree);
		var mynodes = tree.getChildNodes(tree.getRootNode());
		var firstPage;
		if (mynodes.length > 0) {
			firstPage = mynodes[0].treeId;//第一个节点的Id
			mini.get('datagrid1').setUrl("${ctxPath}/sys/core/sysReport/listData.do?treeId=" + firstPage);
		} else {//如果没有tree，访问list1，给一个空的列表防止报错
			mini.get('datagrid1').setUrl("${ctxPath}/sys/core/sysReport/listBlank.do");
		}

		//mini.get('datagrid1').load();
		//行功能按钮 
		function onActionRenderer(e) {
			var record = e.record;
			var uid = record.pkId;
			var s = '<span  title="明细" onclick="detailMyRow(\'' + uid + '\')">明细</span>';
			s += ' <span  title="编辑" onclick="editMyRow(\'' + uid + '\')">编辑</span>';
			s += ' <span  title="删除" onclick="delRow(\'' + uid + '\')">删除</span>';
			s += ' <span  title="发布" onclick="publishRow(\'' + uid + '\')">发布</span>';
			s += ' <span  title="预览" onclick="previewRow(\'' + uid + '\')">预览</span>';
			return s;
		}

		//设置节点图标
		function onDrawNode(e) {
			e.iconCls = 'icon-folder';

		}
		
		//新增节点
		function addNodeList(e) {
			addNode('新增节点','CAT_REPORT')
		}
		//编辑树节点
		function editNodeList(e) {
			editNode('编辑报表分类节点')
		}
		//刷新树
		function refreshSysTree() {
			var systree = mini.get("systree");
			systree.load();
		}





		//按分类树查找数据
		function treeNodeClick(e) {
			var node = e.node;
			grid.setUrl(__rootPath + '/sys/core/sysReport/listData.do?treeId=' + node.treeId);
			grid.load();
			reportCat = node.treeId;
		}

		
		//添加数据
		function addOne() {
			if (reportCat == undefined) {
				reportCat = firstPage;
			}
			_OpenWindow({
				url : __rootPath + "/sys/core/sysReport/edit.do?parentId=" + reportCat,
				title : "新增报表",
				width : 960,
				height : 730,
				ondestroy : function(action) {
					if (action == 'ok'){
						grid.reload();
						mini.showTips({
				            content: "<b>成功</b> <br/>数据保存成功",
				            state: 'success',
				            x: 'center',
				            y: 'center',
				            timeout: 3000
				        });
					}
				}
			});
		}
		
		//项目明细
		function detailMyRow(pkId) {
			_OpenWindow({
				url : __rootPath + "/sys/core/sysReport/get.do?pkId=" + pkId,
				title : "报表明细",
				width : 720,
				height : 600,
			});
		}
		
		//报表发布到菜单
		function publishRow(pkId) {
			_OpenWindow({
				url : __rootPath + "/sys/core/sysReport/publish.do?pkId=" + pkId,
				title : "报表发布到菜单",
				width : 720,
				height : 600,
			});
		}
		
		

		//编辑行数据
		function editMyRow(pkId) {
			_OpenWindow({
				url : __rootPath + "/sys/core/sysReport/edit.do?pkId=" + pkId,
				title : "编辑报表",
				width : 900,
				height : 730,
				ondestroy : function(action) {
					if (action == 'ok') {
						grid.reload();
					}
				}
			});
		}

		/* 预览报表 */
		function previewRow(pkId) {
			var row = grid.getSelected();
			var paramConfig = row.paramConfig;
			_OpenWindow({
				url : __rootPath + "/sys/core/sysReport/preview.do?pkId=" + pkId,
				title : "预览报表",
				width : 1030,
				height :750,
				onload:function(){
	    			 //var iframe = this.getIFrameEl();
	                 //iframe.contentWindow.setContent(paramConfig);
	    		},
				ondestroy : function(action) {
					if (action == 'ok') {
						grid.reload();
					}
				}
			});
		}
	</script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysReport" winHeight="450" winWidth="700" entityTitle="报表" baseUrl="sys/core/sysReport" />
</body>
</html>