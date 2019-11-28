<%-- 
    Document   : [机构类型]列表页
    Created on : 2017-07-10 18:35:32
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[机构类型]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
     <div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li class="liAuto">
						<span class="text">类型编码：</span><input class="mini-textbox" name="Q_TYPE_CODE__S_LK">
					</li>
					<li>
						<span class="text">类型名称：</span><input class="mini-textbox" name="Q_TYPE_NAME__S_LK">
					</li>
					<li class="liBtn">
						<a class="mini-button _search" onclick="searchForm(this)" >搜索</a>
						<a class="mini-button _reset btn-red" onclick="onClearList(this)">清空搜索</a>
					</li>
				</ul>
			</form>
		</div>
		 <ul class="toolBtnBox">
			 <li>
				 <a class="mini-button"   onclick="add()">新增</a>
			 </li>
			 <li>
				 <a class="mini-button btn-red"  onclick="remove()">删除</a>
			 </li>
		 </ul>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/core/sysInstType/listData.do" idField="typeId"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"  align="center"></div>
				<div name="action" cellCls="actionIcons" width="120"   renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="typeName"  sortField="TYPE_NAME_"  width="150"   allowSort="true">类型名称</div>
				<div field="typeCode"  sortField="TYPE_CODE_"  width="120"   allowSort="true">类型编码</div>
				<div field="enabled"  sortField="ENABLED_"  renderer="onRenderer" width="80"   allowSort="true">是否启用</div>
				<div field="isDefault"  sortField="IS_DEFAULT_" renderer="onRenderer"  width="80"   allowSort="true">是否系统缺省</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>';
			if(record.isDefault!='YES'){
					s+=' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			}
			s+='<span  title="分配菜单" onclick="allotRow(\'' + pkId + '\')">分配菜单</span>';
			return s;
		}
		
		function allotRow(pkId){
			_OpenWindow({
	    		url: "${ctxPath}/sys/core/sysTypeSubRef/allotSubSys.do?typeId="+pkId,
	            title: "分配子系统", width: 450, height: 600,
	            ondestroy: function(action) {
	            	if (action == 'ok') {
	                    grid.reload();
	                }
	            }
	    	});
		}
		
		function onRenderer(e) {
            var record = e.record;
            var field = record[e.field];
            
            var arr = [ {'key' : 'YES', 'value' : '是','css' : 'green'}, 
			            {'key' : 'NO','value' : '否','css' : 'red'} ];
            
            return $.formatItemValue(arr,field);
        }

	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysInstType" winHeight="450"
		winWidth="700" entityTitle="机构类型" baseUrl="sys/core/sysInstType" />
</body>
</html>