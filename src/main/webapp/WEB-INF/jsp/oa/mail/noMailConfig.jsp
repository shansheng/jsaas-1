<%-- 
    Document   : 没有外部邮箱账号配置处理页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>你还没有设置邮箱账号配置</title>
<script src="${ctxPath}/scripts/boot.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share.js" type="text/javascript"></script>
<style type="text/css">
	p{
		margin:0;
	}
	#p1{
		position:absolute;
		left:0;
		right:0;
		bottom:0;
		top:0;
		margin:auto;
		padding:10px;
		height:200px;
		width:800px;
	
		
	}
	#p1 h1,
	#p1 p{
		font-size:16px;
		color:#333;
	}
	#p1 .noMail{
		display:inline-block;
		width:98px;
		height:64px;
		background:url(../../../styles/images/mail.png);
	}
	#p1 a.editMail{
		margin-top:6px;
		display:inline-block;
		padding:4px 10px;
		background:#29A5BF;
		color:#fff;
		border-radius:4px;
		font-size:16px;
	}
</style>
</head>
<body>
	<div>
        <div id="p1" class="form-outer" >
      		<div style="text-align:center">
      			<span class="noMail"></span>
	      		<h1>
	      			您还没有增加邮箱的账号设置！
	      		</h1>
	      		<p>
	      			请您配置您的外部邮箱的连接信息~
	      		</p>
	      		<div>
	      			<a class="editMail" href="#">配置邮箱</a>
	      		</div>
        	</div>
		</div>
	</div>
<script type="text/javascript">
	var __rootPath='${ctxPath}';
	/*点击事件处理*/
	$("a.editMail").on("click",function(){
		_OpenWindow({
			url:__rootPath+"/oa/mail/mailConfig/edit.do",
			title : '添加账号配置',
			width : 720,
			height : 600,
			ondestroy : function(action) {
					if(action=='ok')
						window.location=__rootPath+"/oa/mail/mailConfig/getAllConfig.do";
					}
			});
	});
</script>
</body>
</html>