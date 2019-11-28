<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>业务流程解决方案列表管理</title>
<%@include file="/commons/list.jsp"%>
<script type="text/javascript" src="${ctxPath}/scripts/form/customFormUtil.js"></script>
<style type="text/css">
	.mini-layout-border>#center{
 		background: transparent;
	}
</style>
</head>
<body>
	<ul id="treeMenu" class="mini-contextmenu" >
		<li   onclick="addNodeList()">新增分类</li>
	    <li onclick="editNodeList()">编辑分类</li>
	    <li  class=" btn-red" onclick="delNode()">删除分类</li>
	</ul>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		    <div 
		    	title="业务解决方案分类" 
		    	region="west" 
		    	width="220"
		    	showSplitIcon="true" 
		    	showCollapseButton="false"
		    	showProxy="false"
		    	class="layout-border-r"
	    	>
		      	<div class="treeToolBar">
					<a class="mini-button"   plain="true" onclick="addNodeList(>新增</a>
                    <a class="mini-button" plain="true" onclick="refreshSysTree()">刷新</a>
			    </div>
				<div class="mini-fit">
					 <ul
						id="systree"
						class="mini-tree"
						url="${ctxPath}/bpm/core/bpmSolution/getCatTree.do?isAdmin=true"
						style="width:100%;height: 100%;"
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
		    <div title="业务流程解决方案" region="center" showHeader="false" showCollapseButton="false">
				<div class="mini-toolbar">
					<div class="searchBox">
						<form id="searchForm" class="search-form" >
							<ul>
								<li>
									<span class="text">方案：</span>
									<input class="mini-textbox" name="Q_NAME__S_LK"  />
								</li>
								<li>
									<span class="text">别名：</span>
									<input class="mini-textbox" name="Q_KEY__S_LK"  />
								</li>

								<li class="liBtn">
									<a class="mini-button " onclick="searchForm(this)">搜索</a>
									<a class="mini-button   btn-red" onclick="onClearList(this)">清空</a>
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
												class="mini-combobox"
												name="Q_STATUS__S_EQ"
												showNullItem="true"
												emptyText="请选择..."
												data="[{id:'DEPLOYED',text:'发布'},{id:'CREATED',text:'创建'}]"
										/>
									</li>
									<li>
										<span class="text">创建时间从：</span>
										<input class="mini-datepicker" name="Q_CREATE_TIME__D_GE"/>
									</li>
									<li>
										<span class="text-to">至：</span>
										<input class="mini-datepicker" name="Q_CREATE_TIME__D_LE"/>
									</li>
								</ul>
							</div>
						</form>
					</div>
					<ul class="toolBtnBox toolBtnBoxTop">
					<%--	<li>
							<a class="mini-button"  onclick="detailRowFrom()">明细</a>
						</li>--%>
						<li>
							<a class="mini-button"    onclick="fastAdd()">方案设计</a>
						</li>
						<li>
							<a class="mini-button" onclick="fastEdit()">编辑</a>
						</li>
						<li>
							<a class="mini-button btn-red"   onclick="remove()">删除</a>
						</li>
						<li>
							<a class="mini-button" onclick="doExport">导出</a>
						</li>
						<li>
							<a class="mini-button"  onclick="doImport">导入</a>
						</li>

					</ul>
					<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
						<i class="icon-sc-lower"></i>
					</span>
		        </div>
			
				<div class="mini-fit rx-grid-fit">
					<div 
						id="datagrid1" 
						class="mini-datagrid" 
						style="width: 100%; height:100%;"  
						allowResize="false" 
						url="${ctxPath}/bpm/core/bpmSolution/solutionList.do" 
						idField="solId" 
						multiSelect="true" 
						showColumnsMenu="true" 
						sizeList="[5,10,20,50,100,200,500]" 
						pageSize="20" 
						allowAlternating="true" 
						pagerButtons="#pagerButtons"
					>
						<div property="columns">
							<div type="checkcolumn" width="20" headerAlign="center" align="center" ></div>
							<div name="action" cellCls="actionIcons" width="120"   renderer="onActionRenderer" cellStyle="padding-left:2px;">操作</div>
							<div field="name" sortField="NAME_" width="140" headerAlign="" allowSort="true">方案名称</div>
							<div field="key" width="100" sortField="KEY_" headerAlign="" allowSort="true">别名</div>
							<div field="status" width="80" sortField="STATUS_" headerAlign="" renderer="onStatusRenderer"  allowSort="true">发布状态</div>
							<div field="formal" width="80" sortField="FORMAL_" headerAlign="" renderer="onFormalRenderer"  allowSort="true">正式状态</div>
							<div field="createTime" sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss" width="80" headerAlign="" allowSort="true">创建时间</div>
						</div>
					</div>
				</div>
			</div>
	</div>
	<script type="text/javascript">
			mini.parse();
			var systree=mini.get('systree');
		
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var rightJson=record.rightJson["def"];
	            var pkId = record.pkId;
	            var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>';
           		for(var i=0;i<rightJson.length;i++){
           			var json=rightJson[i];
           			s+=getByJson(record,json)
           		}
           		s += '<span  title="清除测试数据" onclick="removeTestInst(\'' + pkId + '\')">清除测试数据</span>';
	            return s;
	        }

	        //表头查看明细
			function detailRowFrom(){
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
				detailRow(row.pkId);
			}

        	
        	function getByJson(record,json){
        		var pkId = record.pkId;
	            var uid=record._uid;
	            var name=record.name;
	            var actDefId=record.actDefId;
        		var str="";
        		switch(json.key){
        			case "design":
        				if(json.val){
        					str+=' <span title="配置" onclick="mgrFastRow(\'' + pkId + '\',\''+name+'\',\'' + actDefId + '\')">方案配置</span>';
        				}
        				break;
        			case "start":
        				if(json.val && ( record.status=='TEST'||record.status=='DEPLOYED')){
        					str=' <span title="启动流程" onclick="startRow(\'' + uid + '\')">启动流程</span>';
			            	str = str + ' <span title="发布菜单"  onclick="deployMenu(\'' + record._uid + '\')">发布菜单</span>'; 
			            }
        				break;
        			case "edit":
        				break;
        			case "del":
        				if(json.val){
        					str='  <span title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
        				}
        				break;
        		}
        		return str;
        	}
        	
        	function deployMenu(uid){
				var row=grid.getRowByUID(uid);
				_OpenWindow({
					title:'发布菜单 ',
					height:450,
					width:800,
					url:__rootPath+"/sys/core/sysMenu/addNode.do",
					onload:function(){
						var win=this.getIFrameEl().contentWindow;
						win.setData({
							name:row.name,
							key:row.key+'_Sol',
							parentId:'',
							url:'/bpm/core/bpmInst/'+row.key+'/start.do',
							showType:'URL',
							isBtnMenu:'NO',
							isMgr:'NO'
						});
					}
				});
			}
		
        	
	        function onStatusRenderer(e) {
	            var record = e.record;
	            var status = record.status;
	            
	            var arr = [ {'key' : 'DEPLOYED', 'value' : '发布','css' : 'green'}, 
				            {'key' : 'CREATED','value' : '创建','css' : 'orange'} ];
				
				return $.formatItemValue(arr,status);
	        }
	        
	        function onFormalRenderer(e) {
	            var record = e.record;
	            var formal = record.formal;
	            
	            var arr = [ {'key' : 'yes', 'value' : '正式','css' : 'green'}, 
				            {'key' : 'no','value' : '测试','css' : 'orange'} ];
				
				return $.formatItemValue(arr,formal);
	            
	        }
	        
	        function removeTestInst(solId){
	        	var cleanTest=function(action){
	        		 if (action != "ok") return;
                	 _SubmitJson({
     		   			url:__rootPath+'/bpm/core/bpmSolution/cleanTestInst.do?solId='+solId,
     		   			success:function(text){
     		   				grid.load();
     		   			}
     		   		}); 
	        	}
		   		mini.confirm("确定清除测试记录？", "确定？",cleanTest);
		   	}
	        
	        function fastAdd(){
	       		var width=getWindowSize().width;
        		var height=getWindowSize().height;

        		var url='${ctxPath}/bpm/core/bpmSolution/mgrFast.do';
        		_OpenWindow({
		   			title:'流程解决方案快速设置',
		   			url:url,
		   			width:width,
		   			height:height,
		   			ondestroy:function(action){
		   				grid.reload();
		   			}
		   		});
	        }
	        
	        function fastEdit(){
	        	var row = grid.getSelected();
	        	if(row){
	        		mgrFastRow(row.pkId,row.name,row.actDefId);
	        	}
	        }
	        
	       
	        //该函数由添加调用时回调函数
	        function addCallback(openframe){
	        	var bpmSolution=openframe.getJsonData();
	        	mgrRow(bpmSolution.solId,bpmSolution.name,bpmSolution.actDefId);
	        }
        	
        	function mgrRow(pkId,name,actDefId){
        		var width=getWindowSize().width;
        		var height=getWindowSize().height;
        		var url='${ctxPath}/bpm/core/bpmSolution/mgr.do?solId='+pkId+'&actDefId='+actDefId
        		_OpenWindow({
		   			title:'流程解决方案设置',
		   			url:url,
		   			width:width,
		   			height:height,
		   			ondestroy:function(action){
		   				grid.reload();
		   			}
		   		});
        		
        	}
        	
        	function mgrFastRow(pkId,name,actDefId){
        		var width=getWindowSize().width;
        		var height=getWindowSize().height;

        		var url='${ctxPath}/bpm/core/bpmSolution/mgrFast.do?solId='+pkId+'&actDefId='+actDefId
        		_OpenWindow({
		   			title:'流程解决方案设置',
		   			url:url,
		   			width:width,
		   			height:height,
		   			ondestroy:function(action){
		   				grid.reload();
		   			}
		   		});
        		
        	}
        	
       		function addNodeList(e){
				addNode('新增业务流程解决方案分类','CAT_BPM_SOLUTION')
		   	}
			function editNodeList(e){
				editNode('编辑节点')
			}
		   	function refreshSysTree(){
		   		var systree=mini.get("systree");
		   		systree.load();
		   	}
		   	

		   	/**
		   	*导出
		   	**/
		   	function doExport(){
		   		var rows=grid.getSelecteds();
		   		if(rows.length==0){
		   			alert('请选择需要导出的流程方案记录！')
		   			return;
		   		}
		   		var ids=_GetIds(rows);
		   		_OpenWindow({
		   			title:'流程方案导出',
		   			url:__rootPath+'/bpm/core/bpmSolution/export.do?ids='+ids,
		   			height:350,
		   			width:600
		   		});
		   	}
		   	
		   	function doImport(){
		   		_OpenWindow({
		   			title:'流程方案导入',
		   			url:__rootPath+'/bpm/core/bpmSolution/import1.do',
		   			height:350,
		   			width:600
		   		});
		   	}
		   	
		   /*	function delNode(e){
		   		var systree=mini.get("systree");
		   		var node = systree.getSelectedNode();
		   
		         mini.confirm("确定删除记录？", "确定？",
		             function (action) {
			        	 if (action != "ok") return;
	                	 _SubmitJson({
	     		   			url:__rootPath+'/sys/core/sysTree/del.do?ids='+node.treeId,
	     		   			success:function(text){
	     		   				systree.load();
	     		   			}
	     		   		}); 
		             }
		         );
		   	}*/
		   	
		   	//按分类树查找数据字典
		   	function treeNodeClick(e){
		   		var node=e.node;
		   		grid.setUrl(__rootPath+'/bpm/core/bpmSolution/solutionList.do?treeId='+node.treeId);
		   		grid.load();
		   	}
		   	
		   	
        	
		   	
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmSolution" 
	winHeight="650" winWidth="900" entityTitle="业务流程解决方案" baseUrl="bpm/core/bpmSolution" />
	
</body>
</html>