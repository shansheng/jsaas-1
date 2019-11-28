
<%-- 
    Document   : [班次设置]编辑页
    Created on : 2018-03-26 13:55:50
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[班次设置]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsShiftInfo.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsShiftInfo.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[班次设置]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
								<input name="code" value="${atsShiftInfo.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
						<td>名称：</td>
						<td>
							<input name="name" value="${atsShiftInfo.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>班次类型：</td>
						<td>
							<input name="shiftType" class="mini-buttonedit icon-dep-button" value="${atsShiftInfo.shiftType}" 
						text="${atsShiftInfo.shiftTypeName}" required="true" allowInput="false" onbuttonclick="onSelShiftType"/>
						</td>
						<td>加班补偿方式：</td>
						<td>
								<input name="otCompens" value="${atsShiftInfo.otCompens}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							<input name="orgId" class="mini-buttonedit icon-dep-button" value="${atsShiftInfo.orgId}" text="${atsShiftInfo.orgName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/>
						</td>
						<td>取卡规则：</td>
						<td>
							<input name="cardRule" class="mini-buttonedit icon-dep-button" value="${atsAttencePolicy.cardRule}" 
						text="${atsShiftInfo.cardRuleName}" required="true" allowInput="false" onbuttonclick="onSelCardRule"/>
						</td>
					</tr>
					<tr>
						<td>标准工时：</td>
						<td>
								<input name="standardHour" value="${atsShiftInfo.standardHour}"
							class="mini-textbox"   style="width: 90%" />
						</td>
						<td>是否默认：</td>
						<td>
							<input value="${atsShiftInfo.isDefault}"
							class="mini-checkbox" onvaluechanged="onIsDefaultvaluechanged" />
							<input id="isDefault" name="isDefault" class="mini-hidden" value="${atsShiftInfo.isDefault}" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							<textarea name="memo"
							class="mini-textarea"   style="width: 90%" >${atsShiftInfo.memo}</textarea>
						</td>
					</tr>
				</table>
				<div >
					<div class="form-toolBox" >
				    	<a class="mini-button"   plain="true" onclick="addats_shift_timeRow">新增</a>
						<a class="mini-button btn-red"  plain="true" onclick="removeats_shift_timeRow">删除</a>
					</div>
					<div id="grid_ats_shift_time" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false"
					multiSelect="true" showColumnsMenu="true" showPager="false" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="segment" displayField="segmentName"  width="120" headerAlign="center" >段次
								<input 
								property="editor"
								class="mini-combobox" 
								data="[{id:'1',text:'一段'},{id:'2',text:'二段'},{id:'3',text:'三段'}]"
								style="width:100%;" minWidth="120"/></div>
							<div field="attendanceType" displayField="attendanceTypeName"  width="120" headerAlign="center" >出勤类型
								<input 
								property="editor"
								class="mini-combobox" 
								data="[{id:'0',text:'正常出勤'},{id:'1',text:'固定加班'},{id:'2',text:'正常出勤不计异常'},{id:'3',text:'固定加班不计异常'}]"
								style="width:100%;" minWidth="120"/></div>
							<div field="onType" displayField="onTypeName"  width="120" headerAlign="center" >上班类型
								<input 
								property="editor"
								class="mini-combobox" 
								data="[{id:'2',text:'今天'},{id:'1',text:'昨天'}]"
								style="width:100%;" minWidth="120"/></div>
							<div field="onTime" displayField="onTimeName"  width="120" headerAlign="center" >上班时间
								<input property="editor" class="mini-datepicker" showTime="true" format="HH:mm" style="width:100%;" minWidth="120" /></div>
							<div field="onPunchCard"  displayField="onPunchCardName"  width="120" headerAlign="center" >上班是否打卡
								<input 
								property="editor"
								class="mini-combobox" 
								data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
								style="width:100%;" minWidth="120"/></div>
							<!-- <div field="onFloatAdjust"  width="120" headerAlign="center" >上班浮动调整值（分）
								<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" /></div> -->
							<div field="segmentRest"  width="120" headerAlign="center" >段内休息时间
								<input property="editor" class="mini-textbox" onblur="valiSegmentRest" style="width:100%;" minWidth="120" /></div>
							<div field="offType" displayField="offTypeName"   width="120" headerAlign="center" >下班类型
								<input 
								property="editor"
								class="mini-combobox" 
								data="[{id:'2',text:'今天'},{id:'3',text:'明天'}]"
								dataField="text"
								style="width:100%;" minWidth="120"/></div>
							<div field="offTime" displayField="offTimeName" width="120" headerAlign="center" >下班时间
								<input property="editor" class="mini-datepicker" showTime="true" format="HH:mm" style="width:100%;" minWidth="120" /></div>
							<div field="offPunchCard"  displayField="offPunchCardName"  width="120" headerAlign="center" >下班是否打卡
								<input 
								property="editor"
								class="mini-combobox" 
								data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
								style="width:100%;" minWidth="120"/></div>
							<!-- <div field="offFloatAdjust"  width="120" headerAlign="center" >下班浮动调整值（分）
								<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" /></div> -->
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	
	<script type="text/javascript">
	mini.parse();
	var grid = mini.get("grid_ats_shift_time");
	var form = new mini.Form("#form1");
	var pkId = '${atsShiftInfo.id}';
	var tenantId='<c:out value='${tenantId}' />';
	var id = pkId==''?"null":pkId;
	grid.setUrl("${ctxPath}/oa/ats/atsShiftTime/listData.do?Q_SHIFT_ID_S_EQ="+id);
	
	var ary1 = [{id:'1',text:'一段'},{id:'2',text:'二段'},{id:'3',text:'三段'}];
	var ary2 = [{id:'0',text:'正常出勤'},{id:'1',text:'固定加班'},{id:'2',text:'正常出勤不计异常'},{id:'3',text:'固定加班不计异常'}];
	var ary3 = [{id:'2',text:'今天'},{id:'1',text:'昨天'},{id:'3',text:'明天'}];
	var ary4 = [{id:'1',text:'是'},{id:'0',text:'否'}];
	
	function convertToObj(ary){
		var o={};
		for(var i=0;i<ary.length;i++){
			var tmp=ary[i];
			o[tmp.id]=tmp.text;
		}
		return o;
	}
	
	
	
	function formatTime(date){
		var hour = date.getHours()<10?"0"+date.getHours():date.getHours();
		var minute = date.getMinutes()<10?"0"+date.getMinutes():date.getMinutes();
		var str =  hour + ":" + minute;
		return str;
	}
	
	function valiSegmentRest(e){
		var value = e.sender.value;
		var reg = new RegExp("^[0-9]*$");
	    if(!reg.test(value)){
	        alert("请输入数字!");
	        this.setValue("");
	        e.sender.value = "";
	    }
	    return true;
	}
	
	
	var ary1Obj=convertToObj(ary1);
	var ary2Obj=convertToObj(ary2);
	var ary3Obj=convertToObj(ary3);
	var ary4Obj=convertToObj(ary4);
	
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsShiftInfo/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj=mini.decode(json);
					form.setData(jsonObj);
					var ary = jsonObj.atsShiftTimes;
					
					for(var i=0;i<ary.length;i++){
						var row=ary[i];
						row.segmentName=ary1Obj[row.segment];
						row.attendanceTypeName=ary2Obj[row.attendanceType];
						row.onTypeName=ary3Obj[row.onType];
						row.onPunchCardName=ary4Obj[row.onPunchCard];
						row.offTypeName=ary3Obj[row.offType];
						row.offPunchCardName=ary4Obj[row.offPunchCard];
						row.onTimeName=formatTime(new Date(row.onTime));
						row.offTimeName=formatTime(new Date(row.offTime));
					} 
					
					grid.setData(ary);
				}					
			});
		})
		
		
	//设置默认班次
	function onIsDefaultvaluechanged(e){
		var is = mini.get("isDefault");
		is.setValue(this.getChecked()==true?1:0);
	}
		
	function addats_shift_timeRow(){
		var row = {};
		grid.addRow(row);
	}
	
	function removeats_shift_timeRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.atsShiftTimes = grid.getData();		
		var config={
        	url:"${ctxPath}/oa/ats/atsShiftInfo/save.do",
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
	
	
	
	

	</script>
</body>
</html>