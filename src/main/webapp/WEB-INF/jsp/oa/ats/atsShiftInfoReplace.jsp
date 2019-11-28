<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>班次信息列表管理</title>
<%@include file="/commons/list.jsp"%>
<style type="text/css">
	#holidayName{
		position: absolute;
		top: 25px;
		left: 210px;
	}
</style>
</head>
<body>

	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false"  style="width:100%" bodyStyle="border:0">
			<div class="southBtn" >
			     <a class="mini-button"     onclick="selectData()">确定</a>
				 <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
			</div>	 
		 </div>
		 <div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
		 <div>
	    	选择日期类型：
			<div id="dateType" class="mini-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
    			textField="text" valueField="id" value="1" 
   				 data="[{id:'1',text:'工作日'},{id:'2',text:'休息日'}<c:if test="${isHoliday}">,{id:'3',text:'法定假日'}</c:if>]" >
			</div>
			<c:if test="${isHoliday}">
			<select  id="holidayName">
				<option value="">-请选择-</option>
				<c:forEach items="${holidayNameSet}" var="holidayName">
					<option value="${holidayName}">${holidayName}</option>
				</c:forEach>
			</select>
			</c:if>
			</div>
		 	<div id="grid1" class="mini-datagrid"
				style="width: 100%; height: 100%;" idField="id" allowResize="true"
				borderStyle="border-left:0;border-right:0;"
				onrowdblclick="onRowDblClick">
				<div property="columns">
					<div type="indexcolumn" width="8%">序号</div>
					<div field="id" width="40%" headerAlign="center" >编号</div>
					<div field="name" width="40%" headerAlign="center" >名称</div>
				</div>
			</div>
		
		 </div>

	</div>
	
	<script type="text/javascript">
		mini.parse();

		var grid = mini.get("grid1");

		//动态设置URL Q_SUBJECT__S_LK

		grid.setUrl("${ctxPath}/oa/ats/atsShiftInfo/listData.do");
		//也可以动态设置列 grid.setColumns([]);

		grid.load();

		var params;
		
		function setData(data){
			params = data;
		}
		
		function selectData(){
			var ids =[],
			 	names =[],
			 	codes = [],
			 	shiftTimes =[],
				chIds = GetData();
			
			if(chIds!=null){
				ids.push(chIds.id);
				names.push(chIds.name);
				codes.push(chIds.code);
				shiftTimes.push(chIds.atsShiftTimes);
			}
			
			var dateType,
			shiftId = ids.join(","),
			title = names.join(","),holidayName ="";
			
			var dateTypes = mini.get("dateType");
			dateType = dateTypes.getValue();
			
			if(dateType == 1){
			
				if(shiftId== ""){
					alert("请选择班次!");
					return 
				}
			}else if(dateType == 3){
				holidayName = $('#holidayName').val();
			}
			
			
			var obj={start:params.start,
						dateType:dateType,
						shiftId :shiftId,
						title:title,
						holidayName:holidayName
					};
			window.CloseOwnerWindow(obj);
		}
		
		function GetData() {
			var row = grid.getSelected();
			return row;
		}
		function search() {
			var key = mini.get("key").getValue();
			grid.load({
				key : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function onRowDblClick(e) {
			selectData();
		}
		
		function CloseWindow(action) {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}

		function onOk() {
			CloseWindow("ok");
		}
		function onCancel() {
			CloseWindow("cancel");
		}
	</script>
</body>
</html>

