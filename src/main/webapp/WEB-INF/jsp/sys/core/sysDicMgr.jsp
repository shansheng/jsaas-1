<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/commons/list.jsp" %>
	<title>数据字典分类管理</title>
	<style type="text/css">
		
		.mini-layout-region-body  .mini-fit{
			overflow: hidden;
		}
		
		.mini-layout-region{
			background: transparent;
		}
		
		.mini-tree .mini-grid-viewport,
		.mini-layout-region-west{
			background: #fff;
		}
		.icon-xia-add,
		.icon-shang-add,
		.icon-brush{
			color: #0daaf6;
		}
		.icon-baocun7{
			color:#2cca4e;
		}
		.icon-trash{
			color: red;
		}
		.icon-jia{
			color: #ff8b00;
		}
		.icon-button:before{
			font-size: 16px;
		}
	</style>
</head>
<body>
	<ul id="treeMenu" class="mini-contextmenu" >
		<li   onclick="addNodeList()">新增分类</li>
	    <li  onclick="editNodeList()">编辑分类</li>
	    <li  class=" btn-red" onclick="delNode">删除分类</li>
	    <li  class=" btn-red" onclick="delNodeDics">删除分类及字典</li>
	    <li  onclick="doExport">导出</li>
	    <li onclick="doImport">导入</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		    <div 
		    	title="数据分类树" 
		    	region="west" 
		    	width="220"
		    	showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false">
		        <div class="treeToolBar" >
					<a class="mini-button"    onclick="addParentNode()" tooltip="新增">新增</a>
		            <a class="mini-button"   onclick="onExpand()" tooltip="展开" plain="true">展开</a>
			    	<a class="mini-button"   onclick="onCollapse()" tooltip="收起" plain="true">收起</a>
		            <a class="mini-button"   onclick="refreshSysTree()" tooltip="刷新" plain="true">刷新</a>
		        </div>
    			<div class="mini-fit">
			         <ul 
			         	id="systree" 
			         	class="mini-tree" 
			         	url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_DIM" 
			         	style="width:100%;height:100%" 
						showTreeIcon="true" 
						textField="name"  
						idField="treeId" 
						resultAsTree="false" 
						parentField="parentId" 
						onload="onLoadTree" 
						expandOnLoad="0" 
						showTreeLines="true"
		                onnodeclick="treeNodeClick"  
		                contextMenu="#treeMenu">        
	            	</ul>
	           </div>
		    </div>
		    <div showHeader="false" showCollapseButton="false">
		        <div class="form-toolBox" >
		         	<ul>
						<li>
							<a class="mini-button"  onclick="saveItems()">保存数据项</a>
						</li>
						<li>
							<a class="mini-button"  onclick="newRow();">新增数据项</a>
						</li>
						<li>
							<a class="mini-button"  onclick="newSubRow();">新增子数据项</a>
						</li>
						<li>
							<a class="mini-button btn-red"   onclick="delRows();">删除数据项</a>
						</li>
						<li>
							<a class="mini-button"  onclick="genQuerySql()">生成查询SQL</a>
						</li>
						<li>
							<a class="mini-button"  onclick="doDeployMenu()">发布至管理菜单</a>
						</li>
					</ul>
			    </div>
		         <div class="mini-fit rx-grid-fit" style="border:0;">
			        <div id="sysdicGrid" class="mini-treegrid" style="width:100%;height:100%;"     
			            showTreeIcon="true" 
			            treeColumn="name" idField="dicId" parentField="parentId"  valueField="dicId"
			            resultAsTree="false"  multiSelect="true"
			            allowResize="true" expandOnLoad="true" 
			            allowCellValid="true" oncellvalidation="onCellValidation" 
			            allowCellEdit="true" allowCellSelect="true" url="${ctxPath}/sys/core/sysDic/listByTreeId.do"
		            	allowAlternating="true"
		            >
			            <div property="columns">
			            	<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
			            	<div name="action" width="100"    align="" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
			                <div name="name" field="name" align="" width="160">项名
			                	<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
			                </div>
			                <div field="key" name="key" align="" width="80">项Key
			                	<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
			                </div>
			                <div field="value" name="value" align="" width="80">项值
			                	<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
			                </div>
			                <div name="descp" field="descp" align="" width="120">项描述
			                	<input property="editor" class="mini-textbox" style="width:100%;" />
			                </div>
			                <div name="sn" field="sn" align="" width="60">序号
			                	<input property="editor" changeOnMousewheel="false" class="mini-spinner"  minValue="1" maxValue="100000" required="true"/>
			                </div>
			            </div>
			        </div>
		        </div>
		    </div><!-- end of the center region  -->
		   </div>
		    <div id="sqlWin" class="mini-window" iconCls="icon-script" title="SQL查询语句" style="width: 550px; height: 350px; display: none;" showMaxButton="true" showShadow="true" showToolbar="true" showModal="true" allowResize="true" allowDrag="true">
				<textarea id="sql" class="mini-textarea" style="height: 100%; width: 100%"></textarea>
			</div>
		   <script type="text/javascript">
		   	mini.parse();
		   	var grid=mini.get("sysdicGrid");
		   	var systree=mini.get("systree");
		   	//CAT_DIM
		   	//var catCombo=mini.get("catCombo");
		   	
		   	grid.on('cellendedit',function(e){
				var record = e.record, field = e.field;
	            var val=e.value;
				
	            if(field=='name' && (record.key==undefined || record.key=='')){
	            	//自动拼音
	           		$.ajax({
	           			url:__rootPath+'/pub/base/baseService/getPinyin.do',
	           			method:'POST',
	           			data:{words:val,isCap:'false',isHead:'true'},
	           			success:function(result){
	           				grid.updateRow(record,{key:result.data});
	           			}
	           		});
	            	
	            	if(record.value==undefined || record.value==''){
	            		grid.updateRow(record,{value:val});
	            	}
	            	
	            	if(record.descp==undefined || record.descp==''){
	            		grid.updateRow(record,{descp:val});
	            	}
	            }
			});
		   	
		   	function onLoadTree(){
		   		//仅展开第二层
			   //systree.expandLevel(2);	
		   	}
		   	function onExpand(){
		   		systree.expandAll();
		   	}
		   	
		   	function onCollapse(){
		   		systree.collapseAll();
		   	}
		   	
		   	function addNodeList(e){
				addNode('新增节点','CAT_DIM')
		   	}
		   	
		   	function addParentNode(){
		   		_OpenWindow({
		   			title:'新增节点',
		   			url:__rootPath+'/sys/core/sysTree/edit.do?parentId=0&catKey=CAT_DIM',
		   			width:800,
		   			height:450,
		   			ondestroy:function(action){
		   				if(action=='ok'){
		   					systree.load();
		   				}
		   			}
		   		});
		   	}
		   	
		   	function refreshSysTree(){
		   		systree.load();
		   	}
		   	
		   	function editNodeList(e){
				editNode('编辑节点')
		   	}
		   	
		   	function delNode(e){
		   		var node = systree.getSelectedNode();
		   		if (!confirm("确定删除该分类及其下所有数字字典？")) {return;}
		   		_SubmitJson({
		   			url:__rootPath+'/sys/core/sysTree/del.do?ids='+node.treeId,
		   			success:function(text){
		   				systree.load();
		   			}
		   		});
		   	}
		   	
		   	function delNodeDics(e){
		   		var node = systree.getSelectedNode();
		   		if (!confirm("确定删除该分类所有子分类及数字字典？")) {return;}
		   		_SubmitJson({
		   			url:__rootPath+'/sys/core/sysDic/delByTreeId.do?treeId='+node.treeId,
		   			success:function(text){
		   				systree.load();
		   			}
		   		});
		   	}
		   	
		   	
		   	//更改分类生成树
		   	function onCatChange(e){
		   		var catKey='CAT_DIM';//;mini.get("#catCombo").getValue();
				systree.setUrl(__rootPath+'/sys/core/sysTree/listByCatKey.do?catKey='+catKey);
				systree.load();
		   	}
		   	//按分类树查找数据字典
		   	function treeNodeClick(e){
		   		var node=e.node;
		   		grid.setUrl(__rootPath+'/sys/core/sysDic/listByTreeId.do?treeId='+node.treeId);
		   		grid.load();
		   	}
		   	
		   	
		   	function onCellValidation(e){
	        	if(e.field=='key' && (!e.value||e.value=='')){
	        		 e.isValid = false;
	        		 e.errorText='项Key不能为空！';
	        	}
	        	if(e.field=='name' && (!e.value||e.value=='')){
	        		e.isValid = false;
	       		 	e.errorText='项名称不能为空！';
	        	}
	        	
	        	if(e.field=='value' && (!e.value||e.value=='')){
	        		e.isValid = false;
	       		 	e.errorText='项值不能为空！';
	        	}
	        	
	        	if(e.field=='sn' && (!e.value||e.value=='')){
	        		e.isValid = false;
	       		 	e.errorText='序号不能为空！';
	        	}
	        	
	        }
		   	
		   	function onActionRenderer(e) {
	            var record = e.record;
	            var uid = record._uid;
	            
	            var s = '<span class="icon-button icon-shang-add" title="在前新增数据项" onclick="newBeforeRow(\''+uid+'\')"></span>';
	            s+=' <span class="icon-button icon-xia-add" title="在后新增数据项" onclick="newAfterRow(\''+uid+'\')"></span>';
	            var node=systree.getSelectedNode();
	            //为树类型才允许往下添加
	            if(node.dataShowType=='TREE'){
	            	s+= '<span class="icon-button icon-jia" title="新增子数据项" onclick="newSubRow()"></span>';
	            }
	            s+=' <span class="icon-button icon-baocun7" title="保存" onclick="saveRow(\'' + uid + '\')"></span>';
	            s+=' <span class="icon-button icon-trash" title="删除" onclick="delRow(\'' + uid + '\')"></span>';
	            return s;
	        }
			//在当前选择行的下添加子记录
	        function newSubRow(){
				var treeNode=systree.getSelectedNode();
				if(!treeNode){
					alert("请选择系统分类树节点！");
					return;
				}
				var node = grid.getSelectedNode();
				 //为树类型才允许往下添加
	            if(treeNode.dataShowType=='TREE'){
		            grid.addNode({}, "add", node);
	            }else{
		            grid.addNode({}, "before", node);
	            }
	           
	        }
			
	        function newRow() {            
	        	var treeNode=systree.getSelectedNode();
				if(!treeNode){
					alert("请选择系统分类树节点！");
					return;
				}
	        	var node = grid.getSelectedNode();
	            grid.addNode({}, "after", node);
	        }

	        function newAfterRow(row_uid){
	        	var node = grid.getRowByUID(row_uid);
	        	grid.addNode({}, "after", node);
	        	grid.cancelEdit();
	        	grid.beginEditRow(node);
	        }
	        
	        function newBeforeRow(row_uid){
	        	var node = grid.getRowByUID(row_uid);
	        	grid.addNode({}, "before", node);
	        	grid.cancelEdit();
	        	grid.beginEditRow(node);
	        }
				
		   	//保存单行
		    function saveRow(row_uid) {
	        	//表格检验
	        	grid.validate();
	        	if(!grid.isValid()){
	            	return;
	            }
				var row = grid.getRowByUID(row_uid);
	            
				var node = systree.getSelectedNode();
				var treeId=null;
				if(node){
					treeId=node.treeId;
				}else{
					alert("请左树分类！");
					return;
				}

	            var json = mini.encode(row);
	            
	            _SubmitJson({
	            	url: "${ctxPath}/sys/core/sysDic/rowSave.do",
	            	data:{
	            		treeId:treeId,
	            		data:json},
	            	method:'POST',
	            	success:function(text){
	            		var result=mini.decode(text);
	            		if(result.data && result.data.treeId){
	                		row.treeId=result.data.treeId;
	                	}
	            		grid.acceptRecord(row);
	            		grid.load();
	            	}
	            });
	        }
	        
	      	//批量多行数据字典
	        function saveItems(){
				var node = systree.getSelectedNode();
				var treeId=null;
				if(node){
					treeId=node.treeId;
				}else{
					alert("请左树分类！");
					return;
				}
				
	        	//表格检验
	        	grid.validate();
	        	if(!grid.isValid()){
	        		mini.showTips({
			            content: "<b>注意</b> <br/>表单有内容尚未填写",
			            state: 'danger',
			            x: 'center',
			            y: 'center',
			            timeout: 3000
			        });
	            	return;
	            }
	        	
	        	//获得表格的每行值
	        	var data = grid.getData();
	        	if(data.length<=0)return;
	            var json = mini.encode(data);
	            
	            var postData={treeId:treeId,gridData:json};
	            
	            _SubmitJson({
	            	url: "${ctxPath}/sys/core/sysDic/batchSave.do",
	            	data:postData,
	            	method:'POST',
	            	success:function(text){
	            		grid.load();
	            	}
	            });
	        }
	      	
	        //删除数据项
	        function delRow(row_uid) {
	        	var row=null;
	        	if(row_uid){
	        		row = grid.getRowByUID(row_uid);
	        	}else{
	        		row = grid.getSelected();	
	        	}
	        	
	        	if(!row){
	        		alert("请选择删除的数据项！");
	        		return;
	        	}
	        	
	        	if (!confirm("确定删除此记录？")) {return;}

	            if(row && !row.dicId){
	            	grid.removeNode(row);
	            	return;
	            }else if(row.dicId){
	            	_SubmitJson({
	            		url: "${ctxPath}/sys/core/sysDic/del.do?ids="+row.dicId,
	                	success:function(text){
	                		grid.removeNode(row);
	                	}
	                });
	            } 
	        }
	        
	      //删除数据项
	        function delRows() {

	        	var rows=grid.getSelecteds();
	        	
	        	var ids=[];
	        	
	        	for(var i=0;i<rows.length;i++){
	        		ids.push(rows[i].dicId);
	        	}
	        	
	        	if(ids.length==0){
	        		alert("请选择删除的数据项！");
	        		return;
	        	}
	        	
	        	if (!confirm("确定删除这些记录？")) {return;}

            	_SubmitJson({
            		url: "${ctxPath}/sys/core/sysDic/del.do",
            		data:{
            			ids:ids.join(',')
            		},
                	success:function(text){
                		grid.load();
                	}
                });
	             
	        }
	        
	        //生成查询的Sql
	        function genQuerySql(){
	        	var node = systree.getSelectedNode();
	        	if(!node){
	        		alert('请选择左树节点！');
	        		return;
	        	}
	        	var sql="select d.* from sys_dic d left join sys_tree t on d.TYPE_ID_=t.tree_id_ ";
				sql=sql+"where t.key_='"+node.key+"' and t.cat_key_='CAT_DIM' order by d.sn_ asc";
	        	
	        	var win = mini.get("sqlWin");
				mini.get('sql').setValue(sql);
				win.show();
	        }
	        
	        /**
		   	*导出
		   	**/
		   	function doExport(){
		   		var node = systree.getSelectedNode();
		   		if(!node){
	        		alert('请选择左树节点！');
	        		return;
	        	}
		   		jQuery.download(__rootPath+'/sys/core/sysDic/doExport.do?key='+node.key+'&catKey='+node.catKey,{},'post');
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
		   		var node = systree.getSelectedNode();
		   		if(!node){
	        		alert('请选择左树节点！');
	        		return;
	        	}
		   		_OpenWindow({
		   			title:'数据字典导入',
		   			url:__rootPath+'/sys/core/sysDic/import1.do',
		   			height:350,
		   			width:600,
		   			onload:function(){
		   				var win=this.getIFrameEl().contentWindow;
		   				win.setPath(node.path);
		   			},
		   			ondestroy:function(action){
		   				systree.reload();
		   			}
		   		});
		   	}
	        
	        function doDeployMenu(){
	        	var node = systree.getSelectedNode();
	        	if(!node){
	        		alert('请选择左树节点！');
	        		return;
	        	}
	        	var dicKey=node.key;
	        	var catKey='CAT_DIM';//catCombo.getValue();
	        	
	        	_OpenWindow({
					title:'发布菜单 ',
					height:450,
					width:800,
					url:__rootPath+"/sys/core/sysMenu/addNode.do",
					onload:function(){
						var win=this.getIFrameEl().contentWindow;
						win.setData({
							name:node.name+'分类维护',
							key:dicKey+'_DIC_MGR',
							parentId:'',
							url:'/sys/core/sysDic/'+catKey+'/'+dicKey+'/oneMgr.do',
							showType:'URL',
							isBtnMenu:'NO',
							isMgr:'NO'
						});
					}
				});
	        }

		   </script>
</body>
</html>