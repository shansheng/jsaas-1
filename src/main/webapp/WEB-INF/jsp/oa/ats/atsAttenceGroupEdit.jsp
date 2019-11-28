
<%-- 
    Document   : [考勤组]编辑页
    Created on : 2018-03-27 11:27:43
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤组]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsAttenceGroup.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsAttenceGroup.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[考勤组]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsAttenceGroup.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsAttenceGroup.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td colspan="3">
						<input name="orgId" class="mini-buttonedit icon-dep-button" value="${atsAttenceGroup.orgId}" 
						text="${atsAttenceGroup.orgName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/>
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							
								<textarea name="memo"
							class="mini-textarea"   style="width: 90%">${atsAttenceGroup.memo}</textarea>
						</td>
					</tr>
				</table>
				<div >
					<div class="form-toolBox" >
				    	<a class="mini-button"   plain="true" onclick="addats_attence_group_detailRow">新增</a>
						<a class="mini-button btn-red"  plain="true" onclick="removeats_attence_group_detailRow">删除</a>
					</div>
					<div id="grid_ats_attence_group_detail" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" showPager="false"
					multiSelect="true" showColumnsMenu="true" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="userNo"  width="120" headerAlign="center" >员工编号
								<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" /></div>
							<div field="fullname"  width="120" headerAlign="center" >姓名
								<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" /></div>
							<div field="orgId"  width="120" headerAlign="center" >组织
								<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" /></div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	var grid = mini.get("grid_ats_attence_group_detail");
	var form = new mini.Form("#form1");
	var pkId = '${atsAttenceGroup.id}';
	var tenantId='<c:out value='${tenantId}' />';
	
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttenceGroup/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj = mini.decode(json);
					form.setData(jsonObj);
					var ary = jsonObj.atsAttenceGroupDetails;
					
					for(var i=0;i<ary.length;i++){
						var row = ary[i];
						row.fullname = row.fullName;
						row.orgId = row.orgName;
					}
					
					grid.setData(ary);
				}					
			});
		})
		
	function addats_attence_group_detailRow(){
		_UserDlg(false,function(user){
			var row = {};
			updateUserGroup(user)
		})
	}
		
	function updateUserGroup(user){
		if(user.length>1){//相同用户则更新
			grid.addRows(user);
			for(var i=0;i<user.length;i++){
				findUserGroup(user,i);
			}
		}else{
			findUserGroup(user,0);
		}
	}
	
	function findUserGroup(user,index){
		var row = grid.findRow(function(row){
		    if(row.userNo == user[index].userNo) return true;
		});
		if(row!=null){
			return;
		}
		$.ajax({
			type:'POST',
			url:"${ctxPath}/oa/ats/atsAttenceGroupDetail/getUserGroup.do",
			data:{"userId":user[index].pkId},
			success:function (json) {
				user[index]["orgId"]=json;
				grid.addRows(user);
			}
		});
		
	}
		
	function removeats_attence_group_detailRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.atsAttenceGroupDetails = grid.getData();		
		var config={
        	url:"${ctxPath}/oa/ats/atsAttenceGroup/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
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