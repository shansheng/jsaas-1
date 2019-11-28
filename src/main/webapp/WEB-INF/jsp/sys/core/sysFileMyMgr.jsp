<%-- 
    Document   : [SysTree]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>我的个人附件列表</title>
<%@include file="/commons/list.jsp"%>
<style type="text/css">
	.mini-layout-border>#center{
 		background: transparent;
	}
	.mini-toolbar{
		padding:6px 0;
	}
	
</style>
</head>
<body>
		<c:choose>
			<c:when test="${param['single']=='true'}">
				<c:set var="multiSelect" value="false"/>
			</c:when>
			<c:otherwise>
				<c:set var="multiSelect" value="true"/>
			</c:otherwise>
		</c:choose>
		<ul id="treeMenu" class="mini-contextmenu"  onbeforeopen="onBeforeShowMenu">
			<li   onclick="addNodeList()" name="addNode">新增目录</li>
		    <li iconCls="icon-edit" onclick="editNodeList()" name="editNode">编辑目录</li>
		    <li iconCls="icon-remove" class=" btn-red" onclick="delNode" name="delNode">删除目录</li>
		</ul>
	<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;" >
			<c:if test="${not empty param['dialog']}">
			<div region="south" showSplitIcon="false"  showHeader="false"  height="46">
				<div class="southBtn">
						<a class="mini-button"   onclick="onOk">确定</a>
						<a class="mini-button btn-red"   onclick="onCancel">关闭</a>
				</div>
			</div>
			</c:if>
			<div 
				title="我的文件夹" 
				region="west" 
				width="230"  
				showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false"
			>
				  <div class="treeToolBar">
					<a class="mini-button"  onclick="addNodeList()">新增</a>
		            <a class="mini-button btn-red"   onclick="delNode()">删除</a>
		            <a class="mini-button" onclick="onRefresh()">刷新</a>
		         </div>
		         <div class="mini-fit" >
			         <ul id="folderTree" class="mini-tree" url="${ctxPath}/sys/core/sysTree/myFileFolder.do" style="width:100%;height:100%;" 
						showTreeIcon="true" textField="name" idField="treeId" resultAsTree="false" parentField="parentId" expandOnLoad="true"
		                onnodeclick="treeNodeClick"  contextMenu="#treeMenu">        
		            </ul>
	             </div>
			</div><!-- end of west -->
			<div title="文件列表" region="center">
				<div class="mini-toolbar" >
					<div class="searchBox">
						<form id="searchForm" class="search-form" >
							<ul>
								<li>
									<span class="text"> 文件名：</span><input class="mini-textbox" name="Q_fileName_S_LK" emptyText="输入文件名"  />
								</li>
								<li>
									<span class="text">上传时间 从：</span>
									<input class="mini-datepicker" name="Q_createTime_D_GE" />
								</li>
								<li style="width: auto">
									<span class="text-to">至：</span>
									<input class="mini-datepicker" name="Q_createTime_D_LE"  />
								</li>
								<li class="liBtn">
									<a class="mini-button "  onclick="searchForm(this)" >搜索</a>
									<a class="mini-button  btn-red" onclick="onClearList(this)" >清空</a>
								</li>
							</ul>
						</form>
					</div>
					<ul class="toolBtnBox">
						<li>
							<a class="mini-button"   onclick="upload()">上传</a>
						</li>
						<li>
							<a class="mini-button"  onclick="moves()">批量归档文件</a>
						</li>
						<li>
							<a class="mini-button btn-red"   onclick="remove()">删除</a>
						</li>

					</ul>
					<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
						<i class="icon-sc-lower"></i>
					</span>
				 </div>
				<div class="mini-fit rx-grid-fit">
					<div id="fileGrid" class="mini-datagrid" style="width: 100%; height: 100%; border:none" allowResize="false"
						url="${ctxPath}/sys/core/sysFile/myFiles.do" idField="keyVar" showColumnsMenu="true" multiSelect="${multiSelect}"
						sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
						<div property="columns">
							<div type="checkcolumn" width="25"></div>
							<div name="action" cellCls="actionIcons" width="80" headerAlign="" align="" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
							<div field="fileName" width="160" headerAlign="" allowSort="true">文件名称</div>
							<div field="sizeFormat" width="120" headerAlign="" sortField="totalBytes" allowSort="true">大小</div>
							<div field="createTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="120" headerAlign="" allowSort="true">上传时间</div>
						</div>
					</div>
				</div>
			</div><!-- end of center -->
		</div>
	

	<script type="text/javascript">
		
    	mini.parse();
    	var grid=mini.get('fileGrid');
    	var tree=mini.get('folderTree');
    	grid.load();
    	
    	//显示上传目录
    	function upload(){
    		_UploadDialogShowFile({
   				from:'SELF',
   				types:'Office',
   				single:false,
   				onlyOne:false,
   				sizelimit:50,
   				showMgr:false,
   				callback:function(files){
   					grid.load();
   				}
   			});
            
    	}
    	//移动文件
    	function moves(){
    		var rows=grid.getSelecteds();
    		if(rows.length==0){
    			alert('请选择要移动的文件！') 
    			return;
    		}
    		var fileIds=_GetIds(rows);
    		_OpenWindow({
       			title:'移动目录',
       			url:__rootPath+'/sys/core/sysFile/moveFolder.do?fileIds='+fileIds,
       			width:780,
       			height:300
       		});
    	}
    	
    	//移动文件
    	function remove(){
    		var rows=grid.getSelecteds();
    		if(rows.length<=0){
    			alert('请选择一份文件！') 
    			return;
    		}
    		var fileId=_GetIds(rows);
    		_SubmitJson({
       			url:__rootPath+'/sys/core/sysFile/del.do?fileId='+fileId,
    			method:'POST',
    			success:function(text){
    	    		grid.load();
    			}
    		});
    	}
    	
    	function addNodeList(){
			addNode('新增我的附件目录','');
    	}
    	
    	function getFiles(){
    		return grid.getSelecteds();
    	}

    	//编辑节点
    	function editNodeList(){
			editNode('编辑我的附件目录');
    	}
    	
    	//树节点点击
    	function treeNodeClick(e){
    		var node=e.node;
    		var treeId=node.treeId;
    		grid.setUrl("${ctxPath}/sys/core/sysFile/myFiles.do?treeId="+treeId);
    		grid.load();
    	}
    	
    	//编辑
        function onActionRenderer(e) {
            var record = e.record;
            var pkId = record.pkId;
            var s = '<span class="" title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+ '<span class="" title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'
            		+ '<span class="" title="移动目录" onclick="moveRow(\'' + pkId + '\')">移动目录</span>';
            return s;
        }

		//刷新树
		function onRefresh(){
			tree.load();
		}
		
       	//onOk
       	function onOk(){
       		CloseWindow('ok');
       	}
       	//onCancel
       	function onCancel(){
       		CloseWindow('cancel');
       	}
       	
       	//显示菜单
       	function onBeforeShowMenu(e) {
       	    var menu = e.sender;
       	    var node = tree.getSelectedNode();
       	    if (!node) {
       	        e.cancel = true;
       	        return;
       	    }
       	 	var editItem = mini.getByName("editNode", menu);
 	    	var removeItem = mini.getByName("delNode", menu);
       	    if (node && node.treeId == "0") {
        	    editItem.hide();
        	    removeItem.hide();
       	    }else{
       	    	editItem.show();
        	    removeItem.show();
       	    }
       	}
       	
       	function delRow(pkId){
       		mini.confirm("确定删除记录？", "确定？",
      	            function (action) {
      					if(action!='ok') return;
      					_SubmitJson({
   	        			url:__rootPath+'/sys/core/sysFile/del.do?fileId='+pkId,
   	        			method:'POST',
   	        			success:function(text){
   	        				grid.load();
   	        			}
   	        		});
      			}
       		);
       	}
       	
       	function moveRow(pkId){
       		_OpenWindow({
       			title:'移动目录',
       			url:__rootPath+'/sys/core/sysFile/moveFolder.do?fileId='+pkId,
       			width:780,
       			height:450
       		});
       	}
       	
       	//附件明细
       	function detailRow(pkId){
       		_OpenWindow({
       			title:'附件明细',
       			height:500,
       			width:800,
       			url:__rootPath+'/sys/core/sysFile/get.do?fileId='+pkId
       		});
       	}
       	
       	//附件预览
       	function previewRow(pkId){
       		_OpenWindow({
       			title:'附件预览',
       			height:500,
       			width:800,
       			url:__rootPath+'/sys/core/sysFile/preview.do?fileId='+pkId
       		});
       	}
       	
       	function onSearch(){
       		var formData=$("#searchForm").serializeArray();
       		//var urlData=jQuery.param(formData);
       		//alert(urlData);
       		var filter=mini.encode(formData);
       		var node = tree.getSelectedNode();
       		var treeId=node==null?'0':node.treeId;
       		grid.setUrl("${ctxPath}/sys/core/sysFile/myFiles.do?treeId="+treeId + "&filter="+filter);
    		grid.load();
       	}
    </script>
	
</body>
</html>