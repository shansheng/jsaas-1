<%-- 
    Document   : [INS_MSG_DEF]列表页
    Created on : 2017-09-01 10:40:15
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>消息列表管理</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-toolbar" >
	<div class="searchBox">
		<form id="searchForm" class="search-form" >
			<ul>
				<li class="liAuto">
					<span class="text">标题：</span><input class="mini-textbox" name="Q_CONTENT__S_LK">
				</li>
				<li class="liBtn">
					<a class="mini-button " onclick="searchFrm()" >搜索</a>
					<a class="mini-button  btn-red" onclick="clearForm()" >清空</a>
				</li>
			</ul>
		</form>
	</div>
	<ul class="toolBtnBox toolBtnBoxTop">
		<li>
			<a class="mini-button"   onclick="add()">新增</a>
		</li>
		<li>
			<a class="mini-button"  onclick="edit()">编辑</a>
		</li>
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
		 url="${ctxPath}/oa/info/insMsgDef/listData.do" idField="msgId"
		 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
		<div property="columns">
			<div type="checkcolumn" width="20"></div>
			<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
			<div field="url"  sortField="URL_"  width="120" headerAlign="" allowSort="true">更多URl</div>
			<div field="content"  sortField="CONTENT_"  width="120" headerAlign="" allowSort="true">标题</div>
			<div field="sqlFunc"  sortField="SQL_FUNC_"  width="120" headerAlign="" allowSort="true">SQL语句</div>
			<div field="type"  sortField="TYPE_"  width="120" headerAlign="" allowSort="true">类型</div>
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
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.InsMsgDef" winHeight="450"
				   winWidth="700" entityTitle="消息" baseUrl="oa/info/insMsgDef" />
</body>
</html>