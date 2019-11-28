/*$(document).ready(function(){
	setTimeout(function(){
		$.each($("div[id^='fit']"), function(){
			$(this).parent().parent().css({"width":"100%;", "height":"100%"});
			var _alias = $(this).parent().attr("alias");
			var _key = $(this).parent().attr("key");
			var _eType = $(this).parent().attr("eType");
			$.post(__rootPath+'/sys/echarts/echartsCustom/json/'+_alias+'.do', 
				function(dat){
					echartsCustomInit(_key, _alias, dat, _eType);
				}
			);
		});
	}, 600); //time too short? (0.0#)
});*/

function ininFrontEcharts(){ //Louis new append
	$.each($("div[id^='fit']"), function(){
		$(this).parent().parent().css({"width":"100%;", "height":"100%"});
		var _alias = $(this).parent().attr("alias");
		var _key = $(this).parent().attr("key");
		var _eType = $(this).parent().attr("eType");
		var _dashboard = $(this).parent().attr("dashboard");
		$.post(__rootPath+'/sys/echarts/echartsCustom/json/'+_alias+'.do', 
			function(dat){
				echartsCustomInit(_key, _alias, dat, _eType, _dashboard);
			}
		);
	});
}

function tableCustomInit(key, alias, dashboard, params){
	if(!params)
		params = {};
	$.post(__rootPath+"/sys/echarts/echartsCustom/jsonTable/"+alias+".do", params,
		function(data){
			var _alias = data.alias;
			var _qArray = data.qArray;
			var _vArray = data.vArray;
			var _data = data.data;
			var _html_ = "";
			var _item = data[0];
			
			if(!dashboard ){
				if(_qArray != undefined && _qArray != null && _qArray.length != 0){
					_html_ = '<div class="titleBar mini-toolbar">'+ 
								'<div class="searchBox">'+ 
									'<form id="searchForm_'+key+'" class="search-form">'+
										'<ul>';
					for(var i = 0; i < _qArray.length; i++){
						_html_ += '<li>' + 
									//'<span class="etable-cond-f-span">'+_qArray[i].comment+'</span>'+
									'<input class="mini-textbox" name="Q_'+_qArray[i].fieldName+'_S_LK" style="width:100px;" emptyText="'+_qArray[i].comment+'" onenter="conditionDoSearch(\''+key+'\');"/>'+
								'</li>';
					}
					_html_ += '<li class="liBtn">'+
								'<a class="mini-button " id="tableSearchBtn_'+key+'" style="display:none;" onclick="searchForm1(this, \''+key+'\');">搜索<a>'+
								'<a class="mini-button " onclick="onClearList1(this, \''+key+'\');">清空</a>'+
							'</li>'+
							'<li><span class="separator" style="mini-width:0px;"></span></li>'+
							'<li>'+
								'<a class="mini-button" iconCls="icon-export" onclick="exportExcel(\''+key+'\',\''+_alias+'\');">导出</a>'+
								//'<a class="mini-button" iconCls="icon-export" onclick="printTable(\''+key+'\',\''+_alias+'\');">打印</a>'+
							'</li></ul></form></div></div>';
				}
			}
			
			_html_ += '<div class="mini-fit" style="height:100%;">'+
							'<div id="datagrid1_'+key+'" class="mini-datagrid" style="width:100%;height:100%;" allowResize="false" '+
									'url="'+__rootPath+'/sys/echarts/echartsCustom/previewTableJson/'+_alias+'.do" '+
									'multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100]" pageSize="10" '+
									'alloAlternating="true" pageButtons="#pagerButtons" onload="dataLoad" allowMoveColumn="false">'+
								'<div property="columns">'+
									'<div type="indexcolumn"></div>';
			if(_qArray != undefined && _qArray != null && _qArray.length != 0){
				for(var i = 0; i < _qArray.length; i++){
					_html_ += '<div field="'+_qArray[i].fieldName+'" name="'+_qArray[i].fieldName+'" qcol="true">'+_qArray[i].comment+'</div>'
				}
			}
			if(_vArray != undefined && _vArray != null && _vArray.length != 0){
				for(var i = 0; i < _vArray.length; i++){
					_html_ += '<div field="'+_vArray[i].fieldName+'" name="'+_vArray[i].fieldName+'">'+_vArray[i].comment+'</div>'
				}
			}
			_html_ += '</div></div>';
			//_html_ += ('<div style="width:100%;height:auto;display:none;"><table id="printTable_'+key+'"><thead><tr></tr></thead><tbody></tbody></table></div>')
			_html_ += '</div>';
			_html_ += '<form id="hideFrm_'+key+'" action="'+__rootPath+'/sys/echarts/echartsCustom/exportExcel/'+_alias+'.do" method="post">'+
							'<input type="hidden" name="alias" value="'+alias+'"/>'+
							'<textarea id="pageData_'+alias+'" name="data" style="display:none;"></textarea>'+
					'</form>'
			$("#fit_"+key).html(_html_);
			
			mini.parse();
			var _grid = mini.get("datagrid1_"+key);
			_grid.load(params);
		}
	);
}

function conditionDoSearch(key){
	mini.get("tableSearchBtn_"+key).doClick();
}

function onClearList1(o, key){
	var form = $("#searchForm_"+key);
	form[0].reset();
	var inputAry = $("input", "#searchForm_"+key);
    searchByInput1(inputAry, key);
}

function searchForm1(o, key){
	var inputAry = $("input", "#searchForm_"+key);
	searchByInput1(inputAry, key);
}

function searchByInput1(inputAry, key){
	var params = []; 
	inputAry.each(function(i){
		var el = $(this);
	   	var obj = {};
	   	obj.name = el.attr("name");
	   	if(!obj.name) 
	   		return true;
	   	obj.value = el.val();
	   	params.push(obj);
	});
   
	var grid = mini.get("datagrid1_"+key);
	var data={};
	data.filter = mini.encode(params);
	data.pageIndex = grid.getPageIndex();
	data.pageSize = grid.getPageSize();
    data.sortField = grid.getSortField();
    data.sortOrder = grid.getSortOrder();
	grid.load(data);
}

function echartsCustomInit(key, alias, dat, eType, dashboard, params){
	//console.log(key + " : " + alias + " : " + eType);
	if(eType == "table"){
		tableCustomInit(key, alias, dashboard, params);
		return;
	}
	var _html;
	if(!dashboard){
		_html = "<div id=\"layout_"+key+"\" class=\"mini-layout\" style=\"width:100%;height:100%;\" expand=\"showNorth\">"+
					"<div region=\"north\" showHeader=\"false\" allowResize=\"false\" showSplit=\"false\" showSplitIcon=\"true\" expanded=\"false\" showProxy=\"false\" style=\"border:none;\">"+
						"<div id=\"condition_"+key+"\" class=\"mini-toolbar\"></div>"+
					"</div>"+
					"<div id=\"container_"+key+"\" region=\"center\" allowResize=\"false\" style=\"border:none;width:100%;height:100%;position:relative;\">"+
						"<div id=\"echart_"+key+"\" style=\"width:100%;height:100%;\"></div>"+
						"<a id=\"redrawEcharts_"+key+"\" class=\"mini-button\" iconCls=\"icon-emailAdd\" onclick=\"redrawEcharts('"+key+"', '"+alias+"');\" style=\"display:none;z-index:9999;position:absolute;right:0;top:0;\">还原</a>"+
					"</div>"+
				"</div>";
	} else {
		_html = "<div id=\"layout_"+key+"\" style=\"width:100%;height:100%;position:relative;\" expand=\"showNorth\">"+
					"<div id=\"echart_"+key+"\" style=\"width:100%;height:100%;\"></div>"+
					"<a id=\"redrawEcharts_"+key+"\" class=\"mini-button\" iconCls=\"icon-emailAdd\" onclick=\"redrawEcharts('"+key+"', '"+alias+"');\" style=\"display:none;z-index:9999;position:absolute;right:0;top:0;\">还原</a>"+
				"</div>";
	}
	
	$("#fit_"+key).html(_html);
	var theme = dat.theme;
	var condition = $("#condition_"+key);
	var conditionJson = dat.condition;
	var drillDown = dat.drillDown;
	var _param = {};
	if(conditionJson == null || conditionJson == ""){
		mini.parse();
		var layout = mini.get("layout_"+key);
		if(layout != undefined){
			loadForUpdateRegion(key);
			layout.updateRegion("north", {showSplitIcon: false});
		}
	} else {
		for(var i = 0; i < conditionJson.length; i++){
			var fieldName = conditionJson[i].fieldName;
			var comment = conditionJson[i].comment;
			var values = conditionJson[i].valueSource;
			var html = "<label style='padding:0 8px 0 15px;'>"+comment+"</label><input id='"+key+"_"+fieldName+"' name='"+key+"_miniSel' class='mini-combobox' style='width:150px;' textField='"+fieldName+"' valueField='"+fieldName+"'/>";
			condition.append(html);
		}
		mini.parse();
		var layout = mini.get("layout_"+key);
		if(layout != undefined){
			loadForUpdateRegion(key);
			for(var i = 0; i < conditionJson.length; i++){
				var fieldName = conditionJson[i].fieldName;
				var values = conditionJson[i].valueSource;
				var fie = key+"_"+fieldName;
				mini.get(fie).setData(values);
				mini.get(fie).on('valuechanged', function(e){
					echartQuery(__rootPath, key, conditionJson, alias, _param);
				});
			}
		}
	}
	
	if(layout != undefined){
		layout.on("beforeexpand", function(e){
			resizeEcharts(key, 300);
			loadForUpdateRegion(key);
		});
		layout.on("beforecollapse", function(e){
			resizeEcharts(key, 300);
			loadForUpdateRegion(key);
		});
	}
	
	
	var echart = echarts.init(document.getElementById("echart_"+key), theme);
	//var ecConfig = echarts.config;

	var _dat = dat.json;
	if(_dat == 'noData'){ //没有数据的处理
		_dat = noDataSetting(_dat);
	}
	specialSetting(_dat);
	echart.setOption(_dat);
	
	//注释，即关闭仪表图实时查询
	/*if(_dat.series.type == "gauge"){
		setInterval(function(){
			$.post(__rootPath+'/sys/echarts/echartsCustom/json/'+alias+'.do',
				function(data){
					echart.setOption(data.json, true);
				}
			);
		},1500);
	}*/
	
	bindClickEvent(echart, key, drillDown, _param, dashboard);
	
	$(window).resize(function(){
		resizeEcharts(key, 350);
		setTimeout(function(){
			loadForUpdateRegion(key);
			//if(gridster){
				//gridster.disable(); //固定网格
			//}
		}, 200);
	});
}

//图形点击触发下钻
function bindClickEvent(echart, key, drillDown, _param, dashboard){
	//console.log("bindClickEvent: " + key + " : " + JSON.stringify(drillDown) + " : " + JSON.stringify(_param));
	var ddField = new Array();
	if(drillDown != undefined && drillDown.drillDownField){
		$.each(drillDown.drillDownField, function(key, item){
			ddField.push(this.fieldName);
		});
	}
	if(drillDown && drillDown.isDrillDown == 1){
		echart.on("click", function(param){
			console.log(param);
			var _paramName = param.name;
			if(_paramName.indexOf("[") == 0 && _paramName.indexOf("]") == _paramName.length - 1){
				var paramNames = _paramName.substring(1, _paramName.length - 1).split(",");
				var ind_ = 0;
				$.each(paramNames, function(){
					if(ddField[ind_] != undefined){
						_param[ddField[ind_++]] = $.trim(this);
					}
				});
			}
			if(dashboard){//大屏联动，必须配有下钻，但是联动和下钻只能同时存在一种
				$.each($("div[id^='chartContainer_']"), function(){
					var _alias = $(this).attr("alias");
					var _key = $(this).attr("key");
					var _eType = $(this).attr("eType");
					var _dashboard = $(this).attr("dashboard");
					console.log(echart._zr.dom.id.toString().indexOf(_key));
					if(echart._zr.dom.id.toString().indexOf(_key) >= 0){//点击的图形不做变化
						return;
					}
					$.post(__rootPath+'/sys/echarts/echartsCustom/json/'+_alias+'.do', _param,
						function(dat){
							echartsCustomInit(_key, _alias, dat, _eType, _dashboard, _param);
						}
					);
				});
			} else {
				if(drillDown.drillDownMethod == "openWindow"){
					var _pa = "?";
					$.each(_param, function(key, value){
						_pa += (key + "=" + value + "&");
					});
					_OpenWindow({
						title: "下钻",
						width: "1000",
						height: "640",
						url: __rootPath + drillDown.openWindowUrl + _pa
					});
				} else {
					$.post(__rootPath+"/sys/echarts/echartsCustom/json/"+drillDown.drillDownKey+".do", _param, 
						function(data){
							echart.off("click");
							if(data.json == 'noData'){
								data.json = noDataSetting(data.json);
							}
							specialSetting(data.json);
							echart.setOption(data.json, true);
							showRedrawButton(key);
						}
					);
				}
			}
		});
	}
}

function showRedrawButton(key){
	mini.get("redrawEcharts_"+key).setVisible(true);
}

function redrawEcharts(key, alias){
	$.post(__rootPath+"/sys/echarts/echartsCustom/json/"+alias+".do",
		function(data){
			$("#fit_"+key).html("");
			echartsCustomInit(key, alias, data);
		}
	);
}

function specialSetting(data){
	//雷达图特殊设置
	if(data.radar && "emphasis" in data.series && "label" in data.series.emphasis && "formatter" in data.series.emphasis.label){
		var func = data.series.emphasis.label.formatter;
		data.series.emphasis.label.formatter = eval("(" + func + ")");
	}
	//字符云特殊设置
	if(data.series.type && data.series.type == "wordCloud"){
		var func = data.series.textStyle.normal.color;
		data.series.textStyle.normal.color = eval("(" + func + ")");
	}
}

function noDataSetting(dat){
	dat = {};
	dat.title = {};
	dat.title.text = "没有数据";
	dat.title.show = true;
	dat.title.textStyle = {};
	dat.title.textStyle.color = "red";
	dat.series = {};
	dat.series.type = "pie";
	return dat;
}

function loadForUpdateRegion(key){
	var layout = mini.get("layout_"+key);
	if(layout != undefined){
		layout.updateRegion("north", {height: $("#condition_"+key).innerHeight()});
	}
}

function resizeEcharts(key, time){
	var enti = document.getElementById("echart_"+key);
	if(enti == null){
		return false;
	}
	
	var echart = echarts.init(document.getElementById("echart_"+key));
	setTimeout(function(){
		echart.resize();
	}, time);
}

function echartQuery(ctxPath, key, conditionJson, alias, _param){
	//console.log(ctxPath + " : " + key + " : " + conditionJson + " : " + alias + " : " + _param);
	var echart = echarts.init(document.getElementById("echart_"+key));
	var params = {};
	for(var i = 0; i < conditionJson.length; i++){
		var fie = key + "_" + conditionJson[i].fieldName
		var sel = mini.get(fie);
		if(sel.getValue() == ""){
			continue;
		}
		params[conditionJson[i].fieldName] = sel.getValue();
	}
	$.post(ctxPath+'/sys/echarts/echartsCustom/json/'+alias+'.do', params, 
		function(data){
			specialSetting(data.json);
			echart.setOption(data.json, true);
			bindClickEvent(echart, key, data.drillDown, _param);
		}
	);
}

function dataLoad(e){
	var columns = e.source.columns;
	var dataAll = e.result.data;
	
	var rowJson = {};
	var cellList = [];
	for(var i = 0; i < dataAll.length; i++){
		for(var j = 1; j < columns.length; j++){
			if(columns[j].name == undefined){
				continue;
			}
			
			var curCellVal = dataAll[i][columns[j].field]; //当前行列单元格数据
			if(i == 0){ //第一行数据不做处理
				rowJson[columns[j].name] = {};
				var curAllField = ""; //行栏位数据和并值
				for(var kk = 1; kk <= j; kk++){
					curAllField += dataAll[i][columns[kk].field];
				}
				rowJson[columns[j].name]["value"] = curAllField;
				rowJson[columns[j].name]["startIndex"] = i;
				rowJson[columns[j].name]["countIndex"] = 1;
			} else if(i == dataAll.length - 1){ //最后一行数据
				if(j == 1){
					if(rowJson[columns[j].name]["value"] == curCellVal){
						cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"]+1, colSpan:1});
					} else {
						cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"], colSpan:1});
					}
					rowJson[columns[j].name]["value"] = curCellVal;
				} else {
					var lastAllField = ""; //上一行所有栏位数据合并
					var curAllField = ""; //当前行所有栏位数据合并
					for(var kk = 1; kk < j; kk++){
						lastAllField += dataAll[i-1][columns[kk].field];
						curAllField += dataAll[i][columns[kk].field];
					}
					//if(rowJson[columns[j - 1].name]["value"] == dataAll[i-1][columns[j - 1].field]){
					if(curAllField == lastAllField){
						if(rowJson[columns[j].name]["value"] == curCellVal){
							cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"]+1, colSpan:1});
						} else {
							cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"], colSpan:1});
						}
					} else {
						cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"], colSpan:1});
					}
				}						
			} else { //其他行数据
				if(j == 1){ //第一列数据
					if(rowJson[columns[j].name]["value"] == curCellVal){
						rowJson[columns[j].name]["countIndex"] = rowJson[columns[j].name]["countIndex"] + 1;
					} else {
						cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"], colSpan:1});
						rowJson[columns[j].name]["value"] = curCellVal;
						rowJson[columns[j].name]["startIndex"] = i;
						rowJson[columns[j].name]["countIndex"] = 1;
					}
				} else {
					//TODO check every pre_row_column is eq cur_row_column's value
					var lastAllField = ""; //上一行所有栏位数据合并
					var curAllField = ""; //当前行所有栏位数据合并
					for(var kk = 1; kk < j; kk++){
						lastAllField += dataAll[i-1][columns[kk].field];
						curAllField += dataAll[i][columns[kk].field];
					}
					//if(rowJson[columns[j - 1].name]["value"] == dataAll[i-1][columns[j - 1].field]){
					if(curAllField == lastAllField){
						if(rowJson[columns[j].name]["value"] == curCellVal){
							rowJson[columns[j].name]["countIndex"] = rowJson[columns[j].name]["countIndex"] + 1;
						} else {
							cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"], colSpan:1});
							rowJson[columns[j].name]["value"] = curCellVal;
							rowJson[columns[j].name]["startIndex"] = i;
							rowJson[columns[j].name]["countIndex"] = 1;
						}
					} else {
						cellList.push({rowIndex:rowJson[columns[j].name]["startIndex"], columnIndex:j, rowSpan:rowJson[columns[j].name]["countIndex"], colSpan:1});
						rowJson[columns[j].name]["value"] = curCellVal;
						rowJson[columns[j].name]["startIndex"] = i;
						rowJson[columns[j].name]["countIndex"] = 1;
					}
				}
			}
		}
	}
	
	e.sender.mergeCells(cellList);
}

function exportExcel(key, alias){
	mini.parse();
	var _grid = mini.get("datagrid1_"+(key==""?alias:key));
	var parent = $("#searchForm_"+alias);
	var inputAry = $("input", parent);
	var params = [];
	inputAry.each(function(i) {
		var el = $(this);
		var obj = {};
		obj.name = el.attr("name");
		if (!obj.name)
			return true;
		obj.value = el.val();
		params.push(obj);
	});
	var data = {};
	data.filter = mini.encode(params);
	data.sortField = _grid.getSortField();
	data.sortOrder = _grid.getSortOrder();
	document.getElementById("pageData_"+alias).value = JSON.stringify(data);
	document.getElementById("hideFrm_"+(key==""?alias:key)).submit();
}

/*function printTable(key, alias){
	mini.parse();
	var _grid = mini.get("#datagrid1_"+key);
	var _datas = _grid.getData();
	var _columns = _grid.getColumns();
	$("#printTable_"+key+" thead tr").html("");
	$("#printTable_"+key+" tbody").html("");
	$.each(_columns, function(n, _column){
		$("#printTable_"+key+" thead tr").append("<th>"+(_column.header == undefined ? "" : _column.header)+"</th>");
	});
	$.each(_datas, function(n, _data){
		var _ind = 0;
		var _html = "";
		for(var i = 0; i < _columns.length; i++){
			$.each(_data, function(_key, _val){
				if(_key == _columns[i].name){
					if(_ind == 0){
						_html += ("<tr><td>"+(n+1)+"</td><td>"+_val+"</td>");
					} else if(_ind == _columns.length - 1) {
						_html += ("<td>"+_val+"</td></tr>");
					} else {
						_html += ("<td>"+_val+"</td>");
					}
					_ind++;
				}
			});
		}
		$("#printTable_"+key+" tbody").append(_html);
	});

	$("#printTable_"+key).print({
		globalStyles: true,
	    iframe: true
	});
}*/