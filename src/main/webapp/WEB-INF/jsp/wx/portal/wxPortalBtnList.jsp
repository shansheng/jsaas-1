<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>手机门户功能按钮列表</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class=" mini-toolbar" >

	<div class="searchBox">
		<form id="searchForm" class="search-form" >
			<ul>
				<li class="liAuto">
					<span>名字:</span>
					<input class="mini-textbox" name="Q_NAME__S_LK">
				</li>
				<li class="liBtn">
					<a class="mini-button " onclick="searchForm(this)">搜索</a>
					<a class="mini-button " onclick="onClearList(this)">清空</a>
				</li>
			</ul>
		</form>
	</div>
	<ul class="toolBtnBox">
		<li>
			<a class="mini-button"  onclick="add()">增加</a>
		</li>
		<li>
			<a class="mini-button"  onclick="edit()">编辑</a>
		</li>
		<li>
			<a class="mini-button btn-red"  onclick="remove()">删除</a>
		</li>
	</ul>
</div>
<div class="mini-fit" style="height: 100%;">
	<div id="datagrid1" class="mini-datagrid"
		 style="width: 100%; height: 100%;" allowResize="false"
		 url="${ctxPath}/wx/portal/wxPortalBtn/listData.do" idField="id"
		 multiSelect="true" showColumnsMenu="true"
		 sizeList="[5,10,20,50,100]" pageSize="10"
		 allowAlternating="true" pagerButtons="#pagerButtons">
		<div property="columns">
			<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
			<div name="action" cellCls="actionIcons" width="60"
				  renderer="onActionRenderer"
				 cellStyle="padding:0;">操作</div>
			<div field="name" sortField="NAME_" width="40"
				 allowSort="true">名字</div>
			<div field="key" sortField="Key_" width="40"
				 allowSort="true">标识</div>
			<div field="icon" sortField="ICON_" width="40"
				 allowSort="true" renderer="onRenderIcon" align="center">图标</div>
			<div field="typeId" sortField="TYPE_ID_" width="40"
				 allowSort="true">所属类别</div>
			<div field="appType" sortField="APP_ID_" width="40"
				 allowSort="true" textField="name" renderer="onAppTypeRender">应用类型</div>
			<div field="url" sortField="URL_" width="120"
				 allowSort="true">链接地址</div>
		</div>
	</div>
</div>

<script>
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
				+'<span  title="权限" onclick="setPermsssion(\'' + pkId + '\')">权限</span>'
		'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
		return s;
	}

	function onRenderIcon(e){
		var record = e.record;
		var iconJson = JSON.parse(record.icon);
		var iconFileId = iconJson[0].fileId;
		var s = "";
		if(iconJson == undefined || iconJson == null || iconJson == ""){
			return s;
		}
		s = '<img src="${ctxPath}/sys/core/file/previewImage.do?fileId='+iconFileId+'" style="width:30px;height:30px;">';
		return s;
	}


	function onAppTypeRender(e){
		var appTypeMap = {'bpmSolution':'流程方案','customList':'自定义列表','customUrl':'自定义路径'};
		var field = e.value;
		if(!field){
			return '暂无分类';
		}
		return appTypeMap[field];
	}


	function setPermsssion(pk){
		var url="${ctxPath}/oa/info/sysObjectAuthPermission/getPermissionByObjectId.do?pkId=" +pk +"&authtype=mobileApp";
		var aryData=[];
		$.get(url,function(result){
			openProfileDialog({
				onload:function(iframe){
					iframe.init(result);
				},onOk:function(data){
					var json={objectId:pk,type:"mobileApp",data:JSON.stringify(data)};
					var config={
						url:"${ctxPath}/wx/portal/wxPortalBtn/saveRight.do",
						method:'POST',
						postJson:true,
						data:json
					}
					_SubmitJson(config);
				}})
		});
	}

</script>

<redxun:gridScript gridId="datagrid1"
				   entityName="com.redxun.wx.portal.entity.WxMobilePortalButton"
				   winHeight="450" winWidth="700" entityTitle="手机门户功能按钮列表"
				   baseUrl="wx/portal/wxPortalBtn" />
</body>
</html>