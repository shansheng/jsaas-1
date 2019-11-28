<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[链接]分享</title>
<%@include file="/commons/edit.jsp"%>
<script src="${ctxPath}/scripts/jquery/qrcode.min.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/clipboard.min.js" type="text/javascript"></script>
<style>
.dz,
.er {
	margin: 30px;
}
.dz{
	width: 740px;
}

.er #qrcode {
	padding-left: 80px;
	
}
.er{
	position: relative;
}

.btn {
	
	background: #3987FE;
	width: 80px;
	height: 23px;
	border-radius:5px;
	border:0px;
	color:#fff;
	
}
.er .txt{
	width:300px;
	top:80px;
	position: absolute;
	right: 50px;
	font-size: 20px;
	color:#3987FE;
}
</style>
</head>
<body>

<div field="dept_name" width="120" class="dz"> 
	地址链接：<input id="txtUrl"  name="txtUrl" type="text" style="width: 80%" value="${genSrc}">
	<button class="btn" data-clipboard-action="copy" data-clipboard-target="#txtUrl">复制链接</button>
</div>
<div class="er">
	二维码分享：<div id="qrcode"></div>
	<div class="txt">使用手机扫描二维码阅读在线文档 </div>
</div>
		
	<script type="text/javascript">
		//mini.parse();
		var url="${genSrc}";
		var clipboard = new ClipboardJS('.btn');
		$(function(){
			var qrcode = new QRCode(document.getElementById("qrcode"), {
				text: url,
				width: 128,
				height: 128,
				colorDark : "#000000",
				colorLight : "#ffffff",
				correctLevel : QRCode.CorrectLevel.H
			});
		
		});
		function closeWin() {
			CloseWindow('Ok');
		}
	</script>

</body>
</html>