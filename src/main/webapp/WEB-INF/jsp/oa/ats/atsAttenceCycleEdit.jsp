
<%-- 
    Document   : [考勤周期]编辑页
    Created on : 2018-03-23 14:36:39
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤周期]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsAttenceCycle.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsAttenceCycle.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[考勤周期]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsAttenceCycle.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsAttenceCycle.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>周期类型：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="type"
							data="[{id:'1',text:'自然月'},{id:'0',text:'月(固定日期)'}]"
							style="width: 90%"
							value="${atsAttenceCycle.type==null?1:atsAttenceCycle.type}"
							onvaluechanged="onValueChanged"
						/>
						</td>
					</tr>
					<tr>
						<td>开始周期：</td>
						<td>
							
							<input name="year" value="${atsAttenceCycle.year}"
							class="mini-monthpicker" allowInput="false" valueType="String" style="width: 20%" onvaluechanged="yearMonthChange" />年
							<input name="month" value="${atsAttenceCycle.month}"
							class="mini-monthpicker" allowInput="false" valueType="String" style="width: 10%" onvaluechanged="yearMonthChange" />月
						</td>
					</tr>
					<tr id="group">
						<td>周期区间</td>
						<td>
							<input name="startMonth" value="${atsAttenceCycle.startMonth}"
							class="mini-datepicker" allowInput="false" valueType="String" style="width: 10%" onvaluechanged="startMonthDay" />月
							<input name="startDay" allowInput="false" value="${atsAttenceCycle.startDay}"
							class="mini-datepicker" valueType="String" style="width: 10%" onvaluechanged="startMonthDay" />日
						
							-
							
							<input name="endMonth" value="${atsAttenceCycle.endMonth}"
							class="mini-datepicker" allowInput="false"  valueType="String" style="width: 10%" onvaluechanged="endMonthDay" />月
							<input name="endDay" value="${atsAttenceCycle.endDay}"
							class="mini-datepicker" allowInput="false" valueType="String" style="width: 10%" onvaluechanged="endMonthDay" />日
						</td>
					</tr>
					<tr>
						<td>是否默认：</td>
						<td>
							<input value="${atsAttenceCycle.isDefault}"
							class="mini-checkbox" onvaluechanged="onIsDefaultvaluechanged" />
							<input id="isDefault" name="isDefault" class="mini-hidden" value="${atsAttenceCycle.isDefault==null?0:1}" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td>
							
								<input name="memo" value="${atsAttenceCycle.memo}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
					<div class="mini-toolbar">
				    	<a class="mini-button"   plain="true" onclick="addats_attence_cycle_detailRow">添加</a>
						<a class="mini-button btn-red" plain="true" onclick="removeats_attence_cycle_detailRow">删除</a>
					</div>
					<div id="grid_ats_attence_cycle_detail" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" oncellendedit="onChangeValue"
					multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="name"  width="120" headerAlign="center" >周期
							<input property="editor" class="mini-monthpicker" onvalidation="onNameValidation"  valueType="String" style="width:100%;"  value="${atsAttenceCycle.name}" />     
							</div>
							<div field="startTime"  width="120" headerAlign="center" >开始时间
								<input property="editor" class="mini-datepicker" ondrawdate="onDrawDate" format="yyyy-MM-dd" valueType="String" style="width:100%;" minWidth="120" /></div>
							<div field="endTime"  width="120" headerAlign="center" >结束时间
								<input property="editor" class="mini-datepicker" ondrawdate="onDrawDate" format="yyyy-MM-dd" valueType="String" style="width:100%;" minWidth="120" /></div>
						</div>
					</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	mini.parse();
	var grid = mini.get("grid_ats_attence_cycle_detail");
	var form = new mini.Form("#form1");
	var pkId = '${atsAttenceCycle.id}';
	var id = pkId==''?"null":pkId;
	grid.setUrl("${ctxPath}/oa/ats/atsAttenceCycleDetail/listData.do?Q_CYCLE_ID_S_EQ="+id);
		$(function(){
			//页面加载时确定周期类型
			changeType("${atsAttenceCycle.type}");
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttenceCycle/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj=mini.decode(json);
					if(!jsonObj)return;
					changeType(jsonObj.type);
					form.setData(jsonObj);
					grid.setData(jsonObj.atsAttenceCycleDetails);
				}					
			});
		})
	
	function onDrawDate(e) {
		var date = e.date;
        var year = mini.getByName("year").getValue();
        var month = mini.getByName("month").getValue();
        
        if (date.getFullYear() < year || (date.getFullYear() >= year && (date.getMonth()+1) < month)) {
            e.allowSelect = false;
        }
    }
		
	function onChangeValue(e){
		var field = e.field;
		if(field == "name"){
			var name = e.row.name;
			var year = mini.getByName("year").getValue();
            var month = mini.getByName("month").getValue();
            var ary = name.split("-");
        	if (ary[0]<year || (ary[0]>=year && ary[1]<month)) {
        		alert("周期设置不能小于开始周期");
        		e.row.name = null;
        		e.row.startTime = null;
        		e.row.endTime = null;
            }
		}
		grid.updateRow(e.row);
	}
	
	//设置是否默认
	function onIsDefaultvaluechanged(e){
		var is = mini.get("isDefault");
		is.setValue(this.getChecked()==true?1:0);
	}
	//选择周期类型时,填入项发生改变
	function onValueChanged(e) {
		changeType(e.value);
		grid.clearRows();
	}
	//设置年月
	function yearMonthChange(e){
		var year = mini.getByName("year");
		var month = mini.getByName("month");
		
		var ary = dateValueChanged(year,0,month,1,e);
		
		var startMonth = mini.getByName("startMonth");
		startMonth.setValue(ary[1]);
	}
	//设置开始月份和日期
	function startMonthDay(e){
		var startMonth = mini.getByName("startMonth");
		var startDay = mini.getByName("startDay");
		
		dateValueChanged(startMonth,1,startDay,2,e);
		
		var month = mini.getByName("month");
		if(parseInt(month.value)!=parseInt(startMonth.value)){
			_ShowTips({
        		msg:"开始月份需和开始周期月份一致,开始月份为"+month.value+"月"
        	})
        	startMonth.setValue(null);
			startDay.setValue(null);
        	return;
		}
		
		var endMonth = mini.getByName("endMonth");
		var endDay = mini.getByName("endDay");

		if(endMonth.value==null || endDay.value==null){
			return;
		}
		var smValue = parseInt(startMonth.value);
		var emValue = parseInt(endMonth.value);
		var sdValue = parseInt(startDay.value);
		var edValue = parseInt(endDay.value);
		if(smValue>emValue){
			_ShowTips({
        		msg:"开始月份大于结束月份"
        	})
        	startMonth.setValue(null);
		}
		if(smValue==emValue){
			if(sdValue>edValue){
				_ShowTips({
            		msg:"开始日期大于结束日期"
            	})
            	startMonth.setValue(null);
			}
		}
	}
	
	//设置结束月份和日期
	function endMonthDay(e){
		var endMonth = mini.getByName("endMonth");
		var endDay = mini.getByName("endDay");
	
		dateValueChanged(endMonth,1,endDay,2,e);
		
		var startMonth = mini.getByName("startMonth");
		var startDay = mini.getByName("startDay");
		
		if(startMonth.value==null || startDay.value==null){
			return;
		}
		var smValue = parseInt(startMonth.value);
		var emValue = parseInt(endMonth.value);
		var sdValue = parseInt(startDay.value);
		var edValue = parseInt(endDay.value);
		if(smValue>emValue){
			_ShowTips({
        		msg:"开始月份大于结束月份"
        	})
    		endMonth.setValue(null);
		}else{
			if(sdValue>edValue){
				_ShowTips({
            		msg:"开始日期大于结束日期"
            	})
				endDay.setValue(null);
			}
		}
	}
	
	//同步时间
	function dateValueChanged(date1,index1,date2,index2,e){
		var ary = e.value.split("-");
		date1.setValue(ary[index1]);
		date2.setValue(ary[index2]);
		return ary;
	}
	
	
	function changeType(value){
		var group = document.getElementById("group");
		if(!value || value == ""){
			group.style.display = "none";
			return;
		}
		if(value == 0){
			group.style.display = "";
		}else{
			group.style.display = "none";
		}
	}	
		
	function addats_attence_cycle_detailRow(){
		grid.clearRows();
		//var row = {};//[{name:"12"},{name:"13"}];
		//[{name:'123',startTime:'2018-05-01',endTime:'2018-05-31'}]
		var type = mini.getByName("type").value;
		var year = parseInt(mini.getByName("year").value);
		var month = parseInt(mini.getByName("month").value);
		
		var rows = [];
		var c = 0;
		if(type=='1'){//自然月
			for(var i=month;i<=12;i++){
				var ary = getLastDay(year,i);
				var name = year+"-"+(i<10?"0"+i:i);
				rows[c] = {name:name,startTime:ary[0].format("yyyy-MM-dd"),endTime:ary[1].format("yyyy-MM-dd")};
				c++;
			}
		}
		if(type=='0'){//固定月
			var startMonth = parseInt(mini.getByName("startMonth").value);
		    var startDay = parseInt(mini.getByName("startDay").value);
		    var endMonth = parseInt(mini.getByName("endMonth").value);
		    var endDay = parseInt(mini.getByName("endDay").value);
		    if(!startMonth || !startDay || !endMonth || !endDay){
		    	alert("请输入周期区间");
		    	return;
		    }
			for(var i=startMonth;i<=endMonth;i++){
				if(startMonth==endMonth){
					name = year+"-"+(i<10?"0"+i:i);
					rows[0] = {name:name,startTime:getMonthDay(year,i,startDay).format("yyyy-MM-dd"),endTime:getMonthDay(year,i,endDay).format("yyyy-MM-dd")};
					break;
				}
				var ary = getLastDay(year,i);
				var name = year+"-"+(i<10?"0"+i:i);
				rows[c] = {name:name,startTime:ary[0].format("yyyy-MM-dd"),endTime:ary[1].format("yyyy-MM-dd")}
				c++;
			}
		}
		grid.addRows(rows);
	}
	
	function getMonthDay(year,month,day){
		return new Date(year,month-1,day);
	}
	
	function getLastDay(year,month)     
	{     
	 var new_year = year;  //取当前的年份     
	 var new_month = month;//取下一个月的第一天，方便计算（最后一天不固定）     
	 if(month>11)      //如果当前大于12月，则年份转到下一年     
	 {     
	 new_month -=12;    //月份减     
	 new_year++;      //年份增     
	 }     
	 var new_date = new Date(new_year,new_month,1);        //取当年当月中的第一天    
	 month++;
	 return [new Date(new_year,new_month-1,1),(new Date(new_date.getTime()-1000*60*60*24))];//获取当月最后一天日期     
	} 
	
	function removeats_attence_cycle_detailRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.atsAttenceCycleDetails = grid.getData();		
		var config={
        	url:"${ctxPath}/oa/ats/atsAttenceCycle/save.do",
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