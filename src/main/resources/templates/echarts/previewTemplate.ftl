<!DOCTYPE html>
<html>
<head>
	<title>图形报表预览</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="${ctxPath}/scripts/mini/boot.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/share.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/jquery/plugins/jQuery.download.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/common/util.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/common/list.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/common/form.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/share/dialog.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/jquery/plugins/jquery.getscripts.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/common/baiduTemplate.js?version=${version}" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/customer/mini-custom.js?version=${version}" type="text/javascript"></script>
	<link  href="${ctxPath}/styles/list.css?version=${version}" rel="stylesheet" type="text/css" />
	<link  href="${ctxPath}/styles/commons.css?version=${version}" rel="stylesheet" type="text/css" />
	<script src="${ctxPath}/scripts/jquery-1.11.3.js?version=${version}" type="text/javascript" ></script>
	<script src="${ctxPath}/scripts/sys/echarts/echarts.min.js?version=${version}" type="text/javascript" ></script>
	<script src="${ctxPath}/scripts/sys/echarts/echarts-wordcloud.min.js?version=${version}" type="text/javascript" ></script>
	<script src="${ctxPath}/scripts/echart/theme/chalk.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/dark.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/essos.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/infographic.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/macarons.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/roma.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/shine.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/walden.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/echart/theme/westeros.js" type="text/javascript"></script>
	<style>
		*{margin:0;padding:0;font-size:12px;list-style:none;}
		html, body{width:100%;height:100%;background-color:#fff;}
		#condition{padding:4px 0;}
		#container{width:100%;height:100%;}
		#chartsContainer{width:100%;height:100%;}
		#redrawEcharts{position:absolute;right:0;top:0;}
		.condLab{padding:0 8px 0 15px;}
		.cus-btn{margin-left:20px;}
	</style>
	</head>
	<body>
		<div class="mini-fit">
			<div id="layout1" class="mini-layout" style="width:100%;height:100%;" expand="showNorth">
				<div id="north" region="north" showHeader="false" allowResize="false" showSplit="false" 
						showSplitIcon="true" expanded="false" showProxy="false" style="border:none;">
					<div id="condition" class="mini-toolbar"></div>
				</div>
				<div id="container" region="center" allowResize="false" style="border:none;width:100%;height:100%;position:relative;">
					<div id="chartsContainer"></div>
					<a id="redrawEcharts" class="mini-button" iconCls="icon-emailAdd" onclick="redrawEcharts('${alias}');" style="display:none;z-index:9999;">还原</a>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var dat = ${json};
			var condition;
			var conditionData;
			var conditionJson;
			var drillDown;
			
			var echart;
			
			if(dat == 'noData'){
				mini.parse();
				var layout = mini.get("layout1");
				loadForUpdateRegion();
				layout.updateRegion("north", {showSplitIcon: false, visible: false});
				dat = noDataSetting(dat);
				//echart.setOption(dat);
			} else {
				condition = $("#condition");
				conditionData = '${condition}';
				conditionJson = "";
				drillDown = ('${drillDown}' == '') ? '' : JSON.parse('${drillDown}');
				
				if(conditionData == undefined || conditionData == null || conditionData == ""){
					mini.parse();
					var layout = mini.get("layout1");
					loadForUpdateRegion();
					layout.updateRegion("north", {showSplitIcon: false, visible: false});
				} else {
					conditionJson = JSON.parse(conditionData);
					for(var i = 0; i < conditionJson.length; i++){
						var fieldName = conditionJson[i].fieldName;
						var comment = conditionJson[i].comment;
						var values = conditionJson[i].valueSource;
						var html = "<label class=\"condLab\">" + comment + "</label><input id=\""+fieldName+"\" name=\"miniSel\" class=\"mini-combobox\" "+ 
										"style=\"width:150px;\" textField=\""+fieldName+"\" valueField=\""+fieldName+"\"/>";
						condition.append(html);
					}
					mini.parse();
					var layout = mini.get("layout1");
					loadForUpdateRegion();
					for(var i = 0; i < conditionJson.length; i++){
						var fieldName = conditionJson[i].fieldName;
						var values = conditionJson[i].valueSource;
						mini.get(fieldName).setData(values);
						mini.get(fieldName).on('valuechanged', function(e){
							echartQuery();
						});
					}
				}
				
				layout.on("beforeexpand", function(e){
					resizeEcharts(300);
					loadForUpdateRegion();
				});
				layout.on("beforecollapse", function(e){
					resizeEcharts(300);
					loadForUpdateRegion();
				});
				
				echart = echarts.init(document.getElementById("chartsContainer") <#if theme ? exists>, '${theme}'</#if>);
				specialSetting(dat);
				echart.setOption(dat);
				/*if(drillDown != ''){
					showRedrawButton(drillDown.drillDownMethod);
				}*/
				
				//关闭仪表图实时查询
				/*if(dat.series.type == "gauge"){
					setInterval(function (){
						$.post('${ctxPath}/sys/echarts/echartsCustom/json/${alias}.do',
							function(data){
								echart.setOption(data.json, true);
							}
						);
					},1500);
				}*/
				
				bindClickEvent();
			}
			
			$(window).resize(function(){
				resizeEcharts(350);
				setTimeout(function(){
					loadForUpdateRegion();
				}, 200);
			});
			
			function loadForUpdateRegion(){
				layout.updateRegion("north", {height: $("#condition").innerHeight()});
			}
			
			function resizeEcharts(time){
				setTimeout(function(){
					echart.resize();
				}, time);
			}
			
			function showRedrawButton(drillDownMethod){
				if(drillDownMethod != "openWindow"){
					mini.get("redrawEcharts").setVisible(true);
				}
			}
			
			function specialSetting(dat){
				//雷达图的特殊设置
				if(dat.radar && "emphasis" in dat.series && "label" in dat.series.emphasis && "formatter" in dat.series.emphasis.label){
					var func = dat.series.emphasis.label.formatter;
					dat.series.emphasis.label.formatter = eval("(" + func + ")");
				}
				//字符云特殊设置
				if(dat.series.type && dat.series.type == "wordCloud"){
					var func = dat.series.textStyle.normal.color;
					dat.series.textStyle.normal.color = eval("(" + func + ")");
				}
			}
			
			function redrawEcharts(alias){
				window.location.reload();
			}
			
			var ddField = new Array();
			if(drillDown != undefined && drillDown.drillDownField){
				for(var k = 0; k < drillDown.drillDownField.length; k++){
					ddField.push( drillDown.drillDownField[k].fieldName);
				}
			}
			
			var _param = {};
			function bindClickEvent(){
				if(drillDown.isDrillDown == 1){
					echart.on("click", function(param){
						var _paramName = param.name;
						if(_paramName.indexOf("[") == 0 && _paramName.indexOf("]") == _paramName.length - 1){
							var paramNames = _paramName.substring(1, _paramName.length - 1).split(",");
							var ind_ = 0;
							$.each(paramNames, function(){
								_param[ddField[ind_++]] = $.trim(this);
							});
						} else {
							_param[ddField[0]] = _paramName;
						}
						_param["drillDownNext"] = "1";
					
						if(drillDown.drillDownMethod == "openWindow"){
							var _pa = "?";
							$.each(_param, function(key, value){
								_pa += (key + "=" + value + "&");
							});
							_OpenWindow({
								title: '下钻',
								width: "1000",
								height: "640",
								url: '${ctxPath}'+drillDown.openWindowUrl+_pa
							});
						} else {
							$.post('${ctxPath}/sys/echarts/echartsCustom/json/'+drillDown.drillDownKey+'.do', _param, 
								function(data){
									echart.off("click");
									if(data.json == 'noData'){
										data.json = noDataSetting(data.json);
									}
									specialSetting(data.json);
									echart.setOption(data.json, true);
									showRedrawButton(drillDown.drillDownMethod);
									//bindClickEvent();
								}
							);
						}
					});
				}
			}
			
			function echartQuery(){
				var params = {};
				for(var i = 0; i < conditionJson.length; i++){
					var sel = mini.get(conditionJson[i].fieldName);
					if(sel.getValue() == ""){
						continue;
					}
					params[conditionJson[i].fieldName] = sel.getValue();
				}
				$.post('${ctxPath}/sys/echarts/echartsCustom/json/${alias}.do', params, 
					function(data){
						specialSetting(data.json);
						echart.setOption(data.json, true);
						if(data.drillDown == undefined || data.drillDown == null || data.drillDown == ""){
							return false;
						}
						drillDownKey = data.drillDown.ddKey;
						//bindClickEvent();
					}
				);
	 		}
	 		
	 		//没有数据的处理
	 		function noDataSetting(dat){
	 			dat = {};
				dat.title = {};
				dat.title.text = "没有数据";
				dat.title.show = true;
				dat.title.textStyle = {};
				dat.title.textStyle.color = "red";
				dat.series = {};
				dat.series.type = 'pie';
				return dat;
	 		}
		</script>
	</body>
</html>