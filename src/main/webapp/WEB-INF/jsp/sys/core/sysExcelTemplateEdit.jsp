<%-- 
    Document   : [Excel模板]编辑页
    Created on : 2018-11-28 21:18:33
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[Excel模板]编辑</title>
<%@include file="/commons/edit.jsp"%>
<script src="${ctxPath}/scripts/share/dialog.js" type="text/javascript"></script>
</head>
<body>
	
	<div class="topToolBar" >
		<div>
			<a class="mini-button"
				plain="true"
				onclick="onSaveConfigJson" 
			>保存</a>
		</div>
		
	</div>

	<div style="display: none">
		<input class="mini-textbox" id="textboxEditor"> 
		<input class="mini-combobox" id="excelFieldEditor" textField="name" valueField="val" onvaluechanged="onFieldChanged"> 
		<input class="mini-combobox" 
				id="timeFormatEditor" 
				textField="format" 
				valueField="format" 
				showNullItem="true"
				allowInput="true"
				data="timeFormat" > 
		
	</div>
<div class="mini-fit">
	<div id="p1" class="form-container"
		style="width: 100%; height: 100%">
			
			<table id="formExcel" class="table-detail" cellspacing="1" cellpadding="0">
				<caption>[Excel模板] 基本信息</caption>
				<tr>
					<td>
						<span class="starBox"> 名称
							<span class="star">*</span>
						</span>
					</td>
					<td>
						<input id="templateName" name="templateName"
						value="" class="mini-textbox"
						required="true" style="width: 100%" />
						<div id="pkId" name="id" class="mini-hidden" ></div> 
					</td>
					<td>
						<span class="starBox"> 别名
							<span class="star">*</span>
						</span>
					</td>
					<td>
						<input id="templateNameAlias" name="templateNameAlias"
						value="" required="true"
						class="mini-textbox" style="width: 100%" />
					</td>
				</tr>
				<tr>
					
					<td >Excel模板上传</td>
					<td colspan="3">
						<input type="file" id="excelTemplateFile" name="excelTemplateFile" accept=".xls,.xlsx" /> 
						<a class="mini-button" id="btnUpload" onclick="doUpload()">上传EXCEL模版</a>
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td colspan="3"><input id="templateComment"
						name="templateComment" value=""
						class="mini-textarea" width="100%" />
					</td>
				</tr>
			</table>
			<div class="mini-fit" id="result"></div>
	</div>
	</div>
	<script type="text/javascript">
	var pkId = '${sysExcelTemplate.id}';
	

	$(function() {
		initForm();
	});
	
	
	</script>
	<script src="${ctxPath}/scripts/sys/sysExcelTemplate/excelTemplateEdit.js" ></script>
	
	
	<script id="tabsBaiduTemplate"  type="text/html">
			<div id="gridTab" class="mini-tabs" style="width: 100%; height: 100%">
			<#
				for(var i = 0; i<sheets.length;i++){
					var sheet=sheets[i];
					var showDb=sheet.dataType=="db";
			#>
				<div id="tab_<#=sheet.idx#>" data-options="{tabId:'tab_<#=sheet.idx#>'}"  class=" mini-toolbar"
					<#if(i>0){#> showCloseButton="true" <#}#>
					title="<#=sheet.name#>" iconCls="icon-info">
					<table id="tab_<#=sheet.idx#>" class="table-detail" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<span class="starBox"> 标题行:<span class="star">*</span></span>
							</td>
							<td>
								<input id="titleStartRow_<#=sheet.idx#>" 
										name="titleStartRow"
										required="true" 
										class="mini-spinner" minValue="0"
										maxValue="10000000" onvaluechanged="changeContentStart" />
								
								<div class="mini-hidden" name="name" value="<#=sheet.name#>" ></div>
								<div class="mini-hidden" name="idx" value="<#=sheet.idx#>" ></div>
								<a class="mini-button" onclick="loadHeader('<#=sheet.idx#>')">加载表头</a>
							</td>
							<td>
								<span class="starBox"> 内容行:<span class="star">*</span></span>
							</td>
							<td>
								<input  id="contentStartRow_<#=sheet.idx#>"
										name="contentStartRow"
										required="true" 
										class="mini-spinner" 
										minValue="0"
										maxValue="10000000" value="1" />
								
							</td>
							<td>
								<span class="starBox"> 类型:<span class="star">*</span></span>
							</td>
							<td>
								<div id="dataType_<#=sheet.idx#>"
									name="dataType"
									data-options="{idx:'<#=sheet.idx#>'}"
									class="mini-radiobuttonlist"
    								textField="text" 
									valueField="id" 
									value="db"
    								data="[{id:'db',text:'数据库'},{id:'es',text:'ELASTIC'}]" onvaluechanged="changeDataType" >
								</div>								
							</td>
							<td>
								<span class="starBox"> 选择表:<span class="star">*</span></span>
							</td>
							<td>
								
								<input 
									id="tableName_<#=sheet.idx#>"
									name="tableName"
									textName="tableName"
									style="width: 150px;" 
									class="mini-buttonedit" showClose="true"
									onbuttonclick="onTable" 
									oncloseclick="_ClearButtonEdit" visible="<#=showDb#>" />
								
								<input id="esTable_<#=sheet.idx#>" 
										name="esTable"  
										data-options="{idx:'<#=sheet.idx#>'}"
										class="mini-combobox" 
										textField="index" 
										valueField="index" 
    									showNullItem="true" 
    									required="true" 
    									allowInput="true"
    									onvalidation="onComboValidation" 
										visible="<#=!showDb#>"
									/> 
							</td>
						</tr>
						<tr>
							<td colspan="8">
								<a class="mini-button" data-options="{idx:'<#=sheet.idx#>'}"  onclick="delSelect">删除</a>&nbsp;
								<a class="mini-button" data-options="{idx:'<#=sheet.idx#>'}"  onclick="validSelect">验证规则</a>
							</td>
						</tr>
					</table>

					<div class="mini-fit">
							<div id="tableExcelGrid_<#=sheet.idx#>"
								class="mini-datagrid" style="width: 100%; height: 100%;"
								allowResize="true" 
								showPager="false" allowCellSelect="true"
								allowCellEdit="true" 
								multiSelect="true"
								allowAlternating="true"
								allowCellValid="true" 
								onCellbeginedit="changeEditor">
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div type="checkcolumn"></div>
									<div field="fieldName"   headerAlign="center">字段</div>
									<div name="comment" field="comment"   headerAlign="center">备注</div>
									<div field="columnType"   renderer="dataRender" headerAlign="center">数据类型</div>
									<div name="valid" field="valid"  displayField="validName"  headerAlign="center">验证规则</div>
									<div name="format" field="format"    headerAlign="center">格式</div>
									<div name="isNull" field="isNull"  align="center"  headerAlign="center" renderer="emptyRender">可空</div>
									<div name="mapType" field="mapType" displayField='mapTypeName' align="right" >
												值来源 <input property="editor" class="mini-combobox"
													valueField='mapType' textField='mapTypeName'
													data="myFieldEditors" />
									</div>
									<div field="mapValue" name="mapValue" displayField="excelFieldName" >值</div>
										
								</div>
							</div>
					</div>
				</div>
			<#}
			#>
			</div>

	</script>
</body>
</html>

