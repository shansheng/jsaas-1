<%-- 
    Document   : [考勤周期]列表页
    Created on : 2018-03-23 14:36:39
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[考勤周期]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm">
				<ul>
						<li><span class="text">编码:</span><input class="mini-textbox" name="Q_CODE_S_LK"></li>
						<li><span class="text">名称:</span><input class="mini-textbox" name="Q_NAME_S_LK"></li>
						<li><span class="text">周期类型:</span>
						<input 
							class="mini-combobox" 
							name="Q_TYPE_S_LK"
						    showNullItem="true"  
						    emptyText="请选择..."
							data="[{id:'1',text:'自然月'},{id:'0',text:'月(固定日期)'}]"
						/></li>
						<li><span class="text">是否默认:</span>
						<input 
							class="mini-combobox" 
							name="Q_IS_DEFAULT_S_LK"
						    showNullItem="true"  
						    emptyText="请选择..."
							data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
						/></li>
					</ul>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li><a class="mini-button"  plain="true" onclick="add()">增加</a></li>
            <li><a class="mini-button"  plain="true" onclick="edit(true)">编辑</a></li>
            <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
            <li><a class="mini-button"   plain="true" onclick="searchFrm()">查询</a></li>
            <li><a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a></li>
            <li><a class="mini-button"  plain="true" onclick="back()">返回</a></li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
	</div>
	<div class="mini-fit">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsAttenceCycle/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"  headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="code"  sortField="CODE"  width="120" headerAlign="" allowSort="true">编码</div>
				<div field="name"  sortField="NAME"  width="120" headerAlign="" allowSort="true">名称</div>
				<div field="type"  sortField="TYPE"  width="120" headerAlign="" allowSort="true" renderer="onTypeRenderer">周期类型</div>
				<div field="startYear"  width="120" headerAlign="" allowSort="true">开始周期</div>
				<div field="startMonth"  sortField="START_MONTH"  width="120" headerAlign="" allowSort="true">周期开始日期</div>
				<div field="isDefault"  sortField="IS_DEFAULT"  width="120" headerAlign="" allowSort="true" renderer="onIsDefaultRenderer">是否默认</div>
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
		
		function onTypeRenderer(e){
			var record = e.record;
	        var type = record.type;
	        var arr = [{'key' : '1', 'value' : '自然月','css' : 'red'}, 
	     	        {'key' : '0','value' : '月(固定日期)','css' : 'green'}];
	     	return $.formatItemValue(arr,type);
		}
		
		function onIsDefaultRenderer(e) {
	        var record = e.record;
	        var isDefault = record.isDefault;
	        var arr = [{'key' : '1', 'value' : '是','css' : 'red'}, 
	     	        {'key' : '0','value' : '否','css' : 'green'}];
	     	return $.formatItemValue(arr,isDefault);
	    }
		
		function back(){
			history.back(-1);
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttenceCycle" winHeight="450"
		winWidth="700" entityTitle="考勤周期" baseUrl="oa/ats/atsAttenceCycle" />
</body>
</html>