<%-- 
    Document   : [考勤计算设置]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[考勤计算设置]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body> 
	<div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm">
				<ul>
					<li>
						<span class="text">考勤制度:</span><input id="attencePolicy" class="mini-buttonedit" name="Q_ATTENCE_POLICY_S_LK" class="icon-dep-button" 
						value="${atsAttencePolicy.id }" text="${atsAttencePolicy.name }" required="true" allowInput="false" onbuttonclick="onSelAttencePolicy" >
					</li>
					<li>
						<span class="text">考勤组:</span><input class="mini-buttonedit" name="Q_GROUP_ID_S_LK" class="icon-dep-button" 
						 required="true" allowInput="false" onbuttonclick="onSelAttenceGroup">
					 </li>
					<li>
						<span class="text">姓名:</span><input class="mini-textbox" name="Q_FULLNAME__S_LK">
					</li>
					<li>
						<span class="text">组织:</span><input class="mini-buttonedit" name="Q_GROUP_ID__S_LK" class="icon-dep-button" 
						 required="true" allowInput="false" onbuttonclick="selectMainDep">
					 </li>
					<li><a class="mini-button"   plain="true" onclick="searchFrm()">查询</a></li>
					<li class="clearfix"></li>
				</ul>
			</form>
		</div>
		<ul class="toolBtnBox"></ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
         </span>
	</div>
	<div class="mini-fit">
		<div id="user_datagrid" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" onselectionchanged="rowChange"
			url="${ctxPath}/oa/ats/atsAttenceCalculateSet/userListData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div field="fileId" width="120" headerAlign="center" allowSort="true">考勤编号</div>
				<div field="userNo"    width="120" headerAlign="center" allowSort="true">员工编号</div>
				<div field="fullName"    width="120" headerAlign="center" allowSort="true">员工姓名</div>
				<div field="orgName"   width="120" headerAlign="center" allowSort="true">所属组织</div>
			</div>
		</div>
	</div>

<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	var tenantId='<c:out value='${tenantId}' />';
	
	mini.parse();

	var user_datagrid = mini.get("user_datagrid");

	user_datagrid.load();
	
	function GetData() {
		var row = user_datagrid.getSelecteds();
		return row;
	}
	
	function rowChange(){
		window.parent.userAry = GetData();
		var attence = mini.get("attencePolicy").text;
		window.parent.attencePolicy = attence;
	}
	
	
	</script>
	<redxun:gridScript gridId="user_datagrid" entityName="com.redxun.oa.ats.entity.AtsAttenceCalculateSet" winHeight="450"
		winWidth="700" entityTitle="考勤计算设置" baseUrl="oa/ats/atsAttenceCalculateSet" />
</body>
</html>