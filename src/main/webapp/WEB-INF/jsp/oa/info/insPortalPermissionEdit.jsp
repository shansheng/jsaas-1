
<%-- 
    Document   : [布局权限设置]编辑页
    Created on : 2017-08-28 15:58:17
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[布局权限设置]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
			<rx:toolbar toolbarId="toolbar1" pkId="insPortalPermission.id" />
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
			<div id="p1" class="form-outer ">
				<form id="form1" method="post">
					<div class="form-inner">
						<input id="pkId" name="id" class="mini-hidden" value="${insPortalPermission.id}" />
						<input id="layoutId" name="layoutId" value="${layoutId}" class="mini-hidden"  />
						<table class="table-detail column-two" cellspacing="1" cellpadding="0">
							<caption>[布局权限设置]基本信息</caption>
							<tr>
								<td>类　　型</td>
								<td>
									<div class="mini-radiobuttonlist" repeatItems="5" repeatLayout="table" value="ALL" onValuechanged="toggleType"
									textField="text" valueField="id"
										 id="portalType" name="portalType"  data="[{id:'ALL',text:'所有人'},{id:'custom',text:'配置'}]" ></div>
								</td>
							</tr>
							<tbody id="customSetting"></tbody>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script id="rootTemplate"  type="text/html">
	<#for(var i=0;i<list.length;i++){
	var json=list[i];
	#>
        <tr>
			<td><#=json.val#></td>
			<td>
				<input class="mini-textboxlist" id="<#=json.key #>" name="<#=json.key #>" allowinput="false"  style="width:90%;min-height:32px;"  />
				&nbsp;<a class="mini-button"  onclick="selOwner('<#=json.key #>')">选择</a>
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
		
		//权限回显
		var subGroupIds=[];
		var subGroupNames=[];
		var groupIds=[];
		var groupNames=[];
		var ids=[];
		var names=[];
		for(var i=0;i<lists.length;i++){
			var obj=lists[i];
			var type=obj.type;
			if(type=="subGroup"){
				subGroupIds.push(obj.ownerId);
				subGroupNames.push(obj.ownerName);
			}
			if(type=="group"){
				groupIds.push(obj.ownerId);
				groupNames.push(obj.ownerName);			
			}
			if(type=="user"){
				ids.push(obj.ownerId);
				names.push(obj.ownerName);
			}
		}
		setValue("subGroup",subGroupIds.join(","),subGroupNames.join(","));
		setValue("group",groupIds.join(","),groupNames.join(","));
		setValue("user",ids.join(","),names.join(","));
		
	}
	
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
		var idAry=[];
		var nameAry=[];
		if (obj.getValue() != '') {
			idAry = obj.getValue().split(',');
        }
        if (obj.getText() != '') {
        	nameAry = obj.getText().split(',');
        }
		var uIds =ids.split(',');
		var uNames =names.split(',');
		for (var i = 0; i < uIds.length; i++) {
            if (idAry.indexOf(uIds[i]) != -1) {
                continue;
            }
            idAry.push(uIds[i]);
            nameAry.push(uNames[i]);
        }
		obj.setValue(idAry.join(','));
		obj.setText(nameAry.join(','));
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