<%-- 
    Document   : [用户类型]列表页
    Created on : 2018-09-03 14:21:10
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[用户类型]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
     <div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >	
				<ul>
					<li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
					<li><span class="text">编码：</span><input class="mini-textbox" name="Q_CODE__S_LK"></li>
					<li class="liBtn">
						<a class="mini-button"  plain="true" onclick="searchFrm()">查询</a>
						<a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
						<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li><span class="text">描述：</span><input class="mini-textbox" name="Q_DESCP__S_LK"></li>
					</ul>
				</div>
			</form>
		</div>
		 <ul class="toolBtnBox">
			 <li><a class="mini-button"  plain="true" onclick="add()">新增</a></li>
			 <li><a class="mini-button"  onclick="edit()">编辑</a></li>
			 <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>

		 </ul>
	    <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/org/osUserType/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="120"    renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="code"  sortField="CODE_"  width="120"   allowSort="true">编码</div>
				<div field="name"  sortField="NAME_"  width="120"   allowSort="true">名称</div>
				<div field="descp"  sortField="DESCP_"  width="120"   allowSort="true">描述</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var uid=record._uid;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+' <span  title="授权" onclick="grantResource(\'' + uid + '\')">授权</span>'
					+' <span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function grantResource(uid){
			var row=grid.getRowByUID(uid);
			_OpenWindow({
				title:'['+row.name + ']'+'--授权管理',
				url:__rootPath+'/sys/org/osGroup/toGrant.do?groupId='+row.groupId + '&tenantId=1' ,
				width:400,
				height:520
			});
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.org.entity.OsUserType" winHeight="450"
		winWidth="700" entityTitle="用户类型" baseUrl="sys/org/osUserType" />
</body>
</html>