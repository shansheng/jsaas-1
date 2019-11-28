<%-- 
    Document   : [打卡导入方案]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[打卡导入方案]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li><span class="text">编码：</span><input class="mini-textbox" name="Q_CODE_S_LK"></li>
					<li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME_S_LK"></li>
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
						<li><span class="text">分割符：</span><input class="mini-textbox" name="Q_SEPARATE_S_LK"></li>
						<li><span class="text">描述：</span><input class="mini-textbox" name="Q_MEMO_S_LK"></li>
						<li><span class="text">打卡对应关系：</span><input class="mini-textbox" name="Q_PUSH_CARD_MAP_S_LK"></li>
					</ul>
				</div>
			</form>
		</div>
		 <ul class="toolBtnBox">
			 <li>
				 <a class="mini-button"  plain="true" onclick="add()">新增</a>
			 </li>
			 <li>
				 <a class="mini-button" plain="true" onclick="edit()">编辑</a>
			 </li>
			 <li>
				 <a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
			 </li>
		 </ul>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div> 
                     
              
					
		
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsImportPlan/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="code"  sortField="CODE"  width="120" headerAlign="" allowSort="true">编码</div>
				<div field="name"  sortField="NAME"  width="120" headerAlign="" allowSort="true">名称</div>
				<div field="separate"  sortField="SEPARATE"  width="120" headerAlign="" allowSort="true">分割符</div>
				<div field="memo"  sortField="MEMO"  width="120" headerAlign="" allowSort="true">描述</div>
				<div field="pushCardMap"  sortField="PUSH_CARD_MAP"  width="120" headerAlign="" allowSort="true">打卡对应关系</div>
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
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsImportPlan" winHeight="450"
		winWidth="700" entityTitle="打卡导入方案" baseUrl="oa/ats/atsImportPlan" />
</body>
</html>