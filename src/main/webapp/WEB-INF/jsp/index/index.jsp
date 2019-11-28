<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>${appName}</title>
	
	<meta charset="UTF-8">
	<meta content="text/html; http-equiv="Content-Type" charset=utf-8"/>
	<%@include file="/commons/index.jsp"%>
	
	<script type="text/javascript" src="${ctxPath}/scripts/index/index/sidemenu.js"></script>
	<link rel="stylesheet" href="${ctxPath}/scripts/index/index/templates.css"/>
	<link rel="stylesheet" href="${ctxPath}/scripts/index/index/sidemenu.css"/>
	<script src="${ctxPath}/scripts/index/index/manage.js" type="text/javascript"></script>
</head>
<body>
	<ul 
 		id="tabsMenu" 
 		class="mini-contextmenu" 
 		onbeforeopen="onBeforeOpen" 
 		style="display:none"
	>
   		<li onclick="closeTab">关闭当前</li>
		<li onclick="closeAllBut">保留当前</li>
		<li onclick="closeAllButFirst">保留首页</li>
    </ul>	

    <div class="topbar">
		<div class="title_box">
	    	<i class="icon-index_icon"></i>
	        <a class="logo" href="#">${appName}</a>
			<p>&nbsp;欢迎您，${curUser.depPathNames}&nbsp;${curUser.fullname}</p>
		</div>
        <ul class="top_icon">
			<li class="My_skin">
				<a  class="icon-skin p_top My_skin2" title="个人信息"></a>
				<dl style="display:none;">
					<dt></dt>
					<dd class="p_top">
						<p onclick="editInfo()">修改个人信息</p>
					</dd>
					<c:if test="${not empty cookie.switchUser }" >
					<dd class="p_top">
						<p onclick="exitSwitchUser()">退出切换</p>
					</dd>
					</c:if>
					
					<dd class="p_top theme" data-src="index">
						<p>炫黑高雅主题</p>
					</dd>
				<!-- 	<dd class="p_top theme" data-src="index1">
						<p>简约时尚主题</p>
					</dd> -->
					<dd class="p_top theme" data-src="index2">
						<p>浅蓝经典主题</p>
					</dd>
					<dd class="p_top theme" data-src="index3">
						<p>深蓝经典主题</p>
					</dd>
					<dd class="p_top theme" data-src="index4">
						<p>深灰项目主题</p>
					</dd>
					<!-- 	<dd class="p_top theme" data-src="index5">
						<p>深黑经典主题</p>
					</dd> -->
				</dl>
			</li>
			<li onclick="innerMsgInfo()">
			<!--  
				<a class="icon-News p_top" title="我的消息"></a>
				-->
			</li>
			<li onclick="onEmail()">
				<a class="icon-Mailbox p_top" title="内部邮件"></a>
			</li>
			<li class="result">
				<a class="iconfont icon-nodeReminder"></a>
				<span style="color:#ff5f5f;position: absolute;left: 25px;bottom: 12px;display:none;" id="redDot">●</span>
				<div id="test" class="messagebox" style="display:none;">
					<span>◆</span>
				</div>
			</li>
			<li class=" _top3" id="moreOrganiParent">
				<a class="iconfont icon-user-org-18" title="多机构列表"></a>
				<dl style="display: none;">
					<dt></dt>
					<dd class="p_top">
						<div id="moreOrgani">
						</div>
					</dd>
				</dl>
			</li>

			<li onclick="javascript:location.href='${ctxPath}/logout'">
				<a class="icon-SignOut p_top"  title="注销"></a>
			</li>
		</ul>
    </div>
    <div class="sidebar">
    	<div class="sidebar_btn">
    		<span class="sidebar_up iconfont sidebar_btn_up"></span>
    		<span class="sidebar_down iconfont sidebar_btn_down"></span>
    	</div>
    	
    	<div class="search">
			<div>
				<input type="text" placeholder="搜索菜单" class="searchVal" />
			</div>
<!-- 			<span>搜</span> -->
			<ul class="listBox"></ul>	
		</div>
    	
    	
    	<div class="sidebar_color"></div>
        <div id="menu1"></div>
    </div>
    <div class="main">
        <div id="mainTab" 
			class="mini-tabs" 
			activeIndex="0" 
			style="width:100%; height:100%; border: 0px;" 
			plain="false" 
			contextMenu="#tabsMenu" 
			onactivechanged="onTabsActiveChanged" 
			bodyStyle="padding:0;margin:0"
        >
            <div title="首页" name="homepage" iconCls=" icon-home" url="${ctxPath}/oa/info/insPortalDef/home.do"></div>
        </div>
        
    </div>

</body>
</html>


