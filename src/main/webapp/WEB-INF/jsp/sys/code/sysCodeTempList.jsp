<%-- 
    Document   : [模板文件管理表]列表页
    Created on : 2018-11-01 16:22:39
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[模板文件管理表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="titleBar mini-toolbar" >
	 	<ul>
			<li>
				 <a class="mini-button" iconCls="icon-create" plain="true" onclick="add()">增加</a>
                 <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit(false)">编辑</a>
                 <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
                 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
			</li>
			<li class="clearfix"></li>
		</ul>
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
						<li><span class="text">名称:</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
						<li><span class="text">别名:</span><input class="mini-textbox" name="Q_ALIAS__S_LK"></li>
					<li class="clearfix"></li>
				</ul>
			</form>	
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/code/sysCodeTemp/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="name"  sortField="NAME_"  width="120" headerAlign="center" allowSort="true">名称</div>
				<div field="alias"  sortField="ALIAS_"  width="120" headerAlign="center" allowSort="true">别名</div>
				<div field="path"  sortField="PATH_"  width="120" headerAlign="center" allowSort="true">文件名</div>
				<div field="suffix"  sortField="SUFFIX_"  width="120" headerAlign="center" allowSort="true">生成文件后缀名</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')"></span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',false)"></span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')"></span>';
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.code.entity.SysCodeTemp" winHeight="450"
		winWidth="700" entityTitle="模板文件管理表" baseUrl="sys/code/sysCodeTemp" />
</body>
</html>