<%-- 
    Document   : [自定义查询]列表页
    Created on : 2017-02-21 15:03:07
    Author     : cjx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]列表管理</title>
<%@include file="/commons/list.jsp"%>
	<script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
</head>
<body>
<ul id="treeMenu" class="mini-contextmenu">
	<li   onclick="addCatNodeTable">新增分类</li>
	<li  onclick="editCatNode">编辑分类</li>
	<li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	<div
		title=SQL分类
		region="west"
		width="220"
		showSplitIcon="true"
		showCollapseButton="false"
		showProxy="false"
	>
		<div class="treeToolBar">
			<a class="mini-button"   plain="true" onclick="addCatNodeTable()">新增</a>
			<a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
		</div>
		<div class="mini-fit">
			<ul
				id="systree"
				class="mini-tree"
				url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_CUSTOM_SQL"
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
	<div showHeader="false" showCollapseButton="false">
	<div class="mini-toolbar" >
		<ul id="popupAddMenu" class="mini-menu" style="display:none;">
			<li  onclick="doExport(false)">导出选中</li>
			<li  onclick="doExport(true)">导出全部</li>
		</ul>

		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">名字：</span>
						<input 
							class="mini-textbox"
							name="Q_NAME__S_LK"
						>
					</li>
					<li>
						<span class="text">标识：</span>
						<input 
							class="mini-textbox"
							name="Q_KEY__S_LK"
						>
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
							<span class="text">对象名称：</span>
							<input class="mini-textbox" name="Q_TABLE_NAME__S_LK" >
						</li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button"  onclick="add()">新增</a>
			</li>
			<li>
				<a class="mini-button"  onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-menubutton"  plain="true" menu="#popupAddMenu">导出</a>
			</li>
			<li>
				<a class="mini-button"  onclick="doImport">导入</a>
			</li>
			<li>
				<a class="mini-button btn-red"    onclick="remove()">删除</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/db/sysSqlCustomQuery/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true"
			sizeList="[5,10,20,50,100,200,500]" pageSize="20"
			allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"
					 renderer="onActionRenderer"
					cellStyle="padding:0;">操作</div>
				<div field="name" sortField="NAME_" width="120" headerAlign="center"
					allowSort="true">名字</div>
				<div field="key" sortField="KEY_" width="120" headerAlign="center"
					allowSort="true">标识</div>
				<div field="tableName" sortField="TABLE_NAME_" width="120"
					headerAlign="center" allowSort="true">对象名称</div>
				
			</div>
		</div>
	</div>
	</div>
</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			//alert('pkId='+pkId);
			var s = 
			//'<span  title="明细" onclick="detailRow(\'' + pkId + '\')"></span>'+
			'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>' +
			'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>' +
			' <span  title="预览" onclick="preview(\'' + pkId + '\')">预览</span>'+
			' <span  title="帮助" onclick="help(\'' + pkId + '\')">帮助</span>';
			return s;
		}
		//预览
		function preview(pkId) {
			_OpenWindow({
				url : "${ctxPath}/sys/db/sysSqlCustomQuery/preview.do?pkId=" + pkId,
				title : "预览",
				max : true,
				ondestroy : function(action) {
					if (action == 'ok') {
						grid.reload();
					}
				}
			});
		}
		
		function help(pkId){
			_OpenWindow({
				url : "${ctxPath}/sys/db/sysSqlCustomQuery/help.do?pkId=" + pkId,
				title : "帮助",
				width:1000,
				height:375
			});
		}
		
		/**
	   	*导出
	   	**/
	   	function doExport(flag){
	   		var rows=grid.getSelecteds();
	   		if(rows.length==0 && !flag){
	   			alert('请选择需要导出的查询记录！')
	   			return;
	   		}
	   		if(flag){
	   			rows = grid.getData();
	   		}
	   		var ids=_GetKeys(rows);
	   		jQuery.download(__rootPath+'/sys/db/sysSqlCustomQuery/doExport.do?keys='+ids,{},'post');
	   	}
	   	
	   	/**
	   	 * 获得表格的行的主键key列表，并且用',’分割
	   	 * @param rows
	   	 * @returns
	   	 */
	   	function _GetKeys(rows){
	   		var ids=[];
	   		for(var i=0;i<rows.length;i++){
	   			ids.push(rows[i].key);
	   		}
	   		return ids.join(',');
	   	}
	   	/**
	   	*导入
	   	**/
	   	function doImport(){
	   		_OpenWindow({
	   			title:'查询导入',
	   			url:__rootPath+'/sys/db/sysSqlCustomQuery/import1.do',
	   			height:350,
	   			width:600,
	   			ondestroy:function(action){
	   				grid.reload();
	   			}
	   		});
	   	}

        /**
         * 分类树添加节点。
         * @param e
         * @returns
         */
        function addCatNodeTable(e){
            var systree=mini.get("systree");
            var node = systree.getSelectedNode();
            var parentId=node?node.treeId:0;
            //findNode("add",node.treeId)
            _OpenWindow({
                title:'公式分类',
                url:__rootPath+'/sys/core/sysTree/edit.do?parentId='+parentId+'&catKey=CAT_CUSTOM_SQL',
                width:720,
                height:420,
                ondestroy:function(action){
                    systree.load();
                }
            });
        }

        function treeNodeClick(e){
            var node=e.node;
            var treeId=node.treeId;
            categoryId=treeId;
            var url=__rootPath +"/sys/db/sysSqlCustomQuery/listData.do?Q_TREE_ID__S_EQ="+treeId;
            grid.setUrl(url);
            grid.reload();
        }



	</script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.sys.db.entity.SysSqlCustomQuery"
		winHeight="450" winWidth="700" entityTitle="自定义查询"
		baseUrl="sys/db/sysSqlCustomQuery" />
</body>
</html>