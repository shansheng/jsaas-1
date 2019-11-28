//显示对话框
	function onSelDialog(e,url,title){
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
						btnEdit.setValue(data.id);
						btnEdit.setText(data.name);
					} else {
						btnEdit.setValue(null);
						btnEdit.setText(null);
					}
				}
			}
		});
	}
/**
 * 导入
 * @param conf
 */
function AtsImport(conf)
{
	if(!conf) conf={};
	var url= conf.url;
	mini.open({
		height:conf.height?conf.height:400,
		width: conf.width?conf.width:500,
		title : conf.title,
		url: url, 
		isResize: true,
	   //自定义参数
		params: conf.params,
		 //回调函数
        sucCall:function(rtn){
    		if(rtn){
    			if(conf.returnUrl)
    				window.location.href = conf.returnUrl;
    			else
    				window.location.reload(true);
    		}
        }
	});
}
	
//选择日历模板对话框
	function onSelCalendarTempl(e){
		var url = __rootPath+"/oa/ats/atsCalendarTempl/dialog.do";
		onSelDialog(e,url,"选择日历模板");
	}
//选择法定假期对话框	
	function onSelLegalHoliday(e){
		var url = __rootPath+"/oa/ats/atsLegalHoliday/dialog.do";
		onSelDialog(e,url,"选择法定假期");
	}
//选择假期类型对话框
	function onSelHolidayType(e){
		var url = __rootPath+"/oa/ats/atsHolidayType/dialog.do";
		onSelDialog(e,url,"选择假期类型");
	}
//选择工作日历对话框
	function onSelWorkCalendar(e){
		var url = __rootPath+"/oa/ats/atsWorkCalendar/dialog.do";
		onSelDialog(e,url,"选择工作日历");
	}
//选择考勤周期对话框
	function onSelAttenceCycle(e){
		var url = __rootPath+"/oa/ats/atsAttenceCycle/dialog.do";
		onSelDialog(e,url,"选择考勤周期");
	}
//选择班次类型对话框
	function onSelShiftType(e){
		var url = __rootPath+"/oa/ats/atsShiftType/dialog.do";
		onSelDialog(e,url,"选择班次类型");
	}
//选择取卡规则对话框
	function onSelCardRule(e){
		var url = __rootPath+"/oa/ats/atsCardRule/dialog.do";
		onSelDialog(e,url,"选择取卡规则");
	}
//选择班次信息对话框
	function onSelShiftInfo(e){
		var url = __rootPath+"/oa/ats/atsShiftInfo/dialog.do";
		onSelDialog(e,url,"选择班次信息");
	}
//选择假期制度对话框
	function onSelHolidayPolicy(e){
		var url = __rootPath+"/oa/ats/atsHolidayPolicy/dialog.do";
		onSelDialog(e,url,"选择假期制度");
	}
//选择考勤制度对话框
	function onSelAttencePolicy(e){
		var url = __rootPath+"/oa/ats/atsAttencePolicy/dialog.do";
		onSelDialog(e,url,"选择考勤制度");
	}
//选择考勤组对话框
	function onSelAttenceGroup(e){
		var url = __rootPath+"/oa/ats/atsAttenceGroup/dialog.do";
		onSelDialog(e,url,"选择考勤组");
	}
	/**
	 * 轮班规则
	 * @param conf
	 */
	function onSelShiftRule(conf)
	{
		if(!conf) conf={};
		mini.open({
			url : __rootPath+"/oa/ats/atsShiftRule/dialog.do",
			title : '选择轮班规则',
			width : 650,
			height : 380,
			ondestroy : function(action) {
				if (action == "ok") {
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);
					if (data) {
						conf.callback.call(this,data);
					}
				}
			}
		})
	}
//选择考勤档案对话框
	function onSelAttendanceFile(e){
		var url = __rootPath+"/oa/ats/atsAttendanceFile/dialog.do";
		var btnEdit=e.sender;
		mini.open({
			url : url,
			title : "选择考勤档案",
			width : 650,
			height : 380,
			ondestroy : function(action) {
				if (action == "ok") {
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);
					if (data) {
						btnEdit.setValue(data.cardNumber);
						btnEdit.setText(data.cardNumber);
					}
				}
			}
		});
	}
//选择组织
	function selectMainDep(e){
		var b=e.sender;
		
		_TenantGroupDlg(tenantId,true,'','1',function(g){
			b.setValue(g.groupId);
			b.setText(g.name);
		},false);
		
	}
	
	