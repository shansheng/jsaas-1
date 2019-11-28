<%
	//组织架构管理，可管理全部租用组织架构，对于非SaaS管理员，仅能管理其本机构的
	//若传入InstId,并且需要检查当前组织机构的域名是否为在redxun.properties中指定的管理机构，
	//即可以进行格式化处理
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>系统组织架构管理</title>
	<%@include file="/commons/list.jsp"%>
	<script type="text/javascript" src="${ctxPath}/scripts/sys/org/org.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/sys/org/dimension.js"></script>
	<style type="text/css">
		.mini-layout-border>#center{
	 		background: transparent;
		}
		.mini-tree .mini-grid-viewport{
			background: #fff;
		}


		.icon-xia-add,
		.icon-shang-add,
		.icon-brush{
			color: #0daaf6;
		}
		.icon-addressbook,
		.icon-jia{
			color: #ff8b00;
		}
		.icon-baocun7{
			color:#2cca4e;
		}
		.icon-trash,
		.icon-offline{
			color: red;
		}
		.icon-quanxian2{
			color: #66b1ff;
		}

		.icon-button:before{
			font-size: 16px;
		}
	</style>
</head>
<body>
	<div style="display:none;">
		<input class="mini-combobox" id="levelCombo" textField="name" valueField="level" 
               url="${ctxPath}/sys/org/osRankType/listByDimId.do?dimId=${osDimension.dimId}"/>
	</div>
	<ul id="dimNodeMenu" class="mini-contextmenu" onbeforeopen="onShowingNodeMenu">        
	    <li iconCls="icon-remove"   onclick="delDim">删除维度</li>
	    <li iconCls="icon-edit" onclick="editDim">编辑维度</li>
	    <li iconCls="icon-edit" onclick="manageDimRank()">管理维度等级</li>  
	</ul>
	<div id="orgLayout" class="mini-layout" style="width:100%;height:100%;">
		    <div 
		    	title="用户组维度" 
		    	region="west" 
		    	width="170"  
		    	showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false"
	    	>
		        <div class="treeToolBar">
					<a class="mini-button"   plain="true" onclick="addDim()">新增</a>
		            <a class="mini-button" plain="true" onclick="refreshDims()">刷新</a>
		        </div>
		        <div class="mini-fit">
			         <ul 
			         	id="dimTree" 
			         	class="mini-tree" 
			         	url="${ctxPath}/sys/org/osDimension/jsonAll.do?tenantId=${sysInst.instId}" 
			         	style="width:100%; height:100%;" 
						imgPath="${ctxPath}/upload/icons/"
						showTreeIcon="true" 
						textField="name" 
						idField="dimId" 
						resultAsTree="false"  
		                onnodeclick="dimNodeClick"
		                contextMenu="#dimNodeMenu"
	                >        
		            </ul>
	            </div>
		    </div>
        
		    <div region="center" showHeader="false" showCollapseButton="false" iconCls="icon-group" >
		         
              	<div class="mini-toolbar" >
			         <ul class="toolBtnBox">
						<li>
							<a class="mini-button"   onclick="saveGroups()">保存</a>
						</li>
						<li>
							<a class="mini-button"   onclick="newGroupRow();">新增</a>
						</li>
						<li>
							<a class="mini-button"  onclick="newGroupSubRow();">新增子组</a>
						</li>
						<li>
							<a class="mini-button btn-red"  onclick="delGroupRow();">删除</a>
						</li>
						<li>
							<ul id="moreMenu" class="mini-menu" style="display:none">
						        <li   onclick="expandGrid()">展开</li>
		                       	<li   onclick="collapseGrid()">收起</li>
				                <li   onclick="userMgr('${sysInst.instId}','${sysInst.nameCn}');">管理用户</li>
						    	<li   onclick="groupRelMgr('${sysInst.instId}','${sysInst.nameCn}');">管理用户组关系</li>
						    </ul>
							<a class="mini-menubutton"  menu="#moreMenu" >更多</a>
						</li>
					</ul>
		     	</div>
		         <div class="mini-fit " >
		         	<div 
		         		id="groupGrid" 
		         		class="mini-treegrid" 
		         		style="width:100%;height:100%;"     
			            showTreeIcon="true" 
			            treeColumn="name" idField="groupId" parentField="parentId" 
			            resultAsTree="false" 
			            allowResize="true"  allowAlternating="true"
			            oncellbeginedit="OnCellBeginEdit" 
			            oncellendedit="OnCellEndEdit"
			            allowRowSelect="true"
			            onrowclick="groupRowClick" onbeforeload="onBeforeGridTreeLoad"
			            allowCellValid="true" oncellvalidation="onCellValidation" 
			            allowCellEdit="true" allowCellSelect="true">
			            <div property="columns">
			            	<div name="action" cellCls="actionIcons" width="160"
			            		renderer="onActionRenderer" cellStyle="padding:0;" align="center" headerAlign="center">操作</div>
			                <div name="name" field="name" align="left" width="160">组名
			                	<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
			                </div>
			                <div field="key" name="key" align="left" width="80">组Key
			                	<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
			                </div>
			                <div name="rankLevel" field="rankLevel" displayField="rankLevelName"  width="80">用户组等级
			                	<input property="editor" class="mini-textbox" style="width:100%;" />
			                </div>
			                <div name="sn" field="sn" align="left" width="60">序号
			                	<input property="editor" changeOnMousewheel="false" class="mini-spinner"  minValue="1" maxValue="100000" required="true"/>
			                </div>
			            </div>
			        </div>
		        </div>
		    </div><!-- end of the center region  -->		    
		    <div 
		    	region="east"  
		    	width="430"  
		    	showSplitIcon="true" 
		    	showHeader="false"
		    	showCollapseButton="false"
		    	showProxy="false"
		    	bodyStyle="border:none;padding:2px;">
		  	    	<div class="mini-fit">
			    	<div class="mini-tabs" style="height:100%;width:100%;border:none;" onactivechanged="resetTab" bodyStyle="border:none;padding:2px;">
					    	<div title="用户关系" iconCls="icon-user">
					    		<div class="form-toolBox">
					    			<ul>
										<li><a class="mini-button"   onclick="addUser();">新增</a></li>
										<li><a class="mini-button"   onclick="joinUser();">加入</a></li>
										<li><a class="mini-button btn-red"   onclick="unjoinUser();">移除</a></li>
										<li><a class="mini-button btn-red"   onclick="deleteUser();">删除</a></li>
										<li><a class="mini-button"   onclick="onSearchUsers()">查询</a></li>
									</ul>
									<form id="userForm" class="text-distance" style="padding-bottom: 6px;">
										<input type="hidden" id="groupId" name="groupId" value=""/>
										<input class="mini-textbox" id="fullname" name="fullname" emptyText="请输入姓名"/>
										<span style="font-size: 14px;">&nbsp;</span>
										<input class="mini-textbox"  id="userNo" name="userNo" emptyText="请输入用户编号"/>
										<!-- a class="mini-button btn-red"    onclick="onClear()">清空</a-->
									</form>
						        </div>
					       		<div class="mini-fit rx-grid-fit">
					        		<div id="userGridTab" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;border:none;">
									</div>
					       		</div>
				    	</div>
				    	<div title="组关系" iconCls="icon-group">
			    			<div class="form-toolBox">
				               <ul>
								   <li>
					              	  <a class="mini-button"   onclick="addGroupRelType();">新增用户组关系</a>
								   </li>
								   <li>
					               	 <a class="mini-button btn-red"  onclick="removeGroupRelType();">移除用户组关系</a>
								   </li>
								   <li>
					               	 <a class="mini-button"  onclick="saveGroupRelInst();">保存</a>
								   </li>
			                   </ul>
					        </div>
					        <div class="mini-fit" style="border:0;">
						    	<div id="groupRelGridTab" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;border:none" bodyStyle="padding:2px;"></div>
					    	</div>
				    	</div>

						<div title="扩展属性" iconCls="icon-group">
							<div class="form-toolBox" >
								<ul>
									<li><a class="mini-button"   onclick="editOrgAttr()">设置扩展属性</a></li>
								</ul>
							</div>
							<div class="mini-fit rx-grid-fit form-outer5" >
								<div
										id="groupAttr"
										class="mini-treegrid"
										style="width:100%;height:100%;"
										showTreeIcon="true"
										treeColumn="name"
										resultAsTree="false"
										allowResize="true"  allowAlternating="true"
										allowCellValid="true"
										allowCellEdit="true" allowCellSelect="true">
									<div property="columns">
										<div name="treeName" field="treeName" align="left" width="10">属性分类
											<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
										</div>
										<div name="attributeName" field="attributeName" align="left" width="10">属性名称
											<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
										</div>
										<div  name="value" align="left" width="20" renderer="onAttrRenderer" >属性值
										</div>
									</div>
								</div>
							</div>
						</div>

			    	</div><!-- end of tabs -->
		    	</div>
		    </div><!-- end of region east -->	
    </div>
	<script type="text/javascript">
		mini.parse();
		var dimTree=mini.get('#dimTree');
		var groupGrid=mini.get('#groupGrid');
		
		var userGrid=mini.get('#usergrid');
		var defaultDimId='${osDimension.dimId}';
		var userGridTab=mini.get('#userGridTab');
		var groupRelGridTab=mini.get('groupRelGridTab');
		var layout=mini.get('orgLayout');
		//当前操作的机构ID
		var tenantId='${sysInst.instId}';
		var instType='${sysInst.instType}';
		
		//是否显示用户组的授权按钮
		var isGrantButton=false;

		function expandGrid(){
			groupGrid.expandAll();
		}
		
		
		function collapseGrid(){
			groupGrid.collapseAll();
		}
		
		//查找用户
		function onSearchUsers(){
			var formData=$("#userForm").serializeArray();
			var data=jQuery.param(formData);
			var tab=userGridTab.getActiveTab();
			var relTypeId=tab.name;
			var grid=mini.get('userGrid_'+relTypeId);
			grid.setUrl("${ctxPath}/sys/org/osUser/listByGroupIdRelTypeId.do?tenantId="+tenantId+"&relTypeId="+relTypeId + "&"+ data);
			grid.load();
		}
		
		function onShowingNodeMenu(e){
			var node=dimTree.getSelectedNode();
			//为默认
			if(node && node.isSystem=='YES'){
				  e.cancel = true;
				  //阻止浏览器缺省右键菜单
				  e.htmlEvent.preventDefault();
			      return;
			}
		}
		
		function onClear(){
			$("#userForm")[0].reset();
		}
		
		
		//重置tab的高度
		function resetTab(){
			mini.layout();
		}
		
		function OnCellBeginEdit(e) {
	    	var node=dimTree.getSelectedNode();
	    	var dimId;
	    	if(!node){
	    		dimId=defaultDimId;
	    	}else{
	    		dimId=node.dimId;
	    	}
	    	
			var field = e.field;
	        
			 if (field == "rankLevel") {
	               e.editor=mini.get('levelCombo');
	               e.editor.setUrl("${ctxPath}/sys/org/osRankType/listByDimId.do?dimId="+dimId);
	               e.column.editor=e.editor;
	         }
	    }
		
	
		//当前维度一样时才切换
		function loadGroupRootNode(){
			var nodes=groupGrid.getRootNode().children;
			for(var i=0;i<nodes.length;i++){
				groupGrid.loadNode(nodes[0]);
			}
		}

		function dimNodeClick(e){
			var node=e.node;
			if(node.isGrant=='YES'){
				isGrantButton=true;
			}else{
				isGrantButton=false;
			}
			layout.updateRegion("center",{title:'用户组--'+node.name});
			
			groupGrid.setUrl(__rootPath +'/sys/org/sysOrg/listByDimId.do?dimId='+node.dimId+'&tenantId='+tenantId);
			
			loadGroupRootNode();
			
			layout.expandRegion("south");
			//动态加载该维度用户的关系
			$.getJSON(__rootPath+'/sys/org/osRelType/getRelTypesOfGroupUser.do?tenantId='+tenantId+'&dimId='+node.dimId,function(json){
				loadUserTabs(json);
			});
			//动态加载该用户组下的用户组关系类型
			$.getJSON(__rootPath+'/sys/org/osRelType/getRelTypesOfGroupGroup.do?tenantId='+tenantId+'&dimId='+node.dimId,function(json){
				loadGroupTabs(json);
			});
		}
		
		
		//保存用户组实例
		function saveGroupRelInst(){
			var tabs2=groupRelGridTab.getTabs();
			var groupJsons=[];
        	for(var i=0;i<tabs2.length;i++){
        		var tab=tabs2[i];
        		var relTypeId=tab.name;
        		var grid=mini.get('groupGroupGrid_'+relTypeId);
        		groupJsons=groupJsons.concat(grid.getData());
        	}
        	
        	if(groupJsons.length==0){
        		return;
        	}
        	
        	_SubmitJson({
        		url:__rootPath+'/sys/org/sysOrg/saveGroupRelInst.do',
        		method:'POST',
        		data:{
        			insts:mini.encode(groupJsons)
        		},
        		success:function(result){
        			
        		}
        	});
		}
		
		
        //用户组操作列表
        function onActionRenderer(e) {
            var record = e.record;
            var uid = record._uid;

            var s = '<span class="icon-button icon-shang-add" title="在前新增用户组" onclick="newBeforeRow(\''+uid+'\')"></span>';
            s+='<span class="icon-button icon-xia-add" title="在后新增用户组" onclick="newAfterRow(\''+uid+'\')"></span>';
            s+='<span class="icon-button icon-jia" title="新增子用户组" onclick="newGroupSubRow()"></span>';
            s+='<span class="icon-button icon-baocun7" title="保存" onclick="saveGroupRow(\'' + uid + '\')"></span>';
            s+='<span class="icon-button icon-trash" title="删除" onclick="delGroupRow(\'' + uid + '\')"></span>';
            if(record.groupId && record.groupId!='' && isGrantButton){
            	s+='<span class="icon-button icon-quanxian2" title="子系统授权" onclick="grantGroupRow(\'' + uid + '\')"></span>';
            }
           
            return s;
        }

        //用户操作编辑
        function onUserActionRenderer(e){
			var uid = e.record._uid;            
            var s = '<span class="icon-button icon-addressbook" title="用户明细" onclick="userDetail(\''+uid+'\')"></span>';
            s+=' <span class="icon-button icon-brush" title="编辑" onclick="userEdit(\''+uid+'\',\''+tenantId+'\')"></span>';
            s+=' <span class="icon-button icon-offline" title="移除" onclick="userUnjoin(\''+uid+'\')"></span>';
            return s;
        }
        
        function groupRelActionRenderer(e){
        	var uid = e.record._uid; 
            var s = '<span class="icon-button icon-group" title="组关系内用户" onclick="grDetail(\''+uid+'\')"></span>';
            return s;
        }
        
        function grDetail(uid){
        	var selectedRow=groupGrid.getSelected();
			if(!selectedRow){
				alert('请选择用户组行!');
				return;
			}
			
			var tab=groupRelGridTab.getActiveTab();
        	if(tab==null) return;
        	
        	var relTypeId=tab.name;
        	var relGrid=mini.get('groupGroupGrid_'+relTypeId);
			
        	var row = relGrid.getRowByUID(uid);
        	var title=selectedRow.name + '-' + row.groupName+'用户管理';
        	_OpenWindow({
        		title:title,
        		height:450,
        		width:800,
        		url:__rootPath+'/sys/org/osRelInst/groupRelUsers.do?p1='+row.party1+'&p2='+row.party2 +'&dimId1='+row.dimId1+'&dimId2='+row.dimId2
        	});
        }
        
        //授权用户组
        function grantGroupRow(uid){
			var row=groupGrid.getRowByUID(uid);
			_OpenWindow({
				title:'['+row.name + ']'+'--授权管理',
				url:__rootPath+'/sys/org/osGroup/toGrant.do?groupId='+row.groupId + '&tenantId='+tenantId + "&instType="+ instType,
				width:450,
				height:600
			});
        }
		//在当前选择行的下添加子记录
        function newGroupSubRow(){
        	var node = groupGrid.getSelectedNode();
            var newNode = {sn:1};
            groupGrid.addNode(newNode, "add", node);
            groupGrid.expandNode(node);
        }
		
        function newGroupRow() {
            var node = groupGrid.getSelectedNode();
            groupGrid.addNode({sn:1}, "before", node);
            groupGrid.cancelEdit();
            groupGrid.beginEditRow(node);
        }

        function newAfterRow(row_uid){
        	var node = groupGrid.getRowByUID(row_uid);
        	groupGrid.addNode({sn:1}, "after", node);
        	groupGrid.cancelEdit();
        	groupGrid.beginEditRow(node);
        }
        
        function newBeforeRow(row_uid){
        	var node = groupGrid.getRowByUID(row_uid);
        	groupGrid.addNode({sn:1}, "before", node);
        	groupGrid.cancelEdit();
        	groupGrid.beginEditRow(node);
        }
		
        function saveGroupRow(row_uid) {
        	//表格检验
        	groupGrid.validate();
        	if(!groupGrid.isValid()){
            	return;
            }
			var row = groupGrid.getRowByUID(row_uid);
            
			var node = dimTree.getSelectedNode();
			var dimId;
			if(node){
				dimId=node.dimId;
			}else{
				alert("请选择维度！");
				return;
			}

            var json = mini.encode(row);
            
            _SubmitJson({
            	url: "${ctxPath}/sys/org/sysOrg/saveGroup.do",
            	data:{
            		dimId:dimId,
            		tenantId:tenantId,
            		data:json},
            	method:'POST',
            	success:function(text){
            		var result=mini.decode(text);
            		if(result.data && result.data.groupId){
            			groupGrid.updateRow(row,result.data);
            		}
            	}
            });
        }
        
      	//批量保存用户组
        function saveGroups(){
			var node = dimTree.getSelectedNode();
			var dimId=null;
			if(node){
				dimId=node.dimId;
			}else{
				alert("请选择维度！");
				return;
			}
			
        	//表格检验
        	groupGrid.validate();
        	if(!groupGrid.isValid()){
            	return;
            }
        	
        	//获得表格的每行值
        	var data = groupGrid.getData();
        	if(data.length<=0)return;
            var json = mini.encode(data);
            
            var postData={
            		dimId:dimId,
            		gridData:json,
            		tenantId:tenantId		
            };
            
            _SubmitJson({
            	url: "${ctxPath}/sys/org/sysOrg/batchSaveGroup.do",
            	data:postData,
            	method:'POST',
            	success:function(text){
            		groupGrid.load();
            	}
            });
        }
      	
        
        function manageDimRank(){
        	var node=dimTree.getSelectedNode();
        	_OpenWindow({
        		url:"${ctxPath}/sys/org/osRankType/list.do?dimId="+node.dimId,
        		title:node.name+"-等级管理",
        		width:600,
        		height:350
        	});
        }
        
        //组的行点击
        function groupRowClick(e){
        	var record=e.record;
        	var groupId=record.groupId;
        	if(!groupId) return;
        	$("#groupId").val(groupId);
        	
        	layout.updateRegion("south",{title:'用户组关系--'+record.name,visible: true });
        	layout.updateRegion("east",{title:'用户--'+record.name,visible: true });
        	
        	var level=record.rankLevel?record.rankLevel:-1;
        	var dimId=record.dimId;
        	
        	var urlUser=__rootPath+'/sys/org/osRelType/getRelTypesOfGroupUser.do?tenantId='+tenantId+'&dimId='+dimId +"&level=" + level;
        	//动态加载该维度用户的关系
			$.getJSON(urlUser,function(json){
				loadUserTabs(json,groupId);
			});
        	
        	var urlGroup=__rootPath+'/sys/org/osRelType/getRelTypesOfGroupGroup.do?tenantId='+tenantId+'&dimId='+dimId+"&level=" + level;
			//动态加载该用户组下的用户组关系类型
			$.getJSON(urlGroup,function(json){
				loadGroupTabs(json,groupId);
			});

			//动态加载扩展属性
			getAttrList(groupId);
        }
		
        //管理组的关系
        function groupRelMgr(tenantId,tenantName){ 
        	var title=tenantName==''?'用户与组关系定义':tenantName+'-用户与组关系定义';        	
    		var config = {};
    		config.title = title;
    		config.url = '${ctxPath}/sys/org/osRelType/list.do?tenantId='+tenantId;
    		config.width = '80%';
    		config.height = '80%';    		
    		_OpenWindow(config);    		
        }
        
      	//管理用户
        function userMgr(tenantId,tenantName){ 
        	var title=tenantName==''?'用户管理':tenantName+'-用户管理';       	
        	var config = {};
    		config.title = title;
    		config.url = '${ctxPath}/sys/org/osUser/list.do?tenantId='+tenantId
    		config.width = '80%';
    		config.height = '80%';    		
    		_OpenWindow(config);
        }
        
        //添加用户组间的关系
        function addGroupRelType(){
        	var selectedRow=groupGrid.getSelected();
			if(!selectedRow){
				alert('请选择用户组行!');
				return;
			}
        	//获得当前的关系方是否包括另一维度，若仅是另一维度的用户组，则弹出的用户组仅能选择该维度下的用户组
        	var tab=groupRelGridTab.getActiveTab();
        	if(tab==null) return;
        	var groupId=selectedRow.groupId;
        	var relTypeId=tab.name;
        	var grid=mini.get('groupGroupGrid_'+relTypeId);
        	$.getJSON('${ctxPath}/sys/org/osRelType/getRecord.do?pkId='+relTypeId,function(relType){
        		var showDimId=relType.dimId2;
        		
        		//function _TenantGroupDlg(tenantId,single,showDimId,callback,reDim){
        		//为当前选择的用户组添加其对应的关系实例
            	_TenantGroupDlg(tenantId, false, "", showDimId, function(groups){ // modofy by qinxinhua 2018-05-07
           			var groupIds=[];
   					//为多个用户组
   					for(var i=0;i<groups.length;i++){
   						groupIds.push(groups[i].groupId);
   					}
   					_SubmitJson({
   						url:__rootPath+'/sys/org/sysOrg/joinGroups.do',
   						method:'POST',
   						data:{
   							groupId:groupId,
   							relTypeId:relTypeId,
   							groupIds:groupIds.join(','),
   							tenantId:tenantId
   						},
   						success:function(text){
   							var result=mini.decode(text);
   							if(result.success){
   								grid.load();
   							}
   						}
   					});
    			},false);
        	});
        }
        
        //删除用户组关系
        function removeGroupRelType(){
        	var tab=groupRelGridTab.getActiveTab();
        	if(tab==null) return;
        	var relTypeId=tab.name;
        	var grid=mini.get('#groupGroupGrid_'+relTypeId);
        	var selRows=grid.getSelecteds();
        	if(selRows.length<=0){
        		return;
        	}
        	
        	var instIds=[];
        	for(var i=0;i<selRows.length;i++){
        		instIds.push(selRows[i].instId);	
        	}
        	
        	_SubmitJson({
        		url:__rootPath+'/sys/org/sysOrg/removeOsRelInst.do',
        		method:'POST',
        		data:{
        			instIds:instIds.join(',')
        		},
        		success:function(text){
        			var result=mini.decode(text);
        			if(result.success){
        				grid.load();
        			}
        		}
        	});
        }
        
       
	</script>
</body>
</html>