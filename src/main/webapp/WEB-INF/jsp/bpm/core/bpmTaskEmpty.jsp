<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>待办事项已经被处理</title>
<%@include file="/commons/list.jsp"%>
<style>
body{ text-align:center;}
.messageBox{
	width:420px;
	border:solid 1px #07c66e;
	padding-bottom:20px;
	background: #fff;
	position: absolute;
    left: 50%;
    margin-left: -210px;
    top: 60px;
}
.messageBox div{
	text-align:center;
}
.messageTit{
	background-color:#07c66e;
	border-bottom:solid 1px #07c66e;
	height:36px;
	line-height: 36px;
	color:#fff;
}
.messageBox div img{
	margin-top:20px;
	border:0;
}
.message{
	color:#333;
	font-size:16px;
	padding:20px;
}
.mini-button{
	width:60px;
}
</style>
</head>
<body>
	<div class="messageBox">
		<div class="messageTit">消息提示</div>
		<div><img src="${ctxPath}/styles/images/alert.png" alt="警告"/></div>
		<div class="message">该任务已经被执行完成！</div>
		<div>
			<a class="mini-button btn-red" onclick="CloseWindow('ok')">关闭</a>
		</div>
	</div>
</body>
</html>