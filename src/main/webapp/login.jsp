<%@ page pageEncoding="UTF-8" %>
<%
	//用于ajax请求时，其响应时进行回写标识，以使前台可以跳到登录页
	response.setHeader("timeout", "true");
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/commons/dynamic.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"> 
 <link rel="shortcut icon" href="${ctxPath}/styles/images/index/icon.ico">
 <script src="${ctxPath}/scripts/jquery-1.11.3.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/jquery.cookie.js" type="text/javascript"></script> 
<script src="${ctxPath}/scripts/jquery/plugins/jquery-cookie.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/sha256.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/login-h01.css"/>
<title>企业BPM敏捷平台--用户登录</title>
<script type="text/javascript">
if(top!=this){//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
	top.location='${ctxPath}/login.jsp';
}
</script> 
</head>
<body>
		<canvas id="canvas" width="1500" height="1000"></canvas>
        <div class="login-box">
        	<div class="logo">
        		<span></span>
        		<p class="textName">企业BPM敏捷平台</p>
        	</div>
        	<div class="content_login">
				<div class="Myinput">
					<span class="span1"></span>
					<input type="text" id="u1">
				</div>
				<div class="Myinput">
					<span class="span2"></span>
					<input type="password"   id="p1" value="">
				</div>
				<div>
					<input type="checkbox" id="rememberMe">
					<span class="rember-me">记住密码</span>
					<span class="forget-key"><a href="${ctxPath}/forgetPwd.jsp">忘记密码?</a></span>
				</div>
				<div style="text-align:center;">
					<input type="button" value="登   录" class="login-btn" onclick="onLoginClick()" id="Login">
				</div>
				<h4>
					新企业？<a href="${ctxPath}/register.jsp">注册申请免费试用。</a>
				</h4>
			</div>
        </div>

		<div class="loadingBox">
			<div class="mini-mask-msg mini-mask-loading">
				<span>登录中...</span>
			</div>
		</div>
	<script src="${ctxPath}/scripts/common/login-01.js"></script>
	<script type="text/javascript">
	 	$(function(){
			var username=$.getCookie('username');	
			if(username){
				$("#username").val(unescape(username));
			}
		}); 
		function onLoginClick(e) {

            var loginTime = setTimeout(function() {
            	$('.loadingBox').show();
            	$('.login-box').hide();
            },100);

			var u1=$("#u1").val(),
			p1=$("#p1").val(),
			rememberMe=$("#rememberMe").is(':checked')?"1":"0";

		  	if( u1=='' || p1=='' ){
		  		clearTimeout(loginTime);
		  		$('.loadingBox').hide();
		  		return alert('账号 密码不能为空');
		  	}
		  	p1=sha256_digest(p1);

		    $.ajax({
		        url: "${ctxPath}/login.do",
		        type: "post",
		        data: {acc:u1,pd:p1,rememberMe:rememberMe},
		        success: function (result) {
		           if(result && result.success){
						window.location = "${ctxPath}/index.do" ;
		           }else{
                	 $('.loadingBox').hide();
                	 $('.login-box').show();
                	 clearTimeout(loginTime);
		             alert("登录失败！"+result.message);
		           }
		        },failture:function(){
	                 alert("登录失败！");
	                 clearTimeout(loginTime);
	                 $('.loadingBox').hide();
	                 $('.login-box').show();
		        }
		    }); 
		}

		function reset(){
			$("#u1").val('');
			$("#p1").val('');
		}

	$(window).resize(
		marginTop
	);
	function marginTop(){
		var window_h = $(window).height(),
			window_w = $(window).width(),
			content_h = $(".content_bg").height(),
			content_margin = (window_h-content_h)/2-30;
		
		$("body").height(window_h)
		$(".content_bg").css("marginTop",content_margin);
		
		if(window_w < 1200){
			$("body").removeClass("minWidth");
		}else{
			$("body").addClass("minWidth");
		}
	}
	marginTop();
	$(".content_r p input").mouseenter(function(){
		$(this).stop(true,true).animate({top:-1},100);
	}).mouseleave(function(){
		$(this).stop(true,true).animate({top:0},100);
	});

	//键盘事件
	var Login = document.getElementById('Login');
	document.onkeydown = function(ev){
		var ev = ev || event;
		if(ev.keyCode === 13){
			Login=onLoginClick();
		}
	};
</script>
</body>
</html>