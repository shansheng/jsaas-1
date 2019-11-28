<%-- 
    Document   : [正则表达式]列表页
    Created on : 2018-11-28 14:21:52
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[正则表达式]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li class="liAuto"><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
					<li><span class="text">别名：</span><input class="mini-textbox" name="Q_KEY__S_LK"></li>
					<li class="liBtn">
						<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
						<a class="mini-button"   plain="true" onclick="clearForm()">清空查询</a>
					</li>
				</ul>
			</form>
		</div>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/bpm/core/bpmRegLib/listData.do?Q_TYPE__S_LK=${param.type}" idField="regId"
			multiSelect="false" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div field="name"  sortField="NAME_"  width="120" headerAlign="center" allowSort="true">名称</div>
				<div field="key"  sortField="KEY_"  width="120" headerAlign="center" allowSort="true">别名</div>
			</div>
		</div>
	</div>
	<div class="bottom-toolbar">
		<a   class="mini-button"  onclick="onOk()">确定</a>
		<a   class="mini-button" onclick="onCancel()">取消</a>
	</div>

	<script type="text/javascript">
		
		function getData() {
			var grid=mini.get("datagrid1");
			var row = grid.getSelected();
			return row;
		}
		
		function onOk() {
			CloseWindow("ok");
		}
		
		function onCancel() {
			CloseWindow("cancel");
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysEsQuery" winHeight="450"
		winWidth="700" entityTitle="ES自定义查询" baseUrl="sys/core/sysEsQuery" />
</body>
</html>