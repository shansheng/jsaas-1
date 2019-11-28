<%-- 
    Document   : [ES自定义查询]编辑页
    Created on : 2018-11-28 14:21:52
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[ES自定义查询]编辑</title>
<%@include file="/commons/edit.jsp"%>
<script type="text/javascript" src="${ctxPath}/scripts/sys/customform/sysCustom.js"></script>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/sys/customform/sysCustomEs.js"></script>
<style type="text/css">
.CodeMirror{
	height: 200px !important;
	border: 1px solid #eee; 
}
</style>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="sysEsQuery.id" >
	<c:if test="${not empty sysEsQuery.id }">
		<div class="self-toolbar">
			<a class="mini-button"  plain="true" onclick="preview('${sysEsQuery.id}')">测试</a>
			<a class="mini-button"  plain="true" onclick="help('${sysEsQuery.id}')">帮助</a>
		</div>
	</c:if>
</rx:toolbar>	
<div class="Mauto">	
		<form id="form1" method="post">
			<div id="tabEsSetting" class="mini-tabs" activeIndex="0" plain="false" >
				<div title="基本信息">
					<input id="pkId" name="id" class="mini-hidden" value="${sysEsQuery.id}" />
					<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
						<caption>ES自定义查询设置</caption>
				            <tr>
								<th>名称：</th>
								<td>
										<input name="name"  class="mini-textbox" required="true"/>
								</td>
							
								<th>别名：</th>
								<td>
										<input name="alias"  class="mini-textbox" required="true"/>
								</td>
							</tr>
				            <tr>
				            	<th>选择索引：</th>
								<td>
									<input id="esTable" 
										name="esTable"  
										class="mini-combobox" 
										textField="index" 
										valueField="index" 
    									showNullItem="true" 
    									required="true" 
    									allowInput="true"
    									onvalidation="onComboValidation" 
									/> 
									
								</td>
								<th>查询类型 :</th>
								<td>
										<div id="queryType" 
												name="queryType" 
												class="mini-radiobuttonlist"  
												textField="text" 
												valueField="id" 
												data="[{id:'1',text:'基于配置'},{id:'2',text:'编写SQL'}]" 
												value="1" 
												onvaluechanged="changeQueryType">
										</div>
								</td>
								
							</tr>
							
				            <tr id="trCustomSql" style="display:none;">
								<th>自定义SQL：</th>
								<td colspan="3">
									条件字段:
									<input id="comboCondition" class="mini-combobox"
										valueField="name" 
										textField="name" 
										onvaluechanged="changeCondition"
										/>
									<textarea id="query" name="query" rows="10" cols="100"></textarea>
										
								</td>
							</tr>
							<tr>
								<th>是否分页：</th>
								<td>
									<div id="needPage" name="needPage" class="mini-radiobuttonlist"  textField="text" valueField="id" 
										data="[{id:'1',text:'是'},{id:'2',text:'否'}]" value="1" ></div>
								</td>
								<th>分页大小：</th>
								<td>
										<input name="pageSize"  class="mini-textbox" value="20" />
								</td>
							</tr>
							
						</table>
					</div>
					<div title="返回字段" name="tabReturn">
						<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
							<a class="mini-button" iconCls="icon-setting" plain="true" onclick="reloadReturn()">重新加载</a> 
							<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('gridRtnFields')">删除</a> 
							<span class="separator"></span>
							<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('gridRtnFields')">向上</a> 
							<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('gridRtnFields')">向下</a>
						</div>
						<div id="gridRtnFields" 
							class="mini-datagrid" 
							style="width: 100%;"
							showPager="false" 
							multiSelect="true"
							allowCellEdit="true" 
							allowCellSelect="true"
							allowAlternating="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="checkcolumn"></div>   
								<div field="name" width="120" headerAlign="center">
									字段名 
								</div>
								<div field="type" width="120" headerAlign="center">
									类型 
								</div>
							</div>
						</div>
					
					</div>
					<div title="条件字段" name="tabCondition">
						<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
							<a class="mini-button" iconCls="icon-setting" plain="true" onclick="addCondition()">新增</a> 
							<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('gridWhere')">删除</a> 
							<span class="separator"></span>
							<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('gridWhere')">向上</a> 
							<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('gridWhere')">向下</a>
						</div>
						<div id="gridWhere" 
							class="mini-datagrid" 
							style="width: 100%;"
							showPager="false" 
							allowCellEdit="true" 
							multiSelect="true"
							allowCellSelect="true"
							oncellbeginedit="gridWhereCellBeginEdit"
							allowAlternating="true">
							<div property="columns">
								<div type="indexcolumn" width="40">序号</div>
								<div type="checkcolumn"></div>   
								<div field="name" width="120" headerAlign="center">字段
									<input property="editor" class="mini-combobox"
										valueField="name" textField="name" data="fieldAry"
										onvaluechanged="onFieldChanged"
										allowInput="true"
    									onvalidation="onComboValidation" 
										/>
								 </div>
								<div field="type" width="60" headerAlign="center">类型</div>
								<div name="typeOperate" 
									displayField="typeOperate_name"
									valueField="id" 
									textField="text" 
									field="typeOperate"
									vtype="required" 
									width="100" 
									align="center" 
									headerAlign="center">
									操作类型 
									<input property="editor" class="mini-combobox"
										valueField="id" textField="text" />
								</div>
								<div name="valueSource" 
									field="valueSource" 
									vtype="required"
									width="100" 
									renderer="onvalueSourceRenderer" 
									align="center"
									headerAlign="center" 
									editor="valueSourceEditor">
									值来源 
									<input property="editor" class="mini-combobox" data="valueSource" />
								</div>
								<div name="valueDef" field="valueDef" width="180" headerAlign="center">默认值</div>
							</div>
						</div>
					</div>
					<div title="排序字段"  name="tabSortField">
						<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
							<a class="mini-button" iconCls="icon-setting" plain="true" onclick="addSort()">新增</a> 
							<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('gridOrder')">删除</a> 
							<span class="separator"></span>
							<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('gridOrder')">向上</a> 
							<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('gridOrder')">向下</a>
						</div>
						<div id="gridOrder" 
							class="mini-datagrid" 
							style="width: 100%;"
							showPager="false" 
							multiSelect="true"
							allowCellEdit="true" 
							allowCellSelect="true"
							allowAlternating="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="checkcolumn"></div>   
								<div field="name" width="120" headerAlign="center">
									字段名 
									<input property="editor" 
										class="mini-combobox"
										valueField="name" 
										textField="name" 
										data="sortFieldAry"
										allowInput="true"
    									onvalidation="onComboValidation" 
										/>
								</div>
								<div field="typeOrder" 
									vtype="required" 
									width="100"
									renderer="onTypeOrderRenderer" 
									align="center"
									headerAlign="center">
									排序类型 
									<input property="editor" class="mini-combobox" data="typeOrder" />
								</div>
							</div>
						</div>
					</div>
				</div>
		</form>
		<div style="display: none;">
			<input id="valueDefTextBox" 
					class="mini-textbox" 
					style="width: 100%;"
					minWidth="120" /> 
			<input id="scriptEditor" 
					class="mini-buttonedit"
					onbuttonclick="getScript" 
					allowInput="false" 
					style="width: 100%;" />
			<input id="constantEditor" 
					class="mini-combobox"
					url="${ctxPath}/sys/core/public/getConstantItem.do" 
					valueField="key"
					textField="val" 
					style="width: 100%;" />
		</div>
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	
	var pkId = '${sysEsQuery.id}';
	$(function(){
		initForm();
	});
	
	</script>
</body>
</html>