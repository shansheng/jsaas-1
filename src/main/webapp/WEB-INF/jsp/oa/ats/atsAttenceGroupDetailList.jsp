<%-- 
    Document   : [考勤组明细]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[考勤组明细]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
         <table style="width:100%;">
             <tr>
                 <td style="width:100%;">
                     <a class="mini-button" iconCls="icon-create" plain="true" onclick="add()">增加</a>
                     <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
                     <a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
                     <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                     <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
                 </td>
             </tr>
              <tr>
                  <td class="search-form" >
                     <ul>
						<li><span class="text">考勤组:</span><input class="mini-textbox" name="Q_GROUP_ID_S_LK"></li>
						<li><span class="text">考勤档案:</span><input class="mini-textbox" name="Q_FILE_ID_S_LK"></li>
					</ul>
                  </td>
              </tr>
         </table>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsAttenceGroupDetail/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="groupId"  sortField="GROUP_ID"  width="120" headerAlign="" allowSort="true">考勤组</div>
				<div field="fileId"  sortField="FILE_ID"  width="120" headerAlign="" allowSort="true">考勤档案</div>
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
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttenceGroupDetail" winHeight="450"
		winWidth="700" entityTitle="考勤组明细" baseUrl="oa/ats/atsAttenceGroupDetail" />
</body>
</html>