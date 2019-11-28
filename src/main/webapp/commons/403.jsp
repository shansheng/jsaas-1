<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>访问拒绝</title>
<style type="text/css">
.errorContent{
	display: flex;
	align-items: center;
	justify-content: space-between;
    width: 1100px;
    position: absolute;
    left: 50%;
    top: 50%;
    margin-left: -550px;
    margin-top: -250px;
}
.errorTit{
	font-size: 122px;
	color: #f8aa12;
	padding-bottom: 5px;
	font-weight: bold;
}
.errorTip{
	font-size: 50px;
	height: 130%;
	padding-bottom: 40px;
	color: #333;
	font-weight: bold;
	transform: scale(1,1.3);
}
.left button{
	border: 0;
	background: #2d93fb;
	border-radius: 5px;
	color: #fff;
	font-size: 30px;
	width: 280px;
	height: 80px;
	text-align: center;
	line-height: 30px;
}
.left button:hover{
	background: #48a2fe;
	cursor: pointer;
}
.right div{
	text-align: center;
	font-size: 30px;
	color: #c4d3e2;
	padding-top: 10px;
}
</style>
</head>
<body>
	<div class="errorContent">
		<div class="left">
			<div class="errorTit">403</div>
			<div class="errorTip">FORBIDDEN</div>
			<button>返回首页</button>
		</div>
		<div  class="right">
			<img src="${ctxPath}/styles/images/403.png" alt="出错"/>
			<div>没有操作权限，请联系系统管理员~</div>
		</div>
	</div>
</body>
</html>

