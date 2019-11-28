<%-- 
    Document   : [考勤档案]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[考勤档案]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		 <ul class="toolBtnBox">
			 <li><a class="mini-button"  plain="true" onclick="editDisUser()">编辑</a></li>
			 <li><a class="mini-button"   plain="true" onclick="searchFrm()">查询</a></li>
			 <li><a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a></li>
			 <li><a class="mini-button btn-red"   plain="true" onclick="back()">返回</a></li>
		 </ul>
		  <div class="searchBox" >
			 <ul>
				<li><span>用户：</span><input id="userId" name="Q_USER_ID_S_EQ" class="mini-buttonedit icon-dep-button"
				required="true" allowInput="false" onbuttonclick="onSelectUser"/></li>
				<li><span>组织：</span><input name="Q_GROUP_ID__S_EQ" class="mini-buttonedit icon-dep-button" value="${mainDepId}"
				text="${mainDepName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/></li>
			</ul>
		  </div>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsAttendanceFile/disUserList.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="userName"   width="120" headerAlign="center" allowSort="true">用户</div>
				<div field="userNo"  width="120" headerAlign="center" allowSort="true">员工编号</div>
				<div field="orgName"   width="120" headerAlign="center" allowSort="true">所属组织</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
		var tenantId='<c:out value='${tenantId}' />';
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var userId = record.userId;
			var s = '<span  title="编辑" onclick="editRowDisUser(\'' + userId + '\',true)">编辑</span>';
			return s;
		}
		
		function back(){
			location.href = "${ctxPath}/oa/ats/atsAttendanceFile/list.do";
		}
		
		function onSelectUser(){
			_TenantUserDlg(tenantId,true,function(user){
				var userIdEdit=mini.get('userId');
				if(user){
					userIdEdit.setValue(user.userId);
					userIdEdit.setText(user.fullname);
				}
			});
		}
		//编辑行数据
	    function editRowDisUser(userId,fullWindow) {    
			var width=700;
	    	var height=450;
	    	if(fullWindow){
	    		width=getWindowSize().width;
	    		height=getWindowSize().height;
	    	}

	    	_OpenWindow({
	    		 url: "${ctxPath}/oa/ats/atsAttendanceFile/editDisUser.do?userId="+userId,
	            title: "编辑考勤档案",
	            width: width, height: height,
	            ondestroy: function(action) {
	                if (action == 'ok') {
	                    grid.reload();
	                }
	            }
	    	});
	    }

		//编辑
	    function editDisUser(fullWindow) {
	        var row = grid.getSelecteds();
	                //行允许删除
	        if(rowEditAllow && !rowEditAllow(row)){
	        	return;
	        }
	        if (row) {
	        	var ids = [];
	        	for(var i=0;i<row.length;i++){
	        		ids.push(row[i].userId);
	        	}
	        	editRowDisUser(ids,fullWindow);
	        } else {
	            alert("请选中一条记录");
	        }
	        
	    }

	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttendanceFile" winHeight="450"
		winWidth="700" entityTitle="考勤档案" baseUrl="oa/ats/atsAttendanceFile" />
</body>
</html>