<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>编辑手机门户功能按钮</title>
	<%@include file="/commons/edit.jsp"%>
	<%-- <script type="text/javascript" src="${ctxPath }/scripts/weixin/portal/js/tmpInit.js"></script> --%>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/weixin/portal/css/index.css?">
</head>
<body>

<div class="mini-layout mini-fit" style="width:100%;height:100%;">

	<div region="west" width="360px" height="100%"  title="当前手机门户预览" allowResize="false">
		<div id="portalPreview" style="width:100%;height:100%;overflow:hidden;">
			<div class="contentHeaderBox">
				<div class="headerNav">
					<span class="headerIconLeft">⊙</span>
					<span class="headerText">欢迎您：xxx</span>
					<span class="headerIconRight">⊙</span>
				</div>
			</div>
			<ul class="centerUl" id="centerUl"></ul>
		</div>
	</div>
	<div region="center" height="100%" >

		<%-- <rx:toolbar toolbarId="toolbar1" pkId="sysDirFile.id" /> --%>
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden" value="${wxPortalBtn.id}"/>
			<table class="table-detail" cellspacing="1" cellpadding="0" style="width:50%;margin:auto;">
				<caption>应用信息</caption>
				<tr>
					<th>名称</th>
					<td colspan="4"><input name="name" class="mini-textbox" required="true" value="${wxPortalBtn.name}"/></td>
				</tr>
				<tr>
					<th>标识</th>
					<td colspan="4"><input name="key" class="mini-textbox" required="true" width="200px" value="${wxPortalBtn.key}"/></td>
				</tr>
				<tr>
					<th>应用ID</th>
					<td colspan="4"><input name="appId" class="mini-textbox" required="true" width="200px" value="${wxPortalBtn.appId}"/></td>
				</tr>
				<tr>
					<th>图标</th>
					<td id="td-icon" colspan="4">
						<script>
							var _icon = '${wxPortalBtn.icon}';
							if(_icon != undefined && _icon != null && _icon != ""){
								var iconData = JSON.parse(_icon);
								$.post('${ctxPath}/wx/portal/wxPortalBtn/querySysFile.do', {"id": iconData[0].fileId},
										function(dat){
											var img = '<img src="${ctxPath}/sys/core/file/previewImage.do?fileId='+iconData[0].fileId+'" style="width:50px;height:50px;">';
											$("#td-icon").prepend(img);
										}
								);
							}
						</script>
						<input id="fileIds" name="icon" class="upload-panel rxc" plugins="upload-panel" style="width:auto;"
							   allowupload="true" label="图标上传" length="2048" sizelimit="200" isone="false"
							   filetype="Image"
							   mwidth="90" wunit="%" mheight="0" hunit="px"/>
					</td>
				</tr>
				<tr>
					<th>应用类型</th>
					<td><input id="appType" name="appType" class="mini-combobox" value="${wxPortalBtn.appType}" textField="name" valueField="key" url="${ctxPath}/sys/core/sysDic/listByTreeKey.do?key=appType"/></td>
					<th>入口选择</th>
					<td><input id="portAlias" name="portAlias" class="mini-buttonedit" onbuttonclick="onButtonEdit" textField="name"/></td>
				</tr>
				<input id="url" name="url" class="mini-hidden"  value="${wxPortalBtn.url}"/>
				<tr>
					<th>所属栏目</th>
					<td colspan="4"><input name="typeId" class="mini-combobox" textField="name" valueField="typeId" width="300px"
										   multiSelect="true" value="${wxPortalBtn.typeId}"
										   url="${ctxPath}/wx/portal/wxPortal/listData.do"/></td>
				</tr>
			</table>
		</form>
		<div style="text-align: center;padding-top: 5px;">
			<a class="mini-button" plain="true"  width="80px" onclick="onOk()">保存</a>
		</div>
	</div>
</div>
<rx:formScript formId="form1" baseUrl="wx/portal/wxPortalBtn"
			   entityName="com.redxun.wx.portal.entity.WxMobilePortalButton" />

<script>
	$(function(){
		$.post('${ctxPath}/oa/info/insPortalDef/getMobilePersonalPort.do', function(_dat){
			var _html = $.parseHTML(_dat.html),
					$_html = $(_html);
			$("#centerUl").append($_html[0].innerHTML);
		})

		//初始化入口别名
		var portAlias ='${wxPortalBtn.portAlias}';
		if(portAlias&&portAlias!=''){
			var portAliasJson = JSON.parse(portAlias);
			console.info(portAliasJson);
			mini.get("portAlias").setValue(portAlias);
			mini.get("portAlias").setText(portAliasJson.name);
			console.info(mini.get("portAlias").getValue());
		}


	});

	var mobileUrl = {"bpmSolution":"startForm","customList":"customList"};

	mini.parse();
	var form = new mini.Form("#form1");

	function onOk(){
		form.validate();
		if (!form.isValid()) {
			return;
		}
		var data=form.getData();
		if(data.icon == ""){
			data.icon = '${wxPortalBtn.icon}'
		}
		var config={
			url:"${ctxPath}/wx/portal/wxPortalBtn/save.do",
			method:'POST',
			postJson:true,
			data:data,
			success:function(result){
				CloseWindow('ok');
			}
		}
		_SubmitJson(config);
	}

	function onButtonEdit(){
		var appType = mini.get("appType").getValue();
		var appTypeName = mini.get("appType").getText();
		var btnEdit = this;
		mini.open({
			url: __rootPath + "/wx/portal/wxPortalBtn/appTypePage.do?appType=" + appType,
			title: appTypeName,
			width: 1024,
			height: 768,
			showMaxButton:true,
			ondestroy: function (action) {
				//if (action == "close") return false;
				if (action == "ok") {
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);    //必须
					console.info(data.key + ":" + data.name);
					if (data) {
						var btnEditData = {};
						btnEditData.key = data.key;
						btnEditData.name = data.name;
						btnEdit.setValue(JSON.stringify(btnEditData));
						btnEdit.setText(data.name);
						var url = getPortUrl(data);
						mini.get("url").setValue(url);
					}
				}

			}
		});

	}

	//构建不同类型的手机端菜单
	function getPortUrl(data){
		debugger;
		var url = "";
		var appType = mini.get("appType").getValue();
		if(appType=="bpmSolution"){
			url = '/' + mobileUrl[appType] + '/' + data.solId  + '/-1';
		}
		else if(appType=="customList"){
			url = '/' + mobileUrl[appType] + '/' + data.key;
		}
		return url;
	}

</script>
</body>
</html>