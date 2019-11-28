//init
mini.parse();
var form = new mini.Form("form1");
var changeFlag = true;
var oldSource = "";
var tabObject = mini.get("tabs1");

//loading加载主题
function loadTheme(theme){
	if(theme == ""){
		return false;
	}
	mini.getByName("theme").setValue(theme);
}

//loading加载title属性
function loadTitle(title){
	if(title == "")
		return false;
	title = JSON.parse(title);
	mini.get("title-show").setValue(title.show? "0" : "1");
	mini.get("title-x").setValue(title.x);
	mini.get("title-y").setValue(title.y);
	mini.get("title-textStyle-fontFamily").setValue(title.textStyle.fontFamily);
	mini.get("title-textStyle-fontStyle").setValue(title.textStyle.fontStyle);
	mini.get("title-textStyle-fontSize").setValue(title.textStyle.fontSize);
	mini.get("title-subtext").setValue(title.subtext);
}

//loading加载legend属性
function loadLegend(legend){
	if(legend == "")
		return false;
	legend = JSON.parse(legend);
	mini.get("legend-show").setValue(legend.show? "0" : "1");
	mini.get("legend-type").setValue(legend.type);
	mini.get("legend-x").setValue(legend.x);
	mini.get("legend-y").setValue(legend.y);
	mini.get("legend-orient").setValue(legend.orient);
	mini.get("legend-align").setValue(legend.align);
	mini.get("legend-selectedMode").setValue(legend.selectedMode);
}

//loading加载grid属性
function loadGrid(grid){
	if(grid == "")
		return false;
	grid = JSON.parse(grid);
	if(mini.get("grid-top")){
		mini.get("grid-top").setValue(grid.top);
	}
	if(mini.get("grid-right")){
		mini.get("grid-right").setValue(grid.right);
	}
	if(mini.get("grid-bottom")){
		mini.get("grid-bottom").setValue(grid.bottom);
	}
	if(mini.get("grid-left")){
		mini.get("grid-left").setValue(grid.left);
	}
}

//loading加载xAxis属性
function loadXAxis(xAxis){
	if(xAxis == "")
		return false;
	xAxis = JSON.parse(xAxis);
	mini.get("xAxis-axisPointer-show").setValue(xAxis.axisPointer.show? "0" : "1");
	mini.get("xAxis-axisPointer-type").setValue(xAxis.axisPointer.type);
}

//loading加载series一些属性
function loadSeries(series){
	if(series == "")
		return false;
	series = JSON.parse(series);
	if(mini.get("series-selectedMode")){
		 mini.get("series-selectedMode").setValue(series.selectedMode? series.selectedMode : "none");
	}
	if(mini.get("series-roseType")){
		mini.get("series-roseType").setValue(series.roseType? series.roseType : "none");
	}
	if(mini.get("series-minRadius")){
		mini.get("series-minRadius").setValue(series.radius[0]);
	}
	if(mini.get("series-maxRadius")){
		mini.get("series-maxRadius").setValue(series.radius[1]);
	}
	if(mini.get("series-center-h")){
		mini.get("series-center-h").setValue(series.center[0]);
	}
	if(mini.get("series-center-v")){
		mini.get("series-center-v").setValue(series.center[1]);
	}
	if(mini.get("series-labelPosition")){
		mini.get("series-labelPosition").setValue(series.labelPosition);
	}
}

//loading加载tree所属
function loadTree(treeId){
	var tree = mini.get("treeId");
	var treeData = tree.data;
	for(var i = 0; i < treeData.length; i++){
		if(treeId == treeData[i].id){
			tree.setValue(treeData[i].id);
			tree.setText(treeData[i].name);
		}
	}
}

//开启双Y轴设置
var _openDoubleYAxis = mini.get("openDoubleYAxis");
if(_openDoubleYAxis != undefined){
	_openDoubleYAxis.on("valuechanged", function(e){
		var yindex = mini.get("gridQuery");
		var _index = 0;
		for(var i = 0; i < yindex.columns.length; i++){
			if(yindex.columns[i].field == "yAxisIndex"){
				_index = i;
			}
		}
		if(this.getValue() == 1){
			yindex.showColumn(_index);
		} else {
			yindex.hideColumn(_index);
		}
	});
}

//开启堆叠
var _openStack = mini.get("openStack");
if(_openStack != undefined){
	_openStack.on("valuechanged", function(e){
		var stock = mini.get("gridQuery");
		var _index = 0;
		for(var i = 0; i < stock.columns.length; i ++){
			if(stock.columns[i].field == "stack"){
				_index = i;
			}
		}
		if(this.getValue() == 1){
			stock.showColumn(_index);
		} else {
			stock.hideColumn(_index);
		}
	});
}

//开启折线平滑
var _openLineSmooth = mini.get("openLineSmooth");
if(_openLineSmooth != undefined){
	_openLineSmooth.on("valuechanged", function(){
		var smooth = mini.get("gridQuery");
		var _index = 0;
		for(var i = 0; i < smooth.columns.length; i++){
			if(smooth.columns[i].field == "smooth"){
				_index = i;
			}
		}
		if(this.getValue() == 1){
			smooth.showColumn(_index);
		} else {
			smooth.hideColumn(_index);
		}
	});
}

//行列对应扇形
var _detailMethod = mini.get("detailMethod");
if(_detailMethod != undefined){
	_detailMethod.on("valuechanged", function(e){
		var tabs1 = mini.get("tabs1");
		if(this.getValue() == 1){
			tabs1.updateTab("xAxis-tab", {"visible": true});
		} else {
			tabs1.updateTab("xAxis-tab", {"visible": false});
		}
	});
}

//是否开启下钻
var _openDrillDown = mini.get("openDrillDown");
if(_openDrillDown != undefined){
	_openDrillDown.on("valuechanged", function(e){
		var drillDown = mini.get("drillDown");
		if(this.getValue() == 1){
			$("#openDrillDownDiv").show(0);
			var _method = mini.get("drillDownMethod");
			drillDownSettingShowOrHide(_method.getValue());
		} else {
			$("#openDrillDownDiv").hide(0);
			$("#drillDownToolbar").hide(0);
			drillDown.setVisible(false);
		}
	});
}
//下钻的显示方式
var _drillDownMethod = mini.get("drillDownMethod");
if(_drillDownMethod != undefined){
	_drillDownMethod.on("valuechanged", function(e){
		var drillDown = mini.get("drillDown");
		drillDownSettingShowOrHide(this.getValue());
	});
}

function selectOpenWidowDemo(type, o, windowSelf) {
	var url = __rootPath;
	if(type == "charts"){
		url += "/sys/echarts/echartsCustom/select.do";
	} else if(type == "customList"){
		url += "/sys/echarts/echartsCustom/boList.do";
	}
    _OpenWindow({
        url: url,
        height: 590,
        width: 950,
        title: o.text+'选择',
        ondestroy: function (action) {
            if (action != 'ok') return;
            var iframe = this.getIFrameEl();
            var dat = iframe.contentWindow.getCustomChartsInfo();
            if(windowSelf == "window"){
            	var _val = "";
                if(type == "charts"){
                	_val = "/sys/echarts/echartsCustom/preview/"+dat.key+".do";
                } else {
                	_val = "/sys/core/sysBoList/"+dat.key+"/list.do";
                }
                mini.get("openWindowKey").setValue(dat.key);
                mini.get("openWindowUrl").setValue(_val);
            } else {
            	mini.get("drillDownKey").setValue(dat.key);
            }
        }
    });
}

function drillDownSettingShowOrHide(o){
	var drillDown = mini.get("drillDown");
	if(o == "openWindow") {
		$("#openWindowMethod").show(0);
		$("#refreshSelfMethod").hide(0);
	} else {
		$("#openWindowMethod").hide(0);
		$("#refreshSelfMethod").show(0);
	}
	$("#drillDownToolbar").show(0);
	drillDown.setVisible(true);
}

//标题设置
function setTitle(){
	var title = {}; 
	title.text = mini.getByName("name").getValue();
	title.show = (mini.get("title-show").getValue() == "0") ? true : false;
	title.subtext = mini.get("title-subtext").getValue();
	title.x = mini.get("title-x").getValue();
	title.y = mini.get("title-y").getValue();
	var textStyle = {}; //标题样式设置
	textStyle.fontFamily = mini.get("title-textStyle-fontFamily").getValue();
	textStyle.fontStyle = mini.get("title-textStyle-fontStyle").getValue();
	textStyle.fontSize = mini.get("title-textStyle-fontSize").getValue();
	title.textStyle = textStyle;
	var _titleField = {
		name : "titleField",
		value: title
	};
	return _titleField;
}

//图例设置
function setLegend(){
	var legend = {};
	legend.show = (mini.get("legend-show").getValue() == "0") ? true : false;
	legend.type = mini.get("legend-type").getValue();
	legend.x = mini.get("legend-x").getValue();
	legend.y = mini.get("legend-y").getValue();
	legend.orient = mini.get("legend-orient").getValue();
	if(mini.get("legend-align")){
		legend.align = mini.get("legend-align").getValue();
	}
	if(mini.get("legend-selectedMode")){
		legend.selectedMode = mini.get("legend-selectedMode").getValue();
	}
	if(mini.get("legend-calculable")){
		legend.calculable = mini.get("legend-calculable").getValue();
	}
	var _legendField = {
		name : "legendField",
		value: legend
	}
	return _legendField;
}

//Save
function saveEchartsDetail(_id, _key, postData){
	$.post(__rootPath+"/sys/echarts/echartsCustom/checkKeyExist.do", 
		{"id": _id, "key":_key}, 
		function(dat){
			if(dat.message == 'success'){
				$.ajax({
					url : __rootPath+"/sys/echarts/echartsCustom/save.do",
					type : "POST",
					data : postData,
					success : function(result) {
						//进行提示
						_ShowTips({
							msg : result.message
						});
						onOk();
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert("出错,错误码=" + XMLHttpRequest.status);
						alert("出错=" + XMLHttpRequest.responseText);
					}
				});
			} else {
				var config = {};
				config.width = 400;
				config.content = '"标识"值已经存在';
				_ShowErr(config);
				return false;
			}
		},
		'json'
	); 
}

/**********************************************************/

tabObject.on("beforeactivechanged", function(e) {
	if (e.tab.name == "customSQL") {
		var sql = sqlEditor.getValue() || "";
		if (!sql.trim()) {
			alert("请输入SQL!");
			e.cancel = true;
		}
	}
});

tabObject.on("activechanged", function(e) {
	if (e.tab.name == "customSQL") {
		editor.refresh();
		var sql = sqlEditor.getValue() || "";
		var tmp = editor.getValue();
		tmp = (tmp || "").trim();
		if (!tmp) {
			sql = "String sql=\"" + sql + "\";\r\n return sql;"
			editor.setValue(sql);
			editor.focus();
		}
	}
});

mini.get("gridWhere").on("drawcell",
	function(e) {
		var record = e.record, field = e.field, value = e.value;
		if (field == "typeOperate") {
			if (value != '' && (record.columnType == 'varchar' || record.columnType == 'clob'))
				e.cellHtml = getValueByKeyInJsonArray( value, stringOperateJson);
			else if (value != '' && record.columnTyp == 'number') {
				e.cellHtml = getValueByKeyInJsonArray(value, numberOperateJson);
			} else if (value != '' && value == 'date') {
				e.cellHtml = getValueByKeyInJsonArray(value, dateOperateJson);
			}
		}
	}
);

var editor = null;
var sqlEditor = null;
function initCodeMirror() {
	var obj = document.getElementById("sqlDiy");
	editor = CodeMirror.fromTextArea(obj, {
		matchBrackets : true,
		mode : "text/x-groovy"
	});

	var sqlObj = document.getElementById("sql");
	sqlEditor = CodeMirror.fromTextArea(sqlObj, {
		lineNumbers : true,
		matchBrackets : true,
		mode : "text/x-sql"
	});
	sqlEditor.setSize('auto', '100px');
}
initCodeMirror();

/*************************************************************/

function changeQueryType(e) {
	initType();
	//清除数据
	clearData();
}

function clearData() {
	mini.get("gridQuery").setData();
	mini.get("gridWhere").setData();
}

function initType() {
	var type = mini.get("sqlBuildType").getValue();
	var sqlPanel = tabObject.getTab("customSQL");
	var conditionDiv = $("#conditionDiv");
	$("#tableTR").hide();
	$("#sqlTR").show();
	toggleCondtionColumns(false);
	toggleTab(false);
	conditionDiv.show();
}

function toggleTab(show) {
	var sqlPanel = tabObject.getTab("customSQL");
	tabObject.updateTab(sqlPanel, {
		visible : show
	});
}

function toggleCondtionColumns(show) {
	var grid = mini.get("gridWhere");
	var aryCol = [ "typeOperate", "valueSource", "valueDef" ];
	for (var i = 0; i < aryCol.length; i++) {
		var col = grid.getColumn(aryCol[i]);
		show ? grid.showColumn(col) : grid.hideColumn(col)
	}
}

function textChanged(e) {
	var row = mini.get("gridWhere").getSelected();
	var obj = $("#valueDefTextAreaSpan");
	mini.get("gridWhere").updateRow(row, {
		valueDef : e.value
	});
}

var numberOperateJson = [ {
	"id" : "=",
	"text" : "等于"
}, {
	"id" : "!=",
	"text" : "不等于"
}, {
	"id" : "<",
	"text" : "小于"
}, {
	"id" : "<=",
	"text" : "小于等于"
}, {
	"id" : ">",
	"text" : "大于"
}, {
	"id" : ">=",
	"text" : "大于等于"
}, {
	"id" : "BETWEEN",
	"text" : "between"
} ];
var stringOperateJson = [ {
	"id" : "=",
	"text" : "等于"
}, {
	"id" : "!=",
	"text" : "不等于"
}, {
	"id" : "LI",
	"text" : " 模糊查询 "
}, {
	"id" : "LL",
	"text" : " 左模糊查询 "
}, {
	"id" : "LR",
	"text" : " 右模糊查询 "
}, {
	"id" : "IN",
	"text" : "in"
} ];
var dateOperateJson = [ {
	"id" : "=",
	"text" : "等于"
}, {
	"id" : "!=",
	"text" : "不等于"
}, {
	"id" : "<",
	"text" : "小于"
}, {
	"id" : "<=",
	"text" : "小于等于"
}, {
	"id" : ">",
	"text" : "大于"
}, {
	"id" : ">=",
	"text" : "大于等于"
}, {
	"id" : "BETWEEN",
	"text" : "between"
} ];

//加载显示双Y轴栏位
function loadOpenDoubleYAxis(__grid, dataFieldStr){
	for (var i = 0; i < dataFieldStr.length; i++) {
		if (dataFieldStr[i].yAxisIndex == 1) {
			mini.get("openDoubleYAxis").setValue("1");
			var _index = 0;
			for(var j = 0 ; j < __grid.columns.length; j++){
				if(__grid.columns[j].field == "yAxisIndex"){
					_index = j;
					break;
				}
			}
			__grid.showColumn(_index);
			break;
		}
	}
}
//加载显示堆叠栏位
function loadOpenStack(__grid, dataFieldStr){
	for(var i = 0; i < dataFieldStr.length; i++){
		if(dataFieldStr[i].stack == 1){
			mini.get("openStack").setValue("1");
			var _index = 0;
			for(var j = 0; j < __grid.columns.length; j++){
				if(__grid.columns[j].field == "stack"){
					_index = j;
					break;
				}
			}
			__grid.showColumn(_index);
			break;
		}
	}
}
//加载显示折线平滑栏位
function loadOpenLineSmooth(__grid, dataFieldStr){
	for(var i = 0; i < dataFieldStr.length; i++){
		if(dataFieldStr[i].smooth){
			mini.get("openLineSmooth").setValue("1");
			var _index = 0;
			for(var j = 0; j < __grid.columns.length; j++){
				if(__grid.columns[j].field == "smooth"){
					_index = j;
					break;
				}
			}
			__grid.showColumn(_index);
			break;
		}
	}
}

function loadQuery(id) {
	if (!id)
		return;

	var url = __rootPath + "/sys/echarts/echartsCustom/getById.do?id=" + id;

	$.get(url, function(data) {
		var dataFieldStr = data.dataField;
		var dataField = null;
		if (dataFieldStr != '') {
			dataFieldStr = dataFieldStr.replace(/\n/g, "").replace(/\r/g, "");
			dataField = mini.decode(dataFieldStr);
		}
		dataFieldStr = JSON.parse(dataFieldStr);
		var __grid = mini.get("gridQuery");
		loadOpenDoubleYAxis(__grid, dataFieldStr);
		loadOpenStack(__grid, dataFieldStr);
		loadOpenLineSmooth(__grid, dataFieldStr);
		mini.get('gridQuery').setData(dataField);

		var whereFieldStr = data.whereField;
		var whereField = [];
		if (whereFieldStr != '') {
			whereField = eval(whereFieldStr);
		}
		addFieldLabel(whereField);
		mini.get("gridWhere").setData(whereField);

		var xAxisFieldStr = data.xAxisDataField;
		var xAxisField = [];
		if (xAxisFieldStr != '') {
			xAxisField = eval(xAxisFieldStr);
		}
		//addFieldLabel(xAxisField);
		mini.get('gridXAxis').setData(xAxisField);
		
		if(data.drillDownField){
			var drillDown = JSON.parse(data.drillDownField);
			mini.get("openDrillDown").setValue(drillDown == null ? 0 : drillDown.isDrillDown);
			mini.get("drillDownMethod").setValue(drillDown == null ? "openWindow" : drillDown.drillDownMethod);
			mini.get("openWindowKey").setValue(drillDown == null ? "" : drillDown.openWindowKey);
			mini.get("openWindowUrl").setValue(drillDown == null ? "" : drillDown.openWindowUrl);
			mini.get("drillDownKey").setValue(drillDown == null ? "" : drillDown.drillDownKey);
			var ddFieldStr = drillDown == null ? null : drillDown.drillDownField;
			var ddField = [];
			if(ddFieldStr != null){
				ddField = eval(ddFieldStr);
			}
			mini.get("drillDown").setData(ddField);
			if(drillDown!= null && drillDown.isDrillDown == 1){
				$("#openDrillDownDiv").show(0);
				if(drillDown.drillDownMethod == "openWindow"){
					$("#openWindowMethod").show(0);
					$("#refreshSelfMethod").hide(0);
				} else {
					$("#openWindowMethod").hide(0);
					$("#refreshSelfMethod").show(0);
				}
				$("#drillDownToolbar").show(0);
				mini.get("drillDown").setVisible(true);
			} else {
				$("#openDrillDownDiv").hide(0);
				$("#drillDownToolbar").hide(0);
				mini.get("drillDown").setVisible(false);
			}
		}

		var whereData = $.clone(whereField);
		var freemarkColumn = mini.get("freemarkColumn");
		freemarkColumn.setData(whereData);

		var availableColumn = mini.get("availableColumn");
		availableColumn.setData(whereData);

	})
}

function addFieldLabel(whereField) {
	if (whereField) {
		for (var i = 0; i < whereField.length; i++) {
			var o = whereField[i];
			o.fieldLabel = o.comment;
		}
	}
}

function getValueByKeyInJsonArray(key, array) {
	var value = "";
	for (var i = 0; i < array.length; i++) {
		if (array[i].id == key) {
			value = array[i].text;
			break;
		}
	}
	return value;
}

function upRow(id) {
	var headGrid = mini.get(id);

	var row = headGrid.getSelected();
	if (row) {
		var index = headGrid.indexOf(row);
		headGrid.moveRow(row, index - 1);
	}
}
function downRow(id) {
	var headGrid = mini.get(id);
	var row = headGrid.getSelected();
	if (row) {
		var index = headGrid.indexOf(row);
		headGrid.moveRow(row, index + 2);
	}
}
function removeRow(id) {
	var headGrid = mini.get(id);
	var selecteds = headGrid.getSelecteds();
	if (selecteds.length > 0 && confirm('确定要删除？')) {
		headGrid.removeRows(selecteds);
	}
}

function varsChanged(e) {
	var val = e.value;
	insertVal(editor, val);
}

function constantChanged(e) {
	var val = e.value;
	insertVal(editor, val);
}

function CloseWindow(action) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}
function onOk(e) {
	CloseWindow("ok");
}
function onCancel(e) {
	CloseWindow("cancel");
}
//选择数据源
function onDatasource(e) {
	var btnEdit = this;
	var callBack = function(data) {
		btnEdit.setValue(data.alias);
		btnEdit.setText(data.name);
	}
	openDatasourceDialog(callBack);
}
//选择表
function onTable(e) {
	var btnEdit = this;
	var dsId = mini.get("dsAlias").getValue();
	var url = __rootPath+"/sys/db/sysDb/tableDialog.do";
	url = url + "?ds=" + dsId;
	mini.open({
		url : url,
		title : "选择表",
		width : 650,
		height : 380,
		ondestroy : function(action) {
			if (action != "ok")
				return;

			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.GetData();
			data = mini.clone(data); //必须
			if (data) {
				btnEdit.setValue(data.tableName);
				btnEdit.setText(data.tableName);
				tableType = data.type == 'table' ? 1 : 0;

				clearData();
			}

		}
	});
}
//选择列
function selectColumnQuery(e) {
	showDialog(function(data) {
		addData("gridQuery", data);
	})
}

function showDialog(callBack) {
	var queryType = mini.get("sqlBuildType").getValue();
	var dsId = mini.get("dsAlias").getValue();
	var query = "";
	if (queryType == "table") {
		var tableName = mini.get("tableName").getValue();
		if (tableName == "") {
			alert("请先选择对象!");
			return;
		}
		query = tableName;
	} else {
		var sql = sqlEditor.getValue();
		if (!sql) {
			alert("请填写SQL!");
			return;
		}
		query = sql;
	}

	var url = __rootPath + "/sys/db/sysDb/columnQueryDialog.do";

	mini.open({
		url : url,
		showMaxButton : true,
		title : "设置列名",
		width : 650,
		height : 380,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.loadData(queryType, query, dsId);
		},
		ondestroy : function(action) {
			if (action != "ok")
				return;
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.GetData();
			if (callBack) {
				callBack(data);
			}
		}
	});
}

function addData(gridId, data) {
	var grid = mini.get(gridId);
	var oldData = grid.getData();

	var addData = mini.decode(data);
	var json = getJson(oldData)

	for (var i = 0; i < addData.length; i++) {
		if (!json[addData[i].fieldName]) {
			var row = addData[i];
			row.comment = row.fieldLabel;
			//DataType//columnType
			var datatype = row.dataType;
			if (datatype == "string") {
				datatype = "varchar";
			}
			row.columnType = datatype;
			oldData.push(row);
		}
	}
	grid.setData(oldData);
}

function getJson(oldData) {
	var obj = {};
	for (var j = 0; j < oldData.length; j++) {
		obj[oldData[j].fieldName] = 1;
	}
	return obj;
}

//选择列
function selectColumnWhere(e) {
	showDialog(function(data) {
		addData("gridWhere", data);

		var freemarkColumn = mini.get("freemarkColumn");
		freemarkColumn.setData(data);

		var availableColumn = mini.get("availableColumn");
		availableColumn.setData(data);

	})
}
//选择列
function selectColumnXAxis(e) {
	showDialog(function(data) {
		addData("gridXAxis", data);
	});
}
//选择列
function selectColumnOrder(e) {
	showDialog(function(data) {
		addData("gridOrder", data);
	})
}
//选择列
function selectColumnDrillDown(e) {
	showDialog(function(data) {
		addData("drillDown", data);
	});
}

var valueSource = [ {
	id : "param",
	text : '参数传入'
}, {
	id : "fixedVar",
	text : '固定值'
}, {
	id : "script",
	text : '脚本'
}, {
	id : "constantVar",
	text : '常量'
} ];
function onvalueSourceRenderer(e) {
	for (var i = 0, l = valueSource.length; i < l; i++) {
		var g = valueSource[i];
		if (g.id == e.value)
			return g.text;
	}
	return "";
}
var typeOrder = [ {
	id : 'ASC',
	text : '升序'
}, {
	id : 'DESC',
	text : '降序'
} ];
function onTypeOrderRenderer(e) {
	for (var i = 0, l = typeOrder.length; i < l; i++) {
		var g = typeOrder[i];
		if (g.id == e.value)
			return g.text;
	}
	return "";
}

//单元格开始编辑事件处理
function gridWhereCellBeginEdit(e) {
	var field = e.field;
	var record = e.record;
	if (field == "typeOperate") {
		if (record.columnType == 'varchar' || record.columnType == 'clob') {
			e.editor.setData(stringOperateJson);
		} else if (record.columnType == 'number') {
			e.editor.setData(numberOperateJson);
		} else if (record.columnType == 'date') {
			e.editor.setData(dateOperateJson);
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
	curGrid = e.sender;
}

function gridWhereCellEndEdit(e) {
	var field = e.field;
	var record = e.record;
	if (field == "valueSource") {
		if (oldSource != e.value) {
			mini.get("gridWhere").updateRow(e.row, {
				valueDef : ""
			});
		}
		oldSource = e.value;
	}
}

//清除控件值
function onCloseClick(e) {
	var btn = e.sender;
	btn.setText('');
	btn.setValue('');
}

function getScript(e) {
	var buttonEdit = e.sender;
	var row = mini.get("gridWhere").getSelected();
	var scriptContent = typeof (row.valueDef) == 'undefined' ? ""
			: row.valueDef;

	_OpenWindow({
		url : __rootPath + "/sys/db/sysDb/scriptDialog.do",
		title : "脚本内容",
		height : "450",
		width : "600",
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setScript(scriptContent);
		},
		ondestroy : function(action) {
			if (action != 'ok')
				return;
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.getScriptContent();
			buttonEdit.value = data;
			buttonEdit.text = data;
		}
	});
}

function constantFreeChanged(e) {
	var val = e.value;
	insertVal(sqlEditor, val);
}

function insertVal(editor, val) {
	var doc = editor.getDoc();
	var cursor = doc.getCursor(); // gets the line number in the cursor position
	doc.replaceRange(val, cursor); // adds a new line
}

function varsFreeChanged(e) {
	var val = e.value;
	insertVal(sqlEditor, val);
}