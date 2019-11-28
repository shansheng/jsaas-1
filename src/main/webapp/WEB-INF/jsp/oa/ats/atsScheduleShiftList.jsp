<%-- 
    Document   : [排班列表]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[排班列表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">姓名：</span><input id="userId" name="Q_FULLNAME__S_LK" class="mini-buttonedit icon-dep-button"
						 required="true" allowInput="false" onbuttonclick="onSelectUser"/>
					<li>
						<span class="text">组织：</span><input name="Q_GROUP_ID__S_LK" class="mini-buttonedit icon-dep-button" value="${mainDepId}" 
						text="${mainDepName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/>
					</li>
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
						<li>
							<span class="text">考勤日期 从：</span><input  name="Q_ATTENCE_TIME_D_GE"  class="mini-datepicker" format="yyyy-MM-dd" />
						</li>
						<li>
							<span class="text-to">至：</span><input  name="Q_ATTENCE_TIME_D_LE" class="mini-datepicker" format="yyyy-MM-dd"  />
						</li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li><a class="mini-button btn-red" plain="true" onclick="remove()">删除</a></li>
			<li><a class="mini-button"  plain="true" onclick="getGuide()">排班向导</a></li>
			<li><a class="mini-button"  plain="true" onclick="importData()">导入</a></li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div> 
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			idField="id" url="${ctxPath}/oa/ats/atsScheduleShift/listData.do"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="fullName"  width="120" headerAlign="" allowSort="true">姓名</div>
				<div field="orgName"   width="120" headerAlign="" allowSort="true">所属组织</div>
				<div field="attenceTime" sortField="ATTENCE_TIME" dateFormat="yyyy-MM-dd HH:mm:ss" width="120" headerAlign="" allowSort="true">考勤日期</div>
				<div field="dateTypeName"  sortField="DATE_TYPE"  width="120" headerAlign="" allowSort="true">日期类型</div>
				<div field="shiftName"  sortField="SHIFT_ID"  width="120" headerAlign="" allowSort="true">班次名称</div>
				<div field="cardNumber"   width="120" headerAlign="" allowSort="true">员工编号</div>
				<div field="attencePolicyName"   width="120" headerAlign="" allowSort="true">考勤制度</div>
				<div field="cardRuleName"   width="120" headerAlign="" allowSort="true">取卡规则</div>
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
			var s = '<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		//跳转至排班向导
		function getGuide(){
			location.href="${ctxPath}/oa/ats/atsAttenceCalculateSet/wizard.do";
		}
		
		function onSelectUser(){
			_TenantUserDlg(tenantId,true,function(user){
				var userIdEdit=mini.get('userId');
				if(user){
					userIdEdit.setValue(user.fullname);
					userIdEdit.setText(user.fullname);
				}
			});
		}
		
		//导入排班
		function importData(){
			AtsImport({
				url:'${ctxPath}/oa/ats/atsScheduleShift/WebUploader.do',
				title:'排班列表导入'
			});
		}
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsScheduleShift" winHeight="450"
		winWidth="700" entityTitle="排班列表" baseUrl="oa/ats/atsScheduleShift" />
</body>
</html>