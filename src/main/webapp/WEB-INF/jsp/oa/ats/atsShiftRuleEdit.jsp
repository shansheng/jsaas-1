
<%-- 
    Document   : [轮班规则]编辑页
    Created on : 2018-03-26 16:50:46
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[轮班规则]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsShiftRule.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsShiftRule.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[轮班规则]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							<input name="code" value="${atsShiftRule.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
				
						<td>名称：</td>
						<td>
							<input name="name" value="${atsShiftRule.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td colspan="3">
							<input name="orgId" class="mini-buttonedit icon-dep-button" value="${atsShiftRule.orgId}" 
						text="${atsShiftRule.orgName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/>
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							<textarea name="memo" value=""
							class="mini-textarea"   style="width: 90%" >${atsShiftRule.memo}</textarea>
						</td>
					</tr>
				</table>
				<div style="">
					<div class="form-toolBox">
				    	<a class="mini-button"   plain="true" onclick="addats_shift_rule_detailRow">新增</a>
						<a class="mini-button btn-red"  plain="true" onclick="removeats_shift_rule_detailRow">删除</a>
					</div>
					<div id="grid_ats_shift_rule_detail" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false"
					multiSelect="true" showColumnsMenu="true" showPager="false" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="dateType" displayField="dateTypeName"  width="120" headerAlign="center" >日期类型
								<input 
								class="mini-combobox" 
								url="${ctxPath}/oa/ats/atsShiftType/getJsonData.do"
								style="width:100%;" minWidth="120"/></div>
							<div field="shiftId"  width="120" headerAlign="center" >班次ID
								<input class="mini-textbox" style="width:100%;" minWidth="120" /></div>
							<div field="shiftName" width="120" headerAlign="center" >班次名称
								<input property="editor" class="mini-buttonedit icon-dep-button" 
								required="true" allowInput="false" onbuttonclick="selShiftInfo"/></div>
							<div field="shiftTime"  width="120" headerAlign="center" >上下班时间
								<input class="mini-textbox" style="width:100%;" minWidth="120" /></div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- data="[{id:'1',text:'工作日'},{id:'2',text:'休息日'},{id:'3',text:'法定假日'}]" -->
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	var grid = mini.get("grid_ats_shift_rule_detail");
	var form = new mini.Form("#form1");
	var pkId = '${atsShiftRule.id}';
	var tenantId='<c:out value='${tenantId}' />';
	var id = pkId==''?"null":pkId;
	grid.setUrl("${ctxPath}/oa/ats/atsShiftRuleDetail/listData.do?Q_RULE_ID_S_EQ="+id);
	
	var ary1 = [{id:'1',text:'工作日'},{id:'2',text:'休息日'},{id:'3',text:'法定假日'}];
	
	function convertToObj(ary){
		var o={};
		for(var i=0;i<ary.length;i++){
			var tmp=ary[i];
			o[tmp.id]=tmp.text;
		}
		return o;
	}
	
	var ary1Obj=convertToObj(ary1);
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsShiftRule/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					var jsonObj=mini.decode(json);
					form.setData(jsonObj);
					var ary = jsonObj.atsShiftRuleDetails;
					for(var i=0;i<ary.length;i++){
						var row=ary[i];
						row.dateTypeName=ary1Obj[row.dateType];
					}
					grid.setData(ary);
				}					
			});
		})
	
		//显示对话框
	function onSelDialog1(e,url,title,callback){
		var btnEdit=e.sender;
		mini.open({
			url : url,
			title : title,
			width : 650,
			height : 380,
			ondestroy : function(action) {
				if (action == "ok") {
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);
					if (data) {
						btnEdit.setValue(data.name);
						btnEdit.setText(data.name);
						if(callback){
			            	callback(data);
			            }
					}
				}
			}
		});
	}
	//弹出班次信息对话框
	function selShiftInfo(e){
		var url = __rootPath+"/oa/ats/atsShiftInfo/dialog.do";
		onSelDialog1(e,url,"选择班次信息",function(data){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsShiftTime/getAtsShfitTime.do",
				data:{ids:data.id},
				success:function (time) {
					var row = grid.getSelected();
					updateats_shift_rule_detailRow(row,{"shiftId":data.id,"shiftTime":time,"dateType":data.shiftType,"dateTypeName":ary1Obj[data.shiftType]});
				}					
			});
		});
	}
	
	function updateats_shift_rule_detailRow(row,rowData){
		grid.updateRow(row,rowData);
	}
	
		
	function addats_shift_rule_detailRow(){
		var row = {};
		grid.addRow(row);
	}
	
	function removeats_shift_rule_detailRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.atsShiftRuleDetails = grid.getData();		
		var config={
        	url:"${ctxPath}/oa/ats/atsShiftRule/save.do",
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