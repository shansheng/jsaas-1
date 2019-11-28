<%-- 
    Document   : [入库单]列表页
    Created on : 2018-12-06 10:19:04
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[入库单]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="titleBar mini-toolbar" >
	 	<ul>
			<li>
				 <a class="mini-button" iconCls="icon-create" plain="true" onclick="add()">增加</a>
                 <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
                 <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
                 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
			</li>
			<li class="clearfix"></li>
		</ul>
	 	<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
						<li><span class="text">单号:</span><input class="mini-textbox" name="Q_NO__S_LK"></li>
						<li><span class="text">金额:</span><input class="mini-textbox" name="Q_TOTAL_FT__LK"></li>
						
						<li>
							<span class="text">更新时间 从</span>:<input  name="Q_UPDATETIME_TIME__D_GE"  class="mini-datepicker" format="yyyy-MM-dd" style="width:100px"/>
						</li>
						<li>
							<span class="text-to">至: </span><input  name="Q_UPDATETIME_TIME__D_LE" class="mini-datepicker" format="yyyy-MM-dd" style="width:100px" />
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
			url="${ctxPath}/stock/core/inStock/listData.do" idField="stockId"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="no"  sortField="NO_"  width="120" headerAlign="center" allowSort="true">单号</div>
				<div field="total"  sortField="TOTAL_"  width="120" headerAlign="center" allowSort="true">金额</div>
				<div field="descp"  sortField="DESCP_"  width="120" headerAlign="center" allowSort="true">描述</div>
				<div field="updatetimeTime" sortField="UPDATETIME_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss" width="120" headerAlign="center" allowSort="true">更新时间</div>
				<div field="updatetimeBy"  sortField="UPDATETIME_BY_"  width="120" headerAlign="center" allowSort="true">更新人</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var bpmInstId=record.bpmInstId;
			var uid=record._uid;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')"></span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)"></span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')"></span>';
					
					if(bpmInstId){
						s=s+'<span  title="bpm" onclick="showBpm(\'' + uid + '\')"></span>';
					}
			return s;
		}
		
		function showBpm(uid){
			var row= grid.getRowByUID(uid);
			var bpmInstId=row.bpmInstId;
			_OpenWindow({
				title:'审批明细',
				height:400,
				width:700,
				max:true,
				url:__rootPath+'/bpm/core/bpmInst/info.do?instId='+bpmInstId
			});
			
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.stock.core.entity.InStock" winHeight="450"
		winWidth="700" entityTitle="入库单" baseUrl="stock/core/inStock" />
</body>
</html>