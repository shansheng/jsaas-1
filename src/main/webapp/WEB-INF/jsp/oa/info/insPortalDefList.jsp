<%-- 
    Document   : Portal定义列表页
    Created on : 2017-08-15 16:07:14
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>Portal定义列表管理</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-toolbar" >
	<div class="searchBox">
		<form id="searchForm" class="search-form" >
			<ul>
				<li class="liAuto">
					<span class="text">布局名：</span><input class="mini-textbox" name="Q_NAME__S_LK">
				</li>
				<li class="liAuto">
					<span class="text">KEY：</span><input class="mini-textbox" name="Q_KEY__S_LK">
				</li>
				<li class="liBtn">
					<a class="mini-button " onclick="searchFrm()" >搜索</a>
					<a class="mini-button  btn-red" onclick="clearForm()" >清空</a>
				</li>
			</ul>
		</form>
	</div>
	<ul class="toolBtnBox toolBtnBoxTop">
		<li>
			<a class="mini-button"   onclick="add()">新增</a>
		</li>
		<li>
			<a class="mini-button"   onclick="edit()">编辑</a>
		</li>
		<li>
			<a class="mini-button btn-red"   onclick="remove()">删除</a>
		</li>
	</ul>
	<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
</div>
<div class="mini-fit" style="height: 100%;">
	<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
		 url="${ctxPath}/oa/info/insPortalDef/listData.do" idField="protId"
		 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
		<div property="columns">
			<div type="checkcolumn" width="20" ></div>
			<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
			<div field="name"  sortField="NAME_"  width="120" headerAlign="" allowSort="true">名字</div>
			<div field="key"  sortField="KEY_"  width="120" headerAlign="" allowSort="true">KEY</div>
			<div field="isDefault"  sortField="IS_DEFAULT_"  width="120" headerAlign="" allowSort="true" renderer="onIsDefaultRenderer">是否默认</div>
			<div field="priority"  sortField="PRIORITY_"  width="120" headerAlign="" allowSort="true">优先级</div>
            <div field="isMobile"  sortField="IS_MOBILE_" width="120" headerAlign="center" allowSort="true" renderer="onIsMobile">是否手机门户</div>

        </div>
	</div>
</div>

<script type="text/javascript">
	//行功能按钮
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var isMobile = record.isMobile;
		var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
				+'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
				+'<span  title="权限" onclick="PermissionRow(\'' + pkId + '\')">权限</span>'
				+'<span  title="发布" onclick="deploy(\'' + record._uid + '\')">发布</span>'
                +'<span  title="模板编辑" onclick="tempRow(\'' + pkId + '\', \'' + isMobile + '\')">模板编辑</span>'
				+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
		return s;
	}

	function deploy(uid){
		var row=grid.getRowByUID(uid);
		var url="/oa/info/insPortalDef/portal/" + row.key +".do";
		openDeploymenuDialog({name:row.name,key:row.key,url:url});
	}

	function PermissionRow(pkId){
		_OpenWindow({
			title : '编辑权限',
			width : 830,
			height : 360,
			url : __rootPath + '/oa/info/insPortalPermission/edit.do?layoutId=' + pkId
		});
	}
	function tempRow(pkId,isMobile){
        var url = __rootPath+'/oa/info/insPortalDef/editTmp.do?portId='+pkId;
        var title = "门户配置";
        if(isMobile == "YES"){
            url = __rootPath+'/wx/portal/wxPortal/editMobileTmp.do?portId='+pkId;
            title = "手机门户配置";
        }
        _OpenWindow({
            title: title,
            height:400,
            width:780,
            max:true,
            url: url,
            ondestroy:function(action){
                if(action!='ok') return;
                grid.load();
            }
        });
	}
    function onIsMobile(e){
        var record = e.record;
        var isMobile = record.isMobile;
        return (isMobile == null || isMobile == 'NO') ? "否" : "是";
    }

	function onIsDefaultRenderer(e) {
		var record = e.record;
		var isDefault = record.isDefault;
		var arr = [{'key' : 'YES', 'value' : '是','css' : 'green'},
			{'key' : 'NO','value' : '否','css' : 'red'} ];
		return $.formatItemValue(arr,isDefault);
	}
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.InsPortalDef" winHeight="360"
				   winWidth="830" entityTitle="自定义门户" baseUrl="oa/info/insPortalDef" />
</body>
</html>