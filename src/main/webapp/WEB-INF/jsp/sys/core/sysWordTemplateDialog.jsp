<%-- 
    Document   : [SYS_WORDTE_MPLATE【模板表】]列表页
    Created on : 2018-05-16 11:29:19
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>WORD模版列表</title>
<%@include file="/commons/list.jsp"%>
<c:set var="multiSelect" value="true"></c:set>
<c:if test="${param.single=='true' }">
	<c:set var="multiSelect" value="false"></c:set>
</c:if>
</head>
<body>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">	
	     <div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false"
	     style="width:100%">
				<div class="southBtn">
			     	<a class="mini-button"   onclick="onOk()">确定</a>
					<a class="mini-button btn-red"  onclick="onCancel()">取消</a>
				</div>
		 </div> 
		 
		 <div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
			 <div class="mini-toolbar" >
				 <div class="form-toolBox">
					 <ul>
						<li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
						<li><span class="text">模板名称：</span><input class="mini-textbox" name="Q_TEMPLATE_NAME__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button"  onclick="searchFrm()">查询</a>
							<a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
						</li>
					 </ul>
				 </div>
		     </div>
	
			<div class="mini-fit" style="height: 100%;">
				<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
					url="${ctxPath}/sys/core/sysWordTemplate/listData.do" idField="id"
					multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
					<div property="columns">
						<div type="checkcolumn" width="20"></div>
						<div field="name"  sortField="NAME_"  width="120" headerAlign="center" allowSort="true">名称</div>
						<div field="dsAlias"  sortField="DS_ALIAS_"  width="120" headerAlign="center" allowSort="true">数据源</div>
						<div field="templateName"  sortField="TEMPLATE_NAME_"  width="120" headerAlign="center" allowSort="true">模板名称</div>
						<div field="description"  sortField="DESCRIPTION_"  width="120" headerAlign="center" allowSort="true">描述</div>
					</div>
				</div>
			</div>
		</div>
</div>

	<script type="text/javascript">
		
		function getSelectedFields(){
			var grid=mini.get("datagrid1");
			return grid.getSelecteds();
		}
		
		function onOk(){
			CloseWindow("ok");
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysWordTemplate" winHeight="450"
		winWidth="700" entityTitle="SYS_WORDTE_MPLATE【模板表】" baseUrl="sys/core/sysWordTemplate" />
</body>
</html>