<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${appName}</title>
	<%@include file="/commons/dynamic.jspf"%>
	
	<link rel="shortcut icon" href="${ctxPath}/styles/images/index/icon.ico">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/icons.css?static_res_version=${static_res_version}">
	<script type="text/javascript" src="${ctxPath}/scripts/mini/boot.js?static_res_version=${static_res_version}"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/jquery/jquery.cookie.js?static_res_version=${static_res_version}"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/share.js?static_res_version=${static_res_version}" ></script>
	<script type="text/javascript" src="${ctxPath}/scripts/common/baiduTemplate.js?static_res_version=${static_res_version}"></script>
	<script src="${ctxPath}/scripts/oa/info/remind.js?static_res_version=${static_res_version}" type="text/javascript"></script>
	
	<link href="${ctxPath}/scripts/index/index5/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
	<link href="${ctxPath}/scripts/index/index5/tabs.css" rel="stylesheet" type="text/css" />
    <link href="${ctxPath}/scripts/index/index5/frame.css" rel="stylesheet" type="text/css" />
    <link href="${ctxPath}/scripts/index/index5/index.css" rel="stylesheet" type="text/css" />
    <link href="${ctxPath}/scripts/index/index5/menu.css" rel="stylesheet" type="text/css" />
    <script src="${ctxPath}/scripts/index/index5/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/index/index5/menu.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/index/index5/menutip.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/index/index5/manage.js" type="text/javascript"></script>

</head>
<body>
	<div class="navbar">
    <div class="navbar-header">
        <div class="navbar-brand">${appName}</div>
        <div class="navbar-brand navbar-brand-compact"><i class="icon-index_icon"></i></div>
    </div>
    <ul class="nav navbar-nav" id="divRootMenu">
    	<li><a id="toggle"><span class="fa fa-bars" ></span></a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
        <li ><a href="#" onclick="getMyTask()"><i class="fa fa-paper-plane"></i> 代办事项</a></li>
        <li><a href="#" onclick="updatePwd(${curUser.sysAccount.accountId})"><i class="fa fa-pencil-square-o"></i> 修改密码</a></li>
        <li class="dropdown">
            <a class="dropdown-toggle userinfo">
                <img class="user-img" src="${ctxPath}/scripts/index/index5/user.jpg" />个人资料<i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu pull-right">
            	<li><a href="#" class="p_top theme" data-src="index"><i class="fa fa-eye "></i>炫黑高雅主题</a></li>
            	<li><a href="#" class="p_top theme" data-src="index1"><i class="fa fa-eye "></i>简约时尚主题</a></li>
            	<li><a href="#" class="p_top theme" data-src="index2"><i class="fa fa-eye "></i>浅蓝经典主题</a></li>
            	<li><a href="#" class="p_top theme" data-src="index3"><i class="fa fa-eye "></i>深蓝经典主题</a></li>
<!--             	<li><a href="#" class="p_top theme" data-src="index4"><i class="fa fa-eye "></i>深灰项目主题</a></li>
            	<li><a href="#" class="p_top theme" data-src="index5"><i class="fa fa-eye "></i>深黑经典主题</a></li> -->
                <li><a href="#" onclick="editInfo()"><i class="fa fa-eye "></i> 用户信息</a></li>
                <li><a href="#" onclick="javascript:location.href='${ctxPath}/logout'"><i class="fa fa-user"></i> 退出登录</a></li>
            </ul>
        </li>
    </ul>
</div>

<div class="container">
    
    <div class="sidebar">
        <div class="sidebar-toggle"><i class = "fa fa-fw fa-dedent" ></i></div>
        <div id="mainMenu"></div>
    </div>

    <div class="main">
        <div id="mainTab" class="mini-tabs main-tabs" activeIndex="0" style="height:100%;" plain="false"
             buttons="#tabsButtons" arrowPosition="side" onactivechanged="onTabsActiveChanged">
            <div name="index" iconCls="fa-android" title="首页"></div>
        </div>
    </div>
   
</div>
	
</body>
</html>
<script id="rootTemplate" type="text/html">
  <#for(var i=0;i<list.length;i++){
    var menu=list[i];
  #>
<li id="<#=menu.menuId#>" class="icontop iconfont" onclick="changeSystem(this)"><a href="#"><i class="nav_icon <#=menu.iconCls#>"></i><span ><#=menu.name#></span></a></li>
  <#}#>
</script>
