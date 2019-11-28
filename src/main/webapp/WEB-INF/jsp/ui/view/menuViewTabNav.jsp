<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>功能展示区</title>
   <%@include file="/commons/list.jsp"%>
        <style type="text/css">
        	.span-icon{
        		display: block;
        		padding:5px;
        		clear: both;
        		margin:5px;
        	}
        	
        	.menuItem{
	        	float:left;
	        	display: block;
	        	width:100px;
	        	margin:5px;
	        	text-align:center;
	        	padding:10px;
	        	cursor: pointer;
	        	border:solid 1px #eee
        	}
        	
        	.menuItem:hover{
        		background-color: yellow;
        	}
        	
        	body{
        		background-color:white;
        		margin-top:10px;
        	}
        	
        	#tab-nav .mini-tab{
				border-color:#fff;
				border-bottom-color:#ececec;
				padding:6px;
			}
			
			#tab-nav .mini-tab-active{
				background:#fff;
				border-bottom:solid 2px #3a82fa;
			}
			
			#tab-nav .mini-tab-active span{
				color:#3a82fa;
				font-weight:500;
			}
			
			#tab-nav .mini-tab .mini-iconfont:before{
				font-size:14px;
			}
			
			#tab-nav .mini-tab-active .mini-iconfont:before{
				color:#3a82fa;
			}
        </style>
    </head>
    <body>
    	<div class="mini-fit" style="background-color: white;">
	        <div id="tab-nav" class="mini-tabs"  style="width:100%;height:100%;background-color: white;">
	         <c:forEach items="${menus}" var="menu">
	         	<c:set var="url" value="${ctxPath}${menu.url}"/>
	         	<c:if test="${fn:startsWith(menu.url, 'http')}">
	         		<c:set var="url" value="${menu.url}"/>
	         	</c:if>
	         	<div title="${menu.name}"  iconCls="${menu.iconCls}" url="${url}"></div>
	         </c:forEach>
	        </div>
        </div>
        <script type="text/javascript">
            mini.parse();
        </script>
    </body>
</html>
