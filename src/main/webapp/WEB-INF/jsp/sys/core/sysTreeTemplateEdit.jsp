<%-- 
    Document   : 系统树节点编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="rx" uri="http://www.redxun.cn/formFun"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>系统树节点编辑</title>
<%@include file="/commons/edit.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${ctxPath}/scripts/boot.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share.js" type="text/javascript"></script>
<link href="${ctxPath}/styles/icons.css" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/form.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="topToolBar" >
		<div>
	   	 <a class="mini-button"  onclick="onOk">保存</a> 
		 <a class="mini-button"  onclick="onClose">关闭</a>
		</div>  
	</div>
	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div style="padding: 5px;">
				<input id="pkId" name="treeId" class="mini-hidden" value="${sysTree.treeId}" />
				<input id="catKey" name="catKey" class="mini-hidden" value="BPM_TEMPLATE_TREE" />
				<input id="sn" name="sn" class="mini-hidden" value="0" />
				<input name="parentId" value="${sysTree.parentId}" class="mini-hidden"/>
				
				
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<tr>
						<td>目录名称 <span class="star">*</span> ：</td>
						<td><input name="name" value="${sysTree.name}" class="mini-textbox" vtype="maxLength:128" required="true" emptyText="请输入名称" style="width:80%"/></td>
					</tr>
					<tr>
						<td>标识键<span class="star">*</span>：</td>
						<td><input id="key" name="key" value="${sysTree.key}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="标识键" style="width:90%"/></td>
					</tr>
					<tr id="solBind">
					<td>绑定流程模版</td>
					<td><input id="bindSolId" name="bindSolId" allowInput="false" class="mini-buttonedit" value="${sysTree.bindSolId}" text="${nameOfSol}" emptyText="请点击右侧按钮选择"  onbuttonclick="selectSol()" /></td>
					
					</tr>
				   <tr>
						<td>是否公共</td>
						<td><ui:radioBoolean id="isAll"  name="isAll"  value="${isAll}"  onValueChanged="changeIsAll()"  required="true" /></td>
					</tr>
					<tr id="userRightTr"  class="templateRight">
					<td>授权给用户</td>
					<td><textarea id="userRight"  name="userRight" value="${userIds}" text="${userNames}"  class="mini-textboxlist" emptyText="请选择用户" allowInput="false" validateOnChanged="false" style="margin-top: 5px;" width="65%" height="50px"></textarea>
					<a class="mini-button" style=" margin-left: 10px; margin-top: 5px;"  onclick="selectUser()">新增用户</a>
					
					</td>
					</tr>
					<tr id="groupRightTr" class="templateRight">
					<td>授权给用户组</td>
					<td>
						<textarea id="groupRight"  name="groupRight" value="${groupIds}" text="${groupNames}"  class="mini-textboxlist" emptyText="请选择组" allowInput="false" validateOnChanged="false" style="margin-top: 5px;" width="65%" height="50px"></textarea>
						<a class="mini-button" style=" margin-left: 10px; margin-top: 0px;"  onclick="selectGroup()">新增组</a>
					</td>
					</tr>
					
				</table>
			</div>
		</form>
	</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		//debugger;
		var isAll = document.getElementsByName("isAll")[0];
		
		$(function(){
			var haveSonOrNot="${haveSonOrNot}";
			if(haveSonOrNot=="YES"){
				$("#solBind").hide();
				$(".templateRight").hide();
			}
			if(isAll.value=="YES"){
				$("#userRightTr").hide();
				$("#groupRightTr").hide();
			}
		});
		var bindSolId=mini.get("bindSolId");
		var form=new mini.Form('form1');
		var userRight=mini.get("userRight");
		var groupRight=mini.get("groupRight");
		
		function changeIsAll(){
			if(isAll.value=="YES"){
				$("#userRightTr").hide();
				$("#groupRightTr").hide();
			}else if(isAll.value=="NO"){
				$("#userRightTr").show();
				$("#groupRightTr").show();
			}
		}
		
		function selectUser(){
			var oldUserIds = userRight.getValue().split(",");
			_UserDlg(false, function(users) {
				var ids=[];
				var fullnames=[];
				if(userRight.getValue().split(",") !=""){
					 ids =userRight.getValue().split(",");
					fullnames = userRight.getText().split(",");
				}
				for (var i = 0; i < users.length; i++) {
					var same = false;
					for(var j = 0;j<oldUserIds.length;j++){
						if(users[i].userId==oldUserIds[j]){
							same = true;
						}
					}
					if(same == false){
						ids.push(users[i].userId);
						fullnames.push(users[i].fullname);
					}
				}
				userRight.setValue(ids.join(','));
				userRight.setText(fullnames.join(','));
			});
		}
		function selectGroup(){
			var oldGroupIds = groupRight.getValue().split(",");
			_GroupDlg(false,function(groups){
				var uIds=[];
				var uNames=[];
				if(groupRight.getValue().split(",") !=""){
					 uIds =groupRight.getValue().split(",");
					uNames = groupRight.getText().split(",");
				}
				for (var i = 0; i < groups.length; i++) {
					var same = false;
					for(var j = 0;j<oldGroupIds.length;j++){
						if(groups[i].groupId==oldGroupIds[j]){
							same = true;
						}
					}
					if(same == false){
						uIds.push(groups[i].groupId);
						uNames.push(groups[i].name);
					}
				}
				groupRight.setValue(uIds.join(','));
				groupRight.setText(uNames.join(','));
			});
		}
		
		function selectSol(){//  
			 _OpenWindow({
					url:__rootPath+'/bpm/core/bpmSolution/dialog.do?single='+true,
					title:'流程解决方案选择',
					height:600,
					width:800,
					iconCls:'icon-flow',
					ondestroy:function(action){
						if(action!='ok')return;
						var iframe = this.getIFrameEl();
			            var sols = iframe.contentWindow.getSolutions();
			            bindSolId.setValue(sols[0].solId);
			        	bindSolId.setText(sols[0].name);
					}
				});
			
		}
		
		function onClose(){
			CloseWindow();
		}
	</script>
	<rx:formScript formId="form1" baseUrl="sys/core/sysTree"  entityName="com.redxun.sys.core.entity.SysTree"/>
</body>
</html>