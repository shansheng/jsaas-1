<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/share/dialog.js"></script>
<script src="${ctxPath}/scripts/jquery/plugins/colorpicker/jquery.colorpicker.js"></script> 
<link href="${ctxPath}/scripts/sys/echarts/css/custom.css?version=${static_res_version}" rel="stylesheet" type="text/css" />

</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="echartsCustom.id" />
	<div class="form-container">
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden" value="${echartsCustom.id}" />
			<input id="table" name="table" class="mini-hidden" value="${echartsCustom.table}" />
			<input id="table" name="echartsType" class="mini-hidden" value="Table" />

			<div id="tabs1" class="mini-tabs" activeIndex="0" plain="false" buttons="#tabsButtons">
				<div id="commonDetail" title="基础数据">
						<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>图表名称</td>
								<td><input name="name" required="true" value="${echartsCustom.name}" class="mini-textbox" style="width:90%;"/></td>
							</tr>
							<tr>
								<td>标　　识</td>
								<td><input name="key" required="true" value="${echartsCustom.key}" class="mini-textbox" style="width:90%;"/></td>
							</tr>
							<tr>
								<td>数 据 源</td>
								<td>
									<input name="dsAlias"
										   value="${echartsCustom.dsAlias}"
										   id="dsAlias"
										   style="width: 350px;"
										   text="${echartsCustom.dsAlias}"
										   class="mini-buttonedit"
										   showClose="true"
										   onbuttonclick="onDatasource"
										   oncloseclick="_ClearButtonEdit"
									/>
								</td>
							</tr>
							<tr>
								<td>分类选择 *</td>
								<td>
									<input id="treeId"
										   name="treeId"
										   class="mini-treeselect"
										   multiSelect="false"
										   textField="name"
										   valueField="treeId"
										   parentField="parentId"
										   required="true"
										   showFolderCheckBox="true"
										   expandOnLoad="true"
										   showClose="true"
										   oncloseclick="_ClearButtonEdit"
										   url="${ctxPath}/sys/echarts/echartsCustom/getUserGrantTreeList.do" resultAsTree="false"
										   popupWidth="350"
										   style="width:350px"
									/>
								</td>
							</tr>
							<tr>
								<td>查询类型</td>
								<td>
									<div class="mini-radiobuttonlist" textField="text" valueField="id" 
										value='${(empty echartsCustom.sqlBuildType) ? 'freeMakerSql': echartsCustom.sqlBuildType}' 
										data="[{id:'freeMakerSql',text:'Freemarker Sql'}]" name="sqlBuildType" id="sqlBuildType"
										onvaluechanged="changeQueryType"></div>
								</td>
							</tr>
							<tr id="sqlTR">
								<td>输入SQL</td>
								<td style="padding: 4px 0 0 0 !important;">
									<div>
										支持freemaker语法 条件字段: <input id="freemarkColumn" class="mini-combobox" showNullItem="true" nullItemText="可选条件列头"
											valueField="fieldName" textField="fieldLabel" onvalueChanged="varsFreeChanged" /> 常量: <input id="constantItem"
											class="mini-combobox" showNullItem="true" nullItemText="可用常量" url="${ctxPath}/sys/core/public/getConstantItem.do"
											valueField="key" textField="val" onvalueChanged="constantFreeChanged" />
									</div><textarea id="sql" emptyText="请输入sql" rows="5" cols="100" width="500" style="height:50px;">${echartsCustom.sql}</textarea>
								</td>
							</tr>
						</table>
				</div>
				<div id="title-tab" title="标题设置">
						<table class="table-detail column_2" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>标题显示</td>
								<td><input id="title-show" class="mini-radiobuttonlist"
									valueField="id" textField="text" 
									data="[{'id':'0', 'text':'是'},{'id':'1', 'text':'否'}]" value="0"/></td>
							</tr>
							<tr>
								<td>标题对齐</td>
								<td>
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">水平位置</label></td>
											<td><input id="title-x" class="mini-radiobuttonlist"
												valueField="id" textField="text" 
												data="[{'id':'left', 'text':'左'},{'id':'center', 'text':'中'},{'id':'right', 'text':'右'}]" value="left"/></td>
										<tr>
									</table>
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">垂直位置</label></td>
											<td><input id="title-y" class="mini-radiobuttonlist"
												valueField="id" textField="text" 
												data="[{'id':'top', 'text':'上'},{'id':'middle', 'text':'中'},{'id':'bottom', 'text':'下'}]" value="top"/></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>字　　体</td>
								<td><input id="title-textStyle-fontFamily" class="mini-combobox" 
									style="width:150px;" textField="id" valueField="id" 
    								data="[{'id':'sans-serif'},{'id':'serif'},{'id':'monospace'},{'id':'Arial'},{'id':'Courier New'},{'id':'Microsoft YaHei'}]" 
    								value="sans-serif"/></td>
							</tr>
							<tr>
								<td>字体风格</td>
								<td><input id="title-textStyle-fontStyle" class="mini-combobox" 
									style="width:150px;" textField="text" valueField="id" 
    								data="[{'id':'normal', 'text':'正常'},{'id':'italic', 'text':'斜体'}]" value="normal"/></td>
							</tr>
							<tr>
								<td>字体大小</td>
								<td><input id="title-textStyle-fontSize" class="mini-textbox" vtype="int"
									style="width:150px;" textField="text" valueField="id" value="18"/></td>
							</tr>
							<tr>
								<td>副 标 题</td>
								<td><input id="title-subtext" value="" class="mini-textbox" style="width:50%;" maxlength="20"/></td>
							</tr>
						</table>
				</div>
				<div title="数据字段" showCloseButton="false">
					<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
						<a class="mini-button"  plain="true" onclick="selectColumnQuery">列头设置</a> <a class="mini-button btn-red"
							 plain="true" onclick="removeRow('gridQuery')">删除</a> <span class="separator"></span> <a class="mini-button"
							 plain="true" onclick="upRow('gridQuery')">向上</a> <a class="mini-button" plain="true"
							onclick="downRow('gridQuery')">向下</a>
					</div>
					<div id="gridQuery" class="mini-datagrid" style="width: 100%;" showPager="false" allowCellEdit="true" allowCellSelect="true"
						allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div field="comment" width="120" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="120" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
				</div>
				<div title="排列栏位" showCloseButton="false">
					<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
						<a class="mini-button"  plain="true" onclick="selectColumnXAxis">列头设置</a>
						<a class="mini-button btn-red"  plain="true" onclick="removeRow('gridXAxis')">删除</a>
						<span class="separator"></span>
						<a class="mini-button"  plain="true" onclick="upRow('gridXAxis')">向上</a>
						<a class="mini-button"  plain="true" onclick="downRow('gridXAxis')">向下</a>
					</div>
					<div id="gridXAxis" class="mini-datagrid" style="width: 100%;" showPager="false" allowCellEdit="true" allowCellSelect="true"
						oncellbeginedit="gridWhereCellBeginEdit" oncellendedit="gridWhereCellEndEdit" allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn" width="40">序号</div>
							<div field="comment" width="120" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="120" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
				</div>
				<div title="查询栏位" showCloseButton="false" visible="false">
					<div class="mini-toolbar"
						style="padding: 2px; text-align: left; border-bottom: none;">
						<a class="mini-button" iconCls="icon-setting" plain="true"
							onclick="selectColumnWhere">列头设置</a> <a class="mini-button btn-red"
							iconCls="icon-remove" plain="true"
							onclick="removeRow('gridWhere')">删除</a> <span class="separator"></span>
						<a class="mini-button" iconCls="icon-up" plain="true"
							onclick="upRow('gridWhere')">向上</a> <a class="mini-button"
							iconCls="icon-down" plain="true" onclick="downRow('gridWhere')">向下</a>
					</div>
					<div id="gridWhere" class="mini-datagrid" style="width: 100%;"
						showPager="false" allowCellEdit="true" allowCellSelect="true"
						oncellbeginedit="gridWhereCellBeginEdit"
						oncellendedit="gridWhereCellEndEdit" allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn" width="40">序号</div>
							<div field="comment" width="80" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="80" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
							<div field="valueSource" width="240" headerAlign="center">
								值来源(请输入SQL) <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
					<div id="divWhereJson" style="display: none;">${echartsCustom.whereField}</div>
				</div>
				<div title="自定义SQL" showCloseButton="false" name="customSQL" visible="false">
					<div>
						<div>
							条件字段:<input id="availableColumn" class="mini-combobox" showNullItem="true" nullItemText="可选条件列头" valueField="fieldName"
								textField="fieldLabel" onvalueChanged="varsChanged" /> 常量:<input id="constantItem" class="mini-combobox" showNullItem="true"
								nullItemText="可用常量" url="${ctxPath}/sys/core/public/getConstantItem.do" valueField="key" textField="val"
								onvalueChanged="constantChanged" />
						</div>
						<ul>
							<li>params存放传入参数，为一个Map数据结构。</li>
							<li>可以使用params.containsKey("变量名")判断上下文是否有对应的变量。</li>
						</ul>

						<textarea id="sqlDiy" emptyText="请输入sql" rows="10" cols="100" width="500" height="250"></textarea>
					</div>
				</div>

			</div>
		</form>

		<rx:formScript formId="form1" baseUrl="sys/echarts/echartsCustom" entityName="com.redxun.sys.echarts.entity.SysEchartsCustom" />
	</div>

	<script src="${ctxPath}/scripts/sys/echarts/echartsCustom.js?version=${version}"></script>
	<script type="text/javascript">
		var id = "${echartsCustom.id}";
		var tableType = "${echartsCustom.table}";
		var sysPath = '${ctxPath}';
		
		$(function() {
			initType();
			loadQuery(id);
			loadTitle('${echartsCustom.titleField}');
			loadGrid('${echartsCustom.gridField}');
			loadXAxis('${echartsCustom.xAxisField}');
			loadTree('${echartsCustom.treeId}');
			var sqlText = $("#sql");
	        sqlText.attr("disabled","disabled");
		});
		
		//保存
		function selfSaveData() {
			form.validate();
			if (!form.isValid())
				return;
			
			//数据字段处理
			var dataGridQuery = mini.get('gridQuery').getData();
			var queryData = [];
			for (var i = 0; i < dataGridQuery.length; i++) {
				var obj = {};
				obj.comment = dataGridQuery[i].comment;
				obj.fieldName = dataGridQuery[i].fieldName;
				queryData.push(obj);
			}
			if (queryData.length < 1) {
				alert("数据字段必须设置！");
				return;
			}
			var queryField = {
				name : 'dataField',
				value : queryData
			}
			
			//获取自定义查询SQL构建类型
			var type = mini.get("sqlBuildType").getValue();
			
			//x轴设置
			var dataGridXAxis = mini.get('gridXAxis').getData();
			var xAxisData = [];
			for (var i = 0; i < dataGridXAxis.length; i++) {
				var obj = {};
				obj.comment = dataGridXAxis[i].comment;
				obj.fieldName = dataGridXAxis[i].fieldName;
				//change -> obj.type = (dataGridQuery[i].shapeType == undefined ? "bar" : dataGridQuery[i].shapeType); //添加当前数据使用什么形状显示, version-1: bar, line
				xAxisData.push(obj);
			}
			var xAxisField = {
				name : 'xAxisDataField',
				value : xAxisData
			}
			
			//条件选择字段设置
			/* var dataGridWhere = mini.get('gridWhere').getData();
			var whereData = [];
			for (var i = 0; i < dataGridWhere.length; i++){
				var obj = {};
				obj.comment = dataGridWhere[i].comment;
				obj.fieldName = dataGridWhere[i].fieldName;
				obj.valueSource = dataGridWhere[i].valueSource;
				whereData.push(obj);
			}
			var whereField = {
				name : 'whereField',
				value : whereData
			} */
			
			formData = $("#form1").serializeArray();

			if (queryData.length > 0)
				formData.push(queryField);
			if (xAxisData.length > 0)
				formData.push(xAxisField);
			/* if (whereData.length > 0)
				formData.push(whereField); */

			for (var i = 0; i < formData.length; i++) {
				if (formData[i]['name'] == 'table') {
					formData[i]['value'] = tableType == 1 ? '1' : '0';
					break;
				}
			}
			if (type != "table") { //保存sql
				formData.push({
					name : "sql",
					value : sqlEditor.getValue()
				});
			}
			
			formData.push(setTitle()); 
			
			var jsonObj = formToObject(formData);
			var formJson = JSON.stringify(jsonObj);
			var postData = {
				json : formJson
			}
			//console.log(formJson);
			
			saveEchartsDetail(id, mini.getByName("key").getValue(), postData);
		}
	</script>
</body>
</html>