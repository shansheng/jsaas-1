<%-- 
    Document   : [单据数据列表]列表页
    Created on : 2017-05-21 12:11:18
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[单据数据列表]列表管理</title>
<%@include file="/commons/list.jsp"%>

</head>
<body>
	<ul id="treeMenu" class="mini-contextmenu" >
		<li  onclick="addNodeList()">添加分类</li>
	    <li  onclick="editNodeList()">编辑分类</li>
	    <li  class=" btn-red" onclick="delNode">删除分类</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		<div 
		 	region="south" 
		 	showSplit="false" 
		 	showHeader="false" 
		 	height="46"
		 	showSplitIcon="false"
	 	>
			<div class="southBtn">
				<a class="mini-button"    onclick="onOkClick()">确定</a>
				<a class="mini-button btn-red"   onclick="onCancel()">取消</a>
			</div>
		 </div>
	    <div 
	    	title="列表分类" 
	    	region="west" 
	    	width="180"
	    	showSplitIcon="true"
	    	showCollapseButton="false"
	    	showProxy="false"
	    	class="layout-border-r" 
    	>
	        <div id="toolbar1" class="treeToolBar">
				<a class="mini-button"  plain="true" onclick="addNodeList()">添加</a>
                <a class="mini-button"  onclick="refreshSysTree()">刷新</a>
	        </div>
	         <ul 
	         	id="systree" 
	         	class="mini-tree" 
	         	url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BO_LIST" 
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
		     <div class="mini-toolbar" >
		     
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
								<a class="mini-button " onclick="searchFrm()">搜索</a>
								<a class="mini-button " onclick="clearForm()">清空</a>
							</li>

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
					url="${ctxPath}/sys/core/sysBoList/listData.do" 
					idField="id"
					multiSelect="false" 
					showColumnsMenu="true" 
					sizeList="[5,10,20,50,100,200,500]" 
					pageSize="20" 
					allowAlternating="true" 
				>
					<div property="columns">
						<div type="checkcolumn" width="20"></div>
						<div field="name"  sortField="NAME_"  width="160" headerAlign="center" allowSort="true">名称</div>
						<div field="key"  sortField="KEY_"  width="120" headerAlign="center" allowSort="true">标识键</div>
						<div field="isLeftTree"  sortField="IS_LEFT_TREE_"  width="80" headerAlign="center" renderer="onRenderer" allowSort="true">是否显示左树</div>
						<div field="createTime" dateformat="yyyy-MM-dd"  sortField="CREATE_TIME_"  width="80" headerAlign="center" allowSort="true">创建时间</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysBoList" winHeight="450"
		winWidth="700" entityTitle="单据数据列表" baseUrl="sys/core/sysBoList" />
		
	<script type="text/javascript">
		function onRenderer(e) {
            var record = e.record;
            var val = record[e.field];
            var arr = [ {'key' : 'YES', 'value' : '是','css' : 'green'}, 
			            {'key' : 'NO','value' : '否','css' : 'red'} ];
			return $.formatItemValue(arr,val);
        }
		
	   	
	   	function refreshSysTree(){
	   		var systree=mini.get("systree");
	   		systree.load();
	   	}
	   	function addNodeList(){
			addNode("新增分类",'');
		}
	   	function editNodeList(e){
			editNode('编辑节点');
	   	}

	   	
	   	//按分类树查找数据字典
	   	function treeNodeClick(e){
	   		var node=e.node;
	   		grid.setUrl(__rootPath+'/sys/core/sysBoList/listData.do?treeId='+node.treeId);
	   		grid.load();
	   	}
	   	
	   	function onOkClick(){
	   		var row=grid.getSelected();
	   		if(!row){
	   			alert("请选择一条自定义列表!");
	   			return ;
	   		}
	   		CloseWindow("ok");
	   	}
	   	
	   	function getData(){
	   		return grid.getSelected();
	   	}
	</script>
</body>
</html>