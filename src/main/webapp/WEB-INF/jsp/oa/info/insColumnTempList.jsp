<%-- 
    Document   : [栏目模板管理表]列表页
    Created on : 2018-08-30 09:50:56
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[栏目模板管理表]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="titleBar mini-toolbar" >
		 <ul>
			<li>
               <a class="mini-button" iconCls="icon-create" plain="true" onclick="add()">增加</a>
               <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit(true)">编辑</a>
               <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
               <a class="mini-button" iconCls="icon-search" plain="true" onclick="searchFrm()">查询</a>
               <a class="mini-button btn-red" iconCls="icon-cancel" plain="true" onclick="clearForm()">清空查询</a>
           	</li>
			<li class="clearfix"></li>
		</ul>
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li><span class="text">名称:</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
					<li><span class="text">标识键:</span><input class="mini-textbox" name="Q_KEY__S_LK"></li>
					<li><span class="text">是否系统预置:</span>
					<input 
						class="mini-combobox" 
						name="Q_IS_SYS__S_LK"
					    showNullItem="true"  
					    emptyText="请选择..."
						data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
					/></li>
					<li><span class="text">状态:</span>
					<input 
						class="mini-combobox" 
						name="Q_STATUS__S_LK"
					    showNullItem="true"  
					    emptyText="请选择..."
						data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]"
					/>
					</li>
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
			url="${ctxPath}/oa/info/insColumnTemp/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="name"  sortField="NAME_"  width="120" headerAlign="center" allowSort="true">名称</div>
				<div field="key"  sortField="KEY_"  width="120" headerAlign="center" allowSort="true">标识键</div>
				<div field="isSys"  sortField="IS_SYS_"  width="120" headerAlign="center" allowSort="true" renderer="onIsSysRenderer">是否系统预设</div>
				<div field="status"  sortField="STATUS_"  width="120" headerAlign="center" allowSort="true" renderer="onStatusRenderer">状态</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span class="icon-detail" title="明细" onclick="detailRow(\'' + pkId + '\')"></span>'
					+'<span class="icon-edit" title="编辑" onclick="editRow(\'' + pkId + '\',true)"></span>'
					+'<span class="icon-remove" title="删除" onclick="delRow(\'' + pkId + '\')"></span>';
			return s;
		}
		
		//绘制是否为系统预置
		function onIsSysRenderer(e) {
            var record = e.record;
            var isSys = record.isSys;
             var arr = [{'key' : '1', 'value' : '是','css' : 'red'}, 
    			        {'key' : '0','value' : '否','css' : 'green'}];
    			return $.formatItemValue(arr,isSys);
        }
		
		//绘制状态
		function onStatusRenderer(e) {
            var record = e.record;
            var status = record.status;
             var arr = [{'key' : '0', 'value' : '禁用','css' : 'red'}, 
    			        {'key' : '1','value' : '启用','css' : 'green'}];
    			return $.formatItemValue(arr,status);
        }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.InsColumnTemp" winHeight="450"
		winWidth="700" entityTitle="栏目模板管理表" baseUrl="oa/info/insColumnTemp" />
</body>
</html>