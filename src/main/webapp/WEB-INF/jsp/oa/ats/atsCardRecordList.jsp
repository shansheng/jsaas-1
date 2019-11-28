<%-- 
    Document   : [打卡记录]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[打卡记录]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li><span class="text">考勤编号：</span><input id="cardNumber" class="mini-textbox" name="Q_CARD_NUMBER_S_LK"></li>
					<li>
						<span class="text">打卡来源：</span>
						<input
							class="mini-combobox"
							name="Q_CARD_SOURCE_S_LK"
							showNullItem="true"
							emptyText="请选择..."
							data="[{id:'1',text:'企业微信'},{id:'0',text:'补打卡'},{id:'2',text:'EXCEL'}]"
						/>
					</li>

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
						<li><span class="text">打卡位置：</span><input class="mini-textbox" name="Q_CARD_PLACE_S_LK"></li>
						<li>
							<span class="text">打卡日期 从：</span><input id="startTime" name="Q_CARD_DATE_D_GE"  class="mini-datepicker" format="yyyy-MM-dd" />
						</li>
						<li>
							<span class="text-to">至： </span><input id="endTime" name="Q_CARD_DATE_D_LE" class="mini-datepicker" format="yyyy-MM-dd"  />
						</li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button" plain="true" onclick="add()">新增</a>
			</li>
			<li>
				<a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
			</li>
			<li>
				<f:a alias="atsCardImport"  showNoRight="false" onclick="importData()">导入</f:a>
			</li>
			<li>
				<a class="mini-button"  plain="true" onclick="exportData()">导出</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsCardRecord/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="cardNumber"   width="120" headerAlign="" allowSort="false">考勤编号</div>
				<div field="userName" width="120" headerAlign="" allowSort="false">员工姓名</div>
				<div field="cardDate" sortField="CARD_DATE"  width="120" headerAlign="" allowSort="true" dateFormat="yyyy-MM-dd" renderer="onDateRenderer">打卡日期</div>
				<div field="cardTime"   width="120" headerAlign="" renderer="onTimeRenderer">打卡时间</div>
				<div field="cardSource"  sortField="CARD_SOURCE"  width="120" headerAlign="" allowSort="true" renderer="onCardSourceRenderer">打卡来源</div>
				<div field="cardPlace"  sortField="CARD_PLACE"  width="120" headerAlign="" allowSort="true">打卡位置</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function onCardSourceRenderer(e) {
            var record = e.record;
            var cardSource = record.cardSource;
             var arr = [{'key' : '0', 'value' : '补打卡'}, 
    			        {'key' : '1','value' : '企业微信'},
    			        {'key' : '2','value' : 'EXCEL'}];
    			return $.formatItemValue(arr,cardSource);
        }
		
		//导入打卡记录
		function importData(){
			AtsImport({
				url:'${ctxPath}/oa/ats/atsCardRecord/WebUploader.do',
				title:'打卡记录导入'
			});
		}
		
		//导出打卡记录
		function exportData(){
			var startTime = mini.get("startTime").text;
			var endTime = mini.get("endTime").text;
			var cardNumber = mini.get("cardNumber").value;
			location.href="${ctxPath}/oa/ats/atsCardRecord/exportData.do?Q_CARD_DATE_D_GE="+startTime+"&Q_CARD_DATE_D_LE="+endTime+
					"&Q_CARD_NUMBER_S_LK="+cardNumber;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsCardRecord" winHeight="450"
		winWidth="700" entityTitle="打卡记录" baseUrl="oa/ats/atsCardRecord" />
</body>
</html>