
function loadUserTabs(json,groupId){
			
	userGridTab.removeAll();
	for(var i=0;i<json.length;i++){
		var tab=userGridTab.addTab({
			title:json[i].name,
			name:json[i].id,
			iconCls:'icon-user'
		});
		var relTypeId=json[i].id;
		var url=__rootPath + "/sys/org/osUser/listByGroupIdRelTypeId.do?relTypeId="+relTypeId+"&tenantId="+tenantId;
		if(groupId){
			url+="&groupId="+groupId;
		}
		var el=userGridTab.getTabBodyEl(tab);
		var userGrid=new mini.DataGrid();
		userGrid.set({
			id:"userGrid_"+json[i].id,
			style:"width:100%;height:100%;",
			url:url,
			idField:"userId",
			multiSelect:true,
			allowAlternating:true,
			columns:[{
				type:'indexcolumn',
				header:'序号'
			},{
				type:'action',
				header:'操作',
				renderer:"onUserActionRenderer"
			},{
				field:'fullname',
				sortField:'FULLNAME_',
				header:'姓名',
				width:120,
				headerAlign:'center',
				allowSort:true
			},{
				field:'userNo',
				header:'用户编号',
				sortField:'USER_NO_',
				width:110,
				headerAlign:'center',
				allowSort:true
			}]
		});
		userGrid.render(el);
		
		userGrid.on("drawcell", function (e) {
            var record = e.record,
	        field = e.field,
	        value = e.value;
          
            if(field=='sex'){
            	if(value=='Male'){
            		e.cellHtml='<img src="${ctxPath}/styles/images/male.png" alt="男性">';
            	}else{
            		e.cellHtml='<img src="${ctxPath}/styles/images/female.png" alt="女性">';
            	}
	        }
		});
		if(groupId){
			userGrid.load();
		}
		
	}
	userGridTab.activeTab(userGridTab.getTab(0));
}


function loadGroupTabs(json,groupId){
	groupRelGridTab.removeAll();
	for(var i=0;i<json.length;i++){
		var relTypeId=json[i].id;
		var tab=groupRelGridTab.addTab({
			title:json[i].name,
			name:relTypeId
		});
		var url=__rootPath+"/sys/org/sysOrg/listByGroupIdRelTypeId.do?relTypeId="+relTypeId+"&tenantId="+tenantId;
		if(groupId){
			url+="&groupId="+groupId;
		}
		
		var el=groupRelGridTab.getTabBodyEl(tab);
		var grid=new mini.DataGrid();
		grid.set({
			id:'groupGroupGrid_'+relTypeId,
			style:"width:100%;height:100%;",
			url:url,
			idField:"instId",
			multiSelect:true,
			allowCellEdit:true,
			allowCellSelect:true,
			allowAlternating:true,
			columns:[{
				type:'indexcolumn',
				header:'序号',
				width:40,
			},{
				type:'checkcolumn',
				width:30,
			},{
				type:'action',
				header:'操作',
				width:50,
				renderer:"groupRelActionRenderer"
			},{
				field:'alias',
				header:'名称',
				sortField:'ALIAS_',
				width:160,
				allowSort:true,
				editor:{type:'textbox'}
			}]
		});
		grid.render(el);
		
		grid.load();
	}
	groupRelGridTab.activeTab(groupRelGridTab.getTab(0));
}


//加入已经存在的用户
function joinUser(){
	var selectedRow=groupGrid.getSelected();
	if(!selectedRow){
		mini.alert('请选择用户组行!');
		return;
	}
	
	//获得激活的tab的标属性
	var tab=userGridTab.getActiveTab();
	
	var groupId=$("#groupId").val();
	
	if(tab==null || groupId=='') return;
	var relTypeId=tab.name;
	var grid=mini.get('#userGrid_'+relTypeId);

	var conf ={
		single:false,
		tenantId:tenantId,
		callback :function(users){
			if(users==null || users.length==0) return;
			var userIds=[];
			for(var i=0;i<users.length;i++){
				userIds.push(users[i].userId);
			}
			_SubmitJson({
				url:__rootPath+'/sys/org/osUser/joinUser.do',
				method:'POST',
				data:{
					userIds:userIds.join(','),
					relTypeId:tab.name,
					tenantId:tenantId,
					groupId:groupId
				},
				success:function(text){
					var result=mini.decode(text);
					if(result.success){
						grid.load();
					}
				}
			});
		}
	};
	_UserDialog(conf);
}

//从用户与组的关系中移除该用户
function unjoinUser(){
	var tab=userGridTab.getActiveTab();
	var groupId=$("#groupId").val();
	if(tab==null || groupId=='') return;
	var relTypeId=tab.name;
	var grid=mini.get('#userGrid_'+relTypeId);
	var selRows=grid.getSelecteds();
	if(selRows.length==0) return;
	var userIds=[];
	for(var i=0;i<selRows.length;i++){
		userIds.push(selRows[i].userId);
	}
	_SubmitJson({
		url:__rootPath+'/sys/org/osUser/unjoinUser.do',
		method:'POST',
		data:{
			userIds:userIds.join(','),
			relTypeId:relTypeId,
			groupId:groupId
		},
		success:function(text){
			var result=mini.decode(text);
			if(result.success){
				grid.load();
			}
		}
	});
}


function deleteUser(){
	var tab=userGridTab.getActiveTab();
	var userGrid=mini.get('#userGrid_'+tab.name);
	var selRows=userGrid.getSelecteds();
	if(selRows==null || selRows.length==0) return;
	if(!confirm('确定要删除选择的用户吗？')){
		return;
	}
	var ids=[];
	for(var i=0;i<selRows.length;i++){
		ids.push(selRows[i].userId);
	}

	_SubmitJson({
		url:__rootPath+'/sys/org/osUser/del.do?ids='+ids.join(','),
		method:'POST',
		success:function(text){
			var tabs=userGridTab.getTabs();
			for(var i=0;i<tabs.length;i++){
				var tab=tabs[i];
				var relTypeId=tab.name;
				var userGrid=mini.get('#userGrid_'+relTypeId);
				userGrid.load();
			}
		}
	});

}

//新增新的用户
function addUser(){
	
	//获得激活的tab的标属性
	var tab=userGridTab.getActiveTab();
	
	var groupId=$("#groupId").val();
	
	var relTypeId=tab!=null?tab.name:'';
	
	_OpenWindow({
		title:'新增新用户',
		url:__rootPath+'/sys/org/osUser/edit.do?tenantId='+tenantId+'&groupId='+groupId+'&relTypeId='+relTypeId,
		height:350,
		width:650,
		max:true,
		ondestroy:function(action){
			if(action!='ok')return;
			var grid=mini.get('#userGrid_'+relTypeId);
			grid.load();
		}
	});
}


//移除用户
function userUnjoin(uid){

	if(!confirm('确定要移除该用户吗？')){
		return;
	}

	var tab=userGridTab.getActiveTab();
	var groupId=$("#groupId").val();
	if(tab==null || groupId=='') return;
	var relTypeId=tab.name;
	var grid=mini.get('#userGrid_'+relTypeId);
	var row=grid.getRowByUID(uid);
	_SubmitJson({
		url:__rootPath+'/sys/org/osUser/unjoinUser.do',
		method:'POST',
		data:{
			userIds:row.userId,
			relTypeId:relTypeId,
			groupId:groupId
		},
		success:function(text){
			var result=mini.decode(text);
			if(result.success){
				grid.load();
			}
		}
	});
}

//用户编辑
function userEdit(uid,editTenantId){
	var tab=userGridTab.getActiveTab();
	var userGrid=mini.get('#userGrid_'+tab.name);
	var row=userGrid.getRowByUID(uid);
	_OpenWindow({
		url: __rootPath+'/sys/org/osUser/edit.do?pkId='+row.userId+"&editTenantId="+editTenantId,
		title:'用户编辑',
		max:true,
		height:350,
		width:650
	});
}

//用户明细
function userDetail(uid){
	var tab=userGridTab.getActiveTab();
	var userGrid=mini.get('#userGrid_'+tab.name);
	var row=userGrid.getRowByUID(uid);
	_OpenWindow({
		url:__rootPath + '/sys/org/osUser/get.do?pkId='+row.userId,
		title:'用户明细',
		max:true,
		height:350,
		width:650
	});
}



//删除用户组行
function delGroupRow(row_uid) {
	var row=null;
	if(row_uid){
		row = groupGrid.getRowByUID(row_uid);
	}else{
		row = groupGrid.getSelected();	
	}
	
	if(!row){
		mini.alert("请选择删除的用户组！");
		return;
	}
	
	if (!confirm("确定删除此记录？")) {return;}

    if(row && !row.groupId){
    	groupGrid.removeNode(row);
    	return;
    }else if(row.groupId){
    	_SubmitJson({
    		url: __rootPath+ "/sys/org/sysOrg/delGroup.do?groupId="+row.groupId,
        	success:function(text){
        		groupGrid.removeNode(row);
        	}
        });
    } 
}

function onCellValidation(e){
	if(e.field=='key' && (!e.value||e.value=='')){
		 e.isValid = false;
		 e.errorText='用户组Key不能为空！';
	}
	if(e.field=='name' && (!e.value||e.value=='')){
		e.isValid = false;
		 	e.errorText='用户组名称不能为空！';
	}
	
	if(e.field=='sn' && (!e.value||e.value=='')){
		e.isValid = false;
		 	e.errorText='序号不能为空！';
	}
}

function onBeforeGridTreeLoad(e){
	var tree = e.sender;    //树控件
	var node = e.node;      //当前节点
	var params = e.params;  //参数对象
	//可以传递自定义的属性
	params.parentId = node.groupId; //后台：request对象获取"myField"
}


function OnCellEndEdit(e){
	var record = e.record, field = e.field;
    var val=e.value;
    
	 if(field=='name' && (record.key==undefined || record.key=='')){
        	//自动拼音
       		$.ajax({
       			url:__rootPath+'/pub/base/baseService/getPinyin.do',
       			method:'POST',
       			data:{words:val,isCap:'true',isHead:'true'},
       			success:function(result){
       				groupGrid.updateRow(record,{key:result.data})
       			}
       		});
        	return;
        }
}

/**
 * 设置扩展属性
 */
function editOrgAttr(){
	var selectedRow=groupGrid.getSelected();
	if(!selectedRow){
		mini.alert("请选择用户组行！");
		return;
	}
	var groupId=selectedRow.groupId;

	_OpenWindow({
		title:'设置扩展属性',
		url:__rootPath+'/sys/org/sysOrg/editOrgAttr.do?groupId='+groupId,
		width:800,
		height:600,
		ondestroy:function(action){
			getAttrList(groupId);
		}
	});
}

/**
 * 获取扩展属性列表
 */
function getAttrList(groupId){
	$.getJSON(__rootPath+'/sys/org/sysOrg/listAttributes.do?groupId='+groupId+'&isEdit=false',function(json){
		var groupAttr = mini.get('#groupAttr');
		if(groupAttr){
			groupAttr.setData(json);
		}
	});
}

/**
 * 扩展属性值变换
 */
function onAttrRenderer(e){
	var record = e.record;
	var s ="";
	if(record.comboboxName){
		s ='<span class="mini-textbox" style="width:100%;" >'+record.comboboxName+'</span>';
	}else{
		s ='<span class="mini-textbox" style="width:100%;" >'+record.value+'</span>';
	}
	return s;
}
