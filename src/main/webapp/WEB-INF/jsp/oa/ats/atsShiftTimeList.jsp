<%-- 
    Document   : [班次时间设置]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[班次时间设置]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
         <table style="width:100%;">
             <tr>
                 <td style="width:100%;">
                     <a class="mini-button"  plain="true" onclick="add()">增加</a>
                     <a class="mini-button"  plain="true" onclick="edit()">编辑</a>
                     <a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
                     <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                     <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
                 </td>
             </tr>
              <tr>
                  <td class="search-form" >
                     <ul>
						<li><span class="text">班次ID:</span><input class="mini-textbox" name="Q_SHIFT_ID_S_LK"></li>
						<li><span class="text">段次:</span><input class="mini-textbox" name="Q_SEGMENT_S_LK"></li>
						<li><span class="text">出勤类型:</span><input class="mini-textbox" name="Q_ATTENDANCE_TYPE_S_LK"></li>
						<li><span class="text">上班时间:</span><input class="mini-textbox" name="Q_ON_TIME_S_LK"></li>
						<li><span class="text">上班是否打卡:</span><input class="mini-textbox" name="Q_ON_PUNCH_CARD_S_LK"></li>
						<li><span class="text">上班浮动调整值（分）:</span><input class="mini-textbox" name="Q_ON_FLOAT_ADJUST_S_LK"></li>
						<li><span class="text">段内休息时间:</span><input class="mini-textbox" name="Q_SEGMENT_REST_S_LK"></li>
						<li><span class="text">下班时间:</span><input class="mini-textbox" name="Q_OFF_TIME_S_LK"></li>
						<li><span class="text">下班是否打卡:</span><input class="mini-textbox" name="Q_OFF_PUNCH_CARD_S_LK"></li>
						<li><span class="text">下班浮动调整值（分）:</span><input class="mini-textbox" name="Q_OFF_FLOAT_ADJUST_S_LK"></li>
						<li><span class="text">上班类型:</span><input class="mini-textbox" name="Q_ON_TYPE_S_LK"></li>
						<li><span class="text">下班类型:</span><input class="mini-textbox" name="Q_OFF_TYPE_S_LK"></li>
					</ul>
                  </td>
              </tr>
         </table>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsShiftTime/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="120"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="shiftId"  sortField="SHIFT_ID"  width="120" headerAlign="" allowSort="true">班次ID</div>
				<div field="segment"  sortField="SEGMENT"  width="120" headerAlign="" allowSort="true">段次</div>
				<div field="attendanceType"  sortField="ATTENDANCE_TYPE"  width="120" headerAlign="" allowSort="true">出勤类型</div>
				<div field="onTime"  sortField="ON_TIME"  width="120" headerAlign="" allowSort="true">上班时间</div>
				<div field="onPunchCard"  sortField="ON_PUNCH_CARD"  width="120" headerAlign="" allowSort="true">上班是否打卡</div>
				<div field="onFloatAdjust"  sortField="ON_FLOAT_ADJUST"  width="120" headerAlign="" allowSort="true">上班浮动调整值（分）</div>
				<div field="segmentRest"  sortField="SEGMENT_REST"  width="120" headerAlign="" allowSort="true">段内休息时间</div>
				<div field="offTime"  sortField="OFF_TIME"  width="120" headerAlign="" allowSort="true">下班时间</div>
				<div field="offPunchCard"  sortField="OFF_PUNCH_CARD"  width="120" headerAlign="" allowSort="true">下班是否打卡</div>
				<div field="offFloatAdjust"  sortField="OFF_FLOAT_ADJUST"  width="120" headerAlign="" allowSort="true">下班浮动调整值（分）</div>
				<div field="onType"  sortField="ON_TYPE"  width="120" headerAlign="" allowSort="true">上班类型</div>
				<div field="offType"  sortField="OFF_TYPE"  width="120" headerAlign="" allowSort="true">下班类型</div>
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
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsShiftTime" winHeight="450"
		winWidth="700" entityTitle="班次时间设置" baseUrl="oa/ats/atsShiftTime" />
</body>
</html>