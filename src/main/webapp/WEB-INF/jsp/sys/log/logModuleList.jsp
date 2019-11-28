<%-- 
    Document   : [日志模块]列表页
    Created on : 2017-09-21 14:38:42
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[日志模块]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
     <div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li class="liAuto">
						<span class="text">模块：</span><input class="mini-textbox" name="Q_MODULE__S_LK">
					</li>
					<li>
						<span class="text">子模块：</span><input class="mini-textbox" name="Q_SUB_MODULE_S_LK">
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
				 <a class="mini-button"  onclick="init()">初始化</a>
			 </li>
			 <li>
				 <a class="mini-button"  onclick="enableRows()">启用</a>
			 </li>
			 <li>
				 <a class="mini-button btn-red"   onclick="disableRows()">禁用</a>
			 </li>
			 <li>
				 <a class="mini-button btn-red" onclick="remove()">删除</a>
			 </li>
		 </ul>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/log/logModule/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="100" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="module"  sortField="MODULE_"  width="120" headerAlign="" allowSort="true">模块</div>
				<div field="subModule"  sortField="SUB_MODULE"  width="120" headerAlign="" allowSort="true">子模块</div>
				<div field="enable"  sortField="ENABLE_"  width="120" headerAlign="" allowSort="true" renderer="onEnableRenderer">状态</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s= '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>';
			if(record.enable!='FALSE'){
				s +='<span  title="禁用" onclick="disableRow(\'' + pkId + '\')">禁用</span>';
			}
			if(record.enable!='TRUE'){
				s +='<span title="启用" onclick="enableRow(\'' + pkId + '\')">启用</span>';
			}
			return s;
		}
		var grid=mini.get("datagrid1");
		
		function disableRow(pkId){
			if (!confirm("确定禁用吗？")) return;
			updateModule(pkId,"FALSE");
		}
		
		function enableRow(pkId){
			if (!confirm("确定启用吗？")) return;
			updateModule(pkId,"TRUE");
		}
		
		function disableRows(){
			disableRow(getIds());
		}
		
		function enableRows(){
			enableRow(getIds());
		}
		
		function getIds(){
			var ids = '';
			var rows = grid.getSelecteds();
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				ids += row.pkId + ",";
			}
			ids = ids.substr(0,ids.length-1);
			return ids;
		}
		
		function updateModule(pkId,status){
			$.ajax({
				type:'post',
				data:{ids:pkId,enable:status},
				url:"${ctxPath}/sys/log/logModule/disableModule.do",
				success:function (result){
					grid.reload();
				}
			});
		}
		
		function init(){
			var messageid = mini.loading("正在初始化中，请稍后", "初始化");
			$.ajax({
				type:'post',
				url:"${ctxPath}/sys/log/logModule/initLogModel.do",
				success:function (result){
					grid.reload();
					mini.hideMessageBox(messageid);
				}
			});
		}
		
		//绘制是否为系统预置
		function onEnableRenderer(e) {
            var record = e.record;
            var enable = record.enable;
             var arr = [{'key' : 'TRUE', 'value' : '启用','css' : 'green'}, 
    			        {'key' : 'FALSE','value' : '禁用','css' : 'red'}];
    			return $.formatItemValue(arr,enable);
        }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.log.entity.LogModule" winHeight="450"
		winWidth="700" entityTitle="日志模块" baseUrl="sys/log/logModule" />
</body>
</html>