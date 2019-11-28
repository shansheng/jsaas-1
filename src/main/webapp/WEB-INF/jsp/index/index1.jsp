<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<title>${appName}</title>
<%@include file="/commons/index.jsp"%>
<link type="text/css" rel="stylesheet" href="${ctxPath}/scripts/index/index1/index.css">
<script type="text/javascript" src="${ctxPath}/scripts/index/index1/scroll.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/index/index1/index.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/index/index1/manage.js"></script>
</head>
<body>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="message.i18n"/>
<fmt:setLocale value="zh_CN" />
<div class="top_bg">
	<div class="search">
		<div>
			<input type="text" placeholder="搜索菜单" class="searchVal" />
		</div>
		<ul class="listBox"></ul>	
	</div>
	<div class="top_l">
			<div id="top_l_top">
				<div class="avatar">
					<img src="${fullPath}" alt="" title="编辑个人信息">
				</div>
				<span>
					<h1>身份：${curUser.fullname}</h1>
					<h2>部门：<c:if test="${not empty curDep }">[${curDep.name}]</c:if></h2>
				</span>
				<div class="clearfix"></div>
			</div>
			<div id="top_l_bottom">
				<p>菜单导航</p>
				<img src="${ctxPath}/styles/images/index/index_indent.png" alt="" id="top_l_bottom01">
				<img src="${ctxPath}/styles/images/index/index_indent02.png" alt="" id="top_l_bottom02">
				<div class="clearfix"></div>
			</div>
		<div class="clearfix"></div>
	</div>
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs top_r">
		<div>
			<span class="fl logo">
				<i class="icon-index_icon"></i>
				<h1>${appName}</h1>
			</span>
	        <ul class="top_icon">
				<li>
					<a  class="iconfont icon-skin p_top" title="个人信息"></a>
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
						<!-- <dd class="p_top theme" data-src="index1">
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
					<!--	<dd class="p_top theme" data-src="index5">
							<p>深黑经典主题</p>
						</dd> -->
					</dl>
				</li>
				<li onclick="innerMsgInfo()">
					<a class="iconfont icon-News p_top" title="我的消息"></a>
				</li>
				<li onclick="onEmail()">
					<a class="iconfont icon-Mailbox p_top" title="内部邮件"></a>
				</li>
				
				
				<li onclick="javascript:location.href='${ctxPath}/logout'">
					<a class="iconfont icon-SignOut p_top"  title="注销"></a>
				</li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="top_tab_box">
			<div class="Hui-tabNav-wp">
				<ul id="min_title_list" class="acrossTab cl">
					<li class="active">
						<span title="首页" class="activespan" >首页</span>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
		</div>	
		<div class="Hui-tabNav-more btn-group">
			<a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;">
				<i class="Hui-iconfont"></i>
			</a>
			<a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;">
				<i class="Hui-iconfont"></i>
			</a>
		</div>
	</div>
	<div class="clearfix"></div>
</div>
<!-- tab右键 -->
<dl id="rightMenu">
	<dd id="refreshMenu" class="p_top">
		刷新当前
	</dd>
	<dd id="currentMenu" class="p_top">
		关闭当前
	</dd>
	<dd id="allMenu" class="p_top">
		关闭全部
	</dd>
	<dd id="otherMenu" class="p_top">
		关闭其它
	</dd>
</dl>
<!--nav_left-->
<div class="nav_l_bg Hui-aside" id="out"> 
</div>
<!--content-->
<div class="content_bg" id="index_content">
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe iframe_show">
			<div style="display:none" class="loading" ></div>
			<iframe id="welcome" scrolling="auto" frameborder="0" src="${ctxPath}/oa/info/insPortalDef/home.do" style="border:none"></iframe>
		</div>
	</div>
</div>



<!-- loading -->
<div id="loading">
  <div id="loading-center">
    <div id="loading-center-absolute">
      <div class="object" id="object_one"></div>
      <div class="object" id="object_two"></div>
      <div class="object" id="object_three"></div>
      <div class="object" id="object_four"></div>
    </div>
  </div>
</div>

<script id="leftMenuTemplate"  type="text/html">
<div id="inner">
  <#for(var i=0;i<list.length;i++){
    var menu=list[i];
  #>
		<div class="nav_l_box menu_dropdown bk_2">
			<span>
				<h5 class="<#=menu.iconCls#> iconfont nav_l_icon_l" title="<#=menu.name#>" menu-id="<#=menu.menuId#>"></h5>
				<h1><#=menu.name#></h1>
				<span class="nav_l_btn">
					<span class="nav_l_bnt_column"></span>
					<span class="nav_l_bnt_wor"></span>
				</span>
				<div class="clearfix"></div>
			</span>

			<#
			if(!menu.children) continue;#>
			<dl>
			<#for(var k=0;k<menu.children.length;k++){      
			var menu2=menu.children[k]; 
			#>
			<dd class="nav_tab p_top secondmenu">
				<a title="<#=menu2.name#>" menu-id="<#=menu2.menuId#>" showType="<#=menu2.showType#>" data-href="<#if(menu2.url==''||!menu2){#>
				<#}else{#>
					<#=menu2.url#>
				<#}#>" data-title="<#=menu2.name#>">
					<h5 class="<#=menu2.iconCls#> iconfont"></h5>
					<p><#=menu2.name#></p>
					<#if(menu2.children){#>
						<i class="icon-subordinate"></i>
					<#}#>
				</a>
				 <#if(menu2.children){#>
                      <ul>
              <#for(var m=0;m<menu2.children.length;m++){     
              var menu3=menu2.children[m]; 
              #>
					<li class="threemenu">
						<a  data-href="<#=menu3.url#>" menu-id="<#=menu3.menuId#>" showType="<#=menu3.showType#>" data-title="<#=menu3.name#>">
							<p><#=menu3.name#></p>
							<#if(menu3.children){#>
								<i class="icon-subordinate"></i>
							<#}#>
						</a>

						<#if(menu3.children){#>
							<ul>
							<#for(var g=0;g<menu3.children.length;g++){
							var menu4=menu3.children[g]; 
              				#>
    
								<li class="fourmenu">
									<a data-href="<#=menu4.url#>" menu-id="<#=menu4.menuId#>" showType="<#=menu4.showType#>" data-title="<#=menu4.name#>">
										<p><#=menu4.name#></p>
									</a>	
								</li>
							<#}#>
							</ul>
						<#}#>
					</li>
                          <#}#>
                      </ul>
                      <#}#>
			</dd>
			<#}#>
			</dl>
			</div>
		<#}#>
</div>
<div id="scrollbar">
	<div id="scrollbtn"></div>
</div>
</script>
<script type="text/javascript" src="${ctxPath}/scripts/index/index1/H-ui.min.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/index/index1/H-ui.admin.js"></script>
</body>
</html>
