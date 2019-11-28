<%--
	time:2015-05-21 09:06:10
	desc:edit the 轮班规则
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>编辑 轮班规则</title>
	<%@include file="/commons/edit.jsp" %>
	<script type="text/javascript" src="${ctxPath}/scripts/ats/lang/zh_CN.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/ats/CustomValid.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
		var params;
		/*KILLDIALOG*/
		$(function() {
			$("a.save").click(function() {
				$.ajax({
					type : "POST",
					url : "${ctxPath}/oa/ats/atsAttenceCalculateSet/calculate.do",
					data : {
						ruleId:mini.get("ruleId").value,
						startNum:mini.get("startNum").value,
						startDate:params.startTime,
						endDate:params.endTime,
						startTime:mini.get("startTime").value,
						endTime:mini.get("endTime").value,
						holidayHandle:mini.get("holidayHandle").value
					},
					success : function(data) {
						var rtn = $.parseJSON(data);
						window.CloseOwnerWindow(rtn.data,rtn.beginCol);
					}
				});
			});
		});
		
		
		function setParam(params){
			this.params = params;
			mini.get('startTime').setValue(params.startTime);
			mini.get('endTime').setValue(params.endTime);
		}
		
		function getParam(){
			return params;
		}
		
		function selectShiftRule(e){
			onSelShiftRule({callback:function(rtn){
			
				$.ajax({
					type : "POST",
					url : "${ctxPath}/oa/ats/atsShiftRule/detail.do",
					data : {id:rtn.id},
					success : function(data) {
						var btnEdit=e.sender;
						btnEdit.setValue(rtn.id);
						btnEdit.setText(rtn.name);
						$('#detailList').val(data);
						var detailLists = $.parseJSON(data);
						grid.setData(detailLists);
					}
				});
			}});
		}
	</script>
</head>
<body>
<div class="topToolBar">
	<div>
		<a class="mini-button save"    id="dataFormSave" href="javaScript:void(0);">确定</a>
		<a class="mini-button close"   href="javaScript:CloseWindow('cancel');">取消</a>
	</div>
</div>
<div class="form-container">
	<form id="form1" method="post">
		<table class="table-detail column_2" cellspacing="1" cellpadding="0">
		<caption>添加轮班规则</caption>
		<tr>
			<td width="20%">轮班规则: </td>
			<td>
				<input id="ruleId" class="mini-buttonedit icon-dep-button" required="true" allowInput="false" onbuttonclick="selectShiftRule"/>
			</td>
			<td width="20%">轮班开始于: </td>
			<td><input class="mini-textbox" id="startNum" value="1"  /></td>				
		</tr>
		<tr>
			<td width="20%">开始时间: </td>
			<td>
				<input id="startTime" class="mini-datepicker" style="width:100%;" format="yyyy-MM-dd" valueType="String" minWidth="120"/>
			</td>
			<td width="20%">结束时间: </td>
			<td>
				<input id="endTime" class="mini-datepicker" style="width:100%;" format="yyyy-MM-dd" valueType="String" minWidth="120"/>
			</td>
		</tr>
		<tr>
			<td width="20%">节假日处理</td>
			<td>
				<input 
					id="holidayHandle"
					class="mini-combobox" 
					data="[{id:'1',text:'替换'},{id:'2',text:'不替换'},{id:'3',text:'顺延'}]"
					value="1"
				/>
			</td>
		</tr>
	</table>
		<textarea style="display: none" id="detailList" name="detailList"></textarea>	
	<div class="mini-fit" style="height: 300px;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			idField="sn"
			multiSelect="false" showColumnsMenu="false" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="false" pagerButtons="#pagerButtons">
			<div property="columns">
				<div field="sn"  width="120" headerAlign="center">序号</div>
				<div field="dateType"  width="120" headerAlign="center" renderer="onDateTypeRenderer">日期类型</div>
				<div field="shiftCode" width="120" headerAlign="center" >班次编码</div>
				<div field="shiftName" width="120" headerAlign="center">班次名称</div>
				<div field="shiftTime" width="120" headerAlign="center">上下班时间</div>
			</div>
		</div>
	</div>
	</form>
</div>
<script type="text/javascript">
	mini.parse();
	var grid = mini.get("datagrid1");

	 function onDateTypeRenderer(e) {
         var record = e.record;
         var dateType = record.dateType;
          var arr = [{'key' : '1', 'value' : '工作日'}, 
 			        {'key' : '2','value' : '休息日'},
 			        {'value' : '法定假日'}];
 			return $.formatItemValue(arr,dateType);
     }
</script>
</body>
</html>
