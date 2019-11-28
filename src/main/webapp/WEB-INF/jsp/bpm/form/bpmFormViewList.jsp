<%-- 
    Document   : 业务表单视图列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>业务表单视图列表管理</title>
<%@include file="/commons/list.jsp"%>
<script src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}" ></script>
<script src="${ctxPath}/scripts/sys/bo/BoUtil.js?version=${static_res_version}" ></script>
<script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
<style type="text/css">
	.mini-layout-border>#center{
 		background: transparent;
	}
</style>
<script>
	$(function () {
		mini.layout();
	})
</script>
</head>
<body>
	<ul id="treeMenu" class="mini-contextmenu" >
		<li  onclick="addCatNode">新增分类</li>
	    <li  onclick="editCatNode">编辑分类</li>
	    <li  onclick="nodeGrant">控制权限</li>
	    <li  class="btn-red" onclick="delCatNode">删除分类</li>
	</ul>
	<ul id="popupAddMenu" class="mini-menu" style="display:none;">
		<li  onclick="add()">在线设计表单</li>
		<li  onclick="addBoForm()">根据业务建模新建表单</li>
        <li  onclick="addUrl()">新增URL表单</li>
     </ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	    <div title="业务表单分类" region="west" width="220" showSplitIcon="true" showCollapseButton="false" showProxy="false" >
	        <div class="treeToolBar">
				<a class="mini-button" onclick="addCatNode()">新增</a>
                <a class="mini-button"  onclick="refreshSysTree()">刷新</a>
	        </div>
	        <div class="mini-fit ">
	         	<ul
				id="systree" 
				class="mini-tree" 
				url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW" 
				style="width:100%;height: 100%;box-sizing: border-box"
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
	    <div region="center" showHeader="false" showCollapseButton="true" >
	        <div class="mini-toolbar" >
				<div class="searchBox">
					<form id="searchForm" >
						<ul>
							<li>
								<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"/>
							</li>
							<li>
								<span class="text">业务模型：</span>
	                    		<input 
	                    			id="btnBoDefId" 
	                    			name="Q_BO_DEFID__S_EQ" 
	                    			class="mini-buttonedit" 
	                    			text="" 
   									showClose="true" 
   									oncloseclick="clearButtonEdit" 
   									value="" onbuttonclick="onSelectBo"/>
							</li>
							<li class="liBtn">
								<a class="mini-button " onclick="searchForm(this)" >搜索</a>
								<a class="mini-button  btn-red" onclick="onClearForm(this);">清空搜索</a>
								<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
									<em>展开</em>
									<i class="unfoldIcon"></i>
								</span>
							</li>
						</ul>
						<div id="moreBox">
							<ul>
								<li>
									<span class="text">表单类型：</span>
									<input
										name="Q_TYPE__S_EQ"
										class="mini-combobox"
										textField="text"
										valueField="id"
										data="[{id:'SEL-DEV',text:'自定义表单'},{id:'ONLINE-DESIGN',text:'在线设计表单'}]"  showNullItem="true" />
								</li>
								<li>
									<span class="text">标识键：</span><input class="mini-textbox" name="Q_KEY__S_LK"/>
								</li>
								<li>
									<span class="text">状态：</span>
									<input
										name="Q_STATUS__S_EQ"
										class="mini-combobox"
										textField="text"
										valueField="id"
										data="[{id:'INIT',text:'草稿'},{id:'DEPLOYED',text:'发布'}]"
										showNullItem="true" />
								</li>
							</ul>
						</div>
					</form>
				</div>
				<ul class="toolBtnBox">
					<li>
						<a class="mini-menubutton " menu="#popupAddMenu" >新增</a>
					</li>
					<li>
						<a class="mini-button btn-red" onclick="remove()">删除</a>
					</li>
					<li>
						<a class="mini-button" onclick="doExport()">导出</a>
					</li>
					<li>
						<a class="mini-button" onclick="doImport()">导入</a>
					</li>
				</ul>
				<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
		     </div>
			<div class="mini-fit">
				<div 
					id="datagrid1" 
					class="mini-datagrid" 
					style="width: 100%; height: 100%;" 
					allowResize="false" 
					url="${ctxPath}/bpm/form/bpmFormView/listAll.do" 
					idField="viewId" 
					multiSelect="true" 
					showColumnsMenu="true" 
					sizeList="[5,10,20,50,100,200,500]" 
					pageSize="20" 
					allowAlternating="true"
				>
					<div property="columns" >
						<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
						<div name="action" cellCls="actionIcons" headerAlign="" width="110" style="min-width:150px!important; " renderer="onActionRenderer" cellStyle="padding:0;" >操作</div>
						<div field="name" width="140" headerAlign="" sortField="NAME_" allowSort="true">名称</div>
						<div field="key" width="110" headerAlign="" sortField="KEY_" allowSort="true">标识键</div>
						<div field="type" width="80" headerAlign="" renderer="onTypeRenderer">类型</div>
						<div field="version" width="60" headerAlign=""  >版本号</div>
						<div field="status" width="60" headerAlign="" renderer="onStatusRenderer">状态</div>
						<div field="createTime" width="90" headerAlign="" sortField="CREATE_TIME_" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">创建时间</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.form.entity.BpmFormView" winHeight="450" winWidth="700" entityTitle="业务表单视图" baseUrl="bpm/form/bpmFormView" />
	<script type="text/javascript">
		
	 function onTypeRenderer(e) {
         var record = e.record;
         var type = record.type;
          var arr = [
			            {'key' : 'ONLINE-DESIGN', 'value' : '在线表单','css' : 'green'}, 
			            {'key' : 'SEL-DEV','value' : '自开发表单','css' : 'gray'},
			            {'key' : 'GENBYBO','value' : '根据模板生成','css' : 'red'}];
			return $.formatItemValue(arr,type);
     }
	  
	  function onStatusRenderer(e) {
         var record = e.record;
         var status = record.status;
          var arr = [
			            {'key' : 'DEPLOYED', 'value' : '发布','css' : 'green'}, 
			            {'key' : 'INIT','value' : '草稿','css' : 'blue'} ];
			return $.formatItemValue(arr,status);
       }

        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var uid = record.pkId;
	            var aryOp=[];

	            if(record.type=="ONLINE-DESIGN"){
	            	if(findNode("edit",record.treeId)){
	            		aryOp.push('<span class="" title="编辑" onclick="editRow(\'' + uid + '\',true)">编辑</span>');
	            	}
					if(findNode("delete",record.treeId)){
						aryOp.push(' <span class="" title="删除" onclick="delRow(\'' + uid + '\')">删除</span>');
					}
	            	aryOp.push(' <span class="" title="版本" onclick="versionRow(\'' + record._uid + '\')">版本</span>');
            		aryOp.push(' <span class="" title="复制" onclick="copy(\'' + record._uid + '\')">复制</span>');
            		aryOp.push(' <span class=""  title="预览"  onclick="preview(\'' + uid + '\')">预览</span>');
					if(record.status=="INIT" && record.boDefId){
						aryOp.push('<span class=""  title="发布" plain="true" onclick="deploy(\'' + uid + '\')">发布</span>');
					}
					if(record.boDefId){
						aryOp.push('<span class="" title="清除BO" onclick="clearBo(\'' + record._uid + '\')">清除BO</span>');
					}
            		aryOp.push(' <span class=""  title="编辑模板"  onclick="editTemplate(\'' + uid + '\')">编辑模板</span>');
                    if(record.boDefId){
                    	aryOp.push(' <span class=""  title="PDF模板"  onclick="pdfTemp(\'' + uid + '\')">PFD模板</span>');
                    	aryOp.push(' <span class=""  title="服务调用接口规范"  onclick="showServiceHelp(\'' + record.boDefId + '\')">服务调用接口规范</span>');
                    }

	            }
	            else if(record.type=="GENBYBO"){
	            	if(findNode("edit",record.treeId)){
	            		aryOp.push('<span class="" title="编辑" onclick="editDesign(\'' + uid + '\',true)">编辑</span>');
	            	}
					if(record.status=="INIT" ){
						aryOp.push('<span class=""  title="发布" plain="true" onclick="deploy(\'' + uid + '\')">发布</span>');
					}
            		aryOp.push(' <span class=""  title="预览"  onclick="preview(\'' + uid + '\')">预览</span>');
            		aryOp.push(' <span class=""  title="编辑模板"  onclick="editTemplate(\'' + uid + '\')">编辑模板</span>');
                    aryOp.push(' <span class=""  title="PDF模板"  onclick="pdfTemp(\'' + uid + '\')">PDF模板</span>');
	            }
	            else{
	            	if(findNode("edit",record.treeId)){
	            		aryOp.push('<span class="" title="编辑" onclick="editUrlRow(\'' + record._uid + '\',true)">编辑</span>');
	            	}
            		if(findNode("delete",record.treeId)){
            			aryOp.push('<span class="" title="删除" onclick="delRow(\'' + uid + '\')">删除</span>');
            		}
					aryOp.push( '<span class="" title="明细" onclick="urlGet(\'' + record._uid + '\')">明细</span>');
	            }
	            return aryOp.join("");
	        }
        	
        	function showServiceHelp(pkId){
        		var width=getWindowSize().width;
	        	var height=getWindowSize().height;
	            _OpenWindow({
	        		 url: __rootPath +"/bpm/form/bpmFormView/showHelp.do?boDefId="+pkId,
	                title: "接口调用规范",
	                width: width, height: height
	               
	        	});
        	}
        	
	        function editDesign(pkId,fullWindow) {    
	        	
	        	var width=getWindowSize().width;
	        	var height=getWindowSize().height;
	            _OpenWindow({
	        		 url: __rootPath +"/bpm/form/bpmFormView/design.do?viewId="+pkId,
	                title: "编辑业务表单视图",
	                width: width, height: height,
	                ondestroy: function(action) {
	                    if (action == 'ok') {
	                        grid.reload();
	                    }
	                }
	        	});
	        }

        	    
        	function findNode(param,treeId){
        		if(${isSuperAdmin}){
        			return true;
        		}
        		var systree=mini.get("systree");
        		var nodes = systree.findNodes(function(node){
        		var right=node.right;
        			if(right){
        				var rightJson=JSON.parse(right);
        				if(rightJson[param]=="true"&&node.treeId==treeId){
        					return true;
        				}
        			}
        		});
        		if(nodes.length){
        			return true;
        		}else{
        			return false;
        		}
        	}
        	
	      	//版本管理
        	function versionRow(uid){
        		var row=grid.getRowByUID(uid);
        		
        		_OpenWindow({
					url:__rootPath+'/bpm/form/bpmFormView/versions.do?key='+row.key,
					title:'表单视图的版本管理--'+row.name,
					width:800,
					height:480,
					ondestroy:function(action){
						grid.load();
					}
				});
        	}
	      	
	      	function editUrlRow(uid){
				var row=grid.getRowByUID(uid);
			        		
        		_OpenWindow({
					url:__rootPath+'/bpm/form/bpmFormView/urlEdit.do?viewId='+row.viewId,
					title:'表单编辑'+row.name,
					width:780,
					height:480,
					ondestroy:function(action){
						grid.load();
					}
				});
	      	}

	      	function urlGet(uid){
				var row=grid.getRowByUID(uid);
			        		
        		_OpenWindow({
					url:__rootPath+'/bpm/form/bpmFormView/urlGet.do?pkId='+row.viewId,
					title:'表单明细'+row.name,
					width:780,
					height:480,
					ondestroy:function(action){
					}
				});
	      	}
	      	
        	function addUrl(){
        		var url=__rootPath+'/bpm/form/bpmFormView/urlEdit.do';
        		
        		_OpenWindow({
					url:url,
					title:'新增URL表单',
					width:780,
					height:480,
					ondestroy:function(action){
						grid.load();
					}
				});
        	}
	      	
	      	function copy(uid){
	      		var row=grid.getRowByUID(uid);
	      		var viewId=row.viewId;
	      		_OpenWindow({
					url:__rootPath+'/bpm/form/bpmFormView/copy.do?viewId='+viewId,
					title:'复制表单--'+row.name,
					width:800,
					height:400,
					ondestroy:function(action){	
						if(action=='ok'){
							grid.load();
						}
					}
				});
	      	}
	      	
	      	
	      	function rightRow(uid){
	      		var row=grid.getRowByUID(uid);
	      		
	      		_OpenWindow({
					url:__rootPath+'/bpm/core/bpmFormRight/edit.do?formAlias='+row.key+'&nodeId=_FORM',
					title:'表单视图的字段管理--'+row.name,
					width:780,
					height:480,
					max:true
				});
	      	}
	      	
	      	function clearBo(uid){
	      		var row=grid.getRowByUID(uid);
	      		mini.confirm("该操作会删除BO定义和关联的表,确定清除BO设定吗?", "提示信息", function(action){
	      			if(action!="ok") return;
	      			var url=__rootPath+'/bpm/form/bpmFormView/clearBoDef.do'
	      			var conf={
	      				url:url,
	      				data:{formViewId:row.viewId},
	      				success:function(data){
	      					grid.load();
	      				}
	      			}
	      			_SubmitJson(conf);
	      		});
	      	}
		   	
		   	/**
		   	* 发布表单。
		   	*/
		   	function deploy(id){
		   		_SubmitJson({
		   			url:__rootPath+'/bpm/form/bpmFormView/deploy.do',
		   			data:{viewId:id},
		   			success:function(text){
		   				grid.load();
		   			}
		   		});
		   	}
		   	
		   	function onClearForm(form){
		   		grid.setUrl(__rootPath+'/bpm/form/bpmFormView/listData.do');
		   		onClearList(form);
		   	}
		   	
		   	//按分类树查找数据字典
		   	function treeNodeClick(e){
		   		var node=e.node;
		   		grid.setUrl(__rootPath+'/bpm/form/bpmFormView/listData.do?treeId='+node.treeId);
		   		grid.load();
		   	}
		   	
		   	function preview(viewId){
		    	var url=__rootPath+'/bpm/form/bpmFormView/previewById/'+viewId+'.do' ;
		    	openNewWindow(url,"bpmFormView");
		    }
		   	
		   	function pdfTemp(viewId){
	   		    _OpenWindow({
					title:'PDF模板',
					max:true,
					url:__rootPath+'/bpm/form/bpmFormView/genPdfTemplate.do?viewId='+viewId,
					ondestroy:function(action){
						if(action!='ok'){
							return;
						}
					}
				});
		   	}
		   	
		   	function editTemplate(viewId){
		   		var url=__rootPath+'/bpm/form/bpmFormView/editTemplate.do?pkId='+viewId;
    			_OpenWindow({
    	    		url:url,
    	    		title:'编辑表单组件',
    	    		width:780,
    	    		height:400,
    	    		max:true
    	    	});	
		   	}
		   	
		   	function nodeGrant(e){
		   		var systree=mini.get("systree");
		   		var node = systree.getSelectedNode();
		   		var treeId=node.treeId;
		   		var url=__rootPath+'/bpm/form/bpmFormView/grant.do?treeId='+treeId;
		   		_OpenWindow({
    	    		url:url,
    	    		title:'表单权限',
    	    		width:780,
    	    		height:400,
    	    		max:false,
    	    		ondestroy:function(action){
    	    			if(action!='ok'){
    	    				return;
    	    			}
    	    			mini.showTips({
    			            content: "<b>成功</b> <br/>保存成功",
    			            state: 'success',
    			            x: 'center',
    			            y: 'center',
    			            timeout: 3000
    			        });
    	    		}
    	    	});
		   	}

	        $(function(){
	        	$('.icon-add').click(function(e) {
	                $('.actionIcons span').css('display','block');

	            });

	        });
	        
	        function searchThisForm(btn) {
	        	var parent=$(btn.el).closest(".mini-toolbar");
	            var inputAry=$("input",parent);
	            searchThisByInput(inputAry);
	            
	        }
	        
	        function searchThisByInput(inputAry){
	        	var params=[];
	        	inputAry.each(function(i){
	           	 var el=$(this);
	           	 var obj={};
	           	 obj.name=el.attr("name");
	           	 if(!obj.name) return true;
	           	 obj.value=el.val();
	           	 params.push(obj);
	           });
	           
	           var data={};
	           
	           data.filter=mini.encode(params);
	    		data.pageIndex=grid.getPageIndex();
	    		data.pageSize=grid.getPageSize();
	    	    data.sortField=grid.getSortField();
	    	    data.sortOrder=grid.getSortOrder();
	    		grid.load(data);
	        }
	        
	        function addBoForm(){
	        	var	width=600;
	        	var	height=400;
	        	
	        	var url=__rootPath +"/bpm/form/bpmFormView/addByBo.do";

	        	_OpenWindow({
		    		url: url,
		            title: "新增业务表单", width: width, height: height,
		            onload:function(){
		            	var iframe = this.getIFrameEl().contentWindow;
		            	iframe.setGrid(grid);
		            },
		            ondestroy: function(action) {
		            	if (action != 'ok') 
		                grid.reload();
		            }
		    	});
	        }
	        
	        function editValition(fullWindow){
	        	var	width=600;
	        	var	height=400;
			    var row = grid.getSelected();
		        //行允许删除
		        if(rowEditAllow && !rowEditAllow(row)){
		        	return;
		        }
		        
		        if (row) {
		        	if(row.type=="SEL-DEV"){//自开发表单
		        		_OpenWindow({
		           		 url:__rootPath + "/bpm/form/bpmFormView/urlEdit.do?viewId="+row.pkId,
		                   title: "编辑业务表单",
		                   width: width, height: height,
		                   ondestroy: function(action) {
		                       if (action == 'ok') {
		                           grid.reload();
		                       }
		                   }
		           		});
		        		return;
		        	}else if(row.type=="GENBYBO"){
                        editDesign(row.pkId,true);
                        return ;
                    }
		            editRow(row.pkId,fullWindow);
		        } else {
		            alert("请选中一条记录");
		        }
	        }
	        
	        
	        /**
	       	*导出
	       	**/
	       	function doExport(){
	       		var rows=grid.getSelecteds();
	       		if(rows.length==0){
	       			alert('请选择需要导出的电脑表单记录！')
	       			return;
	       		}
	       		var ids=_GetIds(rows);
	       		
	       		var url = __rootPath+'/bpm/form/bpmFormView/export.do?ids='+ids;
	       		window.location.href = url;
	       	}
	       	/**
	       	*导入
	       	**/
	       	function doImport(){
	       		_OpenWindow({
	       			title:'电脑表单导入',
	       			url:__rootPath+'/bpm/form/bpmFormView/import1.do',
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