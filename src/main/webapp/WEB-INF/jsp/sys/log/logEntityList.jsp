<%-- 
    Document   : [日志实体]列表页
    Created on : 2017-09-21 14:43:53
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[日志实体]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >

		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">所属模块：</span><input class="mini-textbox" name="Q_MODULE__S_LK">
					</li>
					<li>
						<span class="text">功能：</span><input class="mini-textbox" name="Q_SUB_MODULE__S_LK">
					</li>
					<li class="liBtn">
						<a class="mini-button _search" onclick="searchFrm()" >搜索</a>
						<a class="mini-button _reset btn-red" onclick="clearForm()">清空</a>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li>
							<span class="text">操作名：</span><input class="mini-textbox" name="Q_ACTION__S_LK">
						</li>
						<li>
							<span class="text">操作IP：</span><input class="mini-textbox" name="Q_IP__S_LK">
						</li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button btn-red"   onclick="remove()">删除</a>
			</li>

		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/log/logEntity/myList.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="30"></div>
				<div name="action" cellCls="actionIcons" width="120" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="module"  sortField="MODULE_"  width="120" headerAlign="" allowSort="true">所属模块</div>
				<div field="subModule"  sortField="SUB_MODULE_"  width="120" headerAlign="" allowSort="true">功能</div>
				<div field="action"  sortField="ACTION_"  width="120" headerAlign="" allowSort="true">操作</div>
				<div field="ip"  sortField="IP_"  width="120" headerAlign="" allowSort="true">操作IP</div>
				<div field="createUser"  sortField="CREATE_USER_"  width="80" headerAlign="" allowSort="true">操作人</div>
				<div field="createTime"  sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss"  width="120" headerAlign="" allowSort="true">操作时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.log.entity.LogEntity" winHeight="450"
		winWidth="700" entityTitle="日志实体" baseUrl="sys/log/logEntity" />
</body>
</html>