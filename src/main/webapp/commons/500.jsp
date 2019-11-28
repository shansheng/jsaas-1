<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  isErrorPage="true"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/commons/dynamic.jspf"%>
<title>您访问的页面出错了</title>
</head>
<style type="text/css">
h1,h2,h3,h4,h5{font-weight: normal;margin: 0}
.content_box{width:96%;margin: 0 auto;text-align: center;}
</style>
<body>
	<div class="content_box">	
		<h1>500错误</h1>
		<div style="padding:5px;font-size:12px;color:red;width:500px;margin:auto;">
			原因：<%out.println(exception.getMessage());%>
		</div>
	</div>
</body>
</html>