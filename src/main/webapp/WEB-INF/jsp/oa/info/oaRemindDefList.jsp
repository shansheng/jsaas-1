<%-- 
    Document   : [消息提醒]列表页
    Created on : 2018-04-28 16:03:20
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>[消息提醒]列表管理</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-toolbar" >

	<div class="searchBox">
		<form id="searchForm" class="search-form" >
			<ul>
				<li><span class="text">主题：</span><input class="mini-textbox" name="Q_SUBJECT__S_LK"></li>
				<li><span class="text">消息描述：</span><input class="mini-textbox" name="Q_DESCRIPTION__S_LK"></li>
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
					<li>
						<span class="text">是否有效：</span>
						<input
								class="mini-combobox"
								name="Q_ENABLED__S_LK"
								showNullItem="true"
								emptyText="请选择..."
								data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
						/>
					</li>
				</ul>
			</div>
		</form>
	</div>
	<ul class="toolBtnBox toolBtnBoxTop">
		<li>
			<a class="mini-button" plain="true" onclick="add()">新增</a>
		</li>
		<li>
			<a class="mini-button"  plain="true" onclick="edit()">编辑</a>
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
		 url="${ctxPath}/oa/info/oaRemindDef/listData.do" idField="id"
		 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
		<div property="columns">
			<div type="checkcolumn" width="20"></div>
			<div name="action" cellCls="actionIcons" width="80"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
			<div field="subject"  sortField="SUBJECT_"  width="80" headerAlign="" allowSort="true">主题</div>
			<div field="type"  sortField="TYPE_"  width="80" headerAlign="" allowSort="true">设置类型</div>
			<div field="dsalias"  sortField="DSALIAS_"  width="80" headerAlign="" allowSort="true">数据源别名</div>
			<div field="description"  sortField="DESCRIPTION_"  width="180" headerAlign="" allowSort="true">消息描述</div>
			<div field="sn"  sortField="SN_"  width="60" headerAlign="" allowSort="true">排序</div>
			<div field="enabled"  sortField="ENABLED_"  width="100" renderer="onEnabledRenderer" headerAlign="" allowSort="true">是否有效</div>
		</div>
	</div>
</div>




<script type="text/javascript">
	//行功能按钮
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
				+'<span title="权限" onclick="setPermsssion(\'' + pkId + '\')">权限</span>'
				+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
				+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
		return s;
	}

	function onEnabledRenderer(e) {
		var record = e.record;
		var enabled = record.enabled;
		var count = record.count;
		var arr = [ {'key' : '1', 'value' : '有效','css' : 'green'},
			{'key' : '0','value' : '无效','css' : 'orange'} ];


		return $.formatItemValue(arr,enabled);

	}

	function setPermsssion(pk){
		var url="${ctxPath}/oa/info/sysObjectAuthPermission/getPermissionByObjectId.do?pkId=" +pk +"&authtype=remind";
		var aryData=[];
		$.get(url,function(result){
			openProfileDialog({
				onload:function(iframe){
					iframe.init(result);
				},onOk:function(data){
					var json={objectId:pk,type:"remind",data:JSON.stringify(data)};
					var config={
						url:"${ctxPath}/oa/info/oaRemindDef/saveRight.do",
						method:'POST',
						postJson:true,
						data:json
					}
					_SubmitJson(config);
				}})
		});
	}


</script>

<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.OaRemindDef" winHeight="650"
				   winWidth="900" entityTitle="消息提醒" baseUrl="oa/info/oaRemindDef" />
</body>
</html>