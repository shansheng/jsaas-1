<%-- 
    Document   : [业务实体对象]列表页
    Created on : 2018-05-01 14:21:00
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[业务实体对象]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<c:set var="query" value=""> </c:set>
	 <c:if test="${not empty param.Q_GEN_TABLE__S_EQ  }">
	 <c:set var="query" value="Q_GEN_TABLE__S_EQ=${ param.Q_GEN_TABLE__S_EQ }"> </c:set>
</c:if>

<c:set var="multiSelect" value="false"> </c:set>
<c:if test="${not empty param.single}">
	 <c:if test="${param.single=='false' }">
	 	<c:set var="multiSelect" value="true"> </c:set>
	 </c:if>
</c:if>

<div id="layout1" class="mini-layout" style="width:100%;height:100%;">	
	 <div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false">
		 <div class="southBtn">
			 <a class="mini-button"     onclick="onOk()">确定</a>
			 <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
		 </div>
	</div>
	<div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
		 <div class="mini-toolbar" >
			 <div class="searchBox">
				 <form id="searchForm" class="search-form">
					 <ul>
						 <li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
						 <li><span class="text">注释：</span><input class="mini-textbox" name="Q_COMMENT__S_LK"></li>
						 <li class="liBtn">
							 <a class="mini-button"  plain="true" onclick="searchFrm()">查询</a>
							 <a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
						 </li>
					 </ul>
					 <div id="moreBox">
						 <ul>
							 <li><span class="text">表名：</span><input class="mini-textbox" name="Q_TABLE_NAME__S_LK"></li>
							 <li><span class="text">数据源名称：</span><input class="mini-textbox" name="Q_DS_NAME__S_LK"></li>
						 </ul>
					 </div>
				 </form>
			 </div>

	     </div>
		<div class="mini-fit" style="height: 100%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				url="${ctxPath}/sys/bo/sysBoEnt/listData.do?${query}" idField="id"
				multiSelect="${multiSelect}" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="60"></div>
					<div field="name"  sortField="NAME_"  width="120"  >名称</div>
					<div field="comment"  sortField="COMMENT_"  width="120"  >注释</div>
					<div field="genMode" renderer="onGenModeRenderer"  width="120"  >创建方式</div>
					<div field="tableName"  sortField="TABLE_NAME_"  width="120"  >表名</div>
					<div field="dsName"  sortField="DS_NAME_"  width="120"  >数据源名称</div>
					<div field="genTable"  sortField="GEN_TABLE_"  width="120"  renderer="onGenTableRenderer" >是否生成物理表</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		
		
		function onGenTableRenderer(e) {
            var record = e.record;
            var genTable = record.genTable;
            var arr = [ {'key' : 'yes', 'value' : '已生成','css' : 'green'}, 
			            {'key' : 'no','value' : '未生成','css' : 'orange'} ];
			return $.formatItemValue(arr,genTable);
        }
		
		function onGenModeRenderer(e) {
            var record = e.record;
            var genTable = record.genMode;
            var arr = [ {'key' : 'create', 'value' : '设计','css' : 'green'}, 
			            {'key' : 'form','value' : '表单生成','css' : 'orange'} ];
			return $.formatItemValue(arr,genTable);
        }
		
		function onCancel(){
			CloseWindow('cancel');
		}
		
		function onOk(){
			CloseWindow('ok');
		}
		
		function getData(){
			return grid.getSelecteds();
		}
	
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.bo.entity.SysBoEnt" winHeight="450"
		winWidth="700" entityTitle="业务实体对象" baseUrl="sys/bo/sysBoEnt" />
</body>
</html>