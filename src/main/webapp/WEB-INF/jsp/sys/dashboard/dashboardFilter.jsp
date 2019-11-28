<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>大屏过滤条件</title>
		<%@include file="/commons/edit.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/FullCalender/jquery-ui.min.css">
		<script type="text/javascript" src="${ctxPath}/scripts/jquery-1.11.3.js" ></script>
		<script type="text/javascript" src="${ctxPath}/scripts/layoutit/js/jquery-ui.js" ></script>
		<script type="text/javascript" src="${ctxPath}/scripts/sys/echarts/dashboard.js"></script>
		<style type="text/css">
ul.toobar_li_ul>li, .flex_ul>li {
	display: inline-block;
}

ul.toobar_li_ul>li {
	width: 90px;
	background: #e8f3f5;
	font-size: 12px;
	height: 26px;
	line-height: 26px;
	margin-bottom: 8px;
	margin-left: 8px;
	cursor: pointer;
}

ul.toobar_li_ul>li:hover {
	background: #ffff66;
}

.toobar_li_ul>li>a {
	color: #333;
}

.toobar_li_ul>li>a>i {
	padding-left: 6px;
	padding-right: 2px;
}

.toobar_li_ul>li>a>i.iconfont:before {
	color: #29A5BF;
	font-size: 12px;
}		
	
*{margin:0;padding:0;}	
body {
	background: white;
}

.ui-button-text-only .ui-button-text{
	padding: 0.25em 0.6em;
}

.lightGray-bg{background-color: #eee;}

.pluginSetting{display:inline-block;width:100%;height:auto;line-height:40px;margin:0;padding:0;position:relative;}
.pluginSetting>div{width:100%;height:100%;}
.pluginSetting>div>table{width:100%;}
.pluginSetting>div>table td{padding:0 5px;}
.pluginSetting>div>table td .mini-custom-setting{width:90%;}
.pluginSetting>div>table td:first-child{width:100px;text-align:right;}
.pluginSetting>a{position:absolute;line-height:40px;height:40px;top:0;left:20px;cursor:pointer;font-weight:bold;color:red;}
.pluginSetting>a:hover{font-size:14px;}
.mini-textbox-border{height:calc(100% - 5px);}

.cond{padding: 10px 20px;}
.cond>span{display:block;padding:5px 0;}
.cond>input{width:96%;line-height:30px;padding:0 3px;}
.slider{width:96%;height:6px;margin:10px 5px;display:inline-block;outline:none;}
.sliderVal{text-align:center;}
</style>
	</head>
	<body>
		<div style="width:100%;">
			<table style="width:100%;">
				<tr>
					<td style="width:50%;">
						<div>控件</div>
						<ul class="toobar_li_ul">
							<li><a plugin="mini-textbox"><i class="iconfont icon-clob"></i>文本</a></li>
							<li><a plugin="mini-combobox"><i class="iconfont icon-circle-arrow-bottom"></i>下拉框</a></li>
							<li><a plugin="mini-datepicker"><i class="iconfont icon-richeng"></i>日期范围</a></li>
						</ul>
					</td>
					<td style="text-align:right;padding-right:20px;">
						<a class="mini-button" onclick="saveCustomPlugin()">保存</a>
					</td>
				</tr>
			</table>
			
		</div>
		<div id="template" class="mini-fit">
			<div class="mini-layout" style="width:100%;height:100%;">
				<div region="center">
					<div id="templateContent" style="width:100%;height:100%;">
					</div>
				</div>
				<div region="east" title="控制面板" width="700">
					<div id="contro-mini-textbox" class="mini-fit" style="width:100%;height:100%;display:none;">
						<div class="cond">
							<span>条件名称</span>
							<input type="text" class="condName"/>
						</div>
						<div class="cond">
							<span>查询key值</span>
							<input type="text" class="condKey"/>
						</div>
						<div class="cond">
							<span>宽度</span>
							<input class="mini-radiobuttonlist" name="rbl-mini-textbox"
								data="[{'id':'100','text':'100%'}, {'id':'50','text':'1/2'}, {'id':'25','text':'1/4'}]" 
								textField="text" valueField="id" value="100"/>
						</div>
						<div class="cond">
							<a class="mini-button" onclick="modifyPlugin('mini-textbox');">保存</a>
						</div>
					</div>
					<div id="contro-mini-combobox" class="mini-fit" style="width:100%;height:100%;display:none;">
						<div class="cond">
							<span>条件名称</span>
							<input type="text" class="condName"/>
						</div>
						<div class="cond">
							<span>查询key值</span>
							<input type="text" class="condKey"/>
						</div>
						<div class="cond">
							<span>数据</span>
							<div style="width:100%;height:auto;">
								<input class="mini-radiobuttonlist" name="datasource-mini-combobox"
									data="[{'id':'custom','text':'自定义'}, {'id':'dic','text':'数据字典'}, {'id':'customSql','text':'自定义SQL'}]" 
									textField="text" valueField="id" value="custom" onvaluechanged="rblValChange"/>
								<div id="custom_row" style="width:100%;height:auto;margin-top:10px;display:block;">
									<div class="mini-toolbar" >
									    <table style="width:100%;">
									        <tr>
										        <td style="width:100%;">
										            <a class="mini-button"   plain="true" onclick="addRow">添加</a>
										            <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('customDataGrid')">删除</a>
										            <span class="separator"></span>
										            <a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('customDataGrid')">向上</a>
										            <a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('customDataGrid')">向下</a>
										        </td>
									        </tr>
									    </table>
									</div>
									<div id="customDataGrid" class="mini-datagrid" style="width:100%;height:150px;" showPager="false"
										allowCellEdit="true" allowCellSelect="true">
									    <div property="columns">
									        <div type="indexcolumn">序号</div>                
									        <div field="key" width="120" headerAlign="center">标识键
									         <input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" />
									        </div>    
									        <div field="name" width="120" headerAlign="center">名称
									        	<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" />
									        </div>    
									    </div>
									</div>
								</div>
								<div id="dic_row" style="width:100%;height:auto;margin-top:10px;display:none;">
									<label>数据字典项 </label>
									<input id="dicKey" name="dickey" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listDicTree.do" style="width:80%"
								        textField="name" valueField="pkId" parentField="parentId" 
								        showFolderCheckBox="false" onnodeclick="setTreeKey(e)"/>
								</div>
								<div id="customSql_row" style="width:96%;height:auto;margin-top:10px;display:none;">
									<table style="width:100%;">
										<tr>
											<th style="width:80px;">自定义SQL</th>
											<td><input id="sql" name="sql" style="width:250px;" class="mini-buttonedit" onbuttonclick="onButtonEdit_sql"/></td>
										</tr>
										<tr>
											<th>文本</th>
											<td><input id="sql_textfield" name="sql_textfield" class="mini-combobox" style="width:250px;"
												valueField="fieldName" textField="comment" required="true" allowInput="false"/></td>
										</tr>
										<tr>
											<th>数值</th>
											<td><input id="sql_valuefield" name="sql_valuefield" class="mini-combobox" style="width:250px;"
										  		valueField="fieldName" textField="comment" required="true" allowInput="false"/></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="cond">
							<span>宽度</span>
							<input class="mini-radiobuttonlist" name="rbl-mini-combobox"
								data="[{'id':'100','text':'100%'}, {'id':'50','text':'1/2'}, {'id':'25','text':'1/4'}]" 
								textField="text" valueField="id" value="100"/>
						</div>
						<div class="cond">
							<a class="mini-button" onclick="modifyPlugin('mini-combobox');">保存</a>
						</div>
					</div>
					<div id="contro-mini-datepicker" class="mini-fit" style="width:100%;height:100%;display:none;">
						<div class="cond">
							<span>条件名称</span>
							<input type="text" class="condName"/>
						</div>
						<div class="cond">
							<span>查询key值</span>
							<input type="text" class="condKey"/>
						</div>
						<div class="cond">
							<span>宽度</span>
							<input class="mini-radiobuttonlist" name="rbl-mini-datepicker"
								data="[{'id':'100','text':'100%'}, {'id':'50','text':'1/2'}, {'id':'25','text':'1/4'}]" 
								textField="text" valueField="id" value="100"/>
						</div>
						<div class="cond">
							<a class="mini-button" onclick="modifyPlugin('mini-datepicker');">确定</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- <div>
			<div>用户组织控件</div>
			<ul class="toobar_li_ul">
				<li><a plugin="mini-user"><i class="iconfont icon-geren5"></i>用户选择</a></li>
				<li><a plugin="mini-group"><i class="iconfont icon-kehu-copy"></i>用户组选择</a></li>
				<li><a plugin="mini-dep"><i class="iconfont icon-zuzhiguanli1"></i>部门选择器</a></li>
			</ul>
		</div> -->
		<!-- <div>
			<area id="templateView" name="templateView" type="text/plain"></area>
			<div id="pageTabContainer"></div>
		</div> -->
		<script>
			mini.parse();
			
			$(function(){
				//createPluginSetting('${pluginName}');
				initPluginSetting(${queryFilterJson});
				
				//初始化控件点击事件
				$("[plugin]").each(function(){
					var plugin = $(this).attr('plugin');
					$(this).parent().click(function(){
						createPluginSetting(plugin);
					});
				});
				
				$("[id^='radio-']").each(function(){
					$(this).buttonset();
				});
			});
			
			function pluginSetting(o, plugin){
				//step1	
				$(".pluginSetting").removeClass("lightGray-bg");
				$(o).parent().addClass("lightGray-bg");
				$("[id^='contro-']").hide(0);
				$("#contro-"+plugin).show(0);
				//step2更新右边控制面板的数据
				var pluginData = $(o).parent().attr("plugin-data");
				//init controller panel
				$("#contro-"+plugin).find(".condName").val($(o).find("label").text());
				$("#contro-"+plugin).find(".condKey").val("");
				mini.getByName("rbl-"+plugin).setValue(100);
				if(plugin == "mini-combobox"){
					mini.getByName("datasource-mini-combobox").setValue("custom");
					$("#custom_row").show(0);
					$("#dic_row").hide(0);
					$("#customSql_row").hide(0);
					mini.get("customDataGrid").setData({});
					mini.get("dicKey").setValue("");
					mini.get("sql").setValue("");
					mini.get("sql").setText("");
					mini.get("sql_textfield").setData();
					mini.get("sql_valuefield").setData();
				}
				//设置属性
				if(pluginData){
					pluginData = JSON.parse(pluginData);
					$("#contro-"+plugin).find(".condName").val(pluginData.name);
					$("#contro-"+plugin).find(".condKey").val(pluginData.key);
					mini.getByName("rbl-"+plugin).setValue(pluginData.pluginWidth);
					if(pluginData.dataSource){
						var from = pluginData.dataSource.from;
						mini.getByName("datasource-"+pluginData.pluginType).setValue(from);
						if(from == "custom"){
							mini.get("customDataGrid").setData(pluginData.dataSource.customData);
							$("#custom_row").show(0);
							$("#dic_row").hide(0);
							$("#customSql_row").hide(0);
						} else if(from == "dic"){
							$.post('${ctxPath}/sys/core/sysTree/getByCatKeyAndKey.do', 
									{"key":pluginData.dataSource.dicKey}, 
								function(result){
									mini.get("dicKey").setValue(result.data.key);
									mini.get("dicKey").setText(result.data.name);
								}
							);
							$("#custom_row").hide(0);
							$("#dic_row").show(0);
							$("#customSql_row").hide(0);
						} else {
							$.post('${ctxPath}/sys/db/sysSqlCustomQuery/listColumnByKeyForJson.do', 
									{"key":pluginData.dataSource.sql}, 
								function(result){
									var data = result.data;
									mini.get("sql").setValue(data.key);
									mini.get("sql").setText(data.name);
									var text = mini.get("sql_textfield");
									var value = mini.get("sql_valuefield");
									text.setData(data.resultField);
									text.setValue(pluginData.dataSource.textField);
									value.setData(data.resultField);
									value.setValue(pluginData.dataSource.valueField);
								}
							);
							$("#custom_row").hide(0);
							$("#dic_row").hide(0);
							$("#customSql_row").show(0);
						}
					}
				}
			}
			
			//初始化数据部分的设置
			function initDataSourceSetting(plugin){
				mini.getByName("datasource-mini-combobox").setValue("custom");
				mini.get("customDataGrid").setData({});
				mini.get("dicKey").setValue("");
				mini.get("sql").setValue("");
				mini.get("sql_textfield").setValue("");
				mini.get("sql_valuefield").setValue("");
			}
			
			function rblValChange(e){
				if(e.value == "custom"){
					$("#custom_row").show(0);
					$("#dic_row").hide(0);
					$("#customSql_row").hide(0);
				} else if(e.value == "dic"){
					$("#custom_row").hide(0);
					$("#dic_row").show(0);
					$("#customSql_row").hide(0);
				} else {
					$("#custom_row").hide(0);
					$("#dic_row").hide(0);
					$("#customSql_row").show(0);
				}
			}
			
			//设置插件属性plugin-data的json数据
			function modifyPlugin(plugin){
				var name = $.trim($("#contro-"+plugin).find(".condName").val());
				var key = $.trim($("#contro-"+plugin).find(".condKey").val());
				if(name == ""){
					mini.alert("请输入条件名称!", "注意", function(action){
						if(action!="ok") return;
					});
					return false;
				}
				if(key == ""){
					mini.alert("请输入查询key值!", "注意", function(action){
						if(action!="ok") return;
					});
					return false;
				}
				$(".lightGray-bg").find("label").text(name);
				var pluginWidth = mini.getByName("rbl-"+plugin).value;
				$(".lightGray-bg").css({"width":pluginWidth+"%"});
				//插件的配置
				var pluginData = {};
				pluginData.name = name;
				pluginData.key = key;
				pluginData.pluginType = plugin;
				pluginData.pluginWidth = pluginWidth;
				//数据类型的选择
				var datasource = mini.getByName("datasource-"+plugin);
				if(datasource){
					var type = datasource.value; //数据来源类型
					var dataSource = {};
					dataSource.from = type; //来源
					if(type == "custom"){
						var _data = mini.get("customDataGrid").getData();
						var arr = [];
						$(_data).each(function(){
							var single = {};
							single.key = this.key;
							single.name = this.name;
							arr.push(single);
						});
						dataSource.customData = arr;
					} else if(type == "dic"){
						dataSource.dicKey = mini.get("dicKey").value;
					} else {
						dataSource.sql = mini.get("sql").getValue();
						dataSource.textField = mini.get("sql_textfield").getValue();
						dataSource.valueField = mini.get("sql_valuefield").getValue();
					}
					pluginData.dataSource = dataSource;
				}
				//console.log(pluginData);
				$(".lightGray-bg").attr("plugin-data", JSON.stringify(pluginData));
				//alert("设置成功!");
				mini.alert("设置成功!", "成功", function(action){
					if(action!="ok") return;
				});
			}
			
			function addRow(){
				mini.get("customDataGrid").addRow({});
			}
			
			function setTreeKey(e){
				var node=e.node;
				e.sender.setValue(node.key);
				e.sender.setText(node.name);
			}
			
			/*点击选择自定义SQL对话框时间处理*/
			function onButtonEdit_sql(e) {
				var btnEdit = this;
				var callBack=function (data){
					btnEdit.setValue(data.key);   //设置自定义SQL的Key
					btnEdit.setText(data.name);
					
					loadSqlFields(data.key);
				}
				openCustomQueryDialog(callBack);
			}
			
			function loadSqlFields(key,callBack){
				_SubmitJson({                             //根据SQK的KEY获取SQL的列名和列头
					url:"${ctxPath}/sys/db/sysSqlCustomQuery/listColumnByKeyForJson.do",
					data:{
						key:key
					},
					showMsg:false,
					method:'POST',
					success:function(result){
						var data=result.data;
						var text=mini.get("sql_textfield");
						var value=mini.get("sql_valuefield");
						var params=mini.get("sql_params");
						
						text.setEnabled(true);   //设置下拉控件为可用状态
						value.setEnabled(true);
						text.setData();          //每次选择不同SQL，清空下拉框的数据
						value.setData();
						text.setData(data.resultField);      //设置下拉框的数据
						value.setData(data.resultField);
					}
				});
			}
			
			/**
			获取输入参数。
			*/
			function getParams(data){
				var aryJson=[];
				if(!data.whereField) return aryJson;
				var fields=mini.decode(data.whereField);
				for(var i=0;i<fields.length;i++){
					var field=fields[i];
					if(field.valueSource=="param"){
						aryJson.push(field);
					}
				}
				return aryJson;
			}
			
			var pluginJsonStr = "";
			function saveCustomPlugin(){
				var pluginJson = [];
				var pluginSettings = $("#templateContent").find(".pluginSetting");
				var noSetting = true;
				$(pluginSettings).each(function(){
					if($(this).attr("plugin-data")){
						pluginJson.push($(this).attr("plugin-data"));
					} else {
						noSetting = false;
						return false;
					}
				});
				if(!noSetting){
					//alert("尚有控件未配置属性!");
					mini.alert("尚有控件未配置属性!", "注意", function(action){
						if(action!="ok") return;
					});
					return false;
				}
				pluginJsonStr = JSON.stringify(pluginJson);
				CloseWindow('ok');
			}
		</script>
	</body>
</html>
