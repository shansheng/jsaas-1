<%-- 
    Document   : [FORM_VALID_RULE]列表页
    Created on : 2018-11-27 22:58:37
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[FORM_VALID_RULE]列表管理</title>
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
                 <a class="mini-button"   plain="true" onclick="clearForm()">清空查询</a>
			</li>
			<li class="clearfix"></li>
		</ul>
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
						<li><span class="text">解决方案ID:</span><input class="mini-textbox" name="Q_SOL_ID__S_LK"></li>
						<li><span class="text">表单KEY:</span><input class="mini-textbox" name="Q_FORM_KEY__S_LK"></li>
						<li><span class="text">流程定义ID:</span><input class="mini-textbox" name="Q_ACT_DEF_ID__S_LK"></li>
						<li><span class="text">节点ID:</span><input class="mini-textbox" name="Q_NODE_ID__S_LK"></li>
						<li><span class="text">表单定义:</span><input class="mini-textbox" name="Q_JSON__S_LK"></li>
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
			url="${ctxPath}/bpm/form/formValidRule/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="solId"  sortField="SOL_ID_"  width="120" headerAlign="center" allowSort="true">解决方案ID</div>
				<div field="formKey"  sortField="FORM_KEY_"  width="120" headerAlign="center" allowSort="true">表单KEY</div>
				<div field="actDefId"  sortField="ACT_DEF_ID_"  width="120" headerAlign="center" allowSort="true">流程定义ID</div>
				<div field="nodeId"  sortField="NODE_ID_"  width="120" headerAlign="center" allowSort="true">节点ID</div>
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
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.form.entity.FormValidRule" winHeight="450"
		winWidth="700" entityTitle="FORM_VALID_RULE" baseUrl="bpm/form/formValidRule" />
</body>
</html>