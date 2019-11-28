var editor=null;
/**
 * 索引字段。
 */
var fieldAry=[];
var sortFieldAry=[];

function initCodeMirror() {
	var obj = document.getElementById("query");
	editor = CodeMirror.fromTextArea(obj, {
		matchBrackets : true,
		mode : "text/x-groovy"
	});
}


function changeQueryType(e){
	if(e.value=="1"){
		$("#trCustomSql").hide();
		toggleTab(true);
		toggleCondtionColumns(true);
	}
	else{
		initSql();
		$("#trCustomSql").show();
		toggleTab(false);
		toggleCondtionColumns(false);
	}
}

function onFieldChanged(e){
	  var grid=mini.get("gridWhere");
	  var item=e.sender.getSelected();
	  var row=grid.getEditorOwnerRow(e.sender);
	  grid.updateRow(row,{type:item.type})
}


/**
 * 从索引中加载字段。
 * @param callBack
 * @returns
 */
function loadFields(callback){
	
	var url= __rootPath +"/sys/core/sysEsQuery/getMapping.do";
	var esTable=mini.getByName("esTable").getValue();
	var params={alias:esTable};
	$.post(url,params,function(rtn){
		fieldAry=rtn.data;
		sortFieldAry=$.clone(fieldAry);
		callback($.clone(fieldAry));
	})
}



/**
 * 切换TAB
 * @param show
 * @returns
 */
function toggleTab(show) {
	var sqlPanel = tabObject.getTab("tabSortField");
	tabObject.updateTab(sqlPanel, {
		visible : show
	});
}
/**
 * 重新加载返回字段。
 * @returns
 */
function reloadReturn(){
	var grid=mini.get("gridRtnFields");
	grid.setData($.clone(fieldAry));
}

/**
 * 添加条件字段。
 * @returns
 */
function addCondition(){
	var gridWhere=mini.get("gridWhere");
	gridWhere.addRow({});
}

/**
 * 添加排序
 * @returns
 */
function addSort(){
	var grid=mini.get("gridOrder");
	grid.addRow({});
}



function initTab(){
	tabObject=mini.get("tabEsSetting");
	//选择索引
	tabObject.on("beforeactivechanged",function(e){
		var esTable=mini.getByName("esTable").getValue();
		if(!esTable){
			alert("请选择索引!");
			e.cancel=true;
		}
		else{
			
			var idx=e.index;
			if(idx>0){
				//加载字段
				loadFields(function(data){
					if(idx==1){
						var grid=mini.get("gridRtnFields");
						var orignData=grid.getData();
						if(orignData.length>0) return;
						var ary=[];
						for(var i=0;i<data.length;i++){
							var obj=data[i];
							if(!obj.keyword){
								ary.push(obj);
							}
						}
						grid.setData(ary);
					}
				});
			}
			if(idx==0){
				var data=mini.get("gridWhere").getData();
				var combox=mini.get("comboCondition");
				combox.setData(data);
			}
			
		}
	});
}

function initForm(){
	initCodeMirror();
	initTab();
	if(!pkId) return;
	var url=__rootPath +"/sys/core/sysEsQuery/getJson.do";
	$.post(url,{ids:pkId},function(json){
		var obj=$("#trCustomSql");
		//查询类型。
		var queryType=json.queryType;
		queryType==1?obj.hide():obj.show();
		toggleTab(queryType==1);
		
		form.setData(json);
		if(json.query){
			editor.setValue(json.query);
		}
		if(json.returnFields){
			var returnFields=eval("("+json.returnFields+")");
			mini.get("gridRtnFields").setData(returnFields);
		}
		if(json.conditionFields){
			var conditionFields=eval("("+json.conditionFields+")");
			mini.get("gridWhere").setData(conditionFields);
		}
		
		if(json.sortFields){
			var sortFields=eval("("+json.sortFields+")");
			mini.get("gridOrder").setData(sortFields);
		}
	

	});
}


function onComboValidation(e) {
    var items = this.findItems(e.value);
    if (!items || items.length == 0) {
        e.isValid = false;
        e.errorText = "输入值不在下拉数据中";
    }
}
	
function onOk(){
	form.validate();
    if (!form.isValid()) {
        return;
    }	        
    var data=form.getData();
    
    data.query=editor.getValue();
    
    //返回字段
    var rtnFields= mini.get("gridRtnFields").getData();
    if(rtnFields.length>0){
	    _RemoveGridData(rtnFields);
	    data.returnFields=JSON.stringify(  rtnFields);
    }
    //条件字段
    var condFields=mini.get("gridWhere").getData();
    if(condFields.length>0){
	    _RemoveGridData(condFields);
	    data.conditionFields= JSON.stringify( condFields) ;
    }
    //基于配置
    if(data.queryType==1){
    	//条件字段
    	var sortFields=mini.get("gridOrder").getData();
    	if(sortFields.length>0){
    		_RemoveGridData(sortFields);
            data.sortFields=JSON.stringify( sortFields);
    	}
        
    }
    
    var url=__rootPath +"/sys/core/sysEsQuery/save.do";
    
	var config={
    	url:url,
    	method:'POST',
    	postJson:true,
    	data:data,
    	success:function(result){
    		CloseWindow('ok');
    	}
    }
	_SubmitJson(config);
}	

/**
 * 当sql框没有数据时自动构建SQL
 * @returns
 */
function initSql(){
	var esTable=mini.getByName("esTable").getValue();
	if(!esTable){
		alert("没有填写索引!");
		return;
	}
	var sql=editor.getValue().trim();
	if(!sql){
		
		var str="select * from " + esTable + " where 1=1 ";
		sql = "String sql=\"" + str + "\";\r\n return sql;"
		insertVal(editor, sql);
	}
	
}

var aryTxt={"text":true,"keyword":true};
var aryNum={"long":true,"integer":true,"short":true,"double":true,"byte":true,"float":true,"half_float":true,"scaled_float":true};
var aryDate={"date":true};

/**
 * 获取类型。
 * @param type
 * @returns
 */
function getDataType(type){
	if(aryTxt[type]) return "string";
	if(aryNum[type]) return "number";
	if(aryDate[type]) return "date";
}

/**
 * 插入条件。
 * @param e
 * @returns
 */
function changeCondition(e){
	var v=e.value;
	insertVal(editor, v);
}

/**
 * 
 * textword.
 */
var strOpJson=[
	{"id" : "=","text" : "等于"},
	{"id" : "like","text" : "like"}
];

/**
 * 数字操作
 */
var numOpJson=[
	{"id" : "<","text" : "小于"},
	{"id" : "<=","text" : "小于等于"},
	{"id" : "=","text" : "等于"},
	{"id" : ">","text" : "大于"},
	{"id" : ">=","text" : "大于等于"},
	{"id" : "in","text" : "in"},
	{"id" : "between","text" : "between"},
];

/**
 * 日期操作
 */
var dateOpJson=[
	{"id" : "<","text" : "小于"},
	{"id" : "<=","text" : "小于等于"},
	{"id" : "=","text" : "等于"},
	{"id" : ">","text" : "大于"},
	{"id" : ">=","text" : "大于等于"},
	{"id" : "between","text" : "between"},
];

/**
 * 条件下拉框处理。
 * @param e
 * @returns
 */
function gridWhereCellBeginEdit(e) {
	var field = e.field;
	var record = e.record;
	if (field == "typeOperate") {
		var type=getDataType(record.type);
		
		if (type == 'string') {
			e.editor.setData(strOpJson);
		} else if (type == 'number') {
			e.editor.setData(numOpJson);
		} else if (type == 'date') {
			e.editor.setData(dateOpJson);
		}
	} else if (field == 'valueDef') {
		if (record.valueSource == '' || !record.valueSource)
			e.cancel = true;
		else if (record.valueSource == 'param')
			e.cancel = true;
		else if (record.valueSource == 'script')
			e.editor = mini.get("scriptEditor");
		else if (record.valueSource == 'constantVar')
			e.editor = mini.get("constantEditor");
		else
			e.editor = mini.get("valueDefTextBox");
	}
	e.column.editor = e.editor;
	
}

//预览
function preview(pkId) {
	var url= __rootPath +"/sys/core/sysEsQuery/preview.do?id=" + pkId;
	_OpenWindow({
		url :  url ,
		title : "预览",
		max : true
	});
}

//帮助
function help(pkId){
	var url= __rootPath +"/sys/core/sysEsQuery/help.do?id=" + pkId;
	_OpenWindow({
		url : url,
		title : "帮助",
		width:800,
		height:375
	});
}
