<%-- 
    Document   : [问卷信息]列表页
    Created on : 2019-10-16 10:18:37
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[问卷信息]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<ul id="exportMenu" class="mini-menu" style="display:none;">
		<li  onclick="exportAllPage(this)">导出所有页</li>
		<li  onclick="exportCurPage(this)">导出当前页</li>
	</ul>
	 <div class="mini-toolbar" >
	 	<ul class="toolBtnBox">
			<li>
				 <a class="mini-button" plain="true" onclick="add()">增加</a>
                 <a class="mini-button" plain="true" onclick="edit()">编辑</a>
                 <a class="mini-button btn-red" plain="true" onclick="remove()">删除</a>
                 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
				<a class="mini-menubutton" plain="true" menu="#exportMenu">导出</a>
			</li>
		</ul>
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
						<li><span class="text">问卷名称:</span><input class="mini-textbox" name="Q_F_QUESTIONNAIRE_NAME_S_LK"></li>
						<li><span class="text">问卷类型ID:</span><input class="mini-textbox" name="Q_F_QUESTIONNAIRE_TYPE_S_LK"></li>
						<li><span class="text">问卷类型:</span><input class="mini-textbox" name="Q_F_QUESTIONNAIRE_TYPE_name_S_LK"></li>
						<li><span class="text">问卷主题:</span><input class="mini-textbox" name="Q_F_QUESTIONNAIRE_THEME_S_LK"></li>
						<li>
							<span class="text">开始时间 从</span>:<input  name="Q_F_STARTDATE_D_GE"  class="mini-datepicker" format="yyyy-MM-dd" style="width:100px"/>
						</li>
						<li>
							<span class="text-to">至: </span><input  name="Q_F_STARTDATE_D_LE" class="mini-datepicker" format="yyyy-MM-dd" style="width:100px" />
						</li>
						<li>
							<span class="text">结束时间 从</span>:<input  name="Q_F_ENDDATE_D_GE"  class="mini-datepicker" format="yyyy-MM-dd" style="width:100px"/>
						</li>
						<li>
							<span class="text-to">至: </span><input  name="Q_F_ENDDATE_D_LE" class="mini-datepicker" format="yyyy-MM-dd" style="width:100px" />
						</li>
						<li><span class="text">创建人:</span><input class="mini-textbox" name="Q_F_CREATOR_S_LK"></li>
						<li><span class="text">外键:</span><input class="mini-textbox" name="Q_REF_ID__S_LK"></li>
						<li><span class="text">父ID:</span><input class="mini-textbox" name="Q_PARENT_ID__S_LK"></li>
						<li><span class="text">流程实例ID:</span><input class="mini-textbox" name="Q_INST_ID__S_LK"></li>
						<li><span class="text">状态:</span><input class="mini-textbox" name="Q_INST_STATUS__S_LK"></li>
						<li><span class="text">组ID:</span><input class="mini-textbox" name="Q_GROUP_ID__S_LK"></li>
				</ul>
			</form>	
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/wxrepair/core/patrolQuestionnaireInfo/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="questionnaireName"  sortField="F_QUESTIONNAIRE_NAME"  width="120" headerAlign="center" allowSort="true">问卷名称</div>
				<div field="questionnaireType"  sortField="F_QUESTIONNAIRE_TYPE"  width="120" headerAlign="center" allowSort="true">问卷类型ID</div>
				<div field="questionnaireTypeName"  sortField="F_QUESTIONNAIRE_TYPE_name"  width="120" headerAlign="center" allowSort="true">问卷类型</div>
				<div field="questionnaireTheme"  sortField="F_QUESTIONNAIRE_THEME"  width="120" headerAlign="center" allowSort="true">问卷主题</div>
				<div field="startdate" sortField="F_STARTDATE" dateFormat="yyyy-MM-dd HH:mm:ss" width="120" headerAlign="center" allowSort="true">开始时间</div>
				<div field="enddate" sortField="F_ENDDATE" dateFormat="yyyy-MM-dd HH:mm:ss" width="120" headerAlign="center" allowSort="true">结束时间</div>
				<div field="creator"  sortField="F_CREATOR"  width="120" headerAlign="center" allowSort="true">创建人</div>
				<div field="refId"  sortField="REF_ID_"  width="120" headerAlign="center" allowSort="true">外键</div>
				<div field="parentId"  sortField="PARENT_ID_"  width="120" headerAlign="center" allowSort="true">父ID</div>
				<div field="instId"  sortField="INST_ID_"  width="120" headerAlign="center" allowSort="true">流程实例ID</div>
				<div field="instStatus"  sortField="INST_STATUS_"  width="120" headerAlign="center" allowSort="true">状态</div>
				<div field="groupId"  sortField="GROUP_ID_"  width="120" headerAlign="center" allowSort="true">组ID</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.airdrop.wxrepair.core.entity.PatrolQuestionnaireInfo" winHeight="450"
		winWidth="700" entityTitle="问卷信息" baseUrl="wxrepair/core/patrolQuestionnaireInfo" />
</body>
</html>