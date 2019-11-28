<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>新建信息</title>
<%@include file="/commons/edit.jsp"%>
<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
<style>
*{font-family: '微软雅黑'}


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
			<a class="pauseBtn"  href="${ctxPath}/kms/core/kdDoc/new2.do?docId=${param['docId']}">上一步</a>
			<a class="mini-button" onclick="savePost3()">下一步</a>
		</header>
		<div class="flows">
			<div class="circleBox" >
				<span class="circles circleBox_img">&nbsp;</span>
				<p>填写基本内容</p>
			</div>
			<div class="lines"></div>
			<div class="circleBox ">
				<span class="circles circleBox_img">&nbsp;</span>
				<p>填写内容</p>
			</div>
			<div class="lines"></div>
			<div class="circleBox active">
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

			<table style="width: 100%;" class="gridtable" cellspacing="1" cellpadding="0">
				<tr>
					<th style="vertical-align: top;">封面图</th>
					<td colspan="3"><input name="coverImgId" value="${kdDoc.coverImgId}" class="mini-hidden" vtype="maxLength:64" />
						<img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${kdDoc.coverImgId}" class="upload-file" /></td>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: top;">摘要 </th>
					<td style=""><textarea name="summary" class="mini-textarea" vtype="maxLength:512" style="height: 100px; width: 500px;">${kdDoc.summary}</textarea></td>
				</tr>
				<tr>
					<th style="vertical-align: top;">标签</th>
					<td><input name="tags" value="${kdDoc.tags}" class="mini-textbox" vtype="maxLength:200" style="width: 100%" /></td>
				</tr>
				<tr>
					<th style="vertical-align: top;">存放年限 </th>
					<td style="">
						<input id="storePeroid"
							   name="storePeroid"
							   value="${kdDoc.storePeroid}"
							   class="mini-spinner"
							   minValue="0" maxValue="20"
						/>&nbsp;年（0年表示永不过期，文档到达过期时间后转为过期文档）
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>


	<script type="text/javascript">
		var form = new mini.Form("form1");
		var kdDocId = "${param['docId']}";
		
		//封面图
		$(function() {
			$(".upload-file").on('click', function() {
				var img = this;
				_UserImageDlg(true, function(imgs) {
					if (imgs.length == 0)
						return;
					$(img).attr('src', '${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=' + imgs[0].fileId);
					$(img).siblings('input[type="hidden"]').val(imgs[0].fileId);

				});
			});
		});

		$(function() {
			var time = "${kdDoc.storePeroid}";
			var t = mini.get("storePeroid");
			if (time == "") {
				t.setValue("0");
			}
		});
		
		//提交第三步表单
		function savePost3() {
			
			form.validate();
			if (!form.isValid()) {
				return;
			}
			var formData = $("#form1").serializeArray();
			$.ajax({
				type : "POST",
				url : __rootPath + '/kms/core/kdDoc/saveNew3.do',
				async : false,
				data : formData,
				success : function(result) {
					var docId = result;
					window.location.href = "${ctxPath}/kms/core/kdDoc/new4.do?docId=" + docId;
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
				url : __rootPath + '/kms/core/kdDoc/saveNew3.do',
				async : false,
				data : formData,
				success : function(result) {
					alert("知识文档已暂存，可以在个人中心中继续编辑！");
					CloseWindow();
				}
			});
		}
	</script>
</body>
</html>