<%-- 
    Document   : iconSelectDialog
    Created on : 2017-5-26, 7:26:58
    Author     : cmc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>项目列表</title>
<%@include file="/commons/list.jsp"%>
<c:if test="${param.type=='mobile' }">
<link href="${ctxPath}/styles/mobile.css?static_res_version=${static_res_version}" rel="stylesheet" type="text/css" />
</c:if>
<style type="text/css">
*{
	font-family: '微软雅黑';
}
.iconfont{
	color: #2eaeff;
}
.displayPannel{
	width: 504px;
}

.divicon{
	float:left;
	cursor:pointer;
	border: 1px solid white;
	border-radius:4px;
	width: 38px;
	height:38px;
	background: #efefef !important;
	margin:0  1px;
    text-align: center;
}

.divicon:last-child::after{
	content:'';
	display:block;
	clear: both;
}

.divicon:hover{
	border: 1px solid #BCD2EE; 
}

.divicon::before{
    font-size: 24px;
    height: 38px;
    width: 38px;
    line-height: 40px;
    font-weight: normal;
    padding-right:0;
    margin-right:0;
}
.mini-panel-header-inner{
/* 	padding:0 !important; */
}

.mini-panel-header{
	background: #fff !important;
}

.mini-panel-header-inner span{
	display: none;
}

.mini-panel-header-inner .mini-panel-title{
	width: 100%;
	text-align: center;
}

.mini-pager{
	padding: 3px 0;
	border-top: 1px solid #ececec;
	width: 100%;
	position: fixed; 
	bottom: 0;
	left: 0;
	height: auto;
}
body{
	background: #fff;
}

.mini-messagebox .mini-panel-header{
	background: #fff;
}

.mini-messagebox .mini-messagebox-content-text .iconfont:before{
	font-size: 26px;
}
.mini-pager-left .mini-button{
	margin:0 2px;
}

</style>
</head>
    </head>
    <body>
    <div class="mini-toolbar" >
		<div class="form-toolBox">
			<input class="mini-textbox" id="iconName" emptyText="请输入图标名称,如task" onenter="searchIcon()" style="width:250px;">
			<a class="mini-button"  onclick="searchIcon()" >查询</a>
		</div>
    </div>
	<div class="mini-fit">
		<div id="displayPannel" style="width: 100%;"></div>
		<div 
			id="pager" 
			class="mini-pager"
			onpagechanged="onPageChanged"
			showPageSize="false" 
			showPageSize="true" 
			showPageIndex="true" 
			showPageInfo="true" 
			buttons="#buttons"
		></div>
	</div>

	<script type="text/javascript">
		var iconArray;
		var chooseIconName;
		var displayPannel = $("#displayPannel");
		var icons='${matchList}';
		function getIcon() {
			return chooseIconName;
		}

		$(function() {
			iconArray = icons.substring(1, icons.length - 1).split(",");
			//初始化icon
			initIcon(iconArray);
		});
		
		function searchIcon(){
			var iconName = mini.get("iconName").getValue();
			var index = 0;//索引
			var tempArray = [];
			for(var i=0;i<iconArray.length;i++){
				var icon = iconArray[i];
				if(icon.search(iconName) != -1){
					tempArray[index] = icon;
					index++;
				}
			}
			initIcon(tempArray);
		}
		
		function initIcon(iconArray){
			mini.parse();
			mini.get("pager").setTotalCount(iconArray.length);
			mini.get("pager").setPageSize(60);
			showTheIconArray(1,iconArray);
		}

		function showTheIconArray(pageIndex,tempArray) {
			if (pageIndex <= 0) {
				pageIndex = 1;
			}
			displayPannel.empty();
			for (var i = (pageIndex - 1) * (60); i < pageIndex * 60; i++) {
				if(i>=tempArray.length){
					break;
				}
				var icon = "<div class='divicon iconfont "
						+ tempArray[i] + "' title='"+ tempArray[i]+"' id='" + tempArray[i] + "' ></div>"
				displayPannel.append(icon);
			}
			
			$(".divicon").click(function(){
				var obj=$(this);
				chooseIcon(obj.attr("id"));
			})
			
			
		}

		function onPageChanged(e) {
			showTheIconArray(e.pageIndex + 1,iconArray);
		}
		
		function chooseIcon(iconName){
			mini.confirm("确定选中此图标 <span class='iconfont "+iconName+"' </span>", "",
		            function (action) {
		                if (action != "ok")  return;
		                
		                chooseIconName=iconName;
		                CloseWindow('ok');
		            }
		        );
		}
	</script>
       
    </body>
</html>
