<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${ctxPath}/styles/list.css?static_res_version=${version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/mini/boot.js?static_res_version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share.js?static_res_version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jQuery.download.js?static_res_version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/util.js?version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/list.js?static_res_version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/form.js?static_res_version=${version}" type="text/javascript"></script>
<link href="${ctxPath}/styles/commons.css?static_res_version=${version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/share/dialog.js?version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jquery.getscripts.js?version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/baiduTemplate.js?version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/customer/mini-custom.js?version=${version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/sys/echarts/echartsFrontCustom.js?t=34" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery-1.11.3.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/sys/echarts/jQuery.print.js" type="text/javascript"></script>
<style>
	.etable-cond-f-span{display:inline-block;font-size:14px;min-width:80px;
			text-align:right;box-sizing:border-box;vertical-align:middle;color:#999;}
	#print-table{border:1px solid #999;border-collapse: collapse;}
	#print-table th, #print-table td{border:1px solid #999;}
	#print-table td{text-align:center;}
</style>


<#-- 获取数据集的第一行数据，并设定 -->
<#assign n = 0>
<#list data as _data>
	<#if n lt 1>
		<#assign item=_data>
		<#break>
	</#if>
</#list>
<#-- 搜索栏 -->
<#if !drillDownNext>
	

<#if qArray??>
	<div class="titleBar mini-toolbar">
		<div class="searchBox">
			<form id="searchForm_${alias}" class="search-form">
				<ul>
					<#list qArray as qa>
						<li>
							<#list qa ? keys as key>
								<#if key == "comment">
									<#assign emptyText=qa["${key}"]>
								</#if>
								<#if key == "fieldName">
									<input class="mini-textbox" name="Q_${qa["${key}"]}_S_LK" emptyText="${emptyText}" onenter="conditionDoSearch()"/>
								</#if>
							</#list>
						</li>
					</#list>
					<li class="searchBtnBox">
						<a class="mini-button _search" style="display:none;" id="tableSearchBtn" onclick="searchForm(this);">搜索</a>
						<a class="mini-button _reset" onclick="onClearList(this);">清空</a>
					</li>
					<li><span class="separator" style="min-width:0px;"></span></li>
					<li class="searchBtnBox">
						<a class="mini-button"  onclick="exportExcel('', '${alias}');">导出</a>
						<a class="mini-button"  onclick="printTable('', '${alias}');">打印</a>
					</li>
				</ul>
			</form>
		</div>
	</div>
</#if>
</#if>
<#-- dataGrid位置 -->
<div class="mini-fit" style="height:100%;">
	<div id="datagrid1_${alias}" class="mini-datagrid" style="width:100%;height:100%;" allowResize="false" 
			url="${ctxPath}/sys/echarts/echartsCustom/previewTableJson/${alias}.do${param}" 
			multiSelect="true" showColumnsMenu="true" 
			sizeList="[5,10,20,50,100]" pageSize="10" allowAlternating="true" 
			pagerButtons="#pagerButtons" onload="dataLoad" allowMoveColumn="false">
		<div property="columns">
			<div type="indexcolumn"></div>
			<#if qArray??>
				<#list qArray as qa>
					<#list qa ? keys as key>
						<#if key == "fieldName">
							<#assign _key = qa["${key}"]>
						</#if>
						<#if key == "comment">
							<#assign _name = qa["${key}"]>
						</#if>
					</#list>
					<div field="${_key}" name="${_key}">${_name}</div>
				</#list>
			</#if>
			<#if vArray??>
				<#list vArray as va>
					<#list va ? keys as key>
						<#if key == "fieldName">
							<#assign _key = va["${key}"]>
						</#if>
						<#if key == "comment">
							<#assign _name = va["${key}"]>
						</#if>
					</#list>
					<div field="${_key}" name="${_key}">${_name}</div>
				</#list>
			</#if>
		</div>
	</div>
	<div id="ooo" style="width:100%;height:auto;display:none;">
		<table id="print-table" style="width:100%;">
			<thead><tr></tr></thead>
			<tbody></tbody>
		</table>
	</div>
</div>

<form id="hideFrm_${alias}" action="${ctxPath}/sys/echarts/echartsCustom/exportExcel/${alias}.do" method="post">
	<input type="hidden" name="alias" value="${alias}"/>
	<textarea id="pageData_${alias}" name="data" style="display:none;"></textarea>
</form>

<script>
	mini.parse();
	var grid = mini.get("datagrid1_${alias}");
	grid.load();
	
	function conditionDoSearch(){
		mini.get("tableSearchBtn").doClick();
	}
	
	function printTable(key, alias){
		var _grid = mini.get("#datagrid1_"+alias);
		var _datas = _grid.getData();
		var _columns = _grid.getColumns();
		$("#print-table thead tr").html("");
		$("#print-table tbody").html("");
		$.each(_columns, function(n, _column){
			$("#print-table thead tr").append("<th>"+(_column.header == undefined ? "" : _column.header)+"</th>");
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
			$("#print-table tbody").append(_html);
		});
	
		$("#print-table").print({
			globalStyles: true,
		    iframe: true
		});
	}
</script>