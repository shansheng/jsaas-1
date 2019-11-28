<%-- 
    Document   : [轮班规则明细]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[轮班规则明细]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		 <div class="searchBox">
			 <form action="" id="searchForm" class="search-form">
				 <ul>
					 <li><span class="text">班次ID:</span><input class="mini-textbox" name="Q_RULE_ID_S_LK"></li>
					 <li><span class="text">日期类型:</span><input class="mini-textbox" name="Q_DATE_TYPE_S_LK"></li>
					 <li class="liBtn">
						 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
						 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
						 <span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					 </li>
				 </ul>
				 <div id="moreBox">
					 <ul>
					 	<li><span class="text">班次ID:</span><input class="mini-textbox" name="Q_SHIFT_ID_S_LK"></li>
					 	<li><span class="text">上下班时间:</span><input class="mini-textbox" name="Q_SHIFT_TIME_S_LK"></li>
						 <li><span class="text">排序:</span><input class="mini-textbox" name="Q_SN_S_LK"></li>
					 </ul>
				 </div>
			 </form>
		 </div>
		 <ul class="toolBtnBox">
			 <li><a class="mini-button"  plain="true" onclick="add()">增加</a></li>
			 <li><a class="mini-button"  plain="true" onclick="edit()">编辑</a></li>
			 <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
		 </ul>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsShiftRuleDetail/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="ruleId"  sortField="RULE_ID"  width="120" headerAlign="" allowSort="true">班次ID</div>
				<div field="dateType"  sortField="DATE_TYPE"  width="120" headerAlign="" allowSort="true">日期类型</div>
				<div field="shiftId"  sortField="SHIFT_ID"  width="120" headerAlign="" allowSort="true">班次ID</div>
				<div field="shiftTime"  sortField="SHIFT_TIME"  width="120" headerAlign="" allowSort="true">上下班时间</div>
				<div field="sn"  sortField="SN"  width="120" headerAlign="" allowSort="true">排序</div>
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
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsShiftRuleDetail" winHeight="450"
		winWidth="700" entityTitle="轮班规则明细" baseUrl="oa/ats/atsShiftRuleDetail" />
</body>
</html>