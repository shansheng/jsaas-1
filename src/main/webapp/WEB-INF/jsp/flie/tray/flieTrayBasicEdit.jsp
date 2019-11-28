<%-- 
    Document   : DocFolder编辑页
    Created on : 2018年6月18日16:23:44
    Author     : 杨义
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>文件夹编辑</title>
<%@include file="/commons/edit.jsp"%>
<!DOCTYPE html>
</head>	
<body>
	<rx:toolbar toolbarId="toolbar1"  hideRecordNav="true" ></rx:toolbar>
	<div id="p1" class="form-outer shadowBox" style="width: 90%">
		<form id="form1" method="post">
			<div class="form-inner">
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>文件夹基本信息</caption>
					<tr>
						<th>
							<span class="starBox">
								文档名称
								<span class="star">*</span>
							</span> 
						</th>
						<td colspan="3"><input name="fileTrayName" value="${flieTrayBasic.fileTrayName}"
							class="mini-textbox" vtype="maxLength:128" style="width: 90%"
							required="true" emptyText="请输入文档名称" />

						</td>
					</tr>
						<tr class="updateAdmin">
						<th>
							<span class="starBox">
								管理员
							</span> 
						</th>
					<td colspan="3"><input name="adminName" value="${flieTrayBasic.adminName}" readonly="readonly"
							class="mini-textbox" vtype="maxLength:128" style="width: 90%"
							required="true" emptyText="" /><a class="mini-button" href="javascript:void(0)"><span class="mini-button-text" id="chooseAdmin">选择</span></a></td>
						</tr>

					<tr style="display:none;">
						<th>父  目  录 </th>
						<td><input name="parent" value="${flieTrayBasic.parent}"
								   class="mini-textbox" vtype="maxLength:64" style="width: 90%" />

						</td>
					</tr>

					<tr class="updateAdmin">
						<th>
							<span class="starBox">
								管理员id
							</span> 
						</th>
						<td colspan="3"><input name="adminId" value="${flieTrayBasic.adminId}" readonly="readonly"
							class="mini-textbox" vtype="maxLength:128" style="width: 90%"
							required="true" emptyText="" />

						<input name="adminIdOld" value="${flieTrayBasic.adminId}"  readonly="readonly"
							class="mini-textbox" vtype="maxLength:128" style="width: 90%;display:none"
							required="true" emptyText="" />

					</tr>
							<tr style="display:none">
						<th>
							<span class="starBox">
								创建时间
							</span> 
						</th>
						<td colspan="3"><input name="createTimeOpen" value="${flieTrayBasic.createTime}" readonly="readonly"
							class="mini-textbox" vtype="maxLength:128" style="width: 90%"
							required="true" emptyText="" />

						</td>
					</tr>
<!-- 					<tr > -->
<%-- 						<th>次　　序</th><td><input name="sn" value="${flieTrayBasic.sn}" class="mini-spinner"  minValue="0" maxValue="14"  /></td> --%>
<!-- 					</tr> -->
                   	 <tr class="updateAdmin">
						<th>管理员机构号 </th>
						<td><input name="tenantId" value="${flieTrayBasic.tenantId}"
							class="mini-textbox" vtype="maxLength:64" style="width: 90%"
							required="true"  readonly />

						</td> 
					</tr>
					<tr >
						<th >文档描述 </th>
						<td colspan="3"><textarea name="descp" class="mini-textarea" vtype="maxLength:256" style="width: 90%"  >${flieTrayBasic.descp}</textarea></td>
					</tr>

					
					
					 <tr style="display:none;">
						<th>pkID
						</th>
						<td><input name="id" value="${flieTrayBasic.id}"
							class="mini-textbox" vtype="maxLength:64" style="width: 90%"
							required="true" emptyText="请输入用户ID" />

						</td> 
					</tr>
				</table>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
     mini.parse();
     addBody();
     var pageType="${pageType}";
     window.onload = function()
     {
    	 if(pageType=="new")
    		 {
    		 $(".updateAdmin").css("display","none");
    		 }
     }
	$("#chooseAdmin").click(function()
	{
			_UserDlg(false,function(users){
				var ids=[];
				var names=[];
				var tenantId=[];
				for(var i=0;i<1;i++){
					ids.push(users[i].userId);
					names.push(users[i].fullname);
					console.log(users[i].tenantId);
					tenantId.push(users[i].tenantId)
				}
				setValue("user",ids.join(","),names.join(","),tenantId.join(","));
			});
	}		
	)
	
	function setValue(user,ids,name,tenantId)
	{
		$("input[name='adminId']").val(ids);
		$("input[name='adminName']").val(name);
		$("input[name='tenantId']").val(tenantId);
	}
	
	function _UserDlg(single,callback){
	_TenantUserDlg('',single,callback);
}
	/**
 * 按租用机构进行用户选择
 * @param tenantId 当前用户为指定的管理机构下的用户,才可以查询到指定的租用机构下的用户
 * @param single
 * @param callback 回调函数，返回选择的用户信息，当为单选时，
 * 返回单值，当为多选时，返回多个值
 */
function _TenantUserDlg(tenantId,single,callback){
	_OpenWindow({
		url:__rootPath+'/flie/tray/flieTrayBasic/dialog.do?single='+single+'&tenantId='+tenantId,
		height:450,
		width:1080,
		iconCls:'icon-user-dialog',
		title:'用户选择',
		ondestroy:function(action){
			if(action!='ok')return;
			var iframe = this.getIFrameEl();
            var users = iframe.contentWindow.getUsers();
            if(callback){
            	if(single && users.length>0){
            		callback.call(this,users[0]);
            	}else{
            		callback.call(this,users);
            	}
            }
		}
	});
}
	</script>
	<rx:formScript formId="form1" baseUrl="flie/tray/flieTrayBasic"  entityName="com.airdrop.flie.tray.entity.FlieTrayBasic"/>
</body>
</html>