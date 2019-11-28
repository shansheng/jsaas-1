<%-- 
    Document   : 关系类型列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>关系类型列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class=" mini-toolbar" >

		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">关系名：</span><input class="mini-textbox"
						name="Q_name_S_LK"></li>
					<li><span class="text">关系类型：</span>
					<input 
						class="mini-combobox" 
						name="Q_relType_S_LK"
					    showNullItem="true"
					    emptyText="请选择..."
						data="[{id:'USER-USER',text:'用户与用户关系'},{id:'GROUP-GROUP',text:'用户组与用户组关系'},{id:'GROUP-USER',text:'用户组与用户关系'}]"
					/></li>
					
					<li class="liBtn">
						<a class="mini-button"   plain="true" onclick="searchFrm()">搜索</a>
						<a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空搜索</a>
						<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li><span class="text">关系业务主键：</span><input class="mini-textbox" name="Q_key_S_LK"></li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">

			<li>
				<a class="mini-button"  plain="true" onclick="add()">新增</a>
			</li>
	<%--		<li>
				<a class="mini-button"  plain="true" onclick="edit()">编辑</a>
			</li>--%>
			<li>
				<a class="mini-button"  plain="true" onclick="detail()">明细</a>
			</li>
			<li>
				<a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit ">
		<div id="datagrid1" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/org/osRelType/listData.do?tenantId=${param['tenantId']}"
			idField="id" multiSelect="true" showColumnsMenu="true"
			sizeList="[5,10,20,50,100,200,500]" pageSize="20"
			allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="120" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="name" width="120" headerAlign="" allowSort="true" sortField="NAME_">关系名</div>
				<div field="key" width="120" headerAlign="" >关系业务主键</div>
				<div field="relTypeName" width="120" headerAlign=""
					>关系类型</div>
				<div field="party1" width="120" headerAlign=""
					>关系当前方名称</div>
				<div field="party2" width="120" headerAlign=""
					>关系关联方名称</div>
			</div>
		</div>
	</div>


	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.sys.org.entity.OsRelType"
		tenantId="${param['tenantId']}" winHeight="450" winWidth="800"
		entityTitle="关系类型" baseUrl="sys/org/osRelType" />
	<script type="text/javascript">
		//编辑
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var uid = record._uid;
			var s =  ' <span  title="编辑" onclick="editRow(\''+ pkId + '\')">编辑</span>'
					+' <span  title="删除" onclick="delRow(\''+ pkId + '\')">删除</span>'
					+'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>';
			if (record.relType != 'GROUP-USER') {
				s = s+ ' <span  title="关系定义" onclick="relDef2(\''
						+ uid + '\')">关系定义</span>';
			}
			return s;
		}

		function relDef2(uid) {
			var row = grid.getRowByUID(uid);
			top['index'].showTabFromPage({
				tabId : 'relInst_' + row.pkId,
				title : row.name + '-关系定义',
				url : '${ctxPath}/sys/org/osRelInst/treeLine.do?relTypeId='
						+ row.pkId
			});
		}
	</script>
</body>
</html>