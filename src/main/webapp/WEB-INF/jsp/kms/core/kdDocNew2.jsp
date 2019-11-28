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
	#form1>p{
		padding: 6px 0;
	}
.circleBox .circleBox_img{
	background: url("${ctxPath}/styles/images/correct.jpg") no-repeat;
	border: 0;
}
</style>
</head>
<body>
<div class="mini-fit" style="padding: 20px 0;">
	<div class="form-container" >
		<header>
			<span class="pauseBtn" onclick="temporary()">暂存</span>
			<a class="pauseBtn" href="${ctxPath}/kms/core/kdDoc/new1.do?docId=${param['docId']}" onclick="savePost1()">上一步</a>
			<a class="mini-button" onclick="savePost2()">下一步</a>
		</header>
		<div class="flows">
			<div class="circleBox " >
				<span class="circles circleBox_img">&nbsp;</span>
				<p>填写基本内容</p>
			</div>
			<div class="lines"></div>
			<div class="circleBox active">
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
		<form id="form1" method="post">
			<input id="docId" name="docId" class="mini-hidden" value="${param['docId']}" />
			<p>知识正文内容</p>
			<div style="border: 1px solid #ddd;">
				<ui:UEditor height="300" width="100%" name="content" id="content">${kdDoc.content}</ui:UEditor>
			</div>
			<p>附件</p>
			<div>
				<input id="attFileids" name="attFileids" class="upload-panel"
					   plugins="upload-panel" allowupload="true"
					   label="附件" fname="fileNames"
					   allowlink="true" zipdown="true" fileIds="${kdDoc.attFileids}" fileNames="${fileNames}" />
			</div>
		</form>

	</div>
</div>

	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form1");
		var kdDocId = "${param['docId']}";
		function savePost2() {
			form.validate();
			if (!form.isValid()) {
				return;
			}
			var formData = $("#form1").serializeArray();

			var table = $('.table-opinion');
			var trList = table.children().children();
			var fileIdList = "";
			for(var i=0;trList&&i<trList.length;i++){
				var id = trList[i].id;
				var idList = id.split('li_');
				if(i==trList.length-1){
					fileIdList = fileIdList+idList[1];
				}else{
					fileIdList = fileIdList+idList[1]+",";
				}
			}

			if(fileIdList){
				var fileObject = {
					name:"attFileids",
					value:fileIdList
				};
				formData.push(fileObject);
			}
			$.ajax({
				type : "POST",
				url : __rootPath + '/kms/core/kdDoc/saveNew2.do',
				async : false,
				data : formData,
				success : function(result) {
					var docId = result;
					window.location.href = "${ctxPath}/kms/core/kdDoc/new3.do?docId=" + docId;
				}
			});
		}

		function temporary(){
			form.validate();
			if (!form.isValid()) {
				return;
			}
			var formData = $("#form1").serializeArray();
			$.ajax({
				type : "POST",
				url : __rootPath + '/kms/core/kdDoc/saveNew2.do',
				async : false,
				data : formData,
				success : function(result) {
					alert("知识文档已暂存，可以在个人中心中继续编辑！");
					CloseWindow();
				}
			});
		}
		
		//上传附件
		$(function() {
			$('.upload-panel').each(function() {
				var fileIds="${kdDoc.attFileids}";
				if(fileIds){
					var fileListHtml=$('${fileList}');
					var tableBody = $('.mini-panel-body');
					tableBody.after(fileListHtml);
				}
			});
		});
		function dele(fileId){
			document.getElementById("li_"+fileId).remove();
		}

	</script>
</body>
</html>