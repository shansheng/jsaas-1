<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[单据表单方案]列表管理</title>
<%@include file="/commons/list.jsp"%>
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
    <li  class=" btn-red" onclick="delNode">删除分类</li>
</ul>
	
<div id="layout1" class="mini-layout" style="width:100%;height:100%;" >
    <div 
    	title="表单方案分类" 
    	region="west" 
    	width="200"  
    	showSplitIcon="true"
    	showCollapseButton="false"
    	showProxy="false"
    	class="layout-border-r"
   	>
	    <div class="treeToolBar">
			<a class="mini-button"   plain="true" onclick="createNewTree">新建</a>
            <a class="mini-button"  plain="true" onclick="refreshTree">刷新 </a>
        </div>
     	<div class="mini-fit">
	        <ul 
	        	id="systree" 
	        	class="mini-tree" 
	        	<%-- url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_FORMSOLUTION" --%>
	        	url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_FORM_VIEW" 
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
    <div region="center" showHeader="false" showCollapseButton="false">
     	 <div class="mini-toolbar" >

			<div class="searchBox">
				<form class="search-form" id="searchForm" >
					<ul>
						<li class="liAuto">
							<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK">
						</li>
						<li>
							<span class="text">别名：</span><input class="mini-textbox" name="Q_ALIAS__S_LK">
						</li>
						<li class="liBtn">
							<a class="mini-button " onclick="clearSearch()">搜索</a>
							<a class="mini-button  btn-red" onclick="clearForm()">清空</a>
						</li>
					</ul>
				</form>
			</div>
			 <ul class="toolBtnBox">
				 <li>
					 <a class="mini-button first"    onclick="add()">新增</a>
				 </li>
				 <li>
					 <a class="mini-button"   onclick="edit(true)">编辑</a>
				 </li>
				 <li>
					 <a class="mini-button"   onclick="vaildSetting()">验证规则</a>
				 </li>
				 <li>
					 <a class="mini-button" onclick="doExport()">导出</a>
				 </li>
				 <li>
					 <a class="mini-button" onclick="doImport()">导入</a>
				 </li>
				 <li>
					 <a class="mini-button btn-red"   onclick="remove()">删除</a>
				 </li>
			 </ul>
			 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
	    </div>
		<div class="mini-fit" style="height: 100%;">
			<div 
				id="datagrid1" 
				class="mini-datagrid" 
				style="width: 100%; height: 100%;" 
				allowResize="false"
				url="${ctxPath}/sys/customform/sysCustomFormSetting/listData.do" 
				idField="id"
				multiSelect="true" 
				showColumnsMenu="true" 
				sizeList="[5,10,20,50,100,200,500]" 
				pageSize="20" 
				allowAlternating="true" 
				pagerButtons="#pagerButtons"
			>
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="120" headerAlign="" align="" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="name"  sortField="NAME_"  width="160" headerAlign="" allowSort="true">名称</div>
					<div field="alias"  sortField="ALIAS_"  width="100" headerAlign="" allowSort="true">别名</div>
					<div field="solName"  sortField="SOL_NAME_"  width="120" headerAlign="" allowSort="true">流程方案名称</div>
					<div field="formName"  sortField="FORM_NAME_"  width="120" headerAlign="" allowSort="true">表单名</div>
					<div field="bodefName"  sortField="BODEF_NAME_"  width="120" headerAlign="" allowSort="true">业务模型</div>
					<div field="isTree" renderer="onStatusRenderer" sortField="IS_TREE_"  width="80" headerAlign="" allowSort="true">表单类型</div>
					<div field="createTime"  sortField="CREATE_TIME_"  width="80" headerAlign="" dateFormat="yyyy-MM-dd" allowSort="true">创建时间</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	mini.parse();
	var systree=mini.get("systree");
	
	var grid=mini.get("datagrid1");
	
	//行功能按钮
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		
		var s='<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
				+'<span  title="授权" onclick="setPermission(\'' + record._uid + '\')">授权</span>'
				+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'
				+'<span  title="使用表单" onclick="showForm(\'' + record.alias + '\',\''+record.isTree+'\')">使用表单</span>';
			s+= ' <span  title="发布菜单"  onclick="deployMenu(\'' + record._uid + '\')">发布菜单</span>';
		return s;
	}
	
	function vaildSetting(){
		var rows=grid.getSelecteds();
   		if(rows.length!=1){
   			alert('请选择一个表单方案记录!')
   			return;
   		}
   		if(!rows[0].bodefId){
   			alert("请配置业务模型!");
   			return;
   		}
   		var ids=_GetIds(rows);
		_OpenWindow({
			title:'验证规则',
			max:true,
			url:__rootPath+"/bpm/form/formValidRule/setting.do?setId="+ids
		});
	}
	
	function onStatusRenderer(e){
		var record = e.record;
		var isTree = record.isTree;
        var arr = [ {'key' : 0, 'value' : '普通','css' : 'green'}, 
			            {'key' : 1,'value' : '树形','css' : 'red'} ];
			
		return $.formatItemValue(arr,isTree);
		
	}
	
	function clearSearch(){
		grid.setUrl("${ctxPath}/sys/customform/sysCustomFormSetting/listData.do");
		searchFrm();
	}
	
	function setPermission(uid){
		var row=grid.getRowByUID(uid);
		var formAlias=row.formAlias;
		var solId=row.id;
		var nodeId="_FORMSOL";
		
		_OpenWindow({
			url:__rootPath+'/bpm/core/bpmFormRight/edit.do?formAlias='+formAlias+'&nodeId=_FORMSOL&solId=' +solId,
			title:'表单视图的字段管理--'+row.name,
			width:780,
			height:480,
			max:true
		});
		
		
	}
	
	/**
   	*导出
   	**/
   	function doExport(){
   		var rows=grid.getSelecteds();
   		if(rows.length==0){
   			alert('请选择需要导出的表单方案记录！')
   			return;
   		}
   		var ids=_GetIds(rows);
   		/*_OpenWindow({
   			title:'表单方案导出',
   			url:__rootPath+'/sys/customform/sysCustomFormSetting/export.do?ids='+ids,
   			height:350,
   			width:600
   		});*/
   		
   		var url = __rootPath+'/sys/customform/sysCustomFormSetting/export.do?ids='+ids;
   		window.location.href = url;
   	}
   	/**
   	*导入
   	**/
   	function doImport(){
   		_OpenWindow({
   			title:'表单方案导入',
   			url:__rootPath+'/sys/customform/sysCustomFormSetting/import1.do',
   			height:350,
   			width:600,
   			ondestroy:function(action){
   				mini.get("datagrid1").reload();
   			}
   		});
   	}
	
	
	
	function showForm(alias,isTree){
		var url=__rootPath + "/sys/customform/sysCustomFormSetting/";
		if(isTree==0){
			url+="form/" +alias+".do";
		}
		else{
			url+="treeMgr/"+ alias+".do";
		}
		_OpenWindow({
			url: url,
	        title: "数据编辑", width: "800", height: "600"
		});
	}
	
	function deployMenu(uid){
		var row=grid.getRowByUID(uid);
		
		var isTree=row.isTree;
		var url='';
		if(isTree=='1'){
			url='/sys/customform/sysCustomFormSetting/treeMgr/'+row.alias+'.do';
		}else{
			url='/sys/customform/sysCustomFormSetting/form/'+row.alias+'.do'
		}
		_OpenWindow({
			title:'发布菜单 ',
			height:450,
			width:800,
			url:__rootPath+"/sys/core/sysMenu/addNode.do",
			onload:function(){
				var win=this.getIFrameEl().contentWindow;
				win.setData({
					name:row.name,
					key:row.alias+'_Add',
					parentId:'',
					url:url,
					showType:'URL',
					isBtnMenu:'NO',
					isMgr:'NO'
				});
			}
		});
	}
	
	function treeNodeClick(e){
		var node=e.node;
		var treeId=node.treeId;
		var name=mini.getByName("Q_NAME__S_LK");
		var alias=mini.getByName("Q_ALIAS__S_LK");
		name.setValue();
		alias.setValue();
		grid.setUrl("${ctxPath}/sys/customform/sysCustomFormSetting/getCustomFormSetting.do?treeId="+treeId);
		grid.load();
	}
	function onBeforeOpen(e) {
		var menu = e.sender;
		var node = systree.getSelectedNode();
		if (!node) {
			e.cancel = true;
			return;
		}
	}
	
	function createNewTree(){
   		var node =systree.getSelectedNode();
   		var parentId=node?node.treeId:0;
   		_OpenWindow({
   			title:'新增表单视图分类',
   			//url:__rootPath+'/sys/core/sysTree/edit.do?parentId='+parentId+'&catKey=CAT_FORMSOLUTION',
   			url:__rootPath+'/sys/core/sysTree/edit.do?parentId='+parentId+'&catKey=CAT_FORM_VIEW',
   			width:720,
   			height:350,
   			ondestroy:function(action){
   				systree.load();
   			}
   		});
	}
	
		function addNodeList(e){
			addNode('新增表单方案分类','CAT_FORM_VIEW');
	   	}

	   	function refreshSysTree(){
	   		var systree=mini.get("systree");
	   		systree.load();
	   	}
	   	
	   	function editNodeList(e){
			editNode('编辑表单方案分类')
	   	}

	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.customform.entity.SysCustomFormSetting" winHeight="450"
		winWidth="700" entityTitle="单据表单方案" baseUrl="sys/customform/sysCustomFormSetting" />
</body>
</html>