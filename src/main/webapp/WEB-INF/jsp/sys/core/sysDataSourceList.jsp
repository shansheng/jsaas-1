<%-- 
    Document   : [数据源定义]管理列表页
    Created on : 2017-02-07 09:03:54
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[数据源定义]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
     <div class="mini-toolbar" >
    	 <ul id="popupAddMenu" class="mini-menu" style="display:none;">
			<li  onclick="doExport(false)">导出选中</li>
			<li  onclick="doExport(true)">导出全部</li>
		 </ul>
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">数据源名称：</span><input class="mini-textbox" name="Q_NAME__S_LK">
					</li>
					<li>
						<span class="text">别名：</span><input class="mini-textbox" name="Q_ALIAS__S_LK">
					</li>
					<li class="liBtn">
						<a class="mini-button " onclick="searchFrm()" >搜索</a>
						<a class="mini-button  btn-red" onclick="clearForm()">清空</a>
					</li>
				</ul>
			</form>
		</div>
		 <ul class="toolBtnBox">
			 <li>
				 <a class="mini-button"  onclick="add()()">新增</a>
			 </li>
			 <li>
				 <a class="mini-button"   onclick="edit()">编辑</a>
			 </li>
			 <li>
				 <a class="mini-button"  target="_blank"  href="${ctxPath }/druid">监控</a>
			 </li>
			 <li>
				 <a class="mini-menubutton"  plain="true" menu="#popupAddMenu">导出</a>
			 </li>
			 <li>
				 <a class="mini-button"  onclick="doImport">导入</a>
			 </li>
		 </ul>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit rx-grid-fit" style="height: 100%;">
		<div 
			id="datagrid1" 
			class="mini-datagrid"
			style="width: 100%; height: 100%;" 
			allowResize="false"
			url="${ctxPath}/sys/core/sysDataSource/listData.do" 
			idField="id"
			multiSelect="true" 
			showColumnsMenu="true"
			sizeList="[5,10,20,50,100,200,500]" 
			pageSize="20"
			allowAlternating="true" 
			pagerButtons="#pagerButtons"
		>
			<div property="columns">
				<div type="checkcolumn" width="24" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="120"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="name"  sortField="NAME_"  width="120" headerAlign="" allowSort="true">数据源名称</div>
				<div field="alias"  sortField="ALIAS_"  width="120" headerAlign="" allowSort="true">别名</div>
				<div field="enable"  sortField="ENABLE_"  width="120" renderer="enableRender" headerAlign="" allowSort="true">是否使用</div>
				<div field="dbType"  sortField="DB_TYPE_"  width="120" headerAlign="" allowSort="true">数据库类型</div>
				<div field="initOnStart"  sortField="INIT_ON_START_" renderer="initOnStartRender"  width="120" headerAlign="" allowSort="true">启动时初始化</div>
				<div field="createTime" sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss" width="100" headerAlign="" allowSort="true">创建时间</div>
				
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+' <span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function initOnStartRender(e){
			var record = e.record;
			var val=record.initOnStart;
			var arr = [ { 'key' : 'yes','value' : '是','css' : 'green'}, 
			            {'key' : 'no', 'value' : '否','css' : 'red'} ];
			
			return $.formatItemValue(arr,val);
		}
		
		function enableRender(e){
			var record = e.record;
			var val=record.enabled;
			var arr = [ { 'key' : 'yes','value' : '启用','css' : 'green'}, 
			            {'key' : 'no', 'value' : '禁止','css' : 'red'} ];
			
			return $.formatItemValue(arr,val);
		}
		
		/**
	   	*导出
	   	**/
	   	function doExport(flag){
	   		var rows=grid.getSelecteds();
	   		if(rows.length==0 && !flag){
	   			alert('请选择需要导出的数据源记录！')
	   			return;
	   		}
	   		if(flag){
	   			rows = grid.getData();
	   		}
	   		var ids=_GetKeys(rows);
	   		jQuery.download(__rootPath+'/sys/core/sysDataSource/doExport.do?keys='+ids,{},'post');
	   	}
	   	
	   	/**
	   	 * 获得表格的行的主键key列表，并且用',’分割
	   	 * @param rows
	   	 * @returns
	   	 */
	   	function _GetKeys(rows){
	   		var ids=[];
	   		for(var i=0;i<rows.length;i++){
	   			ids.push(rows[i].alias);
	   		}
	   		return ids.join(',');
	   	}
	   	/**
	   	*导入
	   	**/
	   	function doImport(){
	   		_OpenWindow({
	   			title:'数据源导入',
	   			url:__rootPath+'/sys/core/sysDataSource/import1.do',
	   			height:350,
	   			width:600,
	   			ondestroy:function(action){
	   				grid.reload();
	   			}
	   		});
	   	}
	</script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.sys.core.entity.SysDataSource" winHeight="450"
		winWidth="700" entityTitle="数据源定义管理" baseUrl="sys/core/sysDataSource" />
</body>
</html>