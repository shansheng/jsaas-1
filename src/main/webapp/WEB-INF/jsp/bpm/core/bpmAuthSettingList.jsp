<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>流程授权管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li class="liAuto">
						<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"  />
					</li>
					<li class="liBtn">
						<a class="mini-button " onclick="searchForm(this)" >搜索</a>
						<a class="mini-button  btn-red" onclick="onClearList(this)">清空</a>
					</li>
				</ul>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button"    onclick="add()">新增</a>
			</li>
			<li>
				<a class="mini-button btn-red"   onclick="remove()">删除</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
	</div>
	<div class="mini-fit rx-grid-fit" style="height: 100%;">
		<div 
			id="datagrid1" 
			class="mini-datagrid"
			style="width: 100%; height: 100%;" 
			allowResize="false"
			url="${ctxPath}/bpm/core/bpmAuthSetting/listJson.do" 
			idField="id"
			multiSelect="true" 
			showColumnsMenu="true"
			sizeList="[5,10,20,50,100,200,500]" 
			pageSize="20"
			allowAlternating="true" 
			pagerButtons="#pagerButtons"
		>
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center"  align="center" ></div>
				<div 
					name="action" 
					cellCls="actionIcons" 
					width="100"
					renderer="onActionRenderer"
					cellStyle="padding:0;"
				>操作</div>
				<div field="name" width="120"  sortField="NAME_" allowSort="true">授权名称</div>
				<div  width="120"  renderer="onEnableRenderer" >启用</div>
				<div field='createTime' dateFormat="yyyy-MM-dd HH:mm:ss"  width="120"  allowSort="true" sortField="CREATE_TIME_">创建时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function onClear(){
			$("#searchForm")[0].reset();
			grid.setUrl("${ctxPath}/bpm/core/bpmAuthSetting/listJson.do");
			grid.load();
		}
	
		function onEnableRenderer(e){
			var record = e.record;
			var state = record.enable;
			var arr = [ { 'key' : 'yes','value' : '启用','css' : 'green'}, 
			            {'key' : 'no', 'value' : '禁止','css' : 'red'} ];
			return $.formatItemValue(arr,state);
		}	
	
	
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+ ' <span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+ ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
	</script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.bpm.core.entity.BpmAuthSetting" winHeight="450"
		winWidth="700" entityTitle="权限设定"
		baseUrl="bpm/core/bpmAuthSetting" />
</body>
</html>