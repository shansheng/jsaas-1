﻿<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Bootstrap Layout</title>
	<%@include file="/commons/dynamic.jspf"%>
	<%-- 	<link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/bootstrap-combined.min.css"> --%>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/layoutit/css/combined.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/icons.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/layoutit/css/layoutitIndex.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/layoutit.css">
	<script type="text/javascript" src="${ctxPath }/scripts/boot.js" ></script>
	<%-- 	<script type="text/javascript" src="${ctxPath }/scripts/jquery-1.11.3.js"></script>
     --%>	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery-ui.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery.htmlClean.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/common/baiduTemplate.js"></script>
	<%-- 	<script type="text/javascript" src="${ctxPath}/scripts/mini/miniui/miniui.js"></script>
     --%>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/scripts.js"></script>

	<script type="text/javascript" src="${ctxPath }/scripts/weixin/portal/js/tmpInit.js?t=3"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/weixin/portal/css/index.css?t=3">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/weixin/portal/icon/iconfont.css">
	<style>

		body {background:white;}
		.saveBtn{position:absolute;top:20px;right:100px;border:1px solid #999;background:#BADAE9;padding:10px 20px;color:#000;}
		.saveBtn:hover{background:#f60;color:#fff;cursor:pointer;}
		.leftSideListItem{width:100%;height:40px;line-height:40px;text-align:center;background:white;}
	</style>
</head>
<body>
<div class="bodys" style="margin-top:20px;">
	<a class="saveBtn" onclick="saveHtml()">保存</a>
	<div class="left_content">
		<ul>
			<c:forEach items="${list}" var="item">
				<li id="li_${item.key}" title="${item.name}" style="text-align:center;" onclick="appendToDemoV('${item.colId}')">
					<div class="leftSideListItem">${item.name}</div>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="center_content">
		<div class="centerBox">
			<c:if test="${not empty insPortalDef.editHtml}">
				${insPortalDef.editHtml}
			</c:if>
			<c:if test="${empty insPortalDef.editHtml}">
				<div class="contentHeaderBox">
					<div class="headerNav">
						<span class="headerIconLeft"><i class="iconfont icon-yonghu"></i></span>
						<span class="headerText">欢迎您：${currentUser}</span>
					</div>
				</div>
				<div class="addBoxs" style="position: relative;height:calc(100% - 40px);">
					<ul class="centerUl" id="centerUl">
					</ul>
				</div>
			</c:if>
		</div>
	</div>
</div>
<div class="" style="display: none;">
	<!--banner模板-->
	<ul id="mod_banner">
		<li class="centerLi liBannerBox">
			<div class="bannerBox">
				<ul class="picBox">
				</ul>
				<ul class="dot"></ul>
			</div>
			<div class="editBox">
				<ul>
					<li class="up">上</li>
					<li class="dow">下</li>
					<li class="del">删</li>
				</ul>
			</div>
		</li>
	</ul>
	<!--应用模板-->
	<ul id="mod_app">
		<li class="centerLi liModuleBox">
			<p class="moduleHeadline"></p>
			<ul class="moduleUl"></ul>
			<div class="editBox">
				<ul>
					<li class="up">上</li>
					<li class="dow">下</li>
					<li class="del">删</li>
				</ul>
			</div>
		</li>
	</ul>
</div>
<script>
	function saveHtml(){
		var saveDemo = $(".centerBox").clone();
		saveDemo.find(".editBox").remove();
		saveDemo.find(".contentHeaderBox").remove();
		var portId = "${portId}";
		var url = __rootPath + "/oa/info/insPortalDef/saveHtml.do?portId="	+ portId;
		var params = {
			editHtml : $(".centerBox").html(), 	//编辑的html
			formatSrc : saveDemo.html()			//预览的html
		};
		$.post(url, params, function(data) {
			CloseWindow('ok');
		});
	}

	function appendToDemoV(colId){
		var url = '${ctxPath}/oa/info/insColumnDef/getColHtml.do';
		$.post(url, {'colId': colId}, function(dat){
			$("#centerUl").append(dat);
			var centerLi = $(".centerLi");
			$.each(centerLi, function(){
				if($(this).find(".editBox").length <= 0){
					$(this).append('<div class="editBox"><ul><li class="up"><i class="iconfont icon-shang"></i></li><li class="dow">'+
							'<i class="iconfont icon-xia"></i></li><li class="del"><i class="iconfont icon-shanchu2"></i></li></ul></div>');
				}
			});
		});
	}
</script>
</body>
</html>
