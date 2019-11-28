<%-- 
    Document   : [权限转移日志表]列表页
    Created on : 2018-06-20 17:12:34
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[权限转移日志表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm">
				<span>权限转移人:</span><input id="userIdEditA" name="Q_AUTHOR_PERSON__S_LK" value="${osUser.userId }" text="${osUser.fullname }" required="true" 
							class="mini-buttonedit" emptyText="请输入..."  allowInput="false" onbuttonclick="onSelectUser('userIdEditA')"/>
				<span>目标转移人:</span><input id="userIdEditB" name="Q_TARGET_PERSON__S_LK" value="" text="" required="true" 
							class="mini-buttonedit" emptyText="请输入..."  allowInput="false" onbuttonclick="onSelectUser('userIdEditB')"/>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
            <li><a class="mini-button btn-red"  plain="true" onclick="removeAll()">清空日志</a></li>
            <li><a class="mini-button"   plain="true" onclick="searchFrm()">查询</a></li>
            <li><a class="mini-button"  plain="true" onclick="back()">返回</a></li>
		</ul>
	 	<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
         </span>
	</div>
	<div class="mini-fit">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/translog/sysTransferLog/listDataUser.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div field="opDescp"  sortField="OP_DESCP_"  width="120" headerAlign="center" allowSort="true">操作描述</div>
				<div field="authorPersonName"  sortField="AUTHOR_PERSON_"  width="120" headerAlign="center" allowSort="true">权限转移人</div>
				<div field="targetPersonName"  sortField="TARGET_PERSON_"  width="120" headerAlign="center" allowSort="true">目标转移人</div>
				<div field="createTime"  sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss"  width="120" headerAlign="center" allowSort="true">创建时间</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var tenantId = '${tenantId}';	
	
		function back(){
			history.back(-1);
		}
		
		function onSelectUser(name){
			_TenantUserDlg(tenantId,true,function(user){
				var userIdEdit=mini.get(name);
				if(user){
					userIdEdit.setValue(user.userId);
					userIdEdit.setText(user.fullname);
				}
			});
		}
		
		function removeAll(){
			_SubmitJson({
	        	url:__rootPath+"/sys/translog/sysTransferLog/removeAll.do",
	        	method:'POST',
	        	success: function(text) {
	                grid.load();
	            }
	         });
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.translog.entity.SysTransferLog" winHeight="450"
		winWidth="700" entityTitle="权限转移日志表" baseUrl="sys/translog/sysTransferLog" />
</body>
</html>