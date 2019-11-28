
<%-- 
    Document   : [布局权限设置]编辑页
    Created on : 2017-08-28 15:58:17
    Author     : aichen.yang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[布局权限设置]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="insPortalPermission.id" />
	<div id="p1" class="form-outer shadowBox90">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${insPortalPermission.id}" />
				<input id="layoutId" name="layoutId" value="${layoutId}" class="mini-hidden"  />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>阅读权限</caption>
					<tr>
						<th>类　　型</th>
						<td>
							<div class="mini-radiobuttonlist" repeatItems="5" repeatLayout="table" value="ALL" onValuechanged="toggleType"
    						textField="text" valueField="id"  id="portalType" name="portalType"  data="[{id:'ALL',text:'所有人'},{id:'custom',text:'配置'}]" ></div>
						</td>
					</tr>
					<tbody id="customSetting"></tbody>
				</table>
			</div>
		
		</form>
	
	</div>
	<script id="rootTemplate"  type="text/html">
	<#for(var i=0;i<list.length;i++){
	var json=list[i];
	#>
        <tr>
			<th style="width:15%"><#=json.val#></th>
			<td>
				<input   class="mini-textboxlist" id="<#=json.key #>" name="<#=json.key #>"   style="width:90%;"  />
				<a class="mini-button"  onclick="selOwner('<#=json.key #>')">选择</a>
			</td>
		</tr>
	<#}#>
	</script>
	<script type="text/javascript">
	addBody();
	//设置左分隔符为 <!
	baidu.template.LEFT_DELIMITER='<#';
	//设置右分隔符为 <!  
	baidu.template.RIGHT_DELIMITER='#>';
	var typeJson =${typeJson};
	var lists = '${arr}';
	lists = mini.decode(lists);
	initType();
	mini.parse();
	
	var portalType=mini.get("portalType");
	var portalType1 = mini.get("portalType1");
	var form = new mini.Form("#form1");
	var pkId = '${insPortalPermission.id}';
	
	
	$(function(){
		init();
	})
	
	function initType(){
		var bt=baidu.template;
		var json=[];
		for(var key in typeJson){
			var obj={key:key,val:typeJson[key]};
			json.push(obj);
		}
		var data={"list":json};
		var html=bt("rootTemplate",data);
		$("#customSetting").html(html);	
	}
	
	function selOwner(type){
		try{
			eval("openDialog_"+ type+"()");
		}
		catch(e){
			alert("没有配置【" +typeJson[type] +"】，处理方法!" );
		}
	}
	
	//y@y 修改保存
	function init(){
		var obj=$("#customSetting");
		if(lists.length==1&&lists[0].type=="ALL"){
			portalType.setValue("ALL");
			obj.hide();
			return;
		}else{
			portalType.setValue("custom");
			obj.show();
		}
		var ownerUserIds = "";
		var ownerUserNames = "";
		var ownerGroupIds= "";
		var ownerGroupNames= "";
		var ownerSubGroupIds= "";
		var ownerSubGroupNames= "";
		//权限回显
		for(var i=0;i<lists.length;i++){
			var obj=lists[i];
			var type=obj.type;
			if(type!="ALL"){
				if(type=="user")
				{
					ownerUserIds = ownerUserIds + obj.ownerId + ",";
					ownerUserNames = ownerUserNames + obj.ownerName + ",";
				}
				if(type=="group")
				{
					ownerGroupIds = ownerGroupIds + obj.ownerId + ",";
					ownerGroupNames = ownerGroupNames + obj.ownerName + ",";
				}
				if(type=="subGroup")
				{
					ownerSubGroupIds = ownerSubGroupIds + obj.ownerId + ",";
					ownerSubGroupNames = ownerSubGroupNames +  obj.ownerName + ",";
				}
			}
		}
		var objTextUser=mini.get("user");
		var objTextGroup=mini.get("group");
		var objTextSubGroup=mini.get("subGroup");
		if(ownerUserIds.length>0)
		{
			objTextUser.setValue(ownerUserIds.substring(0,ownerUserIds.length-1));
			objTextUser.setText(ownerUserNames.substring(0,ownerUserNames.length-1));
		}
		if(ownerGroupIds.length>0)
	    {
			objTextGroup.setValue(ownerGroupIds.substring(0,ownerGroupIds.length-1));
			objTextGroup.setText(ownerGroupNames.substring(0,ownerGroupNames.length-1));
	    }
		if(ownerSubGroupIds.length>0)
	    {
			objTextSubGroup.setValue(ownerSubGroupIds.substring(0,ownerSubGroupIds.length-1));
			objTextSubGroup.setText(ownerSubGroupNames.substring(0,ownerSubGroupNames.length-1));
	    }
	}
	//y@y 修改保存
	
	function toggleType(e){
		var val=e.value;
		var obj=$("#customSetting");
		(val=="custom")?obj.show():obj.hide();
	}
	
	function openDialog_user(){
		_UserDlg(false,function(users){
			var ids=[];
			var names=[];
			for(var i=0;i<users.length;i++){
				ids.push(users[i].userId);
				names.push(users[i].fullname);
			}
			setValue("user",ids.join(","),names.join(","));
		});
	}
	
	function openDialog_group(){
		selGroup("group");
	}
	
	function openDialog_subGroup(){
		selGroup("subGroup");
	}
	
	function selGroup(type){
		_GroupDlg(false,function(groups){
			var ids=[];
			var names=[];
			for(var i=0;i<groups.length;i++){
				ids.push(groups[i].groupId);
				names.push(groups[i].name);
			}
			setValue(type,ids.join(","),names.join(","));
		});
	}
	
	function setValue(type, ids,names){
		var obj=mini.get(type);
		obj.setValue(ids);
		obj.setText(names);
	}
	
	function onOk(){
		var form = new mini.Form("form1");
        form.validate();
        if (!form.isValid()) {
            return;
        }
        var formData=form.getData();
        var config={
        	url:"${ctxPath}/oa/info/insPortalPermission/savePortal.do",
        	method:'POST',
        	data:formData,
        	success:function(result){
        		//如果存在自定义的函数，则回调
        		if(isExitsFunction('successCallback')){
        			successCallback.call(this,result);
        			return;	
        		}
        		
        		CloseWindow('ok');
        	}
        }
        
        _SubmitJson(config);
	}
	

	</script>
</body>
</html>