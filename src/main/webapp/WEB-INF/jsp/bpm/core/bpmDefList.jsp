<%-- 
    Document   : 流程定义管理列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>流程定义管理列表管理</title>
<%@include file="/commons/list.jsp"%>
<style type="text/css">
	.mini-layout-border>#center{
 		background: transparent;
	}
</style>
</head>
<body>
	<span url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BPM_DEF"></span>
	<ul id="treeMenu" class="mini-contextmenu">
		<li  onclick="addNodeList()">新增分类</li>
	    <li  onclick="editNodeList()">编辑分类</li>
	    <li  class=" btn-red" onclick="delNode()">删除分类</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	    <div 
	    	title="流程定义分类" 
	    	region="west" 
	    	width="220"
	    	showSplitIcon="true"
	    	showCollapseButton="false"
	    	showProxy="false"
	    	class="layout-border-r" 
    	>
	        <div class="treeToolBar">
				<a class="mini-button"   plain="true" onclick="addNodeList()">新增</a>
                <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
	        </div>
			<div class="mini-fit">
				 <ul
					id="systree"
					class="mini-tree"
					url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BPM_DEF"
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
	    </div>
	    <div region="center" showHeader="false" showCollapseButton="false">
		<div class=" mini-toolbar" >
			<ul id="popupAddMenu" class="mini-menu" style="display:none;">
				<li  onclick="add()">新建</li>
				<li  onclick="copyAdd()">复制新建</li>
			</ul>
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
						 <ul>
							<li>
								<span class="text">名称：</span><input class="mini-textbox" name="Q_SUBJECT__S_LK"/>
							</li>
							<li>
								<span class="text">标识键：</span><input class="mini-textbox" name="Q_KEY__S_LK"/>
							</li>
							 <li class="liBtn">
								 <a class="mini-button " onclick="searchFrm()" >搜索</a>
								 <a class="mini-button  btn-red" onclick="clearForm()">清空</a>
								 <span class="unfoldBtn" onclick="no_more(this,'moreBox')">
									<em>展开</em>
									<i class="unfoldIcon"></i>
								</span>
							 </li>
						</ul>
					<div id="moreBox">
						<ul>
							<li>
								<span class="text">状态：</span>
								<input
										name="Q_STATUS__S_EQ"
										class="mini-combobox"
										textField="text"
										valueField="id"
										data="[{id:'INIT',text:'创建'},{id:'DEPLOYED',text:'发布'}]"
										showNullItem="true"
								/>
							</li>
						</ul>
					</div>
					</form>
				</div>
				<ul class="toolBtnBox">
					<li><a class="mini-menubutton"  plain="true" menu="#popupAddMenu">新增</a></li>
					<li><a class="mini-button"  plain="true" onclick="edit()">编辑</a></li>
					<li><a class="mini-button" plain="true" onclick="detailRow1()">明细</a></li>
					<li><a class="mini-button" onclick="uploadBpmnFile()" plain="true">上传BPMN设计文件</a></li>
					<li><a class="mini-button"  onclick="uploadDesignFile()" plain="true">上传设计文件</a></li>
					<li><a class="mini-button btn-red" plain="true" onclick="remove()">删除</a></li>
				</ul>
				<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
	     </div>
			<div class="mini-fit " style="height: 100px;">
				<div 
					id="datagrid1" 
					class="mini-datagrid" 
					style="width: 100%; height: 100%;" 
					allowResize="false" 
					pagerButtons="#pagerButtons"
					url="${ctxPath}/bpm/core/bpmDef/listData.do" 
					idField="defId" 
					multiSelect="true" 
					showColumnsMenu="true"
					sizeList="[5,10,20,50,100,200,500]" 
					pageSize="20" 
					allowAlternating="true"
				>
					<div property="columns">
						<div type="checkcolumn" width="20"  headerAlign="center" align="center" ></div>
						<div name="action" cellCls="actionIcons" width="120" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
						<div field="subject" width="160" headerAlign="" allowSort="true" sortField="SUBJECT_" >标题</div>
						<div field="key" width="120" headerAlign="" >标识Key</div>
						<div field="status" width="60" headerAlign=""  renderer="onStatusRenderer">状态</div>
						<div field="version" width="60" headerAlign=""  >版本号</div>
						<div field="createTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="80" headerAlign="" allowSort="true" sortField="CREATE_TIME_">创建时间</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">

			//查看明细
			function detailRow1() {
				var row = grid.getSelected();
				if(row){
					var rows = grid.getSelecteds();
					if(rows && rows.length>1){
						alert("您已选择多条记录，请只选中一条记录进行查看明细！");
						return;
					}
				}else{
					alert("请选中一条记录");
					return;
				}

				_OpenWindow({
					title:row.subject+'-流程明细',
					url:__rootPath+'/bpm/core/bpmDef/get.do?pkId='+row.pkId,
					max:true,
					height:400,
					width:800,
				});
			}
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var uid=record._uid;
	            var modelId=record.modelId;
	            var ary=[];
	            ary.push('<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>');
	            ary.push(' <span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>');
	            ary.push(' <span  title="复制" onclick="copy(\'' + record._uid + '\')">复制</span>');
	            ary.push(' <span  title="设计" onclick="designRow(\'' + modelId + '\')">设计</span>');
	            ary.push(' <span  title="版本管理" onclick="versionRow(\'' + uid + '\')">版本管理</span>');
	            ary.push(' <span  title="上传新版本BPMN文件" onclick="uploadNewBpmnFile('+pkId+')">上传新版本BPMN文件</span>');
	            ary.push(' <span  title="下载设计文件" onclick="downLoadFile('+pkId+')">下载设计文件</span>');
	            ary.push(' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>');
	            return ary.join("");
	        }
        	
        	function downLoadFile(defId){
        		location.href="${ctxPath}/bpm/core/bpmDef/downloadDesign.do?defId=" +defId; 
        	}
        	
	      
	        function onStatusRenderer(e) {
	            var record = e.record;
	            var status = record.status;
	            
	            var arr = [
				            {'key' : 'DEPLOYED', 'value' : '发布','css' : 'green'}, 
				            {'key' : 'INIT','value' : '创建','css' : 'orange'} ];
				
				return $.formatItemValue(arr,status);
	            
	        }
        	
        	//该函数由添加调用时回调函数
	        function addCallback(openframe){
	        	var bpmDef=openframe.getJsonData();
	        	designRow(bpmDef.modelId);
	        }
        	//版本管理
        	function versionRow(uid){
        		var row=grid.getRowByUID(uid);
        		
        		_OpenWindow({
					url:__rootPath+'/bpm/core/bpmDef/versions.do?mainDefId='+row.mainDefId,
					title:'流程定义版本管理--'+row.subject,
					width:780,
					height:480,
					ondestroy:function(action){
						grid.load();
					}
				});
        	}
        	
        	function copy(uid){
        		var row=grid.getRowByUID(uid);
        		
        		_OpenWindow({
					url:__rootPath+'/bpm/core/bpmDef/copy.do?defId='+row.defId,
					title:'流程定义拷贝--'+row.subject,
					width:780,
					height:480,
					ondestroy:function(action){
						grid.load();
					}
				});
        	}
        	
        	function bpmnDesign(){
        		var row=grid.getSelected();
        		if(!row){
        			alert('请选择行！');
        		}
        		var subject=row?'':row.subject;
        		_OpenWindow({
        			title:'BPMN流程建模_'+subject,
        			width:780,
					height:480,
					url:__rootPath+'/bpm/modeler/designer.do?defId='+row.defId,
					ondestroy:function(action){
						if(action!='ok') return;
						grid.load();
					}
        		});
        	}

        	function imageRow(uid){
        		var row=grid.getRowByUID(uid);
        		_OpenWindow({
        			title:'流程图-'+row.subject,
        			height:450,
        			width:780,
        			max:true,
        			url:__rootPath+'/bpm/core/bpmDef/image.do?actDefId='+row.actDefId
        		});
        	}
        	
	        function designRow(modelId){
        		_OpenWindow({
        			width:800,
        			height:600,
        			max:true,
        			url:__rootPath+'/process-editor/modeler.jsp?modelId='+modelId,
        			title:'流程建模设计',
        			ondestroy:function(action){
        				if(action!='ok')return;;
        				grid.load();
        			}
        		});
        	}
			function addNodeList(e){
				addNode('新增流程定义分类','CAT_BPM_DEF');
		   	}
		   	
		   	function refreshSysTree(){
		   		var systree=mini.get("systree");
		   		systree.load();
		   	}
			function editNodeList(e){
				editNode('编辑节点');
		   	}

		   	//按分类树查找数据字典
		   	function treeNodeClick(e){
		   		var node=e.node;
		   		grid.setUrl(__rootPath+'/bpm/core/bpmDef/listData.do?treeId='+node.treeId);
		   		grid.load();
		   	}
		   	
		   	function uploadBpmnFile(){
		   		_OpenWindow({
		   			title:'上传BPMN文件',
		   			url:__rootPath+'/bpm/core/bpmDef/upBpmnFile.do',
		   			width:590,
		   			height:360,
		   			ondestroy:function(action){
		   				if(action!='ok') return;
		   				grid.load();
		   			}
		   		});
		   	}
		   	
		   	function uploadDesignFile(){
		   		_OpenWindow({
		   			title:'上传设计文件',
		   			url:__rootPath+'/bpm/core/bpmDef/upDesignFile.do',
		   			width:590,
		   			height:430,
		   			ondestroy:function(action){
		   				if(action!='ok') return;
		   				grid.load();
		   			}
		   		});
		   		
		   	}
		   	
		   	function uploadNewBpmnFile(pkId){
		   		_OpenWindow({
		   			title:'上传BPMN文件',
		   			url:__rootPath+'/bpm/core/bpmDef/upBpmnFile.do?defId='+pkId,
		   			width:605,
		   			height:360,
		   			ondestroy:function(action){
		   				if(action!='ok') return;
		   				grid.load();
		   			}
		   		});
		   	}
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmDef" winHeight="400" winWidth="900" entityTitle="流程定义管理" baseUrl="bpm/core/bpmDef" />
</body>
</html>