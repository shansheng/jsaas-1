<%@ page pageEncoding="UTF-8" %>
<!doctype html>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
	<%@include file="/commons/dynamic.jspf" %>
	<link rel="shortcut icon" href="${ctxPath}/styles/images/login2/icon.ico">
	<link rel="stylesheet" href="${ctxPath}/styles/login02.css" type="text/css">
	<script src="${ctxPath}/scripts/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/jquery/plugins/jquery-cookie.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/common/sha256.js" type="text/javascript"></script>

	<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/login-h01.css"/>
	<title>红迅软件-合作伙伴平台--登录</title>
	<style>
		.hides{
			display: none;
			position: absolute;
			left: 40px;
			right: 43px;
			border: 1px solid #ddd;
			z-index: 999;
			top: 48px;
			background: #fff;
			border-radius: 3px;
		}
		.hides li{
			line-height: 20px;
			font-size:14px;
		}
		.hides li:hover{
			background: #ddd;
			color: #fff;
			cursor: pointer;
		}
	</style>
</head>
<body>

<canvas id="canvas" width="1500" height="1000"></canvas>
<div class="login-box">
	<div class="logo">
		<span></span>
		<p class="textName">APS敏捷开发平台</p>
	</div>
	<div class="content_login">
		<div class="Myinput" style="position: relative">
			<span class="span1" ></span>
			<input type="text" class="firmName" id="companyName" name="companyName" value="机构名称">
			<ul class="hides" style="position: absolute;" id="hides">
			</ul>
		</div>
		<div class="Myinput">
			<span class="span1"></span>
			<input type="text"  class="loginId" id="username" name="username" value="登录账号" onfocus="if(value=='登录账号'){value=''}" onblur="if(value==''){value='登录账号'}">
		</div>
		<div class="Myinput">
			<span class="span2"></span>
			<input id="password" class="loginPassword" type="password" name="password" value="">
		</div>
		<div>
			<input type="checkbox" id="rememberMe">
			<span class="rember-me">记住密码</span>
			<span class="forget-key"><a href="${ctxPath}/forgetPwd.jsp">忘记密码?</a></span>
		</div>
		<div style="text-align:center;">
			<input type="button" value="登   录" class="login-btn" onclick="loginAction()" id="Login">
		</div>
	</div>
</div>

<script src="${ctxPath}/scripts/common/login-01.js"></script>
<script type="text/javascript">
	hides();
	var isShow = false;
	function hides(){
		$("#hides").hide();
		$("#companyName").click(function(event){
			if(isShow){
				$("#hides").show();
			}
			event.stopPropagation();
		});
		$("#hides").on("click","li",function(event){
			var values = $(this).html();
			$("#companyName").val(values);
			$(this).parent().hide();
			event.stopPropagation();
		});
		$("body").click(function(){
			$("#hides").hide();
		});
	}

	$('#companyName').bind('input propertychange', function() {
		var  companyNameValue =$('#companyName').val();
		if(companyNameValue){
			$.ajax({
				url: "${ctxPath}/partner/getAllInst.do",
				type: "post",
				data: {
					companyName:companyNameValue
				},
				success: function (data) {
					if(data && data.length>0){
						isShow = true;
						$(".hides").empty();
						for(var i=0;i<data.length;i++){
							$(".hides").append("<li>"+data[i]+"</li>");
						}
						$(".hides").show();
					}else{
						isShow = false;
						$(".hides").hide();
					}
				},failture:function(){
				}
			});
		}else if(isShow){
			$(".hides").show();
		}
	});


	function reset(){
		document.getElementById('loginForm').reset();
	}
	$(function(){
		var username=$.getCookie('username');
		var companyName=$.getCookie('companyName');
		if(username){
			$("#username").val(unescape(username));
		}
		if(companyName){
			$("#companyName").val(unescape(companyName));
		}
	});
	function loginAction(){
		var username=$("#username").val();
		var companyName=$("#companyName").val();
		var password=$("#password").val();
		$.setCookie('username',username);
		$.setCookie('companyName',companyName);
		showLoading();
		password=sha256_digest(password);
		$.ajax({
			url: "${ctxPath}/partner/login.do",
			type: "post",
			data: {
				username:username,
				companyName:companyName,
				password:password
			},
			success: function (result) {
				if(result && result.success){
					setTimeout(function() {
						// hideLoading();
						$.setCookie('username',username);
						window.location = "${ctxPath}/index.do";
					}, 200);
				}else{
					alert("登录失败！"+result.message);
					hideLoading();
				}
			},failture:function(){
				alert("登录失败！");
				hideLoading();
			}
		});
	}
	function showLoading() {
		$("#content").css('display','none');
		$("#loading").css('display','');
	}


	function hideLoading() {
		$("#loading").css('display','none');
		$("#content").css('display','');
	}
</script>


<!--上下居中-->
<script type="text/javascript">
	$(window).resize(
			marginTop
	);
	function marginTop(){
		var window_h = $(window).height(),
				window_w = $(window).width(),
				content_margin = (window_h-590)/2;
		$(".content_bg").css("marginTop",content_margin);

		if(window_w < 1200){
			$("body").removeClass("minWidth");
		}else{
			$("body").addClass("minWidth");
		}
	}
	marginTop();
	$(".content_r p input")
			.mouseenter(function(){
				$(this).stop(true,true).animate({top:-1},100);
			})
			.mouseleave(function(){
				$(this).stop(true,true).animate({top:0},100);
			});

</script>



<!--footer-->
<div class="footer_bg">
	<p>©版权所有</p>
</div>

</body>
</html>
