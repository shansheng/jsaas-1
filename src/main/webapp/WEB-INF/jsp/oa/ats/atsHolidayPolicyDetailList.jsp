<%-- 
    Document   : [假期制度明细]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[假期制度明细]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
         <table style="width:100%;">
             <tr>
                 <td style="width:100%;">
                     <a class="mini-button" plain="true" onclick="add()">增加</a>
                     <a class="mini-button"  plain="true" onclick="edit()">编辑</a>
                     <a class="mini-button btn-red" plain="true" onclick="remove()">删除</a>
                     <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                     <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
                 </td>
             </tr>
              <tr>
                  <td class="search-form" >
                     <ul>
						<li><span class="text">假期制度ID:</span><input class="mini-textbox" name="Q_HOLIDAY_ID_S_LK"></li>
						<li><span class="text">假期类型:</span><input class="mini-textbox" name="Q_HOLIDAY_TYPE_S_LK"></li>
						<li><span class="text">假期单位:</span><input class="mini-textbox" name="Q_HOLIDAY_UNIT_S_LK"></li>
						<li><span class="text">启动周期:</span><input class="mini-textbox" name="Q_ENABLE_PERIOD_S_LK"></li>
						<li><span class="text">周期长度:</span><input class="mini-textbox" name="Q_PERIOD_LENGTH_S_LK"></li>
						<li><span class="text">周期单位:</span><input class="mini-textbox" name="Q_PERIOD_UNIT_S_LK"></li>
						<li><span class="text">控制单位额度:</span><input class="mini-textbox" name="Q_ENABLE_MIN_AMT_S_LK"></li>
						<li><span class="text">单位额度:</span><input class="mini-textbox" name="Q_MIN_AMT_S_LK"></li>
						<li><span class="text">是否允许补请假:</span><input class="mini-textbox" name="Q_IS_FILL_HOLIDAY_S_LK"></li>
						<li><span class="text">补请假期限:</span><input class="mini-textbox" name="Q_FILL_HOLIDAY_S_LK"></li>
						<li><span class="text">补请假期限单位:</span><input class="mini-textbox" name="Q_FILL_HOLIDAY_UNIT_S_LK"></li>
						<li><span class="text">是否允许销假:</span><input class="mini-textbox" name="Q_IS_CANCEL_LEAVE_S_LK"></li>
						<li><span class="text">销假期限:</span><input class="mini-textbox" name="Q_CANCEL_LEAVE_S_LK"></li>
						<li><span class="text">销假期限单位:</span><input class="mini-textbox" name="Q_CANCEL_LEAVE_UNIT_S_LK"></li>
						<li><span class="text">是否控制假期额度:</span><input class="mini-textbox" name="Q_IS_CTRL_LIMIT_S_LK"></li>
						<li><span class="text">假期额度规则:</span><input class="mini-textbox" name="Q_HOLIDAY_RULE_S_LK"></li>
						<li><span class="text">是否允许超额请假:</span><input class="mini-textbox" name="Q_IS_OVER_S_LK"></li>
						<li><span class="text">超出额度下期扣减:</span><input class="mini-textbox" name="Q_IS_OVER_AUTO_SUB_S_LK"></li>
						<li><span class="text">是否允许修改额度:</span><input class="mini-textbox" name="Q_IS_CAN_MODIFY_LIMIT_S_LK"></li>
						<li><span class="text">包括公休日:</span><input class="mini-textbox" name="Q_IS_INCLUDE_REST_S_LK"></li>
						<li><span class="text">包括法定假日:</span><input class="mini-textbox" name="Q_IS_INCLUDE_LEGAL_S_LK"></li>
						<li><span class="text">描述:</span><input class="mini-textbox" name="Q_MEMO_S_LK"></li>
					</ul>
                  </td>
              </tr>
         </table>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsHolidayPolicyDetail/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="holidayId"  sortField="HOLIDAY_ID"  width="120" headerAlign="center" allowSort="true">假期制度ID</div>
				<div field="holidayType"  sortField="HOLIDAY_TYPE"  width="120" headerAlign="center" allowSort="true">假期类型</div>
				<div field="holidayUnit"  sortField="HOLIDAY_UNIT"  width="120" headerAlign="center" allowSort="true">假期单位</div>
				<div field="enablePeriod"  sortField="ENABLE_PERIOD"  width="120" headerAlign="center" allowSort="true">启动周期</div>
				<div field="periodLength"  sortField="PERIOD_LENGTH"  width="120" headerAlign="center" allowSort="true">周期长度</div>
				<div field="periodUnit"  sortField="PERIOD_UNIT"  width="120" headerAlign="center" allowSort="true">周期单位</div>
				<div field="enableMinAmt"  sortField="ENABLE_MIN_AMT"  width="120" headerAlign="center" allowSort="true">控制单位额度</div>
				<div field="minAmt"  sortField="MIN_AMT"  width="120" headerAlign="center" allowSort="true">单位额度</div>
				<div field="isFillHoliday"  sortField="IS_FILL_HOLIDAY"  width="120" headerAlign="center" allowSort="true">是否允许补请假</div>
				<div field="fillHoliday"  sortField="FILL_HOLIDAY"  width="120" headerAlign="center" allowSort="true">补请假期限</div>
				<div field="fillHolidayUnit"  sortField="FILL_HOLIDAY_UNIT"  width="120" headerAlign="center" allowSort="true">补请假期限单位</div>
				<div field="isCancelLeave"  sortField="IS_CANCEL_LEAVE"  width="120" headerAlign="center" allowSort="true">是否允许销假</div>
				<div field="cancelLeave"  sortField="CANCEL_LEAVE"  width="120" headerAlign="center" allowSort="true">销假期限</div>
				<div field="cancelLeaveUnit"  sortField="CANCEL_LEAVE_UNIT"  width="120" headerAlign="center" allowSort="true">销假期限单位</div>
				<div field="isCtrlLimit"  sortField="IS_CTRL_LIMIT"  width="120" headerAlign="center" allowSort="true">是否控制假期额度</div>
				<div field="holidayRule"  sortField="HOLIDAY_RULE"  width="120" headerAlign="center" allowSort="true">假期额度规则</div>
				<div field="isOver"  sortField="IS_OVER"  width="120" headerAlign="center" allowSort="true">是否允许超额请假</div>
				<div field="isOverAutoSub"  sortField="IS_OVER_AUTO_SUB"  width="120" headerAlign="center" allowSort="true">超出额度下期扣减</div>
				<div field="isCanModifyLimit"  sortField="IS_CAN_MODIFY_LIMIT"  width="120" headerAlign="center" allowSort="true">是否允许修改额度</div>
				<div field="isIncludeRest"  sortField="IS_INCLUDE_REST"  width="120" headerAlign="center" allowSort="true">包括公休日</div>
				<div field="isIncludeLegal"  sortField="IS_INCLUDE_LEGAL"  width="120" headerAlign="center" allowSort="true">包括法定假日</div>
				<div field="memo"  sortField="MEMO"  width="120" headerAlign="center" allowSort="true">描述</div>
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
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsHolidayPolicyDetail" winHeight="450"
		winWidth="700" entityTitle="假期制度明细" baseUrl="oa/ats/atsHolidayPolicyDetail" />
</body>
</html>