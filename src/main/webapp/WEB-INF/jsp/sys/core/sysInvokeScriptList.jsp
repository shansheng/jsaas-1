<%-- 
    Document   : [执行脚本配置]列表页
    Created on : 2018-10-18 11:06:29
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[执行脚本配置]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-layout"   style="width: 100%;height: 100%;">
	<div region="center" showHeader="false" showSplitIcon="false" style="width: 100%;height: 100%;">
		 <div class=" mini-toolbar" >
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
						<li><span class="text">别名：</span><input class="mini-textbox" name="Q_ALIAS__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
							<a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
						</li>
					</ul>
					<div id="moreBox">
						<ul>
							<li><span class="text">脚本内容：</span><input class="mini-textbox" name="Q_CONTENT__S_LK"></li>
						</ul>
					</div>
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
		<div class="mini-fit">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				url="${ctxPath}/sys/core/sysInvokeScript/listData.do" idField="id"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
					<div name="action" cellCls="actionIcons" width="50"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="name"  sortField="NAME_"  width="120"  allowSort="true"> 名称</div>
					<div field="alias"  sortField="ALIAS_"  width="120"  allowSort="true">别名</div>
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
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'
					+' <span title="测试" onclick="preview(\'' + pkId + '\')">测试</span>'
					+' <span  title="帮助" onclick="help(\'' + pkId + '\')">帮助</span>';
			return s;
		}

		//预览
		function preview(pkId) {
			_OpenWindow({
				url : "${ctxPath}/sys/core/sysInvokeScript/preview.do?pkId=" + pkId,
				title : "测试",
				max : true,
				ondestroy : function(action) {
					if (action == 'ok') {
						grid.reload();
					}
				}
			});
		}

		function help(pkId){
			_OpenWindow({
				url : "${ctxPath}/sys/core/sysInvokeScript/help.do?pkId=" + pkId,
				title : "帮助",
				width:1000,
				height:500
			});
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysInvokeScript" winHeight="450"
		winWidth="700" entityTitle="执行脚本配置" baseUrl="sys/core/sysInvokeScript" />
</body>
</html>