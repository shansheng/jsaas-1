<%-- 
    Document   : [流程超时节点表]列表页
    Created on : 2019-03-27 18:50:23
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[流程超时节点表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<ul id="exportMenu" class="mini-menu" style="display:none;">
		<li iconCls="icon-create" onclick="exportAllPage(this)">导出所有页</li>
		<li iconCls="icon-copyAdd" onclick="exportCurPage(this)">导出当前页</li>
	</ul>
	 <div class="titleBar mini-toolbar" >
	 	<ul>
			<li>
				 <a class="mini-button" iconCls="icon-create" plain="true" onclick="add()">增加</a>
                 <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
                 <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
                 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
				<a class="mini-menubutton" iconCls="icon-create" plain="true" menu="#exportMenu">导出</a>
			</li>
			<li class="clearfix"></li>
		</ul>
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
						<li><span class="text">解决方案ID:</span><input class="mini-textbox" name="Q_SOL_ID__S_LK"></li>
						<li><span class="text">流程实例ID:</span><input class="mini-textbox" name="Q_INST_ID__S_LK"></li>
						<li><span class="text">流程节点ID:</span><input class="mini-textbox" name="Q_NODE_ID__S_LK"></li>
						<li><span class="text">操作类型:</span><input class="mini-textbox" name="Q_OP_TYPE__S_LK"></li>
						<li><span class="text">操作内容:</span><input class="mini-textbox" name="Q_OP_CONTENT__S_LK"></li>
						<li><span class="text">超时时间:</span><input class="mini-textbox" name="Q_OVERTIME_S_LK"></li>
						<li><span class="text">节点状态:</span><input class="mini-textbox" name="Q_STATUS__S_LK"></li>
					<li class="clearfix"></li>
				</ul>
			</form>	
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/bpm/core/bpmOvertimeNode/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="solId"  sortField="SOL_ID_"  width="120" headerAlign="center" allowSort="true">解决方案ID</div>
				<div field="instId"  sortField="INST_ID_"  width="120" headerAlign="center" allowSort="true">流程实例ID</div>
				<div field="nodeId"  sortField="NODE_ID_"  width="120" headerAlign="center" allowSort="true">流程节点ID</div>
				<div field="opType"  sortField="OP_TYPE_"  width="120" headerAlign="center" allowSort="true">操作类型</div>
				<div field="opContent"  sortField="OP_CONTENT_"  width="120" headerAlign="center" allowSort="true">操作内容</div>
				<div field="OVERTIME"  sortField="OVERTIME"  width="120" headerAlign="center" allowSort="true">超时时间</div>
				<div field="status"  sortField="STATUS_"  width="120" headerAlign="center" allowSort="true">节点状态</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')"></span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)"></span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')"></span>';
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmOvertimeNode" winHeight="450"
		winWidth="700" entityTitle="流程超时节点表" baseUrl="bpm/core/bpmOvertimeNode" />
</body>
</html>