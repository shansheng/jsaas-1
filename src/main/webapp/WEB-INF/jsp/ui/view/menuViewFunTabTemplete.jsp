<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>功能展示区</title>
	<%@include file="/commons/list.jsp"%>
	<style type="text/css">
		.menuItem {
			float: left;
			display: block;
			width: 120px;
			height:110px;
			margin: 10px;
			text-align: center;
			padding: 40px 0 0;
			cursor: pointer;
			border: solid 1px #eee;
			border-radius: 10px;
		}

		.p_top i{
			float: left;
			text-align: center;
			width: 100%;
		}

		.p_top i:before{
			float: none;
			font-size:50px;
		}

		.menuItem h1{
			font-size:14px;
			line-height:16px;
			color:#666;
			text-align: center;
			font-weight: normal;
			margin:30px 0 0 0 ;
			float: left;
			width: 100%;
		}

		.mini-tab-text{
			margin-left: 4px;
		}

		.mini-tab {
			padding-left:10px;
			padding-right:10px;
		}

		/*.mini-panel-header-inner .mini-iconfont::before{
			font-size:20px !important;
			float: left;
			color: #fff;
		}*/

		.mini-panel .mini-panel-title{
			line-height:22px;
			color: #fff;
		}

		#tab-nav .mini-tab-active .mini-tab-text{
			color:#3a82fa;
			font-weight:500;
		}

		#tab-nav .mini-tab .mini-iconfont:before{
			font-size:20px;
		}

		#tab-nav .mini-tab-active .mini-iconfont:before{
			color:#EC6F21;
		}

		.p_top:hover{
			box-shadow: 0 6px 18px 2px #e0e5e7;
			border-color: transparent;
		}

		/*.mini-panel-header-inner{
			padding: 6px 4px;
		}*/

		.mini-panel .mini-panel-icon{
			line-height: 22px;
			height: 22px;
		}

		.mini-fit{
			margin-top: 0;
		}

		.mini-tabs-bodys{
			border: none;
		}

		body .mini-tabs-plain .mini-tabs-headers{
			padding-top: 10px;
			background: #fff;
		}
		.subscript{
			color: #fff;
			height: 30px;
			width: 100px;
			position: absolute;
			left: 0px;
			text-align: center;
			line-height: 30px;
			background-color: #409EFF;
			border-top-right-radius: 15px;
			border-bottom-right-radius: 15px;
		}

		.tab-panel{
			margin: 11px;
			padding: 8px 5px 10px 4%;
			height: 160px;
			background-color: #fff;
		}

		.itmsFont{
			font-size: 0;
			padding:  12px 6px 0;
		}
		.itmsBoxNot{
			width: calc( 100% / 6 );
			box-sizing: border-box;
			text-align: center;
			font-size: 0;
			display: inline-block;
			margin: 0 0 12px;
			vertical-align: middle;

		}
		.itmsBoxNot>div{
			border-radius: 6px;
			background: #fff;
			padding:26px 10px 20px;
			margin:0 6px;
			cursor: pointer;
			-webkit-transition: all 0.3s;
			-moz-transition: all 0.3s;
			-ms-transition: all 0.3s;
			-o-transition: all 0.3s;
			transition: all 0.3s;
		}
		.itmsBoxNot>div:hover{
		/*	margin-top: -2px;*/
			box-shadow: 0 6px 18px 2px #e0e5e7;
			color: #3a82fa;
		}
		.itmsBoxNot i:before{
			font-size: 40px;
		}
		.itmsBoxNot p{
			font-size: 14px;
			margin-top: 10px;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}

		.itmsBos{
			font-size: 14px;
			border-radius: 6px;
			background: #fff;
			margin:  0 6px;
			margin-bottom: 12px;
		}
		.itmsBos header{
			line-height: 40px;
			padding-left: 20px;
			border-bottom: 1px solid #eef2f4;
		}
		.itmsBos ul{
			font-size: 0;
			padding: 10px 0;
			margin: 0 6px;
		}
		.itmsBos ul li{
			vertical-align: middle;
			font-size: 14px;
			width: calc( 100% / 8  );
			display: inline-block;
			color: #555;
			text-align: center;
		}
		.itmsBos ul li>div{
			padding: 20px 10px 16px;
			margin: 6px;
			border-radius: 6px;
			background: #fff;
			cursor: pointer;
			border: 1px solid #eef2f4;
			-webkit-transition: all 0.3s;
			-moz-transition: all 0.3s;
			-ms-transition: all 0.3s;
			-o-transition: all 0.3s;
			transition: all 0.3s;
		}
		.itmsBos ul li>div:hover{
			margin-top: -2px;
			box-shadow: 0 6px 18px 2px #e0e5e7;
			color: #3a82fa;
		}
		.itmsBos ul li i:before{
			font-size: 35px;
		}
		.itmsBos ul li p{
			margin-top: 6px;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
	</style>
	<!--[if IE 8 ]>
	<style>.p_top:hover{border-color: #ccc;}</style>
	<![endif]-->
</head>
<body>
<!-- tab类型 -->
<c:if test="${menuDisplay=='tab'}">
	<div class="mini-fit">
		<div id="tab-nav" class="mini-tabs" tabPosition="top" style="width:100%;height:100%">
			<c:forEach items="${menus}" var="menu">
				<div title="${menu.name}" url="${ctxPath}${menu.url}"  style="margin: 5px;padding: 5px;">
					<c:forEach items="${menu.childList}" var="subMenu">
						<div
								class="menuItem link p_top"
								url="${subMenu.url}"
								menuId="${subMenu.menuId}"

								title="${subMenu.name}"
								showType="${subMenu.showType}"
						>
							<i class="${subMenu.iconCls} span-icon"></i>
							<h1 class="tabName">${subMenu.name}</h1>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
</c:if>
<!-- 块状按钮类型 -->
<c:if test="${menuDisplay=='block'}">
	<div class="container itmsFont">
			<c:choose>
				<c:when test="${isMultiMenus==false}">
					<c:forEach items="${menus}" var="menu">
						<div
								class="menuItem link p_top"
						>
							<i class="${menu.iconCls}"></i>
							<h1>${menu.name}</h1>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${menus}" var="menu">
						<c:if test="${ empty menu.childList}"><%--没有子项--%>
							<div class="itmsBoxNot link"
								 url="${menu.url}"
								 title="${menu.name}"
								 menuId="${menu.menuId}"
								 iconCls="${menu.iconCls}"
								 showType="${menu.showType}"
							>
								<div>
									<i class="iconfont ${menu.iconCls}"></i>
									<p>${menu.name}</p>
								</div>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${menus}" var="menu">
						<c:if test="${ not empty menu.childList}"><%--有子项--%>
							<div class="itmsBos">
								<header>${menu.name}</header>
								<ul>
									<c:forEach items="${menu.childList}" var="subMenu">
									<li class="link"
										title="${subMenu.name}"
										menuId="${subMenu.menuId}"
										iconCls="${subMenu.iconCls}"
										showType="${subMenu.showType}"
										url="${subMenu.url}"
										>
										<div>
											<i class="${subMenu.iconCls}"></i>
											<p>${subMenu.name}</p>
										</div>
									</li>
									</c:forEach>
								</ul>
							</div>
						</c:if>
					<%--	<div
								class="tab-panel"
								iconCls="${menu.iconCls}"
								title="${menu.name}"
								width="auto"
								height="auto"
								style=""
						>
							<div class="subscript" iconCls="${menu.iconCls}">
									${menu.name}
							</div>
							<c:forEach items="${menu.childList}" var="subMenu">
								<div
										class="menuItem link p_top"
										url="${subMenu.url}"
										title="${subMenu.name}"
										menuId="${subMenu.menuId}"
										iconCls="${subMenu.iconCls}"
										showType="${subMenu.showType}"
								>
									<i class="${subMenu.iconCls}"></i>
									<h1>${subMenu.name}</h1>
								</div>
							</c:forEach>
						</div>--%>
					</c:forEach>
				</c:otherwise>
			</c:choose>

	</div>
</c:if>





<script type="text/javascript">
	mini.parse();
	console.log("${menus}");
	$(function() {
		$('.link').click(function() {
			var link = $(this);
			var showType = link.attr('showType');
			var title = link.attr('title');
			var url = link.attr('url');
			var menuId=link.attr('menuId');
			var iconCls=link.attr('iconCls');

			top['index'].showTabPage({
				title:title,
				url:url,
				showType:showType,
				iconCls:iconCls,
				menuId:menuId
			});
		});
	});

</script>
</body>
</html>
