
<%-- 
    Document   : [假期制度]编辑页
    Created on : 2018-03-23 17:08:22
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[假期制度]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsHolidayPolicy.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsHolidayPolicy.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[假期制度]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsHolidayPolicy.code}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsHolidayPolicy.name}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							<input name="orgId" class="mini-buttonedit icon-dep-button" value="${atsHolidayPolicy.orgId}"  style="width:100%"
						text="${atsHolidayPolicy.orgName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/>
						</td>
					
						<td>是否默认：</td>
						<td>
							<input name="isDefault" value="${atsHolidayPolicy.isDefault}"
							class="mini-checkbox" onvaluechanged="onIsDefaultvaluechanged" />
							<input id="isDefault" name="isDefault" class="mini-hidden" value="${atsHolidayPolicy.isDefault}" />
						</td>
					</tr>
					<tr>
						<td>是否启动半天假：</td>
						<td colspan="3">
							<input value="${atsHolidayPolicy.isHalfDayOff}"
							class="mini-checkbox" onvaluechanged="onIsHalfDayOffvaluechanged" />
							<input id="isHalfDayOff" name="isHalfDayOff" class="mini-hidden" value="${atsHolidayPolicy.isHalfDayOff}" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
								<tearea name="memo" 
							class="mini-textarea"   style="width: 100%" >${atsHolidayPolicy.memo}</tearea>
						</td>
					</tr>
				</table>
				<div>
						<div class="form-toolBox" >
					    	<a class="mini-button"   plain="true" onclick="addats_holiday_policy_detailRow">新增</a>
							<a class="mini-button btn-red"  plain="true" onclick="removeats_holiday_policy_detailRow">删除</a>
						</div>
						<div id="grid_ats_holiday_policy_detail" class="mini-datagrid" style="width: 100%;min-height: 150px;" allowResize="false"
						idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" ondrawcell="onDrawCell"
						multiSelect="true" showColumnsMenu="true" showPager="false" allowAlternating="true" >
							<div property="columns">
								<div type="checkcolumn" width="20"></div>
								<div field="holidayType" displayField="holidayTypeName" width="120" headerAlign="center" >假期类型
								<input property="editor" class="mini-buttonedit icon-dep-button"
								 required="true" allowInput="false" onbuttonclick="onSelHolidayType"/></div>
								<div field="memo"  width="120" headerAlign="center" >描述
									<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" /></div>
							</div>
						</div>
					
				</div>	
			</div>
		</form>
	</div>
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	var grid = mini.get("grid_ats_holiday_policy_detail");
	var form = new mini.Form("#form1");
	var pkId = '${atsHolidayPolicy.id}';
	var tenantId='<c:out value='${tenantId}' />';
	var id = pkId==''?"null":pkId;
	grid.setUrl("${ctxPath}/oa/ats/atsHolidayPolicyDetail/listData.do?Q_HOLIDAY_ID_S_EQ="+id);
	
	var ary1 = [{id:'1',text:'年'},{id:'2',text:'月'},{id:'3',text:'天'}];
	var ary2 = [{id:'1',text:'年'},{id:'0',text:'月'}];
	var ary3 = [{id:'1',text:'天'},{id:'0',text:'小时'}];
	
	function convertToObj(ary){
		var o={};
		for(var i=0;i<ary.length;i++){
			var tmp=ary[i];
			o[tmp.id]=tmp.text;
		}
		return o;
	}
	
	function convertToHoliday(ary){
		var o={};
		for(var i=0;i<ary.length;i++){
			var tmp=ary[i];
			o[tmp.id]=tmp.name;
		}
		return o;
	}
	
	var ary1Obj=convertToObj(ary1);
	var ary2Obj=convertToObj(ary2);
	var ary3Obj=convertToObj(ary3);
	var ary4Obj=[];//假期类型
	
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsHolidayType/listData.do",
				success:function (json) {
					var jsonObj = mini.decode(json);
					ary4Obj = convertToHoliday(jsonObj.data);
				}
			})
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsHolidayPolicy/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj=mini.decode(json);
					form.setData(jsonObj);
					
					var ary=jsonObj.atsHolidayPolicyDetails;
					for(var i=0;i<ary.length;i++){
						var row=ary[i];
						row.holidayUnitName=ary3Obj[row.holidayUnit];
						row.periodUnitName=ary2Obj[row.periodUnit];
						row.fillHolidayUnitName=ary1Obj[row.fillHolidayUnit];
						row.cancelLeaveUnitName=ary1Obj[row.cancelLeaveUnit];
						row.holidayTypeName=ary4Obj[row.holidayType];
					} 
					
					grid.setData(ary);
				}					
			});
		})
		
	function addats_holiday_policy_detailRow(){
		var row = {};
		grid.addRow(row);
	}
	
	function removeats_holiday_policy_detailRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.atsHolidayPolicyDetails = grid.getData();		
		var config={
        	url:"${ctxPath}/oa/ats/atsHolidayPolicy/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		//如果存在自定义的函数，则回调
        		if(isExitsFunction('successCallback')){
        			successCallback.call(this,result);
        			return;	
        		}
        		
        		CloseWindow('ok');
        	}
        }
	        
		_SubmitJson(config);
	}	
	
	
	//设置是否默认
	function onIsDefaultvaluechanged(e){
		var is = mini.get("isDefault");
		is.setValue(this.getChecked()==true?1:0);
	}
	//设置启动半天假
	function onIsHalfDayOffvaluechanged(e){
		var is = mini.get("isHalfDayOff");
		is.setValue(this.getChecked()==true?1:0);
	}
	//绘制单选
	function onDrawCell(e) {
        var record=e.record;
        var field=e.field;
       	if(field=='enablePeriod'){
       		qiyon(record.enablePeriod,e);
	     }
       	if(field=='enableMinAmt'){
       		qiyon(record.enableMinAmt,e);
	     }
       	if(field=='isFillHoliday'){
       		qiyon(record.isFillHoliday,e);
	     }
       	if(field=='isCancelLeave'){
       		qiyon(record.isCancelLeave,e);
	     }
       	if(field=='isCtrlLimit'){
       		qiyon(record.isCtrlLimit,e);
	     }
       	if(field=='holidayRule'){
       		qiyon(record.holidayRule,e);
	     }
       	if(field=='isOver'){
       		qiyon(record.isOver,e);
	     }
       	if(field=='isOverAutoSub'){
       		qiyon(record.isOverAutoSub,e);
	     }
       	if(field=='isCanModifyLimit'){
       		qiyon(record.isCanModifyLimit,e);
	     }
       	if(field=='isIncludeRest'){
       		qiyon(record.isIncludeRest,e);
	     }
       	if(field=='isIncludeLegal'){
       		qiyon(record.isIncludeLegal,e);
	     }
    } 
	
	function qiyon(field,e){
		if(field==1){e.cellHtml='是';}
	    else if(field==0){e.cellHtml='否';}
	    else if(field=="true"){e.cellHtml='启用';}
	    else if(field=="false"){e.cellHtml='禁用';}
	}
	
	</script>
</body>
</html>