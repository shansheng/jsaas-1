<%-- 
    Document   : [业务实体对象]列表页
    Created on : 2018-05-01 14:21:00
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[业务实体对象]列表管理</title>
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
		title="业务实体分类"
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
	 <div showHeader="false" showCollapseButton="false">
		 <div class="mini-toolbar" >

			<div class="searchBox">
				<form id="searchForm" class="search-form" >						
					<ul>
						<li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
						<li><span class="text">注释：</span><input class="mini-textbox" name="Q_COMMENT__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button"    onclick="searchFrm()">查询</a>
							<a class="mini-button btn-red"   onclick="clearForm()">清空</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
						</li>
					</ul>
					<div id="moreBox">
						<ul>
							<li><span class="text">表名：</span><input class="mini-textbox" name="Q_TABLE_NAME__S_LK"></li>
							<li><span class="text">是否生成物理表：</span>
								<input
										class="mini-combobox"
										name="Q_GEN_TABLE__S_LK"
										showNullItem="true"
										emptyText="请选择..."
										data="[{id:'yes',text:'已生成'},{id:'no',text:'未生成'}]"
								/>
							</li>
						</ul>
					</div>
				</form>
			</div>
			 <ul class="toolBtnBox">
				 <li>
					 <a class="mini-button"  plain="true" onclick="addBoEnt()">新增</a>
				 </li>
			<%--	 <li>
					 <a class="mini-button"  plain="true" onclick="edit()">编辑</a>
				 </li>--%>
				 <li>
					 <a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
				 </li>

			 </ul>
			 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
     	</div>
		
		<div class="mini-fit" style="height: 100%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				url="${ctxPath}/sys/bo/sysBoEnt/listData.do" idField="id"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="50" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="140" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="comment"  sortField="COMMENT_"  width="150" headerAlign="" >注释</div>
					<div field="name"  sortField="NAME_"  width="120" headerAlign="" >名称</div>
					<div field="genMode" renderer="onGenModeRenderer"  width="100" headerAlign="" >创建方式</div>
					<div field="tableName"  sortField="TABLE_NAME_"  width="120" headerAlign="" >表名</div>
					<div field="dsName"  sortField="DS_NAME_"  width="100" headerAlign="" >数据源名称</div>
					<div field="isMain"  sortField="IS_MAIN_"  width="80" headerAlign="" renderer="onMainRenderer" >主实体</div>
					<div field="genTable"  sortField="GEN_TABLE_"  width="80" headerAlign="" renderer="onGenTableRenderer" >已生成表</div>
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
			var tableName = record.tableName;
			var aryStr=[];
			if(record.genMode=='create' && record.isMain==1){
				aryStr.push('<span  title="复制" onclick="copy(\'' + record._uid + '\',true)">复制</span>');
			}
			if(record.genMode=='create' || record.genMode=='db' ){
				aryStr.push('<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>');
			}
			if(record.genTable=='yes'){
				aryStr.push('<span  title="删除物理表" onclick="deleteBoTable(\'' + pkId + '\',\'' + tableName + '\')">删除物理表</span>');
			}else{
				aryStr.push('<span  title="生成物理表" onclick="createBoTable(\'' + pkId + '\',true)">生成物理表</span>');
			}
			aryStr.push('<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>');
			return aryStr.join("");
		}


		function createBoTable(pik) {
			mini.confirm("该操作会生成实体关联的表,确定生成物理表吗?", "提示信息", function(action){
				if(action!="ok") return;
				var url=__rootPath+'/sys/bo/sysBoEnt/creatBoTable.do';
				var conf={
					url:url,
					data:{pkId:pik},
					success:function(data){
						grid.load();
					}
				}
				_SubmitJson(conf);
			});
		}


		function deleteBoTable(pik,tableName) {
			mini.confirm("该操作会删除实体关联的表,确定清除物理表吗?", "提示信息", function(action){
				if(action!="ok") return;
				var url=__rootPath+'/sys/bo/sysBoEnt/deleteBoTable.do'
				var conf={
					url:url,
					data:{
						tableName:tableName,
						pkId:pik},
					success:function(data){
						grid.load();
					}
				}
				_SubmitJson(conf);
			});
		}
		
		function onGenTableRenderer(e) {
            var record = e.record;
            var genTable = record.genTable;
            var arr = [ {'key' : 'yes', 'value' : '已生成','css' : 'green'}, 
			            {'key' : 'no','value' : '未生成','css' : 'orange'} ];
			return $.formatItemValue(arr,genTable);
        }
		
		function onMainRenderer(e){
			var record = e.record;
            var isMain = record.isMain;
            var arr = [ {'key' : '1', 'value' : '是','css' : 'green'}, 
			            {'key' : '0','value' : '否','css' : 'red'} ];
			return $.formatItemValue(arr,isMain);
		}
		
		function onGenModeRenderer(e) {
            var record = e.record;
            var genTable = record.genMode;
            var arr = [ {'key' : 'create', 'value' : '设计','css' : 'green'}, 
			            {'key' : 'form','value' : '表单生成','css' : 'orange'} ,
			            {'key' : 'db','value' : '从数据库生成','css' : 'red'} ];
			return $.formatItemValue(arr,genTable);
        }
		
		function copy(uid){
      		var row=grid.getRowByUID(uid);
      		var entId=row.id;
      		_OpenWindow({
				url:__rootPath+'/sys/bo/sysBoEnt/copy.do?pkId='+entId,
				title:'复制表单--'+row.comment,
				width:800,
				height:400,
				ondestroy:function(action){
					grid.load();
				}
			});
      	}
		
		var categoryId="";
		function treeNodeClick(e){
			var node=e.node;
			var treeId=node.treeId;
			categoryId=treeId;
			var url=__rootPath +"/sys/bo/sysBoEnt/listData.do?Q_CATEGORY_ID__S_EQ=" + treeId;
			grid.setUrl(url);
			grid.reload();
		}
		
		function addBoEnt(){
	    	var width=getWindowSize().width;
			var height=getWindowSize().height;
			var url=__rootPath +"/sys/bo/sysBoEnt/edit.do?categoryId="+categoryId ;
	    	
	    	_OpenWindow({
	    		url:url,
	            title: "新增业务实体对象", width: width, height: height,
	            ondestroy: function(action) {
	            	if(action!= 'ok') return;
	                grid.reload();
	            }
	    	});

		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.bo.entity.SysBoEnt" winHeight="450"
		winWidth="700" entityTitle="业务实体对象" baseUrl="sys/bo/sysBoEnt" />
</body>
</html>