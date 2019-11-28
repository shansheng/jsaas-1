var _startTime="";//开始时间
var _endTime="";//结束时间
var _attencePolicyId="";//考勤制度
var grid="";
var index="";//页码

$(function(){
	//初始化
	_startTime = $('#startTime').val();
	_endTime = $('#endTime').val();
	_attencePolicyId = $("#attencePolicy").val();
})

//查询方法
function searchGrid(){
	var flag = getInitVal();
	if(flag){
		return;
	}
   if(index == "0"){//已计算人员
	   renderDataGrid("getGridColModel");
   } else if(index == "1"){//未计算人员
	  loadNoUserGrid();
   } else  if(index == "2"){//结果明细
	   loadResultDetailGrid();
   }
}

//计算全部
function allCalculate(){
	calculate();
}


//计算所选
function calculateSelect(){
	var selectedIds = grid.getSelecteds();
	if (selectedIds == null || selectedIds.length < 1) {
		alert("请选择要计算的人员！");
		return;
	}
	var fileIds = [];
		for (var i = 0; i < selectedIds.length; i++) {
	     var rowData = selectedIds[i];
	     if(!rowData.fileId) continue
		 fileIds.push(rowData.fileId);
	}
		calculate(fileIds.join(","));
}

/**
 * 计算数据
 */
function calculate(fileIds){
	if(index == "2"){
		alert("该视图不进行计算！");
		return;
	}	
	var flag = getInitVal();
	if(flag){
		return;
	}
	_SubmitJson({
		url:__rootPath+"/oa/ats/atsAttenceCalculate/calculate.do",
		method:'POST',
		data : {
			"startTime" : _startTime,
			"endTime" : _endTime,
			"fileIds":fileIds?fileIds:''
		},
		success : function(data) {
			searchGrid();
		}
	})
	
}

//汇总显示
function summary(){
	var url = __rootPath+"/oa/ats/atsAttenceCalculateSet/edit.do?type=1";
	mini.open({
		url : url,
		title : '汇总显示',
		height:400,
		width: 500,
		ondestroy : function(action) {
			//
		}
	});
}

//明细显示
function detail(){
	var url = __rootPath+"/oa/ats/atsAttenceCalculateSet/edit.do?type=2";
	mini.open({
		url : url,
		title : '明细显示',
		height:400,
		width: 500,
		ondestroy : function(action) {
			//
		}
	});
}

//导出
function exportFile(){
	location.href = __rootPath+"/oa/ats/atsAttenceCalculate/exportReportDetail.do?"+
	"action="+index+"&Q_beginattenceTime_DL="+_startTime+"&Q_endattenceTime_DE="+_endTime+
	"&Q_attencePolicy_L="+_attencePolicyId+"&Q_fullname_SL="+mini.get("fullname").getValue()+"&Q_userId_S="+mini.get("userId").getValue()+
	"&orgPath="+mini.get("orgId").getValue()+"&type="+mini.get("attenceType").getValue();
}


function getInitVal(){
	_startTime = mini.get('startTime').value;
	_endTime = mini.get('endTime').value;
	_attencePolicyId = mini.get('attencePolicy').value;
	
	if(_attencePolicyId == "") {
		alert("请选择考勤制度");
		return true;
	}
	if(_startTime == "" ){
		alert("请输入开始时间");
		return true;
	}
	if(_endTime == "" ){
		alert("请输入结束时间");
		return true;
	}
	return false;
}

function remoteCall(conf){
	var url = conf.url;
	if(conf.method)
		url =__rootPath+"/oa/ats/atsAttenceCalculate/"+conf.method+".do";
	$.ajax({
		type : "POST",
		url :url,
		data : conf.param?conf.param:{},
		success : function(data) {
			conf.success.call(this,data);
		}
	});
}

function renderDataGrid(method){
	remoteCall({
		method : method,
		param : {
			"startTime" : _startTime,
			"endTime" : _endTime,
			"attencePolicyId" : _attencePolicyId
		},
		success : function(data) {
			onLoadGrid(data);
		}
	});
}

function onLoadGrid(data){
	grid = mini.get("datagrid1");
	var colNames = data.colNames;
	var	colModel = data.colModel;
	
	 	grid.set({
	        columns: mini.decode(colModel)
	    });
	 	
	 	loadGrid();
}

function loadGrid(){
	grid.setUrl(__rootPath+"/oa/ats/atsAttenceCalculate/getCalList.do");
	grid.load({
		"orgPath":mini.get("orgId").getValue(),
		"Q_fullname_SL":mini.get("fullname").getValue(),
		"Q_beginattenceTime_D_LE":_startTime,
		"Q_endattenceTime_D_GE":_endTime,
		"Q_attencePolicy_L":_attencePolicyId,
		"Q_userId_S":mini.get("userId").getValue()
	});
}

function loadNoUserGrid(){
	grid = mini.get("datagrid2");
	grid.setUrl(__rootPath+"/oa/ats/atsAttenceCalculate/getNoneCalList.do");
	grid.load({
		"orgPath":mini.get("orgId").getValue(),
		"Q_fullname_SL":mini.get("fullname").getValue(),
		"Q_userId_S":mini.get("userId").getValue(),
		"Q_beginattenceTime_DL":_startTime,
		"Q_endattenceTime_DE":_endTime,
		"Q_attencePolicy_L":_attencePolicyId,
		"Q_abnormity_S":mini.get("abnormity").getValue()
	});
}

function loadResultDetailGrid(){
	var type = mini.get("attenceType").getValue();
	grid = mini.get("datagrid3");
	grid.setUrl(__rootPath+"/oa/ats/atsAttenceCalculate/getDetailList.do");
	grid.load({
		"orgPath":mini.get("orgId").getValue(),
		"Q_fullname_SL":mini.get("fullname").getValue(),
		"Q_userId_S":mini.get("userId").getValue(),
		"Q_beginattenceTime_DL":_startTime,
		"Q_endattenceTime_DE":_endTime,
		"Q_attencePolicy_L":_attencePolicyId,
		"type":type,
		"Q_abnormity_S":mini.get("abnormity").getValue()
	});
}


function onTabsActiveChanged(e) {
    var tabs = e.sender;
   // var tab = tabs.getActiveTab();
    index=tabs.getActiveIndex();
    $('#abnormityLi').hide();
	$('#attenceTypeLi').hide();
    if(index==0){
    	renderDataGrid("getGridColModel");
    }
    if(index==1){
    	loadNoUserGrid();
    }
    
    if(index==2){
    	$('#abnormityLi').show();
 	    $('#attenceTypeLi').show();
    	loadResultDetailGrid();
    }
}