<%-- 
    Document   : [权限转移设置表]列表页
    Created on : 2018-06-20 17:12:34
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[权限转移设置表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form">
				<ul>
					<li class="liAuto"><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
					<li><span class="text">状态：</span><input class="mini-combobox" showNullItem="true" name="Q_a.STATUS__S_LK" data="[{id:'1',text:'启动'},{id:'0',text:'禁用'}]"></li>
					<li class="liBtn">
						<a class="mini-button" plain="true" onclick="searchFrm()">查询</a>
					</li>
				</ul>
			</form>
		</div>
		 <div class="toolBtnBox">
			 <li><a class="mini-button"  plain="true" onclick="add()">增加</a></li>
			 <!-- <li><a class="mini-button"  plain="true" onclick="setting()">设置</a></li>
			 <li><a class="mini-button"  plain="true" onclick="log()">日志</a></li> -->
		 </div>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
         </span>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/transset/sysTransferSetting/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"  headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="120" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="name"  sortField="NAME_"  width="120"  allowSort="true">名称</div>
				<div field="status" renderer="statusRenderer"  sortField="STATUS_"  width="120"  allowSort="true">状态</div>
				<div field="createByName"  sortField="CREATE_BY_"  width="120"  allowSort="true">创建人</div>
				<div field="createTime"  sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd"  width="120"  allowSort="true">创建时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function statusRenderer(e){
			var record = e.record;
	        var status = record.status;
	        var arr = [{'key' : '1', 'value' : '启用','css' : 'green'}, 
	     	        {'key' : '0','value' : '禁用','css' : 'red'}];
	     	return $.formatItemValue(arr,status);
		}
		
		//设置
		function setting(){
			var row = grid.getSelected();
			var rowId;
		    if (row) {
		    	rowId = row.pkId;
		    }
		    location.href="${ctxPath}/sys/transset/sysTransferSetting/mgr.do?pkId="+rowId;
		}
		
		//日志
		function log(){
			location.href=__rootPath+'/sys/translog/sysTransferLog/list.do';
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.transset.entity.SysTransferSetting" winHeight="450"
		winWidth="700" entityTitle="权限转移设置表" baseUrl="sys/transset/sysTransferSetting" />
</body>
</html>