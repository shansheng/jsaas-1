<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>手机门户类别列表</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >
         <ul class="toolBtnBox">
			<li>
				<a class="mini-button" onclick="add()">增加</a>
			</li>
			<li>
				<a class="mini-button" onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-button btn-red" onclick="remove()">删除</a>
			</li>
			<li class="clearfix"></li>
		</ul>
		<div class="searchBox">
			<form id="searchForm" class="search-form" >
				<ul>
					<li class="liAuto">
						<span>名字:</span>
						<input class="mini-textbox" name="Q_NAME__S_LK">
					</li>
					<li class="liBtn">
						<a class="mini-button " onclick="searchForm(this)">搜索</a>
						<a class="mini-button " onclick="onClearList(this)">清空</a>
					</li>
					<li class="clearfix"></li>
				</ul>
			</form>	
		</div>
    </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/wx/portal/wxPortal/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true"
			sizeList="[5,10,20,50,100]" pageSize="5"
			allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="60"
					renderer="onActionRenderer"
					cellStyle="padding:0;">操作</div>
				<div field="name" sortField="NAME_" width="120"
					allowSort="true">名字</div>
				<div field="typeId" sortField="TYPE_ID_" width="120"
					allowSort="true">标识</div>
			</div>
		</div>
	</div>
	
	<script>
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var key = record.key;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'+
				'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
	</script>

	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.wx.portal.entity.WxMobilePortal"
		winHeight="450" winWidth="700" entityTitle="手机门户类别列表"
		baseUrl="wx/portal/wxPortal" />
</body>
</html>