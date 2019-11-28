<%-- 
    Document   : [流程数据绑定表]列表页
    Created on : 2018-07-24 17:46:42
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[流程数据绑定表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-layout" style="width: 100%;height: 100%">
	<div region="center" showSplitIcon="false" showHeader="false">
     <div class=" mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK">
					</li>
					<li>
						<span class="text">别名：</span><input class="mini-textbox" name="Q_KEY__S_LK">
					</li>

					<li class="liBtn">
						<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
						<a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空</a>
						<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li>
							<span class="text">请求方式：</span>
							<input  name="Q_MODE__S_LK" class="mini-combobox"  showNullItem="true"   emptyText="请选择..."
									url="${ctxPath}/sys/webreq/sysWebReqDef/getSelectData.do?key=MODE" />
						</li>
						<li>
							<span class="text">请求类型：</span>
							<input  name="Q_TYPE__S_LK" class="mini-combobox"  showNullItem="true"  emptyText="请选择..."
									url="${ctxPath}/sys/webreq/sysWebReqDef/getSelectData.do?key=TYPE" />
						</li>
						<li>
							<span class="text">状态：</span>
							<input  name="Q_STATUS__S_LK" class="mini-combobox"  showNullItem="true"   emptyText="请选择..."
									url="${ctxPath}/sys/webreq/sysWebReqDef/getSelectData.do?key=STATUS"/>
						</li>
					</ul>
				</div>
			</form>
		</div>
		 <ul class="toolBtnBox">
			 <li><a class="mini-button" plain="true" onclick="add()">增加</a></li>
			 <li><a class="mini-button"  plain="true" onclick="edit(true)">编辑</a></li>
			 <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
		 </ul>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		 </span>
     </div>
	
		<div class="mini-fit" style="height: 100%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				url="${ctxPath}/sys/webreq/sysWebReqDef/listData.do" idField="id"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="120"  align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="name"  sortField="NAME_"  width="120"  allowSort="true">名称</div>
					<div field="key"  sortField="KEY_"  width="120"  allowSort="true">别名</div>
					<div field="mode"  sortField="MODE_"  width="120"  allowSort="true">请求方式</div>
					<div field="type"  sortField="TYPE_"  width="120"  allowSort="true">请求类型</div>
					<div field="status"  sortField="STATUS_"  width="120"  allowSort="true" renderer="onIsStatusRenderer">状态</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function onIsStatusRenderer(e) {
	        var record = e.record;
	        var status = record.status;
	        var arr = [{'key' : '1', 'value' : '启动','css' : 'green'}, 
	     	        {'key' : '0','value' : '禁用','css' : 'red'}];
	     	return $.formatItemValue(arr,status);
	    }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.webreq.entity.SysWebReqDef" winHeight="450"
		winWidth="700" entityTitle="流程数据绑定表" baseUrl="sys/webreq/sysWebReqDef" />
</body>
</html>