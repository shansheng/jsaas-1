
<%-- 
    Document   : [日历模版]编辑页
    Created on : 2018-03-22 09:49:46
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[日历模版]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsCalendarTempl.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsCalendarTempl.id}" />
				<table class="table-detail column_2" cellspacing="1" cellpadding="0">
					<caption>[日历模版]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsCalendarTempl.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsCalendarTempl.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="status"
						    showNullItem="true"  
						    emptyText="请选择..."
							data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]"
							value="${atsCalendarTempl.status}"
						/>
						</td>
						<td>描述：</td>
						<td>
							
								<input name="memo" value="${atsCalendarTempl.memo}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
					<div class="mini-toolbar">
				    	<a class="mini-button"   plain="true" onclick="addats_calendar_templ_detailRow">添加</a>
						<a class="mini-button btn-red" plain="true" onclick="removeats_calendar_templ_detailRow">删除</a>
					</div>
					<div id="grid_ats_calendar_templ_detail" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false"
					multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="week" displayField="weekName" width="120" headerAlign="center" >星期
								<input property="editor" class="mini-combobox" style="width:100%;" minWidth="120" data="weeks" /></div>
							<div field="dayType" displayField="dayTypeName"   width="120" headerAlign="center" >日期类型
								<input property="editor" class="mini-combobox" style="width:100%;" minWidth="120" data="dayTypes" /></div>
						</div>
					</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	mini.parse();
	var gridats_calendar_templ_detail = mini.get("grid_ats_calendar_templ_detail");
	var form = new mini.Form("#form1");
	var pkId = '${atsCalendarTempl.id}';
	var id = pkId==''?"null":pkId;
	gridats_calendar_templ_detail.setUrl("${ctxPath}/oa/ats/atsCalendarTempl/getDetail.do?Q_CALENDAR_ID_S_EQ="+id);
	
	var weeks = [{ id: 1, text: '周一' }, { id: 2, text: '周二'}, { id: 3, text: '周三'}
	, { id: 4, text: '周四'}, { id: 5, text: '周五'}, { id: 6, text: '周六'}, { id: 0, text: '周日'}];
	
	var dayTypes = [{ id: 0, text: '工作日' }, { id: 1, text: '休息日'}];
	
	
	function convertToObj(ary){
		var o={};
		for(var i=0;i<ary.length;i++){
			var tmp=ary[i];
			o[tmp.id]=tmp.text;
		}
		return o;
	}
	
	var dayTypesObj=convertToObj(dayTypes);
	var weeksObj=convertToObj(weeks);
	
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsCalendarTempl/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj=mini.decode(json);
					form.setData(jsonObj);
					var ary=jsonObj.atsCalendarTemplDetails;

					for(var i=0;i<ary.length;i++){
						var row=ary[i];
						row.dayTypeName=dayTypesObj[row.dayType];
						row.weekName=weeksObj[row.week];
					}
					
					gridats_calendar_templ_detail.setData(ary);
				}
			});
		})
		
	function addats_calendar_templ_detailRow(){
		var row = {};
		gridats_calendar_templ_detail.addRow(row);
	}
	
	function removeats_calendar_templ_detailRow(){
		var selecteds=gridats_calendar_templ_detail.getSelecteds();
		gridats_calendar_templ_detail.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.atsCalendarTemplDetails = gridats_calendar_templ_detail.getData();	
		var config={
        	url:"${ctxPath}/oa/ats/atsCalendarTempl/save.do",
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