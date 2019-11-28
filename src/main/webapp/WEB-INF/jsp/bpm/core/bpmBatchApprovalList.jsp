<%-- 
    Document   : [流程批量审批设置表]列表页
    Created on : 2018-06-27 15:19:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[流程批量审批设置表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		 <div class="searchBox">
			 <form id="searchForm" class="search-form" >
				 <ul>
					 <li><span class="text">流程方案名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
					 <li><span class="text">节点名称：</span><input class="mini-textbox" name="Q_NODE_NAME__S_LK"></li>
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
						 <li><span class="text">状态：</span><input
								 class="mini-combobox"
								 name="Q_STATUS__S_LK"
								 showNullItem="true"
								 emptyText="请选择..."
								 data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]"
						 /></li>
					 </ul>
				 </div>
			 </form>
		 </div>
		 <ul class="toolBtnBox">
			 <li>
				 <a class="mini-button"  plain="true" onclick="add()">新增</a>
			 </li>
			 <li>
				 <a class="mini-button" plain="true" onclick="edit()">编辑</a>
			 </li>
			 <li>
				 <a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
			 </li>
		 </ul>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/bpm/core/bpmBatchApproval/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="80"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="solName"  sortField="SOL_ID_"  width="120" headerAlign="" allowSort="true">流程方案</div>
				<div field="taskName"  sortField="NODE_ID_"  width="120" headerAlign="" allowSort="true">节点名称</div>
				<div field="status"  sortField="STATUS_"  width="120" headerAlign="" allowSort="true" renderer="onStatusRenderer">状态</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function onStatusRenderer(e) {
	        var record = e.record;
	        var status = record.status;
	        var arr = [{'key' : '1', 'value' : '启用','css' : 'green'}, 
	     	        {'key' : '0','value' : '禁用','css' : 'red'}];
	     	return $.formatItemValue(arr,status);
	    }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmBatchApproval" winHeight="450"
		winWidth="700" entityTitle="流程批量审批设置表" baseUrl="bpm/core/bpmBatchApproval" />
</body>
</html>