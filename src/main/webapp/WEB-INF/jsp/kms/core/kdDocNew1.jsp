<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>新建信息</title>
	<%@include file="/commons/edit.jsp"%>

	<style>
		.pauseBtn{
			display: inline-block;
			height: 34px;
			-webkit-border-radius: 2px;
			-moz-border-radius: 2px;
			border-radius: 2px;
			padding: 0 14px ;
			line-height: 34px;
			background: #409eff;
			color: #fff;
			text-align: center;
			font-size: 14px;
            cursor: pointer;
			vertical-align: middle;
		}
        .pauseBtn:hover{
            background: #66b1ff;
        }
		header{
			border-bottom: 1px solid #ddd;
			padding-right: 20px;
			text-align: right;
			padding-bottom: 10px;
		}
		.bottom-toolbar{
			padding: 10px 0;
		}
		.flows{
			font-size: 0;
			text-align: center;
			white-space: nowrap;
			width: 100%;
			padding: 40px 0;
		}
		.circleBox,
		.lines{
			display: inline-block;
			vertical-align: middle;
		}
		.lines{
			width: 10%;
			height: 1px;
			font-size: 14px;
			background: #ddd;
			margin: 0 10px;
		}
		.circleBox{
			font-size: inherit;
		}
		.circleBox span,
		.circleBox p{
			display: inline-block;
			font-size: 14px;
		}
		.circleBox span{
			width: 40px;
			height: 40px;
			line-height: 40px;
			border: 1px solid #ddd;
			text-align: center;
			border-radius: 50%;
		}
		.circleBox p{
			margin-left: 10px;
			color: #888;
		}
		.circleBox.active .circles{
			border-color: #3a82fa;
			color: #3a82fa;
		}
		.circleBox.active p{
			color: #333;
			font-weight: bold;
		}
		.table-detail.column-two tr td:nth-child(odd){
			text-align: right;
		}
		.table-detail.column-two>tbody>tr>td{
			border: 0;
			height: 60px;
		}
		.table-detail{
			border: 0;
		}
		.mini-textboxlist-inputLi{
			display: none;
		}

	</style>
</head>
<body>
<div class="mini-fit" style="padding: 20px 0;">
	<div class="form-container">
		<header>
			<span class="pauseBtn" onclick="temporary()">暂存</span>
			<a class="mini-button" onclick="savePost1()">下一步</a>
		</header>
		<div class="flows">
			<div class="circleBox active" >
				<span class="circles">1</span>
				<p>填写基本内容</p>
			</div>
			<div class="lines"></div>
			<div class="circleBox">
				<span class="circles">2</span>
				<p>填写内容</p>
			</div>
			<div class="lines"></div>
			<div class="circleBox">
				<span class="circles">3</span>
				<p>完善属性</p>
			</div>
			<div class="lines"></div>
			<div class="circleBox">
				<span class="circles">4</span>
				<p>权限设置</p>
			</div>
		</div>
		<input id="docId" name="docId" class="mini-hidden" value="${param['docId']}" />
		<input id="docType" name="docType" class="mini-hidden" value="KD_DOC" />
		<form id="form1" method="post">
			<table class="table-detail column-two" cellspacing="0" cellpadding="0" style="width: 54%;margin: auto">
				<tr>
					<td>所属分类*：</td>
					<td>
						<textarea class="mini-textboxlist" required="true"
								  allowInput="false" validateOnChanged="false"
								  style="width: 300px;"
								  text="${treeType}" value="${kdDoc.treeId}"
								  id="treeId" name="treeId"
						>
						</textarea>
						<a class="mini-button" style="margin-left: 10px;vertical-align: middle" onclick="selectGroup()">选择分类</a>
					</td>
				</tr>
				<tr>
					<td>文档标题*：</td>
					<td><input name="subject" value="${kdDoc.subject}"
							   class="mini-textbox" vtype="maxLength:128"
							   style="width: 80%" required="true" emptyText="请输入文档标题" />
					</td>
				</tr>
				<tr>
					<td>作者类型*：</td>
					<td>
						<div name="authorType" class="mini-radiobuttonlist" value="${kdDoc.authorType}"
							 required="true" repeatItems="1" textField="text"
							 valueField="id" data="[{id:'INNER',text:'内部'},{id:'OUTER',text:'外部'}]"
							 onValueChanged="changAuthorType">

						</div>
					</td>
				</tr>
				<tr>
					<td>作者*：</td>
					<td>
						<input name="author" value="${kdDoc.author}" class="mini-textbox"
							   vtype="maxLength:64" style="width: 80%" required="true" emptyText="请输入作者" />
					</td>
				</tr>
				<tr id="dep">
					<td>所属部门：</td>
					<td>
						<input id="belongDepid" name="belongDepid" value="${kdDoc.belongDepid}" text="${depName}"
							   allowInput="false" style="width: 80%;" class="mini-buttonedit" onbuttonclick="selectDepartment" />
					</td>
				</tr>
				<tr id="pos">
					<td>所属岗位：</td>
					<td>
						<input id="authorPos" name="authorPos" value="${kdDoc.authorPos}" text="${jobName}" style="width:80%;"
							   allowInput="false" class="mini-buttonedit" onbuttonclick="selectJob" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<%--<div style="margin-top: 20px; margin-left: 40%;">
	<a class="topButton" style="background-color: #909090; height: 40px; width: 90px; line-height: 40px;">上一步</a>
	<a class="topButton" style="height: 40px; width: 90px; line-height: 40px; text-decoration: none;" onclick="savePost1()">下一步</a>
</div>--%>
<script type="text/javascript">
	addBody();
	var form = new mini.Form("form1");
	var kdDocId = "${param['docId']}";
	var tenantId = "${param['tenantId']}";
	function savePost1() {
		form.validate();
		if (!form.isValid()) {
			return;
		}
		var formData = $("#form1").serializeArray();
		$.ajax({
			type : "POST",
			url : __rootPath + '/kms/core/kdDoc/saveNew1.do',
			async : false,
			data : formData,
			success : function(result) {
				var docId = result;
				window.location.href = "${ctxPath}/kms/core/kdDoc/new2.do?docId=" + docId;
			}
		});
	}

	//部门选择
	function selectDepartment() {
		var infDepartment = mini.get('belongDepid');
		infDepartment.setValue("");
		infDepartment.setText("");
		_GroupSingleDim(true, "1", function(users) {
			var uIds = [];
			var uNames = [];
			uIds.push(users.groupId);
			uNames.push(users.name);
			if (infDepartment.getValue() != '') {
				uIds.unshift(infDepartment.getValue().split(','));
			}
			if (infDepartment.getText() != '') {
				uNames.unshift(infDepartment.getText().split(','));
			}
			infDepartment.setValue(uIds.join(','));
			infDepartment.setText(uNames.join(','));
		});
	}

	//岗位选择
	function selectJob() {
		var infJob = mini.get('authorPos');
		infJob.setValue("");
		infJob.setText("");
		_GroupSingleDim(true, "3", function(users) {
			var uIds = [];
			var uNames = [];
			uIds.push(users.groupId);
			uNames.push(users.name);
			if (infJob.getValue() != '') {
				uIds.unshift(infJob.getValue().split(','));
			}
			if (infJob.getText() != '') {
				uNames.unshift(infJob.getText().split(','));
			}
			infJob.setValue(uIds.join(','));
			infJob.setText(uNames.join(','));
		});
	}

	//分类选择
	function selectGroup() {
		var infGroup = mini.get('treeId');
		infGroup.setValue("");
		infGroup.setText("");
		_TypeDlg(true, function(users) {
			var uIds = [];
			var uNames = [];
			uIds.push(users.treeId);
			uNames.push(users.name);
			if (infGroup.getValue() != '') {
				uIds.unshift(infGroup.getValue().split(','));
			}
			if (infGroup.getText() != '') {
				uNames.unshift(infGroup.getText().split(','));
			}
			infGroup.setValue(uIds.join(','));
			infGroup.setText(uNames.join(','));
		});
	}
	function _TypeDlg(single, callback, reDim) {
		if (!reDim) {
			reDim = false;
		}
		_TenantTypeDlg('', single, '', callback, reDim);
	}
	function _TenantTypeDlg(tenantId, single, showDimId, callback, reDim) {
		var title = '知识分类选择';
		_OpenWindow({
			iconCls : 'icon-group',
			url : __rootPath + '/kms/core/kdDoc/groupDialog.do?single=' + single + '&tenantId=' + tenantId +'&cat=CAT_KMS_KDDOC',
			height : 480,
			width : 680,
			title : title,
			ondestroy : function(action) {
				if (action != 'ok')
					return;
				var iframe = this.getIFrameEl();
				var groups = iframe.contentWindow.getGroups();
				var dim = {};
				//需要返回dim
				if (reDim) {
					var dimNode = iframe.contentWindow.getSelectedDim();
					dim = {
						dimId : dimNode.dimId,
						dimKey : dimNode.dimKey,
						name : dimNode.name
					};
				}
				if (callback) {
					if (single && groups.length > 0) {
						callback.call(this, groups[0], dim);
					} else {
						callback.call(this, groups, dim);
					}
				}
			}
		});
	}

	//暂存
	function temporary(){
		form.validate();
		if (!form.isValid()) {
			return;
		}
		var formData = $("#form1").serializeArray();
		$.ajax({
			type : "POST",
			url : __rootPath + '/kms/core/kdDoc/saveNew1.do',
			async : false,
			data : formData,
			success : function(result) {
				alert("知识文档已暂存，可以在个人中心中继续编辑！");
				CloseWindow();
			}
		});
	}

	function changAuthorType(e){
		var authorType = this.getValue();
		if(authorType == "OUTER"){
			$("#dep").hide();
			$("#pos").hide();
		}else{
			$("#dep").show();
			$("#pos").show();
		}
	}
</script>
</body>
</html>