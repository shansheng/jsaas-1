<%-- 
    Document   : [ES单据数据列表]列表页
    Created on : 2017-05-21 12:11:18
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[ES单据数据列表]列表管理</title>
<%@include file="/commons/list.jsp"%>

</head>
<body>
	<ul id="treeMenu" class="mini-contextmenu" >
		<li   onclick="addNodeList()">添加分类</li>
	    <li iconCls="icon-edit" onclick="editNodeList()">编辑分类</li>
	    <li iconCls="icon-remove" class=" btn-red" onclick="delNode">删除分类</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	    <div 
	    	title="列表分类" 
	    	region="west" 
	    	width="180"
	    	showSplitIcon="true"
	    	showCollapseButton="false"
	    	showProxy="false"
	    	class="layout-border-r" 
    	>
	        <div id="toolbar1" class="mini-toolbar-no">
				<a class="mini-button"   plain="true" onclick="addNodeList()">添加</a>
                <a class="mini-button" iconCls="icon-refresh" plain="true" onclick="refreshSysTree()">刷新</a>          
	        </div>
	         <ul 
	         	id="systree" 
	         	class="mini-tree" 
	         	url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_ES_LIST" 
	         	style="width:100%;" 
				showTreeIcon="true" 
				textField="name" 
				idField="treeId" 
				resultAsTree="false" 
				parentField="parentId" 
				expandOnLoad="true"
                onnodeclick="treeNodeClick"  
                contextMenu="#treeMenu"
              >        
            </ul>
	    </div>
		<div region="center" showHeader="false" showCollapseButton="false" title="业务查询列表">
			
		     
		     
		     
	     <div class="titleBar mini-toolbar" >
	         <ul>
				<li>
					<a class="mini-button" iconCls="icon-create" plain="true" onclick="addBoList">增加</a>
				</li>
				<li>
					<a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit(true)">编辑</a>
				</li>
				<li>
					<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
				</li>
				<li class="clearfix"></li>
			</ul>
			<div class="searchBox">
				<form id="searchForm" class="search-form" style="display: none;">					
					<ul>
						<li>
							<span class="text">名称:</span><input class="mini-textbox" name="Q_NAME__S_LK">
						</li>
						<li>
							<span class="text">标识键:</span><input class="mini-textbox" name="Q_KEY__S_LK">
						</li>
						<li class="searchBtnBox">
							<a class="mini-button _search" onclick="searchFrm()">搜索</a>
							<a class="mini-button _reset" onclick="clearForm()">清空</a>
						</li>
						<li class="clearfix"></li>
					</ul>
				</form>	
				<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
			</div>
	    </div> 
		     
		     
		     
		     
		     
		     
			<div class="mini-fit rx-grid-fit">
				<div 
					id="datagrid1" 
					class="mini-datagrid" 
					style="width: 100%; height: 100%;" 
					allowResize="false"
					url="${ctxPath}/sys/core/sysEsList/listData.do" 
					idField="id"
					multiSelect="true" 
					showColumnsMenu="true" 
					sizeList="[5,10,20,50,100,200,500]" 
					pageSize="20" 
					allowAlternating="true" 
				>
					<div property="columns">
						<div type="checkcolumn" width="20"></div>
						<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
						<div field="name"  sortField="NAME_"  width="160" headerAlign="center" allowSort="true">名称</div>
						<div field="alias"  sortField="ALIAS_"  width="120" headerAlign="center" allowSort="true">标识键</div>
						<div field="createTime" dateformat="yyyy-MM-dd"  sortField="CREATE_TIME_"  width="80" headerAlign="center" allowSort="true">创建时间</div>
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
			var uid=record._uid;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)"></span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')"></span>'
					+ ' <span class="icon-preview" title="预览"  onclick="preview(\'' + uid + '\')"></span>'
					+ ' <span class="icon-html" title="编辑代码"  onclick="editHtml(\'' + uid + '\')"></span>'; 
			return s;
		}
	</script>
	
	
		<redxun:gridScript gridId="datagrid1" 
			entityName="com.redxun.sys.core.entity.SysEsList" 
			winHeight="450"
			winWidth="700" 
			entityTitle="ES单据数据列表" 
			baseUrl="sys/core/sysEsList" />
		
	<script type="text/javascript">
		//添加bo列表
		function addBoList(){
			_OpenWindow({
				title:'ES单据数据列表',
				width:800,
				height:450,
				max:true,
				url:__rootPath+'/sys/core/sysEsList/edit.do'
			});
		}
		
		function preview(uid){
			var row=grid.getRowByUID(uid);
			var url=__rootPath+'/sys/core/sysEsList/'+row.alias+'/list.do';
			_OpenWindow({
				title: row.name+'-预览',
				max:true,
				url:url,
				height:500,
				width:800
			});
		}
		
		function editHtml(uid){
			var row=grid.getRowByUID(uid);
			var url=__rootPath+'/sys/core/sysEsList/edit3.do?id='+row.id;
			_OpenWindow({
				title: row.name+'-代码',
				max:true,
				url:url,
				height:500,
				width:800
			});
		}
		
		function deployMenu(uid){
			var row=grid.getRowByUID(uid);
			var id=row.id;
			var url='/sys/core/sysEsList/'+row.key+'/list.do';
			openDeploymenuDialog({name:row.name,key:row.key,url:url,boListId:id,showMobileIcon:true});
		}
		
		function addNodeList(e){
			addNode('添加列表分类','CAT_ES_LIST')
	   	}
	   	
	   	function refreshSysTree(){
	   		var systree=mini.get("systree");
	   		systree.load();
	   	}
	   	function editNodeList(e){
			editNode('编辑节点');
	   	}
	   	
	   	function delNode(e){
	   		var systree=mini.get("systree");
	   		var node = systree.getSelectedNode();
	   		_SubmitJson({
	   			url:__rootPath+'/sys/core/sysTree/del.do?ids='+node.treeId,
	   			success:function(text){
	   				systree.load();
	   			}
	   		});
	   	}
	   	
	   	//按分类树查找数据字典
	   	function treeNodeClick(e){
	   		var node=e.node;
	   		grid.setUrl(__rootPath+'/sys/core/sysEsList/listData.do?Q_TREE_ID__S_EQ='+node.treeId);
	   		grid.load();
	   	}
	</script>
</body>
</html>