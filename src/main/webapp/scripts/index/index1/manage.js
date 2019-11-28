$(function(){
	initMenu();
});

var menuData;
function initMenu(){
	var url=__rootPath +"/getMenus.do";
	$.get(url,function(data){
		menuData=data;
		var curId= getCurrentSys();
		var curIdx=getActiveMenu(data,curId);
		//构建左侧导航
		buildLeftMemu(data,curIdx);
	});
}

function buildLeftMemu(data,curIdx){
	var menuData=data;
	var data={"list":menuData};
	var menuHtml=bt('leftMenuTemplate',data);
	$(".Hui-aside").html(menuHtml);
	initCols();
	attachMenuEvents();
}


//加载页面移除
window.onload = function(){
	setTimeout(function(){
		$("#loading").slideUp(600);	
	},1000);	
};
