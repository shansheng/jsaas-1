<%-- 
    Document   : [sys_excel_template]列表页
    Created on : 2018-12-17 21:26:09
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>EXCEL导入模版管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-layout" style="width: 100%;height: 100%">
	<div region="center" showSplitIcon="false" showHeader="false">
		 <div class=" mini-toolbar" >
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li class="liAuto"><span class="text">名称：</span><input class="mini-textbox" name="Q_TEMPLATE_NAME__S_LK"></li>
						<li><span class="text">别名：</span><input class="mini-textbox" name="Q_TEMPLATE_NAME_ALIAS__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
							<a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
						</li>
					</ul>
				</form>
			</div>
			 <ul class="toolBtnBox">
				 <li><a class="mini-button"  plain="true" onclick="add()">增加</a></li>
				 <li><a class="mini-button"  plain="true" onclick="edit()">编辑</a></li>
				 <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
			 </ul>
			 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		 </div>

		<div class="mini-fit" style="height: 100%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				url="${ctxPath}/sys/core/sysExcelTemplate/listData.do" idField="id"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="120"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="templateName"  sortField="TEMPLATE_NAME_"  width="120"  allowSort="true">模式名称</div>
					<div field="templateNameAlias"  sortField="TEMPLATE_NAME_ALIAS_"  width="120"  allowSort="true">模式别名</div>
					<div field="templateComment"  sortField="TEMPLATE_COMMENT_"  width="120" allowSort="true">备注</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'
					+'<span  title="导入" onclick="excelImport(\'' + pkId + '\')">导入</span>'
					+'<span title="下载模版" onclick="download(\'' + record.excelTemplateFile + '\')">下载模版</span>';
			return s;
		}
		
	    function excelImport(pkId) {
	    	var obj=getWindowSize();
	        _OpenWindow({
	        	url: "${ctxPath}/sys/core/sysExcelTemplate/excelImport.do?pkId=" + pkId,
	            title: "${entityTitle}Excel导入", width: 600, height: 400,
	        });
	    }   
	    
	    function download(fileId){
	    	var url="${ctxPath}/sys/core/file/downloadOne.do?fileId=" + fileId ;
	    	location.href=url;
	    }
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysExcelTemplate" winHeight="450"
		winWidth="700" entityTitle="Excel导入模板" baseUrl="sys/core/sysExcelTemplate" />
</body>
</html>