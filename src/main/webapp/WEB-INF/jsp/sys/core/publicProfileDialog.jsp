<%-- 
    Document   : [BpmSolUsergroup]编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户分组信息编辑</title>
<%@include file="/commons/edit.jsp"%>
<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" >
	var typeJson=${typeJson};
</script>
</head>
<body>
<div class="topToolBar">
	<div>
		<a class="mini-button" plain="true" onclick="onOk">保存</a>
		<a class="mini-button" onclick="reSetAll">重置</a>
		<a class="mini-button btn-red" plain="true" onclick="onCancel">关闭</a>
	</div>
</div>
<div class="mini-fit">
<div class="form-container">
	<form id="form1" method="post">
		<table class="table-detail column-two" cellspacing="1" cellpadding="0">
				<tr id="rdoTr">
					<td>人员配置：</td>
					<td>
						<div id="rdoType" class="mini-radiobuttonlist" repeatItems="2" repeatLayout="table" repeatDirection="horizontal"
						    textField="text" valueField="id" value="everyone"
						    data="[{id:'everyone',text:'所有人'},{id:'custom',text:'配置'}]" onValuechanged="toggleType">
						</div>
					</td>
				</tr>
				<tbody id="customSetting"></tbody>
		</table>
	</form>
</div>
</div>
	<script id="rootTemplate"  type="text/html">
	<#for(var i=0;i<list.length;i++){
	var json=list[i];
	#>
        <tr>
			<td style="width:15%"><#=json.val#>：</td>
			<td>
				<input   class="mini-textboxlist" id="<#=json.key #>" name="<#=json.key #>"   style="width:80%;height:100px"  />
				<a class="mini-button"  onclick="selOwner('<#=json.key #>')" style="margin-left: 6px">选择</a>
			</td>
		</tr>
	<#}#>
	</script>
	
	<script type="text/javascript">
	//设置左分隔符为 <!
	baidu.template.LEFT_DELIMITER='<#';
	//设置右分隔符为 <!  
	baidu.template.RIGHT_DELIMITER='#>';
	
	initType();
	
	mini.parse();
	
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
	
	
	
	var form = new mini.Form("#form1");            
	var rdoType=mini.get("rdoType");
	function toggleType(e){
		var val=e.value;
		var obj=$("#customSetting");
		(val=="custom")?obj.show():obj.hide();
	}
	
	function onOk(){
		CloseWindow("ok");
	}
	
	function onCancel(){
		CloseWindow("cancel");
	}
	
	
	function getData(){
		var objType=mini.get("rdoType");
		
		if(objType.getValue()=="everyone"){
			return [{type:"everyone",name:"所有人"}];
		}
		
		var data=form.getData();
		var ary=[];
		for(var key in typeJson){
			var obj=mini.get(key);   
			var ids=obj.getValue();
			var names=obj.getText();
			var json={type:key,name:typeJson[key]};
			if(!ids) continue;
			json.ids=ids;
			json.names=names;
			ary.push(json);
		}
		return ary;
		
	}
	
	function init(aryData){
		var hideRadio="${param.hideRadio}";
		var isEvery=true;
		if(hideRadio==="YES"){
			rdoType.setValue("custom");
			$("#rdoTr").hide();
			isEvery=false;
		}
		if(aryData){
			for(var i=0;i<aryData.length;i++){
				var obj=aryData[i];
				if(obj.type!="everyone"){
					isEvery=false;
					break;
				}
			}
		}
		var obj=$("#customSetting");
		
		isEvery?obj.hide():obj.show();
		
		mini.get("rdoType").setValue(isEvery?"everyone":"custom");
		
		if(isEvery) return;
		
		for(var i=0;i<aryData.length;i++){
			var obj=aryData[i];
			var type=obj.type;
			var objText=mini.get(type );
			objText.setValue(obj.ids);
			objText.setText(obj.names);
			
		}
	}
	
	$(function(){
		init();
	})
	
	
	
	function selOwner(type){
		try{
			eval("openDialog_"+ type+"()");
		}
		catch(e){
			alert("没有配置【" +typeJson[type] +"】，处理方法!" );
		}
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
		var value = obj.getValue();
		var text = obj.getText();
		var ary = ids.split(",");
		var aryText = names.split(",");
		for(var i=0;i<ary.length;i++){
			if(value.indexOf(ary[i])!=-1){
				continue;
			}
			if(value){
				value += ","+ary[i];
				text += ","+aryText[i];
			}else{
				value += ary[i];
				text += aryText[i];
			}
		}
		obj.setValue(value);
		obj.setText(text);
	}
	
	function reSetAll(){
		var form = new mini.Form("#form1");
        form.clear();
	}

	</script>
	
</body>
</html>