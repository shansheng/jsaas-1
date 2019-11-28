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
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>	
					<li><span class="text">用户：</span><input class="mini-textbox" name="Q_FULLNAME__S_LK"></li>
					<li><span class="text">组织：</span><input name="Q_GROUP_ID__S_LK" class="mini-buttonedit icon-dep-button" value="${mainDepId}"
					text="${mainDepName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/></li>
					<li class="liBtn">
						<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
						<a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
						<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li><span class="text">员工编号：</span><input class="mini-textbox" name="Q_USER_ID_S_LK"></li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button"  plain="true" onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-button btn-red" plain="true" onclick="remove()">删除</a>
			</li>

			<li>
				<a class="mini-button"  plain="true" onclick="disUser()">未建档案人员</a>
			</li>
			<li>
				<a class="mini-button"  plain="true" onclick="upload()">导入</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsAttendanceFile/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="120"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="userName"  sortField="USER_ID"  width="120" headerAlign="" allowSort="true">用户</div>
				<div field="orgName"  sortField="orgId"  width="120" headerAlign="" allowSort="true">组织</div>
				<div field="userNo"  sortField="USER_NO_"  width="120" headerAlign="" allowSort="true">员工编号</div>
				<div field="isAttendance"  sortField="IS_ATTENDANCE"  width="120" headerAlign="" allowSort="true" renderer="onIsAttendanceRenderer">是否参与考勤</div>
				<div field="attencePolicyName"  sortField="ATTENCE_POLICY"  width="120" headerAlign="" allowSort="true">考勤制度</div>
				<div field="holidayPolicyName"  sortField="HOLIDAY_POLICY"  width="120" headerAlign="" allowSort="true">假期制度</div>
				<div field="defaultShiftName"  sortField="DEFAULT_SHIFT"  width="120" headerAlign="" allowSort="true">默认班次</div>
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
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		//绘制是否为系统预置
		function onIsAttendanceRenderer(e) {
            var record = e.record;
            var isAttendance = record.isAttendance;
             var arr = [{'key' : '1', 'value' : '是','css' : 'red'}, 
    			        {'key' : '0','value' : '否','css' : 'green'}];
    			return $.formatItemValue(arr,isAttendance);
        }
		
		//进入未建立档案人员页面
		function disUser(){
			location.href = "${ctxPath}/oa/ats/atsAttendanceFile/disUser.do";
		}
		
		//显示上传目录
    	function upload(){
    		AtsImport({
    			url:'${ctxPath}/oa/ats/atsAttendanceFile/WebUploader.do',
    			title:'考勤档案导入'
    		});
    	}
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttendanceFile" winHeight="450"
		winWidth="700" entityTitle="考勤档案" baseUrl="oa/ats/atsAttendanceFile" />
</body>
</html>