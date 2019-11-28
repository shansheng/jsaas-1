
<%-- 
    Document   : [新闻公告权限表]编辑页
    Created on : 2017-11-03 11:47:25
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[新闻公告权限表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar" >
		<div>
			<a class="mini-button" onclick="onSave">保存</a>
		</div>
	</div>
	<div class="mini-fit">
	<div class="form-container">
			<div class="mini-fit rx-grid-fit">
				<form id="grantForm">			
					<table class="table-detail column-two" style="width:100%;">
						
						<tr class="atable">
							<td rowspan="2" style="font-size: 10px;">[附件查看]
							</td>
							<td>
								<input id="checkAgroupIds"
									   class="mini-textboxlist"
									   allowInput="false"
									   name="checkAgroupIds"
									   style="width:70%;"
									   value="${checkGroupIds}"
									   text="${checkGroupNames}"/>
								<a class="mini-button" onclick="clearGroups('checkAgroupIds')">清空</a>
								<a class="mini-button" onclick="selGroups('checkAgroupIds')">用户组</a>
							</td>
						</tr>
						<tr class="atable">
							<td style="text-align: left">
								<input id="checkAuserIds" class="mini-textboxlist" allowInput="false" name="checkAuserIds"  style="width:70%;" value="${checkUserIds}" text="${checkUserNames}"/>
								<a class="mini-button" onclick="clearUsers('checkAuserIds')">清空</a>
								<a class="mini-button" onclick="selUsers('checkAuserIds')">用户</a>
							</td>
						</tr>
						<tr class="atable">
							<td  rowspan="2" style="font-size: 10px;">[附件下载]
							</td>
							<td>
								<input id="downAgroupIds" class="mini-textboxlist" allowInput="false" name="downAgroupIds"  style="width:70%;" value="${downGroupIds}" text="${downGroupNames}"/>
								<a class="mini-button" onclick="clearGroups('downAgroupIds')">清空</a>
								<a class="mini-button" onclick="selGroups('downAgroupIds')">用户组</a>
							</td>
						</tr>
						<tr class="atable">
							<td style="text-align: left">
								<input id="downAuserIds"
									   class="mini-textboxlist"
									   allowInput="false"
									   name="downAuserIds"
									   style="width:70%;"
									   value="${downUserIds}"
									   text="${downUserNames}"
								/>
								<a class="mini-button" onclick="clearUsers('downAuserIds')">清空</a>
								<a class="mini-button" onclick="selUsers('downAuserIds')">用户</a>
							</td>
						</tr>
					</table>
				
					
				</form>
			</div>
	</div>
	</div>
	<script type="text/javascript">
	mini.parse();
	var gform=new mini.Form('grantForm');
	var newsId='${newsId}';

	
	function onSave(){
		var data=gform.getData();
		data.newsId=newsId;
		_SubmitJson({
			url:__rootPath+'/oa/info/insNewsCtl/saveCtl.do?newId='+newsId,
			data:data,
			success:function(result){
				if(isExitsFunction('successCallback')){
        			successCallback.call(this,result);
        			return;	
        		}
				CloseWindow('ok');
			}
		});
	}
	function clearGroups(element){
		var elementSelect=mini.get(element);
		elementSelect.setText('');
		elementSelect.setValue('');
	}
	function clearUsers(element){
		var elementSelect=mini.get(element);
		elementSelect.setText('');
		elementSelect.setValue('');
	}
	
	function selGroups(element){
		var elementSelect=mini.get(element);
		_GroupDlg(false,function(groups){
			var uIds=[];
			var uNames=[];
			for(var i=0;i<groups.length;i++){
				uIds.push(groups[i].groupId);
				uNames.push(groups[i].name);
			}
			if(elementSelect.getValue()!=''){
				uIds.unshift(elementSelect.getValue().split(','));
			}
			if(elementSelect.getText()!=''){
				uNames.unshift(elementSelect.getText().split(','));	
			}
			elementSelect.setValue(uIds.join(','));
			elementSelect.setText(uNames.join(','));
		});
	}
	
	function selUsers(element){
		var elementSelect=mini.get(element);
		_UserDlg(false,function(users){	
			var uIds=[];
			var uNames=[];
			for(var i=0;i<users.length;i++){
				uIds.push(users[i].userId);
				uNames.push(users[i].fullname);
			}
			if(elementSelect.getValue()!=''){
				uIds.unshift(elementSelect.getValue().split(','));
			}
			if(elementSelect.getText()!=''){
				uNames.unshift(elementSelect.getText().split(','));	
			}
			elementSelect.setValue(uIds.join(','));
			elementSelect.setText(uNames.join(','));
		});
	}
	
	
	

	</script>
</body>
</html>