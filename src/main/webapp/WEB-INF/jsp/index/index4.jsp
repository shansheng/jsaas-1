<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${appName}</title>
	<%@include file="/commons/index.jsp"%>
	<link type="text/css" rel="stylesheet" href="${ctxPath}/scripts/index/index4/manage3.css" />

	<link type="text/css" rel="stylesheet" href="${ctxPath}/scripts/index/index4/index4.css" />
	<link href="${ctxPath}/styles/commons.css?static_res_version=${static_res_version}" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctxPath}/scripts/index/index4/manage.js"></script>

</head>
<body>
<ul
	id="tabsMenu"
	class="mini-contextmenu"
	onbeforeopen="onBeforeOpen"
	style="display: none"
	>
	<li onclick="closeTab">关闭当前标签页</li>
	<li onclick="closeAllBut">关闭其他标签页</li>
	<li onclick="closeAll">关闭所有标签页</li>
</ul>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="message.i18n" />
<fmt:setLocale value="zh_CN" />


<div id="mainLayout" class="mini-layout top_one" style="width: 100%; height: 100%;" >
	<div
			showHeader="false"
			region="west"
			showSplit="true"
			class="nav"
			width="222"
			showSplitIcon="false"
			showCollapseButton="true"
			splitSize="0"
			style="border-top: 0px;"
			>
		<div class="logoBoxs">
			<em class="iconLogo"></em>
			<span id="logoTitle" style="padding-right: 6px">
				<%--${appName}--%>
				企业流程平台
			</span>
		</div>
		<div class="mini-fit">
			<ul class="sidemenu" id="sidemenu"></ul>
		</div>
	</div>
	<div
			title="center"
			region="center"
			showSplitIcon="false"
			showCollapseButton="false"
			showTreeIcon="true"
			>
		<div class="mini-layout" style="width: 100%;height: 100%">
			<div
					class="topBar"
					region="north"
					height="50"
					showHeader="false"
					style="border: 0px"
					allowResize="false"
					showSplit="false"
					showSplitIcon="false"
					showProxy="false"
					splitSize="0"
			>
				<div class="headerBox" id="headerBox">
					<div id="toggleBtn">

					</div>
					<ul id="headerNav">
						<%--<c:if test="${menuSize<=4}">--%>
							<c:forEach items="${menus}" var="menu" varStatus="i">
									<li <c:if test="${i.count==1}">class="act"</c:if> iconCls="${menu.iconCls }" showType="${menu.showType }" menuId="${menu.menuId}" name="${menu.name}" url="${menu.url }">
										<i class="iconfont ${menu.iconCls }"></i>
										${menu.name }
									</li>
							</c:forEach>
					<%--	</c:if>--%>
						<%--<c:if test="${menuSize>4}">
							<c:forEach items="${menus}" var="menu" varStatus="i" begin="0" end="3">
								<li <c:if test="${i.count==1}">class="act"</c:if> iconCls="${menu.iconCls }" showType="${menu.showType }" menuId="${menu.menuId}" name="${menu.name}" url="${menu.url }">
									<i class="iconfont ${menu.iconCls }"></i>
									${menu.name }
								</li>
							</c:forEach>
							<li id="navMore">
							更多&nbsp;<i class="iconfont icon-shouqi3"></i>
							<div class="navMoreBoxs">
								<ul class="moreSelect">
							<c:forEach items="${menus}" var="menu" varStatus="i" begin="4" end="${menuSize }">
								<li iconCls="${menu.iconCls }" showType="${menu.showType }" menuId="${menu.menuId}" name="${menu.name}" url="${menu.url }">
									<i class="iconfont ${menu.iconCls }"></i>
									${menu.name }
								</li>
							</c:forEach>
									</ul>
							</div>
							</li> 
						</c:if>--%>
					</ul>
					<ul id="headerToolbar">
						<li class="skinBtn">
							<p ><i class="iconfont icon-huanfu2" title="更多皮肤"></i></p>
							<ol class="hideSkin">
								<li class="theme" data-src="index">
									<p>炫黑高雅主题</p>
								</li>
								<li class="theme" data-src="index2">
									<p>浅蓝经典主题</p>
								</li>
								<li class="theme" data-src="index3">
									<p>深蓝经典主题</p>
								</li>
								<li class="theme" data-src="index4">
									<p>深灰项目主题</p>
								</li>
							</ol>
						</li>
						<li class="result">
							<i class="iconfont icon-urge"></i>
							<span style="" id="redDot"></span>
							<div id="test" class="messagebox" >

							</div>
						</li>
						<li onclick="onEmail()">
							<i class="iconfont icon-Mailbox" title="内部邮件"></i>
						</li>
						<li class="user" onclick="editInfo()">
                            <span style="vertical-align: middle">
							    ${curUser.fullname}<c:if test="${not empty curDep }">&nbsp;[${curDep.name}]</c:if>
                            </span>
							<i id="userMessage" class="iconfont icon-zhanghao" title="个人信息"></i>
						</li>
						<li class="_top2" onclick="javascript:location.href='${ctxPath}/logout'">
							<i class="iconfont icon-jieshu1 " title="退出"></i>
                            <span style="vertical-align: middle;">退出</span>
						</li>
					</ul>
					<div class="search">
						<div>
							<input type="text" placeholder="搜索菜单" class="searchVal" />
						</div>
						<!-- 			<span>搜</span> -->
						<ul class="listBox"></ul>
					</div>
				</div>
			</div>

			<div title="center"
				 region="center"
				 showSplitIcon="false"
				 showCollapseButton="false"
				 showTreeIcon="true"
			>
				<div class="mini-fit">
					<div
						id="mainTab"
						class="mini-tabs"
						activeIndex="0"
						arrowPosition="side"
						showNavMenu="true"
						style="width: 100%!important; height: 100%; border: 0px;"
						plain="false"
						contextMenu="#tabsMenu"
						onactivechanged="onTabsActiveChanged"
						bodyCls="width:100%;"
					>
						<div title="首页"  url="${ctxPath}/oa/info/insPortalDef/home.do" ></div>

					</div>
				</div>
			</div>
		</div>
	</div>






</div>

<script type="text/html" id="leftMenuTemplate">
<#for(var i=0;i<list.length;i++){
    var menu=list[i];
  #>
    <li class="firstmenu">
          <p menuId="<#=menu.menuId#>" name="<#=menu.name#>" url="<#=menu.url#>" showType="<#=menu.showType#>" iconCls="<#=menu.iconCls#>" class="menu base">
			<i class="<#=menu.iconCls#>"></i>
			<span><#=menu.name#></span>
			<#if(menu.children){#>
				<span class="spread">
					<span class="horizontal"></span><span class="vertical"></span>
				</span>
			<#}#>
		  </p>
		<#
        if(!menu.children) continue;
        for(var k=0;k<menu.children.length;k++){      
          var menu2=menu.children[k]; 
        #>
              <ul class="secondmenu">
                  <li >
                      <p iconCls="<#=menu2.iconCls#>" showType="<#=menu2.showType#>"  menuId="<#=menu2.menuId#>" name="<#=menu2.name#>" url="<#=menu2.url#>" >
						<i class="iconfont <#=menu2.iconCls#>"></i>
						<span><#=menu2.name#></span>
						<#if(menu2.children){#>
							<span class="spread">
								<span class="horizontal"></span><span class="vertical"></span>
							</span>
						<#}#>
					  </p>
            		  <#if(menu2.children){#>
                      	<ul class="threemenu">
              		  		<#for(var m=0;m<menu2.children.length;m++){     
              					var menu3=menu2.children[m]; 
              		  		#>
                            	<li menuId="<#=menu3.menuId#>" iconCls="<#=menu3.iconCls#>" name="<#=menu3.name#>" url="<#=menu3.url#>" showType="<#=menu.showType#>">
									<p showType="<#=menu3.showType#>" iconCls="<#=menu3.iconCls#>" menuId="<#=menu3.menuId#>" name="<#=menu3.name#>" url="<#=menu3.url#>" >
										<i class="iconfont <#=menu3.iconCls#>"></i>
										<span><#=menu3.name#></span>
										<#if(menu3.children){#>
											<span class="spread">
												<span class="horizontal"></span><span class="vertical"></span>
											</span>
										<#}#>
									</p>
									
                      			<#if(menu3.children){
									var menusfour=menu3.children;
								#>
								
								<ul class="fourmenu">
              		  				<#for(var n=0;n<menusfour.length;n++){     
              							var menu4=menusfour[n]; 
              		  				#>
                            			<li menuId="<#=menu4.menuId#>" name="<#=menu4.name#>" iconCls="<#=menu.iconCls#>" iconCls="<#=menu4.iconCls#>" url="<#=menu4.url#>" showType="<#=menu.showType#>">
											<p iconCls="<#=menu4.iconCls#>" showType="<#=menu.showType#>"  menuId="<#=menu4.menuId#>" name="<#=menu4.name#>" url="<#=menu4.url#>" >
												<i class="<#=menu4.iconCls#>"></i>
												<span><#=menu4.name#></span>
												<#if(menu4.children){#>
													<span class="spread">
														<span class="horizontal"></span><span class="vertical"></span>
													</span>
												<#}#>
											</p>
										</li>
                      				<#}#>
                      			</ul>
								
								<#}#>
								</li>
							<#}#>
                      	</ul>
            		  <#}#>
                  </li>
              </ul>
            <#}#>
      </li>
      <#}#>




</script>
<script>
	/*---------头部导航适应---------*/
	$(function () {
		$(window).resize(function () {
			setTimeout(function () {
				headerNav();
			},500);
		})
		var _liAll = $("#headerNav li");
		var  arryAll = [];
		for (var k = 0 ; k< _liAll.length; k++ ){
			arryAll.push(_liAll.eq(k));
		}
		headerNav();
		function headerNav() {
			$("#headerNav").empty();
			$.each(arryAll,function (s,val) {
				$("#headerNav").append(val);
			})
			var headerBox_width = $("#headerBox").width();
			var headerToolbar_width = $("#headerToolbar").innerWidth();
			var max_headerNav_width =  headerBox_width - headerToolbar_width - 70 ;
			$("#headerNav").width(max_headerNav_width);
			var _width = 0 ;
			var  arry1 =[];
			var  arry2 =[];
			var _li = $("#headerNav li");
			for (var i = 0 ; i< _li.length; i++ ){
				_width = _width + _li.eq(i).innerWidth() + 13 ;
				if(_width + 80 > max_headerNav_width){
					arry2.push(_li.eq(i));
				}else {
					arry1.push(_li.eq(i));
				}
			}
			var html_more = $('<li id="navMore">' +
					'更多&nbsp;<i class="iconfont icon-shouqi3"></i>'+
					'<div class="navMoreBoxs">'+
					'<ul class="moreSelect" id="moreSelect">'+
					'</ul>'+
					'</div>'+
					'</li>')
			$("#headerNav").empty();
			if (_width > max_headerNav_width){
				$("#headerNav").append(arry1);
				$("#headerNav").append(html_more);
				$("#moreSelect").append(arry2)
			} else {
				$("#headerNav").append(arry1);
			}
		}
	})
</script>
</body>
</html>
