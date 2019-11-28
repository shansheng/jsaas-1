<%-- 
    Document   : [系统自定义业务管理列表]列表页
    Created on : 2017-05-21 12:11:18
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>系统对话框列表管理</title>
<%@include file="/commons/list.jsp"%>
<link rel="stylesheet" href="/aps/scripts/jquery/plugins/json-viewer/jquery.json-viewer.css" />
<script type="text/javascript" src="/aps/scripts/jquery/plugins/json-viewer/jquery.json-viewer.js"></script>
<style type="text/css">
	.mini-layout-border>#center{
 		background: transparent;
	}
</style>
</head>
<body>
	
	<ul id="treeMenu" class="mini-contextmenu" >
		<li   onclick="addNodeList()">新增分类</li>
	    <li  onclick="editNodeList()">编辑分类</li>
	    <li  class=" btn-red" onclick="delNode()">删除分类</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	    <div 
	    	title="对话框分类"
	    	region="west" 
	    	width="220"
	    	showSplitIcon="true"
	    	showCollapseButton="false"
	    	showProxy="false" 
	    	class="layout-border-r" 
   		>
	        <div class="treeToolBar">
   	             <a class="mini-button"    onclick="addNodeList()">新增</a>
                 <a class="mini-button"  onclick="refreshSysTree()">刷新</a>
	        </div>
			<div class="mini-fit">
				 <ul
					id="systree"
					class="mini-tree"
					url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BO_LIST_DLG"
					style="width:100%; height:100%;"
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
	    </div>
		<div region="center" showHeader="false" showCollapseButton="false" title="对话框列表">
		  	
	          <div class="mini-toolbar" >
			    <ul id="popupAddMenu" class="mini-menu" style="display:none;">
				    <li  onclick="doExport(false)">导出选中</li>
				    <li onclick="doExport(true)">导出全部</li>
		        </ul>

				<div class="searchBox">
					<form class="search-form" id="searchForm" >					
						<ul>
							<li>
								<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK">
							</li>
							<li>
								<span class="text">标识键：</span><input class="mini-textbox" name="Q_KEY__S_LK">
							</li>
							<li class="liBtn">
								<a class="mini-button " onclick="searchFrm()">搜索</a>
								<a class="mini-button  btn-red" onclick="clearForm()">清空</a>
							</li>
						</ul>
					</form>
				</div>
			  <ul class="toolBtnBox">
				  <li>
					  <a class="mini-button"  onclick="editBoList()">新增</a>
				  </li>
				  <li>
					  <a class="mini-button" onclick="editSelRow()">编辑</a>
				  </li>
				  <li>
					  <a class="mini-button"  onclick="editTreeDlg()">新增树型对话框</a>
				  </li>
				  <li>
					  <a class="mini-menubutton"  plain="true" menu="#popupAddMenu">导出</a>
				  </li>
				  <li>
					  <a class="mini-button"  onclick="doImport">导入</a>
				  </li>
				  <li>
					  <a class="mini-button btn-red"   onclick="remove()">删除</a>
				  </li>
			  </ul>
			    <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
		    </div>
			<div class="mini-fit"> 
			<div id="datagrid1"
				 class="mini-datagrid"
				 style="width: 100%; height: 100%;"
				 allowResize="false"
				 url="${ctxPath}/sys/core/sysBoList/listDialogJsons.do"
				 idField="id"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
				<div property="columns">
					<div type="checkcolumn" width="20"  headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="100" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="name"  sortField="NAME_"  width="120" headerAlign="" allowSort="true">名称</div>
					<div field="key"  sortField="KEY_"  width="120" headerAlign="" allowSort="true">标识键</div>
					<div field="isTreeDlg" sortField="IS_TREE_DLG_"  width="80" headerAlign="" allowSort="true" renderer="onIsTreeDlgRenderer">是否树型</div>
					<div field="isLeftTree"  sortField="IS_LEFT_TREE_"  width="60" headerAlign="" allowSort="true" renderer="onIsLeftTreeRenderer">是否显示左树</div>
					<div field="isPage"  sortField="IS_PAGE_"  width="60" headerAlign="" allowSort="true" renderer="onIsPageRenderer">是否分页</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	<div 
		id="jsonWin" 
		class="mini-window" 
		iconCls="icon-script" 
		title="JSON数据" 
		style="width: 550px; 
		height: 350px; 
		display: none;" 
		showMaxButton="true"
		showShadow="true" 
		showToolbar="true" 
		showModal="true" 
		allowResize="true" 
		allowDrag="true"
	>
		<textarea id="json" class="mini-textarea" style="height: 100%; width: 100%"></textarea>
	</div>
	
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var uid=record._uid;
			var s = '<span  title="编辑" onclick="editSelRow(\'' + uid + '\')">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
					if(!record.refId && record.type==0){
						s+= '<span  title="创建手机对话框"  onclick="createMobileDialog(\'' + pkId + '\')">创建手机对话框</span>';
					}
					
					if(record.isGen=='YES'){
						s+= '<span title="预览"  onclick="preview(\'' + uid + '\')">预览</span>';
						s+= '<span  title="编辑代码"  onclick="editHtml(\'' + uid + '\')">编辑代码</span>';
					}
			return s;
		}
		
		  function onIsTreeDlgRenderer(e) {
	            var record = e.record;
	            var isTreeDlg = record.isTreeDlg;
	             var arr = [{'key' : 'YES', 'value' : '是','css' : 'green'}, 
	    			        {'key' : 'NO','value' : '否','css' : 'orange'}];
	    			return $.formatItemValue(arr,isTreeDlg);
	        }
		
		  function onIsLeftTreeRenderer(e) {
	            var record = e.record;
	            var isLeftTree = record.isLeftTree;
	             var arr = [{'key' : 'YES', 'value' : '是','css' : 'green'}, 
	    			        {'key' : 'NO','value' : '否','css' : 'orange'}];
	    			return $.formatItemValue(arr,isLeftTree);
	        }
		  
		  function onIsPageRenderer(e) {
	            var record = e.record;
	            var isPage = record.isPage;
	             var arr = [{'key' : 'YES', 'value' : '是','css' : 'green'}, 
	    			        {'key' : 'NO','value' : '否','css' : 'orange'}];
	    			return $.formatItemValue(arr,isPage);
	        }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysBoList" winHeight="450"
		winWidth="700" entityTitle="系统对话框定义" baseUrl="sys/core/sysBoList" />
		
	<script type="text/javascript">
		//添加bo列表
		function editBoList(pkId){
			var id=pkId?pkId:'';
			_OpenWindow({
				title:'系统对话框定义',
				width:800,
				height:450,
				max:true,
				url:__rootPath+'/sys/core/sysBoList/edit.do?isDialog=YES&pkId='+id
			});
		}
		function editSelRow(uid){
			var selected=null;
			if(uid){
				selected=grid.getRowByUID(uid);
			}else{
				selected=grid.getSelected();
			}
			if(!selected){
				alert('请选择行!');
			}
			var isTreeDlg=selected.isTreeDlg;
			var id=selected.id;
			
			if('YES'==isTreeDlg){
				editTreeDlg(id);
			}else{
				editBoList(id);
			}
		}
		function editTreeDlg(pkId){
			var id=pkId?pkId:'';
			_OpenWindow({
				title:'树型对话框定义',
				width:800,
				height:450,
				max:true,
				url:__rootPath+'/sys/core/sysBoList/treeDlgEdit.do?isDialog=YES&pkId='+id
			});
		}
		
		function preview(uid){
			var row=grid.getRowByUID(uid);
			_CommonDialogExt({
				dialogKey:row.key,
				ondestroy:function(data){
					var win = mini.get("jsonWin");
					mini.get('json').setValue(mini.encode(data));
					win.show();
				}
			})
		}
		
		function editHtml(uid){
			var row=grid.getRowByUID(uid);
			var url=__rootPath+'/sys/core/sysBoList/edit3.do?id='+row.id;
			_OpenWindow({
				title: row.name+'-代码',
				max:true,
				url:url,
				height:500,
				width:800
			});
		}
		

		function addNodeList(e){
			addNodeList('新增列表分类','CAT_BO_LIST_DLG');
	   	}
	   	
	   	function refreshSysTree(){
	   		var systree=mini.get("systree");
	   		systree.load();
	   	}
	   	
	   	function editNodeList(e){
			editNode('编辑节点')
	   	}

	   	
	   	//按分类树查找数据字典
	   	function treeNodeClick(e){
	   		var node=e.node;
	   		grid.setUrl(__rootPath+'/sys/core/sysBoList/listDialogJsons.do?treeId='+node.treeId);
	   		grid.load();
	   	}
	   	
	   	function createMobileDialog(pkId){
			_OpenWindow({
	   			title:'创建手机对话框',
	   			url:__rootPath+'/sys/core/sysBoList/mobileEdit.do?refId='+pkId,
	   			width:780,
	   			height:350,
	   			ondestroy:function(action){
	   				if(action=='ok'){
	   					systree.load();
	   				}
	   			}
	   		});
		}
	   	
	   	/**
	   	*导出
	   	**/
	   	function doExport(flag){
	   		var rows=grid.getSelecteds();
	   		if(rows.length==0 && !flag){
	   			alert('请选择需要导出的对话框记录！')
	   			return;
	   		}
	   		if(flag){
	   			rows = grid.getData();
	   		}
	   		var ids=_GetKeys(rows);
	   		jQuery.download(__rootPath+'/sys/core/sysBoList/doExport.do?boKeys='+ids,{isDialog:true},'post');
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
	   			title:'对话框导入',
	   			url:__rootPath+'/sys/core/sysBoList/import1.do',
	   			height:350,
	   			width:600,
	   			ondestroy:function(action){
	   				grid.reload();
	   			}
	   		});
	   	}
	</script>
</body>
</html>