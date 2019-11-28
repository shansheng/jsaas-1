<%-- 
    Document   : [数据批量录入]列表页
    Created on : 2019-01-02 10:49:42
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[数据批量录入]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="titleBar mini-toolbar" >
	 	<ul>
			<li>
				 <a class="mini-button" iconCls="icon-create" plain="true" onclick="add()">增加</a>
                 <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
                 <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
                 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
			</li>
			<li class="clearfix"></li>
		</ul>
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
						<li><span class="text">上传文件ID:</span><input class="mini-textbox" name="Q_UPLOAD_ID__S_LK"></li>
						<li><span class="text">批次ID:</span><input class="mini-textbox" name="Q_BAT_ID__S_LK"></li>
						<li><span class="text">服务名:</span><input class="mini-textbox" name="Q_SERVICE_NAME__S_LK"></li>
						<li><span class="text">子系统ID:</span><input class="mini-textbox" name="Q_APP_ID__S_LK"></li>
						<li><span class="text">类型:</span><input class="mini-textbox" name="Q_TYPE__S_LK"></li>
						<li><span class="text">EXCEL文件:</span><input class="mini-textbox" name="Q_EXCEL_ID__S_LK"></li>
						<li><span class="text">表名:</span><input class="mini-textbox" name="Q_TABLE_NAME__S_LK"></li>
						<li><span class="text">流程实例ID:</span><input class="mini-textbox" name="Q_INST_ID__S_LK"></li>
						<li><span class="text">流程实例状态:</span><input class="mini-textbox" name="Q_INST_STATUS__S_LK"></li>
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
			url="${ctxPath}/sys/core/sysDataBat/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="uploadId"  sortField="UPLOAD_ID_"  width="120" headerAlign="center" allowSort="true">上传文件ID</div>
				<div field="batId"  sortField="BAT_ID_"  width="120" headerAlign="center" allowSort="true">批次ID</div>
				<div field="serviceName"  sortField="SERVICE_NAME_"  width="120" headerAlign="center" allowSort="true">服务名</div>
				<div field="appId"  sortField="APP_ID_"  width="120" headerAlign="center" allowSort="true">子系统ID</div>
				<div field="type"  sortField="TYPE_"  width="120" headerAlign="center" allowSort="true">类型</div>
				<div field="excelId"  sortField="EXCEL_ID_"  width="120" headerAlign="center" allowSort="true">EXCEL文件</div>
				<div field="tableName"  sortField="TABLE_NAME_"  width="120" headerAlign="center" allowSort="true">表名</div>
				<div field="instId"  sortField="INST_ID_"  width="120" headerAlign="center" allowSort="true">流程实例ID</div>
				<div field="instStatus"  sortField="INST_STATUS_"  width="120" headerAlign="center" allowSort="true">流程实例状态</div>
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
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysDataBat" winHeight="450"
		winWidth="700" entityTitle="数据批量录入" baseUrl="sys/core/sysDataBat" />
</body>
</html>