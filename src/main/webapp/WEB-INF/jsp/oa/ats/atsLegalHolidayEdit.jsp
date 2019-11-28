
<%-- 
    Document   : [法定节假日]编辑页
    Created on : 2018-03-22 16:48:35
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[法定节假日]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsLegalHoliday.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsLegalHoliday.id}" />
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>[法定节假日]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsLegalHoliday.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsLegalHoliday.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>年度：</td>
						<td>
							<input class="mini-monthpicker" name="year" format="yyyy" valueType="String" value="${atsLegalHoliday.year}"/>
							
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td>
							
								<input name="memo" value="${atsLegalHoliday.memo}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
					<div class="mini-toolbar">
				    	<a class="mini-button"   plain="true" onclick="addats_legal_holiday_detailRow">添加</a>
						<a class="mini-button btn-red"  plain="true" onclick="removeats_legal_holiday_detailRow">删除</a>
					</div>
					<div id="grid_ats_legal_holiday_detail" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" oncellendedit="onChangeValue"
					multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="name"  width="120" headerAlign="" >假日名称
								<input property="editor" class="mini-textbox" style="width:100%;"  minWidth="120" /></div>
							<div field="startTime"  width="120" headerAlign="" >开始时间
								<input property="editor" class="mini-datepicker" style="width:100%;" ondrawdate="onDrawDate" format="yyyy-MM-dd" valueType="String" minWidth="120"/></div>
							<div field="endTime"  width="120" headerAlign="" >结束时间
								<input property="editor" class="mini-datepicker" style="width:100%;" ondrawdate="onDrawDate" format="yyyy-MM-dd" valueType="String" minWidth="120"/></div>
						</div>
					</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	mini.parse();
	var grid = mini.get("grid_ats_legal_holiday_detail");
	var form = new mini.Form("#form1");
	var pkId = '${atsLegalHoliday.id}';
	var id = pkId==''?"null":pkId;
	grid.setUrl("${ctxPath}/oa/ats/atsLegalHolidayDetail/listData.do?Q_HOLIDAY_ID_S_EQ="+id);
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsLegalHoliday/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj=mini.decode(json);
					form.setData(jsonObj);
					var ary = jsonObj.atsLegalHolidayDetails;
					
					grid.setData(ary);
				}					
			});
		})
		
	//年度之外时间不可选
	function onDrawDate(e) {
       var date = e.date;
       var d = mini.getByName("year").getValue();

       if (date.getFullYear() != d) {
           e.allowSelect = false;
       }
    }
		
	function onChangeValue(e){
		var field = e.field;
		var startTime = e.row.startTime;
		var endTime = e.row.endTime;
		if(startTime > endTime) {
			if(field == "startTime"){
				alert("开始时间大于结束时间");
				e.row.startTime = null;
			}
			if(field == "endTime"){
				alert("结束时间小于开始时间");
				e.row.endTime = null;
			}
		}
		grid.updateRow(e.row);
	}

		
	function addats_legal_holiday_detailRow(){
		var row = {};
		grid.addRow(row);
	}
	
	function removeats_legal_holiday_detailRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		var ary = grid.getData();		
		for(var i=0;i<ary.length;i++){
			var name = ary[i].name;
			if(name == undefined || name == null || name.trim() == ''){
				alert("请输入假期名称");
				return;
			}
		}
		data.atsLegalHolidayDetails = ary;
		var config={
        	url:"${ctxPath}/oa/ats/atsLegalHoliday/save.do",
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