<%-- 
    Document   : [KdUserLevel]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[KdUserLevel]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>

	<redxun:toolbar entityName="com.redxun.kms.core.entity.KdUserLevel" />

	<div class="mini-fit rx-grid-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" url="${ctxPath}/kms/core/kdUserLevel/listData.do" idField="confId" multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="30"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="startVal" width="120" headerAlign="" allowSort="true">起始值</div>
				<div field="endVal" width="120" headerAlign="" allowSort="true">结束值</div>
				<div field="levelName" width="120" headerAlign="" allowSort="true">等级名称</div>
				<div field="headerIcon" width="120" headerAlign="" allowSort="true">头像Icon</div>
				<div field="memo" width="120" headerAlign="" allowSort="true">备注</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var s = ' <span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>'
						+'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
	                    + ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
	            return s;
	        }
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.kms.core.entity.KdUserLevel" winHeight="450" winWidth="700" entityTitle="等级" baseUrl="kms/core/kdUserLevel" />
</body>
</html>