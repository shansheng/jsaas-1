<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>业务表单视图编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div id="toolbar1" class="mini-toolbar topBtn" >
	     	<a class="mini-button"  plain="true" onclick="saveFormRight()">保存</a>
			<a class="mini-button btn-red" plain="true" onclick="CloseWindow('cancel');">关闭</a>
	        <a class="mini-button btn-red" iconCls="icon-clear" plain="true" onclick="reset()">重置</a>     
	</div>
	 <div class=" shadowBox90" style="padding-top: 8px;">
		<div id="p1" class="form-outer2">
			<form id="form1" method="post">
				<div class="form-inner">
					<table class="table-detail" cellspacing="1" cellpadding="0">
					<input id="treeId" 	  name="treeId"     class="mini-hidden" value="${treeId}"/>
					<input id="singleId"  name="singleId" 	class="mini-hidden" value="${singleId}"/>
					<input id="userName"  name="userName"   class="mini-hidden" value="${userName}"/>
					<input id="groupName" name="groupName"  class="mini-hidden" value="${groupName}"/>
					<input id="subGroupName" name="subGroupName"   class="mini-hidden"   value="${subGroupName}"/>
						<tr>
							<th>用　　户</th>
							<td colspan="3">
								<input 
									id="userId" 
									name="userId"   
									class="mini-textboxlist" 
									allowInput="false" 
									style="width: 80%;min-height:30px;"  
									value="${userId}" 
									text="${userName}" 
								/>
							<a class="mini-button"  onclick="selUser()">选择</a>
							</td>
						</tr>
						<tr>
							<th >用  户  组</th>
							<td colspan="3">
								<input 
									id="groupId" 
									name="groupId"  
									class="mini-textboxlist" 
									allowInput="false" 
									style="width: 80%;min-height:30px;" 
									value="${groupId}" 
									text="${groupName}"
								/>
							<a class="mini-button"  onclick="selGroup()">选择</a>
							</td>
						</tr>
						<tr>
							<th >组织或以下</th>
							<td colspan="3">
								<input 
									id="subGroupId" 
									name="subGroupId"  
									class="mini-textboxlist" 
									allowInput="false" 
									style="width: 80%;min-height:30px;" 
									value="${subGroupId}" 
									text="${subGroupName}"
								/>
							<a class="mini-button"  onclick="selGroup('sub')">选择</a>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	mini.parse();
	var user=mini.get("userId");
	var group=mini.get("groupId");
	var subGroup = mini.get("subGroupId");
	var form=new mini.Form("#form1");
	function selGroup(sub){
		if(sub){
			_GroupDlg(false,function(groups){
				var sids=[];
				var snames=[];
				for(var i=0;i<groups.length;i++){
					sids.push(groups[i].groupId);
					snames.push(groups[i].name);
				}
				subGroup.setValue(sids.join(","));
				subGroup.setText(snames.join(","));
				mini.get("subGroupName").setValue(snames.join(","));
			});
		} else {
			_GroupDlg(false,function(groups){
				var ids=[];
				var names=[];
				for(var i=0;i<groups.length;i++){
					ids.push(groups[i].groupId);
					names.push(groups[i].name);
				}
				group.setValue(ids.join(","));
				group.setText(names.join(","));
				mini.get("groupName").setValue(names.join(","));
			});
		}
	}
	
	function selUser(){
		_UserDlg(false,function(users){
			var ids=[];
			var names=[];
			for(var i=0;i<users.length;i++){
				ids.push(users[i].userId);
				names.push(users[i].fullname);
			}
			user.setValue(ids.join(","));
			user.setText(names.join(","));
			mini.get("userName").setValue(names.join(","));
		});
	}
	
	/*重置表单*/
	function reset(){
		var treeId=mini.get("treeId");
		var treeIdValue=treeId.getValue();
		var settingId=mini.get("settingId");
		var settingIdValue=settingId.getValue();
		form.clear();
		treeId.setValue(treeIdValue);
		settingId.setValue(settingIdValue);
	}
	
	function saveFormRight(){
		var data=form.getData();
		$.ajax({
			type:'post',
			url:'${ctxPath}/sys/echarts/echartsPremission/saveTreeGrantPremssion.do',
			data:data,
			success:function (result){
				CloseWindow('ok');
			}
		});
	};
	
	addBody();
	</script>
</body>
</html>