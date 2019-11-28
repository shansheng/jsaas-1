$(function(){
	$(".toobar_li_ul li").on("click", function(){
		//alert($(this).find("a").attr("plugin"));
		//createPlugin(this);
		//openPluginSetting(this);
	});
});

//初始化插件模板
function initPluginSetting(pluginJson){
	if(pluginJson.queryFilterJson == ""){
		return false;
	}
	var qJson = JSON.parse(pluginJson.queryFilterJson);
	var content;
	$(qJson).each(function(){
		var plugin = JSON.parse(this);
		if(plugin.pluginType != "mini-datepicker"){
			content = "<div class=\"pluginSetting\" plugin-data=\'"+this.toString()+"\'>"+
						"<div onclick=\"pluginSetting(this, '"+plugin.pluginType+"');\">"+
						"<table>"+
							"<tr>"+
								"<td><label>"+plugin.name+"</label></td>"+
								"<td><input class=\""+plugin.pluginType+" mini-custom-setting\"/></td>"+
							"</tr>"+
						"</table>"+
					"</div>"+
					"<a onclick=\"deletePlugin(this)\">×</a>"+
				"</div>";
		} else {
			content = "<div class=\"pluginSetting\" plugin-data=\'"+this.toString()+"\'>"+
						"<div onclick=\"pluginSetting(this, '"+plugin.pluginType+"');\">"+
							"<table>"+
								"<tr>"+
									"<td><label>"+plugin.name+"</label></td>"+
									"<td><input class=\""+plugin.pluginType+"\" showTime=\"true\"/>至<input class=\""+plugin.pluginType+"\" showTime=\"true\"/></td>"+
								"</tr>"+
							"</table>"+
						"</div>"+
						"<a onclick=\"deletePlugin(this)\">×</a>"+
					"</div>";
		}
		$("#templateContent").append(content);
	});
	mini.parse();
}

//创建插件配置html
function createPluginSetting(pluginName){
	var content = "";
	if(pluginName != "mini-datepicker"){
		content = "<div class=\"pluginSetting\">"+
						"<div onclick=\"pluginSetting(this, '"+pluginName+"');\">"+
							"<table>"+
								"<tr>"+
									"<td><label>参数</label></td>"+
									"<td><input class=\""+pluginName+" mini-custom-setting\"/></td>"+
								"</tr>"+
							"</table>"+
						"</div>"+
						"<a onclick=\"deletePlugin(this)\">×</a>"+
					"</div>";
	} else {
		content = "<div class=\"pluginSetting\">"+
						"<div onclick=\"pluginSetting(this, '"+pluginName+"');\">"+
							"<table>"+
								"<tr>"+
									"<td><label>日期</label></td>"+
									"<td><input class=\""+pluginName+"\" showTime=\"true\"/>至<input class=\""+pluginName+"\" showTime=\"true\"/></td>"+
								"</tr>"+
							"</table>"+
						"</div>"+
						"<a onclick=\"deletePlugin(this)\">×</a>"+
					"</div>";
	}
	$("#templateContent").append(content);
	mini.parse();
}

//删除控件
function deletePlugin(o){
	$(o).parent().remove();
}

//整体查询提交
function submitDashboard(){
	var params = {};
	$.each($("#queryFilterContainerFrm input[name]"), function(){
		params[$(this).attr("name")] = $(this).val();
	});
	$.each($("div[id^='chartContainer_']"), function(){
		var _alias = $(this).attr("alias");
		var _key = $(this).attr("key");
		var _eType = $(this).attr("eType");
		var _dashboard = $(this).attr("dashboard");
		$.post(__rootPath+'/sys/echarts/echartsCustom/json/'+_alias+'.do', params,
			function(dat){
				echartsCustomInit(_key, _alias, dat, _eType, _dashboard, params);
			}
		);
	});
}