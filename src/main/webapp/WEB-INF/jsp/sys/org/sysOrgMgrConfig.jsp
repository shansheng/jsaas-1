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
	<style type="text/css">
		.mini-layout-border>#center{
	 		background: transparent;
		}
		.mini-tree .mini-grid-viewport{
			background: #fff;
		}
	</style>
</head>
<body>
	<div style="display:none;">
		<input class="mini-combobox" id="levelCombo" textField="name" valueField="level" 
               url="${ctxPath}/sys/org/osRankType/listByDimId.do?dimId=${osDimension.dimId}"/>
	</div>
	<div id="orgLayout" class="mini-layout" style="width:100%;height:100%;">
		    <div showHeader="false" showCollapseButton="false" iconCls="icon-group" region="center">
              	<div class="form-toolBox" >
			         <ul>
						<li>
							<a class="mini-button"   onclick="newGroupRow();">添加</a>
						</li>
						<li>
							<a class="mini-button btn-red"  onclick="delGroupRow();">删除</a>
						</li>
					</ul>
		     	</div>
		         <div class="mini-fit rx-grid-fit form-outer5" >
		         	<div 
		         		id="groupGrid" 
		         		class="mini-treegrid" 
		         		style="width:100%;height:100%;"     
			            showTreeIcon="true" 
			            treeColumn="name" idField="groupId" parentField="parentId" 
			            resultAsTree="false" 
			            allowResize="true"  allowAlternating="true"
			            allowRowSelect="true" 
			            onrowclick="groupRowClick" onbeforeload="onBeforeGridTreeLoad"
			            allowCellValid="true" oncellvalidation="onCellValidation" 
			            allowCellEdit="true" allowCellSelect="true"
		            >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div name="action" cellCls="actionIcons" width="50"  headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
							<div field="fullname" width="50"  allowSort="true" sortField="FULLNAME_">姓名</div>
							<div field="sn" width="50"  allowSort="true" sortField="SN_">序号</div>
							<div field="roleName" width="50"  allowSort="true" sortField="ROLENAME_">角色</div>
						</div>
					</div>
		        </div>
		    </div>

    </div>
	<script type="text/javascript">
		mini.parse();
		var groupId = '${groupId}';
		var groupName = '${groupName}';
		var dimTree=mini.get('#dimTree');
		var grid=mini.get('#groupGrid');
		var layout=mini.get('orgLayout');
		var isSuperAdmin = '${isSuperAdmin}';
		//当前操作的机构ID
		var tenantId='${param.tenantId}';
		//查询用户
		dimNodeClick();
		
		//是否显示用户组的授权按钮
		var isGrantButton=false;
		
		function expandGrid(){
			grid.expandAll();
		}
		
		
		function collapseGrid(){
			grid.collapseAll();
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

		function refreshDims(){
			dimTree.load();
		}
		
		function onBeforeGridTreeLoad(e){
			var tree = e.sender;    //树控件
	        var node = e.node;      //当前节点
	        var params = e.params;  //参数对象
	        //可以传递自定义的属性
	        params.parentId = node.groupId; //后台：request对象获取"myField"
		}

		//当前维度一样时才切换
		function loadGroupRootNode(){
			var nodes=grid.getRootNode().children;
			for(var i=0;i<nodes.length;i++){
				grid.loadNode(nodes[0]);
			}
		}

		function dimNodeClick(){

			layout.updateRegion("center",{title:'用户组--'+groupName});
			
			grid.setUrl('${ctxPath}/sys/org/osGradeAdmin/listByGroupId.do?groupId='+groupId);
			
			loadGroupRootNode();
			
			layout.expandRegion("south");
		}
		
		function onCellValidation(e){
        	if(e.field=='fullname' && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='名称不能为空！';
        	}
        	
        	if(e.field=='sn' && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='序号不能为空！';
        	}
        }
        //用户组操作列表
        function onActionRenderer(e) {
            var record = e.record;
            var uid = record._uid;
            
            var s ='<span  title="明细" onclick="userDetail(\''+uid+'\')">明细</span>';
			s+='<span  title="编辑用户角色" onclick="editGroupRow(\'' + uid + '\')">编辑用户角色</span>';
            s+='<span  title="删除" onclick="delGroupRow(\'' + uid + '\')">删除</span>';
           
            return s;
        }

     	 //用户对话框
        function userDialog(dimId){
        	_OpenWindow({
        		url:__rootPath+'/sys/org/osUser/dialog1.do?single=false&dimId='+dimId+"&groupId="+groupId+"&userAdminId=false&tenantId="+tenantId+"&isSuperAdmin="+isSuperAdmin,
        		height:600,
        		width:1200,
        		iconCls:'icon-user-dialog',
        		title:'用户选择',
        		ondestroy:function(action){
        			if(action!='ok')return;
        			var iframe = this.getIFrameEl();
                    var users = iframe.contentWindow.getUsers();

                    if(!users || users.length==0)return;
					var groupData = iframe.contentWindow.getGroups();
                    saveAdminUsers(users,groupData);
        		}
        	});
        }

		//编辑用户角色
		function editGroupRow(uid){
			var row=grid.getRowByUID(uid);
			_OpenWindow({
				iconCls:'icon-group-dialog',
				url:__rootPath+'/sys/org/osGroup/dialog1.do?single=&reDim=false&showDimId=2&tenantId=&config=&usAdminId='+row.id,
				height:480,
				width:930,
				title:'角色选择',
				ondestroy:function(action){
					if(action!="ok")return;
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.getGroups();
					var osGradeAdminAndRole ={
                        gradeAdminId:row.id,
                        osGradeRole:[]
                    };
					for(var i=0;data&&i<data.length;i++){
                        var obj = {};
                        obj.adminId = row.id;
                        obj.groupId = data[i].groupId;
                        obj.name = data[i].name;
                        osGradeAdminAndRole.osGradeRole.push(obj);
                    }
                    var config={
                        url:"${ctxPath}/sys/org/osGradeAdmin/updataRole.do",
                        method:'POST',
                        postJson:true,
                        data:osGradeAdminAndRole,
                        success:function(result){
                        	grid.load();
                        }
                    }
                    _SubmitJson(config);
				}
			});
		}

        function newGroupRow() {
            userDialog("1");
        }
        
      	//批量保存用户组
        function saveAdminUsers(users,groupData){
            var ary = [];
			var groupAry=[];
            var adminAndRole ={
				osGradeAdmin:[],
				osGradeRole:[]
			};
			for(var i=0;i<users.length;i++){
				var data = {};
				data.groupId=groupId;
				data.userId=users[i].userId;
				data.fullname=users[i].fullname;
				ary.push(data);
			}
			adminAndRole.osGradeAdmin=ary;
			if(groupData!=null && groupData.length>0){
				for(var i=0;i<groupData.length;i++){
					var obj = {};
					obj.adminId = "";
					obj.groupId = groupData[i].groupId;
					obj.name = groupData[i].name;
					groupAry.push(obj);
				}
			}
			adminAndRole.osGradeRole=groupAry;

			var config={
		        	url:"${ctxPath}/sys/org/osGradeAdmin/saveAll.do",
		        	method:'POST',
		        	postJson:true,
		        	data:adminAndRole,
		        	success:function(result){
		        		grid.load();
		        	}
		    }
			_SubmitJson(config);

        }
      	
        //删除用户组行
        function delGroupRow(row_uid) {
        	var row=null;
        	if(row_uid){
        		row = grid.getRowByUID(row_uid);
        	}else{
        		row = grid.getSelected();	
        	}

        	if(!row){
        		alert("请选择删除的用户！");
        		return;
        	}
        	
        	if (!confirm("确定删除此记录？")) {return;}
        	
            if(row && !row.id){
            	grid.removeNode(row);
            	return;
            }else if(row){
            	_SubmitJson({
            		url: "${ctxPath}/sys/org/osGradeAdmin/del.do?ids="+row.id,
                	success:function(text){
                		grid.removeNode(row);
                		dimTree.load();
                	}
                });
            } 
        }

        
        //组的行点击
        function groupRowClick(e){
        	var record=e.record;
        	var groupId=record.pkId;
        	if(!groupId) return;
        	$("#groupId").val(groupId);
        }

        //用户明细
        function userDetail(uid){
        	var row=grid.getRowByUID(uid);
        	_OpenWindow({
        		url:'${ctxPath}/sys/org/osUser/get.do?pkId='+row.userId,
        		title:'用户明细',
        		max:true,
        		height:350,
        		width:650
        	});
        }


	</script>
</body>
</html>